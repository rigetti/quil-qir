/**
 * Copyright 2021 Rigetti Computing
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 *
 *    Unless required by applicable law or agreed to in writing, software
 *    distributed under the License is distributed on an "AS IS" BASIS,
 *    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *    See the License for the specific language governing permissions and
 *    limitations under the License.
 **/
use llvm_ir::{instruction::Call, Function, Module, Name, Operand};
use quil::instruction::{
    GateModifier, Instruction as QuilInstruction, MemoryReference, Qubit, Vector,
};

use crate::{
    environment::{variable::VariableValue, Environment, GlobalEnvironment},
    translate::{block, errors::TranslationError, utilities, TranslationResult},
};

/// Provide the base-case implementation of certain function invocations.
pub fn translate_function_call(
    env: &mut Environment,
    module: &Module,
    function: &Function,
    call: &Call,
) -> TranslationResult<Vec<QuilInstruction>> {
    let function_name = match &call.function {
        either::Either::Right(llvm_ir::Operand::ConstantOperand(reference)) => {
            match reference.as_ref() {
                llvm_ir::Constant::GlobalReference {
                    name: Name::Name(name),
                    ..
                } => name.clone(),
                other => {
                    return Err(TranslationError::UnsupportedFunctionCall(format!(
                        "{:?}",
                        other
                    )))
                }
            }
        }
        other => {
            return Err(TranslationError::UnsupportedFunctionCall(format!(
                "{:?}",
                other
            )))
        }
    };

    let qubits = utilities::get_argument_qubits(call, &env);

    match function_name.as_str() {
        // QIR native gates/instructions that map directly into a Quil
        // gates/instructions
        "__quantum__qis__x__body" => Ok(vec![QuilInstruction::Gate {
            name: "X".into(),
            qubits,
            parameters: vec![],
            modifiers: vec![],
        }]),
        "__quantum__qis__h__body" => {
            let qubits = utilities::get_argument_qubits(call, env);
            Ok(vec![QuilInstruction::Gate {
                name: "H".into(),
                qubits,
                parameters: vec![],
                modifiers: vec![],
            }])
        }
        "__quantum__qis__x__ctl" => {
            let qubit_names: Vec<String> = utilities::get_argument_names(call)
                .iter()
                .map(utilities::name_to_string)
                .collect();
            let controls_name =
                match env.local.variables[&utilities::get_argument_names(call)[0]].to_owned() {
                    VariableValue::Qubit(q) => q,
                    VariableValue::Array(controls) => {
                        Qubit::Variable(utilities::name_to_string(&controls[0]))
                    }
                    other => {
                        return Err(TranslationError::UnexpectedVariableType(format!(
                            "{:?}",
                            other
                        )))
                    }
                };
            let target_name = qubit_names[1].to_owned();
            let qubits = vec![controls_name, Qubit::Variable(target_name)];
            Ok(vec![QuilInstruction::Gate {
                name: "X".into(),
                parameters: vec![],
                qubits,
                modifiers: vec![GateModifier::Controlled],
            }])
        }
        "__quantum__qis__measure__body" => {
            let qubit =
                match env.local.variables[&utilities::get_argument_names(call)[1]].to_owned() {
                    VariableValue::Qubit(q) => q,
                    VariableValue::Array(measures) => {
                        Qubit::Variable(utilities::name_to_string(&measures[0]))
                    }
                    other => {
                        return Err(TranslationError::UnexpectedVariableType(format!(
                            "{:?}",
                            other
                        )))
                    }
                };
            let target_name = call
                .dest
                .as_ref()
                .ok_or(TranslationError::MissingDestinationForCall)?;
            let target_variable = utilities::name_to_label(&function.name, &target_name);
            Ok(vec![QuilInstruction::Measurement {
                qubit,
                target: Some(MemoryReference {
                    name: target_variable,
                    index: 0,
                }),
            }])
        }

        // QIR utility functions that do not map directly into a Quil construct,
        // but instead have some effect on the environment in which translation
        // occurs
        "__quantum__rt__qubit_allocate" => {
            let variable_name = match call.dest.clone() {
                Some(name) => name,
                None => return Err(TranslationError::MissingDestinationForCall),
            };
            env.local.variables.insert(
                variable_name,
                VariableValue::Qubit(Qubit::Fixed(env.local.next_qubit_to_allocate)),
            );
            env.local.next_qubit_to_allocate += 1;
            Ok(vec![])
        }
        "__quantum__rt__array_create_1d" => {
            let variable_name = match call.dest.clone() {
                Some(name) => name,
                None => return Err(TranslationError::MissingDestinationForCall),
            };
            let array_length = match get_constant_operand_value!(&call.arguments[1].0) {
                Some(len) => len,
                None => return Err(TranslationError::ExpectedConstantOperand),
            };
            env.local.variables.insert(
                variable_name,
                VariableValue::Array(Vec::with_capacity(*array_length as usize)),
            );
            Ok(vec![])
        }
        "__quantum__rt__array_get_element_ptr_1d" => {
            let variable_name = match call.dest.clone() {
                Some(name) => name,
                None => return Err(TranslationError::MissingDestinationForCall),
            };
            let array_argument = call.arguments[0].0.clone();
            env.local.store_alias(&variable_name, &array_argument);
            Ok(vec![])
        }
        "__quantum__rt__qubit_release" => {
            let variable_name = match &call.arguments[0].0 {
                Operand::LocalOperand { name, .. } => name,
                _ => return Err(TranslationError::ExpectedLocalOperandForCall),
            };
            env.local.variables.remove(variable_name);
            Ok(vec![])
        }

        // No-ops
        "__quantum__rt__array_update_alias_count"
        | "__quantum__rt__result_get_one"
        | "__quantum__rt__result_equal"
        | "__quantum__rt__array_update_reference_count"
        | "__quantum__rt__result_update_reference_count" => Ok(vec![]),

        //
        name => {
            if !env.global.circuit_definitions.contains_key(name) {
                let function = module.get_func_by_name(&name).ok_or_else(|| {
                    TranslationError::MissingFunctionDefinition(*function_name.clone())
                })?;
                let circuit = translate_function_definition(module, function, &mut env.global)?;
                env.global
                    .circuit_definitions
                    .insert(function_name.to_string(), circuit);
            }

            let qubits = utilities::get_argument_qubits(call, env);

            Ok(vec![QuilInstruction::Gate {
                name: name.to_owned(),
                parameters: vec![],
                qubits,
                modifiers: vec![],
            }])
        }
    }
}

/// Translate a function body into Quil instructions
pub fn translate_function_body(
    module: &Module,
    function: &Function,
    global_env: &mut GlobalEnvironment,
) -> TranslationResult<Vec<QuilInstruction>> {
    let mut result = vec![];
    let mut local_env = Default::default();
    let mut env = Environment {
        global: global_env,
        local: &mut local_env,
    };

    for block in &function.basic_blocks {
        result.extend(block::translate_block(&mut env, module, function, block)?);
    }

    // Create DECLARE instructions for all variables used
    result.extend(local_env.variables.iter().filter_map(|(name, variable)| {
        match variable {
            VariableValue::Data(scalar_type) => {
                Some(QuilInstruction::Declaration {
                    name: utilities::name_to_label(&function.name, name),
                    size: Vector {
                        data_type: scalar_type.clone(),
                        length: 1,
                    }, // TODO: Implement data types
                    sharing: None,
                })
            }
            _ => None,
        }
    }));

    Ok(result)
}

/// Translate a function definition into a Quil DEFCIRCUIT
fn translate_function_definition(
    module: &Module,
    function: &Function,
    env: &mut GlobalEnvironment,
) -> TranslationResult<QuilInstruction> {
    let (_, qubits) = utilities::unpack_function_parameters(function);
    let instructions = translate_function_body(module, function, env)?;
    Ok(QuilInstruction::CircuitDefinition {
        name: function.name.to_owned(),
        parameters: vec![],
        qubit_variables: qubits,
        instructions,
    })
}
