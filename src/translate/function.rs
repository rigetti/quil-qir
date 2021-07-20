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
use llvm_ir::{instruction::Call, Constant, Function, Module, Name, Operand};
use quil::instruction::{
    GateModifier, Instruction as QuilInstruction, MemoryReference, Qubit, Vector,
};

use crate::environment::variable::TupleData;
use crate::translate::utilities::{
    name_to_string, unpack_controlled_gate_call, unpack_controlled_parametric_gate_call,
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

    match function_name.as_str() {
        // QIR native gates/instructions that map directly into a Quil
        // gates/instructions
        "__quantum__qis__rx" => Ok(vec![QuilInstruction::Gate {
            name: "RX".into(),
            qubits: utilities::get_qubits_from_call(call, &env)?,
            parameters: utilities::get_parameters_from_call(call)?,
            modifiers: vec![],
        }]),
        "__quantum__qis__ry" => Ok(vec![QuilInstruction::Gate {
            name: "RY".into(),
            qubits: utilities::get_qubits_from_call(call, &env)?,
            parameters: utilities::get_parameters_from_call(call)?,
            modifiers: vec![],
        }]),
        "__quantum__qis__rz" => Ok(vec![QuilInstruction::Gate {
            name: "RZ".into(),
            qubits: utilities::get_qubits_from_call(call, &env)?,
            parameters: utilities::get_parameters_from_call(call)?,
            modifiers: vec![],
        }]),
        "__quantum__qis__x" => Ok(vec![QuilInstruction::Gate {
            name: "X".into(),
            qubits: utilities::get_qubits_from_call(call, &env)?,
            parameters: vec![],
            modifiers: vec![],
        }]),
        "__quantum__qis__y" => Ok(vec![QuilInstruction::Gate {
            name: "Y".into(),
            qubits: utilities::get_qubits_from_call(call, &env)?,
            parameters: vec![],
            modifiers: vec![],
        }]),
        "__quantum__qis__z" => Ok(vec![QuilInstruction::Gate {
            name: "Z".into(),
            qubits: utilities::get_qubits_from_call(call, &env)?,
            parameters: vec![],
            modifiers: vec![],
        }]),
        "__quantum__qis__t" => Ok(vec![QuilInstruction::Gate {
            name: "T".into(),
            qubits: utilities::get_qubits_from_call(call, &env)?,
            parameters: vec![],
            modifiers: vec![],
        }]),
        "__quantum__qis__tadj" => Ok(vec![QuilInstruction::Gate {
            name: "T".into(),
            qubits: utilities::get_qubits_from_call(call, &env)?,
            parameters: vec![],
            modifiers: vec![GateModifier::Dagger],
        }]),
        "__quantum__qis__s" => Ok(vec![QuilInstruction::Gate {
            name: "S".into(),
            qubits: utilities::get_qubits_from_call(call, &env)?,
            parameters: vec![],
            modifiers: vec![],
        }]),
        "__quantum__qis__sadj" => Ok(vec![QuilInstruction::Gate {
            name: "S".into(),
            qubits: utilities::get_qubits_from_call(call, &env)?,
            parameters: vec![],
            modifiers: vec![GateModifier::Dagger],
        }]),
        "__quantum__qis__x__body" => Ok(vec![QuilInstruction::Gate {
            name: "X".into(),
            qubits: utilities::get_qubits_from_call(call, &env)?,
            parameters: vec![],
            modifiers: vec![],
        }]),

        "__quantum__qis__h__body" => Ok(vec![QuilInstruction::Gate {
            name: "H".into(),
            qubits: utilities::get_qubits_from_call(call, &env)?,
            parameters: vec![],
            modifiers: vec![],
        }]),
        "__quantum__qis__h" => Ok(vec![QuilInstruction::Gate {
            name: "H".into(),
            qubits: utilities::get_qubits_from_call(call, &env)?,
            parameters: vec![],
            modifiers: vec![],
        }]),
        "__quantum__qis__cnot" => {
            // look up variables from the environment
            // use those are the qubits for CNOT
            Ok(vec![QuilInstruction::Gate {
                name: "CNOT".into(),
                parameters: vec![],
                qubits: utilities::get_qubits_from_call(call, &env)?,
                modifiers: vec![],
            }])
        }
        "__quantum__qis__swap" => {
            // look up variables from the environment
            // use those are the qubits for CNOT
            Ok(vec![QuilInstruction::Gate {
                name: "SWAP".into(),
                parameters: vec![],
                qubits: utilities::get_qubits_from_call(call, &env)?,
                modifiers: vec![],
            }])
        }
        "__quantum__qis__x__ctl" => {
            let name = utilities::get_argument_names_from_call(call)[0].clone();
            let controls_name = match env.local.variables[&name].to_owned() {
                VariableValue::Array(controls) => {
                    let control = match &controls[0] {
                        TupleData::Name(name) => name,
                        other => panic!("expected a Name for control, got {:?}", other),
                    };
                    match env.resolve_alias(control) {
                        None => Qubit::Variable(control.clone()),
                        Some(name) => match env.local.variables.get(&name).unwrap() {
                            VariableValue::Qubit(q) => q.clone(),
                            _ => todo!(),
                        },
                    }
                }
                _ => {
                    return Err(TranslationError::UnexpectedVariableType(
                        name,
                        "Array".to_string(),
                    ))
                }
            };

            let target_name = &utilities::get_argument_names_from_call(call)[1];
            let resolved_target = match env.resolve_alias(target_name) {
                None => Qubit::Variable(target_name.clone()),
                Some(name) => {
                    let value = env.local.variables.get(&name).ok_or_else(|| {
                        TranslationError::CannotResolveLocalVariableValue(name.clone())
                    })?;
                    match value {
                        VariableValue::Qubit(q) => q.clone(),
                        _ => todo!(),
                    }
                }
            };
            let qubits = vec![controls_name, resolved_target];
            Ok(vec![QuilInstruction::Gate {
                name: "X".into(),
                parameters: vec![],
                qubits,
                modifiers: vec![GateModifier::Controlled],
            }])
        }
        "__quantum__qis__m__body" => {
            let qubits = utilities::get_qubits_from_call(call, &env)?;
            let target_name = name_to_string(
                call.dest
                    .as_ref()
                    .ok_or(TranslationError::MissingDestinationForCall)?,
            );
            let target_variable = utilities::prefix_name_for_label(&function.name, &target_name);
            Ok(vec![QuilInstruction::Measurement {
                qubit: qubits[0].clone(),
                target: Some(MemoryReference {
                    name: target_variable,
                    index: 0,
                }),
            }])
        }
        "__quantum__qis__measure__body" => {
            let qubit_name = env
                .resolve_alias(&utilities::get_argument_names_from_call(call)[1])
                .unwrap();
            let qubit_value = env.local.variables.get(&qubit_name).ok_or_else(|| {
                TranslationError::CannotResolveLocalVariableValue(qubit_name.clone())
            })?;
            let qubit = match qubit_value {
                VariableValue::Array(qs) => {
                    let q = match &qs[0] {
                        TupleData::Name(name) => name,
                        other => panic!("expected a Name, got {:?}", other),
                    };
                    match env.resolve_alias(q) {
                        None => Qubit::Variable(q.clone()),
                        Some(name) => match env.local.variables.get(&name).unwrap() {
                            VariableValue::Qubit(q) => q.clone(),
                            _ => todo!(),
                        },
                    }
                }
                other => {
                    return Err(TranslationError::UnexpectedVariableType(
                        qubit_name.clone(),
                        other.type_of(),
                    ))
                }
            };
            let target_name = name_to_string(
                call.dest
                    .as_ref()
                    .ok_or(TranslationError::MissingDestinationForCall)?,
            );
            let target_variable = utilities::prefix_name_for_label(&function.name, &target_name);
            // Store the target as a global, which has the effect of producing a corresponding DECLARE
            env.global.variables.insert(
                target_variable.clone(),
                VariableValue::Alias("measurement".to_string()),
            );
            Ok(vec![QuilInstruction::Measurement {
                qubit,
                target: Some(MemoryReference {
                    name: target_variable,
                    index: 0,
                }),
            }])
        }

        // There are some functions that, when compiled to QIR, result in rather complex functions, but can translate
        // much more directly into Quil.
        "Microsoft__Quantum__Intrinsic__I__ctl" => {
            let (modifiers, qubits) = unpack_controlled_gate_call(&call, &env)?;
            Ok(vec![QuilInstruction::Gate {
                name: "RX".to_string(),
                parameters: vec![],
                qubits,
                modifiers,
            }])
        }

        "Microsoft__Quantum__Intrinsic__Rx__ctl" => {
            let (modifiers, parameters, qubits) =
                unpack_controlled_parametric_gate_call(&call, &env)?;
            Ok(vec![QuilInstruction::Gate {
                name: "RX".to_string(),
                parameters,
                qubits,
                modifiers,
            }])
        }

        "Microsoft__Quantum__Intrinsic__Ry__ctl" => {
            let (modifiers, parameters, qubits) =
                unpack_controlled_parametric_gate_call(&call, &env)?;
            Ok(vec![QuilInstruction::Gate {
                name: "RY".to_string(),
                parameters,
                qubits,
                modifiers,
            }])
        }

        "Microsoft__Quantum__Intrinsic__Rz__ctl" => {
            let (modifiers, parameters, qubits) =
                unpack_controlled_parametric_gate_call(&call, &env)?;
            Ok(vec![QuilInstruction::Gate {
                name: "RZ".to_string(),
                parameters,
                qubits,
                modifiers,
            }])
        }

        "Microsoft__Quantum__Intrinsic__X__ctl" => {
            let (modifiers, qubits) = unpack_controlled_gate_call(&call, &env)?;
            Ok(vec![QuilInstruction::Gate {
                name: "X".to_string(),
                parameters: vec![],
                qubits,
                modifiers,
            }])
        }

        "Microsoft__Quantum__Intrinsic__Y__ctl" => {
            let (modifiers, qubits) = unpack_controlled_gate_call(&call, &env)?;
            Ok(vec![QuilInstruction::Gate {
                name: "Y".to_string(),
                parameters: vec![],
                qubits,
                modifiers,
            }])
        }

        "Microsoft__Quantum__Intrinsic__Z__ctl" => {
            let (modifiers, qubits) = unpack_controlled_gate_call(&call, &env)?;
            Ok(vec![QuilInstruction::Gate {
                name: "Z".to_string(),
                parameters: vec![],
                qubits,
                modifiers,
            }])
        }

        "Microsoft__Quantum__Intrinsic__H__ctl" => {
            let (modifiers, qubits) = unpack_controlled_gate_call(&call, &env)?;
            Ok(vec![QuilInstruction::Gate {
                name: "H".to_string(),
                parameters: vec![],
                qubits,
                modifiers,
            }])
        }

        "Microsoft__Quantum__Intrinsic__T__ctl" => {
            let (modifiers, qubits) = unpack_controlled_gate_call(&call, &env)?;
            Ok(vec![QuilInstruction::Gate {
                name: "T".to_string(),
                parameters: vec![],
                qubits,
                modifiers,
            }])
        }

        "Microsoft__Quantum__Intrinsic__S__ctl" => {
            let (modifiers, qubits) = unpack_controlled_gate_call(&call, &env)?;
            Ok(vec![QuilInstruction::Gate {
                name: "H".to_string(),
                parameters: vec![],
                qubits,
                modifiers,
            }])
        }

        // QIR utility functions that do not map directly into a Quil construct,
        // but instead have some effect on the environment in which translation
        // occurs
        "__quantum__rt__qubit_allocate" => {
            let variable_name = match call.dest.clone() {
                Some(name) => name_to_string(&name),
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
                Some(name) => name_to_string(&name),
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
        "__quantum__rt__qubit_allocate_array" => {
            let variable_name = match call.dest.clone() {
                Some(name) => name_to_string(&name),
                None => return Err(TranslationError::MissingDestinationForCall),
            };
            let array_length = match get_constant_operand_value!(&call.arguments[0].0) {
                Some(len) => len,
                None => return Err(TranslationError::ExpectedConstantOperand),
            };
            let mut qubits: Vec<Qubit> = Vec::with_capacity(*array_length as usize);

            for _ in 0..*array_length {
                qubits.push(Qubit::Fixed(env.local.next_qubit_to_allocate));
                env.local.next_qubit_to_allocate += 1;
            }

            env.local
                .variables
                .insert(variable_name, VariableValue::Qubits(qubits));

            Ok(vec![])
        }
        "__quantum__rt__array_get_element_ptr_1d" => {
            let variable_name = match call.dest.clone() {
                Some(name) => name_to_string(&name),
                None => return Err(TranslationError::MissingDestinationForCall),
            };
            let array_argument = call.arguments[0].0.clone();
            let index = match call.arguments[1].0.clone().as_constant().unwrap().clone() {
                Constant::Int { value, .. } => value,
                _ => return Err(TranslationError::NonIntegerIndex),
            };

            let array_name = get_name_from_operand!(array_argument.clone()).ok_or_else(|| {
                TranslationError::UnexpectedOperandType(
                    "LocalOperand".to_string(),
                    array_argument.to_string(),
                )
            })?;
            env.local.variables.insert(
                variable_name,
                VariableValue::Index(array_name, index as usize),
            );
            Ok(vec![])
        }
        "__quantum__rt__array_get_size_1d" => Ok(vec![]),
        "__quantum__rt__tuple_create" => {
            let destination = call
                .dest
                .as_ref()
                .ok_or(TranslationError::MissingDestinationForCall)?;
            env.allocate_tuple(&destination);
            Ok(vec![])
        }
        "__quantum__rt__qubit_release" => {
            let variable_name = match &call.arguments[0].0 {
                Operand::LocalOperand { name, .. } => name_to_string(&name),
                _ => return Err(TranslationError::ExpectedLocalOperandForCall),
            };
            env.local.variables.remove(&variable_name);
            Ok(vec![])
        }
        "__quantum__rt__qubit_release_array" => Ok(vec![]),
        "__quantum__rt__result_get_zero" => Ok(vec![]),

        // Some QIR intrinsics are specifically *not* supported and cannot be ignored
        name @ ("abba" | "__quantum__qis__reset__body") => Err(
            TranslationError::UnsupportedLLVMInstruction(name.to_string()),
        ),

        // No-ops
        "__quantum__rt__array_update_alias_count"
        | "__quantum__rt__result_get_one"
        | "__quantum__rt__result_equal"
        | "__quantum__rt__array_update_reference_count"
        | "__quantum__rt__tuple_update_reference_count"
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

            let qubits = utilities::get_qubits_from_call(call, env)?;

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

    // Prime the local environment with any function arguments that are type %Qubit
    function.parameters.iter().for_each(|p| {
        if is_qubit_type!(p.ty) {
            let value = VariableValue::Qubit(Qubit::Variable(name_to_string(&p.name.clone())));
            let name = name_to_string(&p.name);
            env.local.variables.insert(name, value);
        }
    });

    for block in &function.basic_blocks {
        result.extend(block::translate_block(&mut env, module, function, block)?);
    }

    // Create DECLARE instructions for all variables used
    result.extend(local_env.variables.iter().filter_map(|(name, variable)| {
        match variable {
            VariableValue::QuilData(scalar_type) => {
                Some(QuilInstruction::Declaration {
                    name: utilities::prefix_name_for_label(&function.name, &name),
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
