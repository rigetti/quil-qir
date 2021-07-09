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
use std::vec;

use llvm_ir::{function::Parameter, instruction::Call, Function, Module, Name, Operand};
use quil::instruction::{Instruction as QuilInstruction, Qubit, Vector};

use super::{errors::TranslationError, TranslationResult};
use crate::environment::{variable::VariableValue, Environment};
use llvm_ir::function::FunctionAttribute;

/// Unpack the LLVM function parameters into a tuple of Quil parameter names and
/// qubit names. Silently drops any parameter names that refer to
/// globally-defined variables (i.e. those that will be DECLAREd).
pub fn unpack_function_parameters(function: &Function) -> (Vec<String>, Vec<String>) {
    let mut parameters = vec![];
    let mut qubits = vec![];

    for parameter in &function.parameters {
        let label = name_to_string(&parameter.name);
        if is_qubit_type!(parameter.ty) {
            qubits.push(label);
        } else {
            parameters.push(label);
        }
    }

    (parameters, qubits)
}

/// Convert an llvm_ir::Name to a string, prepending a prefix.
/// This is useful among other things for namespacing local variables used within circuits.
pub fn name_to_label(prefix: &str, name: &Name) -> String {
    format!("{}__{}", prefix, name_to_string(name))
}

/// Convert an llvm_ir::Name to a string
pub fn name_to_string(name: &Name) -> String {
    match name {
        Name::Name(name) => *name.clone(),
        Name::Number(number) => format!("{}", *number),
    }
}

/// Extract a Name from a LocalOperand.
/// Note: this does not support constant or metadata operands
fn get_local_operand_name(operand: &Operand) -> Option<Name> {
    match operand {
        Operand::LocalOperand { name, .. } => Some(name.clone()),
        _ => None,
    }
}

/// Given a function call, return the names of the local operands used in the call.
/// NOTE: this omits constant and metadata operands
pub fn get_argument_names(call: &Call) -> Vec<Name> {
    call.arguments
        .iter()
        .filter_map(|(op, _)| get_local_operand_name(op))
        .collect()
}

/// Given a function call and the environment in which that call is made, return a vector of the qubits
/// used in the call, in original order.
///
/// Note: this does not yet support qubit arrays
pub fn get_argument_qubits(call: &Call, env: &Environment) -> Vec<Qubit> {
    let local_argument_names = get_argument_names(call);

    let mut qubits = vec![];
    for argument in local_argument_names {
        let local_definition = env.local.variables.get(&argument);
        if let Some(VariableValue::Qubit(qubit)) = &local_definition {
            qubits.push(qubit.clone())
        }
    }

    qubits
}

/// Convert a function parameter to a Quil DECLARE instruction
pub fn parameter_to_declare(parameter: &Parameter) -> TranslationResult<QuilInstruction> {
    match parameter.ty.as_ref() {
        llvm_ir::Type::IntegerType { .. } => Ok(QuilInstruction::Declaration {
            name: name_to_string(&parameter.name),
            size: Vector {
                data_type: quil::instruction::ScalarType::Integer,
                length: 1,
            },
            sharing: None,
        }),
        llvm_ir::Type::FPType(_) => Ok(QuilInstruction::Declaration {
            name: name_to_string(&parameter.name),
            size: Vector {
                data_type: quil::instruction::ScalarType::Real,
                length: 1,
            },
            sharing: None,
        }),
        _ => Err(TranslationError::UnexpectedVariableType(format!(
            "{:?}",
            parameter
        ))),
    }
}

pub fn module_entrypoint(module: &Module) -> Option<&Function> {
    module.functions.iter().find(|&el| {
        el.function_attributes
            .contains(&FunctionAttribute::StringAttribute {
                kind: "InteropFriendly".into(),
                value: "".into(),
            })
    })
}
