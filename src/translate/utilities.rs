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

use llvm_ir::{function::Parameter, instruction::Call, Constant, Function, Module, Name, Operand};
use quil::instruction::{GateModifier, Instruction as QuilInstruction, Qubit, Vector};

use super::{errors::TranslationError, TranslationResult};
use crate::environment::variable::TupleData;
use crate::environment::{variable::VariableValue, Environment};
use llvm_ir::constant::Float;
use llvm_ir::function::FunctionAttribute;
use quil::expression::Expression;
use quil::instruction::Qubit::Variable;
use quil::real;

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
pub fn prefix_name_for_label(prefix: &str, name: &str) -> String {
    format!("{}__{}", prefix, name)
}

/// Convert an llvm_ir::Name to a (sanitized) string
///
/// Sanitization replaces all periods "." with underscores "_"
pub fn name_to_string(name: &Name) -> String {
    match name {
        Name::Name(name) => name.clone().replace(".", "_"),
        Name::Number(number) => format!("{}", *number),
    }
}

/// Extract a Name from a LocalOperand.
/// Note: this does not support constant or metadata operands
fn get_name_from_local_operand(operand: &Operand) -> Option<String> {
    match operand {
        Operand::LocalOperand { name, .. } => Some(name_to_string(&name)),
        _ => None,
    }
}

/// Given a function call, return the names of the local operands used in the call.
/// NOTE: this omits constant and metadata operands
pub fn get_argument_names_from_call(call: &Call) -> Vec<String> {
    call.arguments
        .iter()
        .filter_map(|(op, _)| get_name_from_local_operand(op))
        .collect()
}

pub fn get_constant_parameters_from_call(call: &Call) -> Vec<Constant> {
    call.arguments
        .iter()
        .filter_map(|(op, _)| match op {
            Operand::ConstantOperand(op) => Some(op.as_ref().clone()),
            _ => None,
        })
        .collect()
}

/// Given a function call and the environment in which that call is made, return a vector of the qubits
/// used in the call in the same order.
///
/// Non-qubit arguments are ignored.
pub fn get_qubits_from_call(
    call: &Call,
    env: &Environment,
) -> Result<Vec<Qubit>, TranslationError> {
    let mut qubits = vec![];

    let local_argument_names = get_argument_names_from_call(call);
    for argument in local_argument_names {
        // TODO Should this resolve in the global env also?
        if let Some(local_definition) = env.local.variables.get(&argument) {
            // The call argument *must* resolve to a known variable, either in the local environment,
            // the enclosing function signature, or the global environment.
            let resolved_name = env.resolve_alias(&argument).ok_or(
                TranslationError::CannotResolveLocalVariableName(argument.clone()),
            )?;
            // If we can resolve the variable name, then it *must* have a value.
            let resolved_value = env.local.variables.get(&resolved_name).ok_or(
                TranslationError::CannotResolveLocalVariableValue(argument.clone()),
            )?;

            match resolved_value {
                VariableValue::Qubit(q) => {
                    qubits.push(q.clone());
                }
                VariableValue::Qubits(qs) => {
                    // If we have a vector of qubits, then we also need an index to choose a particular one!
                    match local_definition {
                        VariableValue::Index(_, i) => {
                            qubits.push(qs[*i as usize].clone());
                        }
                        other => {
                            return Err(TranslationError::UnexpectedVariableType(
                                argument,
                                "Index".to_string(),
                            ))
                        }
                    }
                }
                VariableValue::Index(array_name, index) => {
                    // The target array *must* exist in the environment
                    let source_array = env.local.variables.get(array_name).ok_or(
                        TranslationError::CannotResolveLocalVariableName(array_name.clone()),
                    )?;
                    match source_array {
                        VariableValue::Qubits(qs) => qubits.push(qs[*index].clone()),
                        other => {
                            return Err(TranslationError::UnexpectedVariableType(
                                array_name.clone(),
                                "Qubits".to_string(),
                            ))
                        }
                    }
                }
                VariableValue::Tuple(_) => todo!(),
                other => {
                    return Err(TranslationError::UnexpectedVariableType(
                        argument,
                        "one of Qubit, Qubits, Index, or Tuple".to_string(),
                    ))
                }
            }
        }
    }

    Ok(qubits)
}

pub fn get_f64_from_llvm_ir_float(float: &Float) -> TranslationResult<f64> {
    match float {
        Float::Single(f) => Ok(f.clone() as f64),
        Float::Double(f) => Ok(f.clone()),
        other => Err(TranslationError::UnsupportedFloatType(format!("{}", other))),
    }
}

pub fn get_parameters_from_call(call: &Call) -> TranslationResult<Vec<Expression>> {
    let constant_params = get_constant_parameters_from_call(call);

    let mut params = vec![];

    for param in constant_params {
        match param {
            Constant::Int { value, .. } => {
                params.push(Expression::Number(num_complex::Complex64::new(
                    value as f64,
                    0.0,
                )));
            }
            Constant::Float(value) => {
                let float = get_f64_from_llvm_ir_float(&value)?;
                params.push(Expression::Number(num_complex::Complex64::new(float, 0.0)));
            }
            other => {
                return Err(TranslationError::UnexpectedConstantType(
                    "Int or Float".to_string(),
                    format!("{}", other),
                ))
            }
        }
    }

    Ok(params)
}

/// Convert a function parameter to a Quil DECLARE instruction
///
/// An error is raised if parameter is non-numeric
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
        other => Err(TranslationError::UnsupportedParameterType(
            name_to_string(&parameter.name),
            format!("{}", other),
        )),
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

fn get_control_qubits_from_operand(
    op: &Operand,
    env: &Environment,
) -> TranslationResult<Vec<String>> {
    if let Operand::LocalOperand { name, .. } = op {
        let name = name_to_string(name);
        let resolved_name =
            env.resolve_alias(&name)
                .ok_or(TranslationError::CannotResolveLocalVariableName(
                    name.clone(),
                ))?;
        let resolved_value = env.local.variables.get(&resolved_name).ok_or(
            TranslationError::CannotResolveLocalVariableValue(name.clone()),
        )?;
        return match resolved_value {
            VariableValue::Array(names) => Ok(names
                .clone()
                .iter()
                .map(|t| match t {
                    TupleData::Name(name) => Ok(name.clone()),
                    other => Err(TranslationError::UnexpectedVariableType(
                        resolved_name.clone(),
                        other.type_of(),
                    )),
                })
                .collect::<Result<Vec<_>, _>>()?),
            other => Err(TranslationError::UnexpectedVariableType(
                resolved_name.clone(),
                other.type_of(),
            )),
        };
    } else {
        Err(TranslationError::UnexpectedOperandType(
            "LocalOperand".to_string(),
            format!("{}", op),
        ))
    }
}

fn get_parameters_and_target_qubit_from_operand(
    op: &Operand,
    env: &Environment,
) -> TranslationResult<Vec<TupleData>> {
    match op {
        Operand::LocalOperand { name, .. } => {
            let name = name_to_string(name);
            let resolved_name = env.resolve_alias(&name).ok_or(
                TranslationError::CannotResolveLocalVariableName(name.clone()),
            )?;
            let resolved_value = env.local.variables.get(&resolved_name).ok_or(
                TranslationError::CannotResolveLocalVariableValue(resolved_name.clone()),
            )?;
            match resolved_value {
                VariableValue::Tuple(names) => Ok(names.clone()),
                _ => Err(TranslationError::UnexpectedVariableType(
                    resolved_name,
                    "Tuple".to_string(),
                )),
            }
        }
        other => Err(TranslationError::UnexpectedOperandType(
            "LocalOperand".to_string(),
            format!("{}", other),
        )),
    }
}

fn resolve_controls_to_qubits(
    controls: Vec<String>,
    env: &Environment,
) -> TranslationResult<Vec<Qubit>> {
    controls
        .iter()
        .map(|name| {
            let resolved_name = env.resolve_alias(&name).ok_or(
                TranslationError::CannotResolveLocalVariableName(name.clone()),
            )?;
            let resolved_value = env.local.variables.get(&resolved_name).ok_or(
                TranslationError::CannotResolveLocalVariableValue(resolved_name.clone()),
            )?;
            match resolved_value {
                VariableValue::Qubit(q) => Ok(q.clone()),
                other => Err(TranslationError::UnexpectedVariableType(
                    "Qubit".to_string(),
                    other.type_of(),
                )),
            }
        })
        .collect::<TranslationResult<_>>()
}

fn get_expression_from_parameters_tuple(tuple: &TupleData) -> TranslationResult<Vec<Expression>> {
    match tuple {
        TupleData::Double(v) => Ok(vec![Expression::Number(v.into())]),
        TupleData::Integer(i) => Ok(vec![Expression::Number(real!(*i as f64))]),
        other => Err(TranslationError::UnsupportedParameterType(
            "Double or Integer".to_string(),
            other.type_of(),
        )),
    }
}

fn get_qubit_from_parameters_tuple(tuple: &TupleData) -> Option<Qubit> {
    match tuple {
        TupleData::Qubit(q) => Some(q.clone()),
        _ => None,
    }
}

/// Unpack a Call to a controlled and parametric Q# intrinsic, into a tuple (gate modifiers, gate parameters, gate
/// qubits)
pub fn unpack_controlled_parametric_gate_call(
    call: &Call,
    env: &Environment,
) -> TranslationResult<(Vec<GateModifier>, Vec<Expression>, Vec<Qubit>)> {
    // First argument is an array of control names
    let control_names = get_control_qubits_from_operand(&call.arguments[0].0, env)?;
    // Second argument is a tuple (angle, qubit)
    let param_and_target_names =
        get_parameters_and_target_qubit_from_operand(&call.arguments[1].0, env)?;
    let mut qubits: Vec<Qubit> = resolve_controls_to_qubits(control_names, env)?;
    let modifiers = vec![GateModifier::Controlled; qubits.len()];
    let parameters = get_expression_from_parameters_tuple(&param_and_target_names[0])?;
    let target = get_qubit_from_parameters_tuple(&param_and_target_names[1]).ok_or(
        TranslationError::UnexpectedVariableType("target".to_string(), "Qubit".to_string()),
    )?;

    qubits.push(target);

    Ok((modifiers, parameters, qubits))
}

fn get_qubit_from_operand(op: &Operand, env: &Environment) -> TranslationResult<Qubit> {
    match op {
        Operand::LocalOperand { name, .. } => {
            let name = name_to_string(name);
            let resolved_name = env.resolve_alias(&name).ok_or(
                TranslationError::CannotResolveLocalVariableName(name.clone()),
            )?;
            let resolved_value = env.local.variables.get(&resolved_name).ok_or(
                TranslationError::CannotResolveLocalVariableValue(resolved_name.clone()),
            )?;
            match resolved_value {
                VariableValue::Qubit(name) => Ok(name.clone()),
                other => Err(TranslationError::UnexpectedVariableType(
                    resolved_name,
                    other.type_of(),
                )),
            }
        }
        other => Err(TranslationError::UnexpectedOperandType(
            "LocalOperand".to_string(),
            format!("{}", other),
        )),
    }
}

/// Unpack a Call to a controlled Q# intrinsic, into a tuple (gate modifiers, gate parameters, gate qubits)
pub fn unpack_controlled_gate_call(
    call: &Call,
    env: &Environment,
) -> TranslationResult<(Vec<GateModifier>, Vec<Qubit>)> {
    // First argument is an array of control names
    let control_names = get_control_qubits_from_operand(&call.arguments[0].0, env)?;
    // Second argument is a qubit
    let mut qubits = resolve_controls_to_qubits(control_names, env)?;
    let modifiers = vec![GateModifier::Controlled; qubits.len()];
    let target = get_qubit_from_operand(&call.arguments[1].0, env)?;
    qubits.push(target.clone());
    Ok((modifiers, qubits))
}
