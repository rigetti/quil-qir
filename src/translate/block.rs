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
use log;

use llvm_ir::{
    BasicBlock, Constant, Function, Instruction as LLVMInstruction, Module, Operand, Type,
};
use quil::instruction::{
    ArithmeticOperand, Instruction as QuilInstruction, MemoryReference, ScalarType,
};

use crate::environment::variable::TupleData;
use crate::translate::utilities::name_to_string;
use crate::{
    environment::{
        variable::{VariableDataType, VariableType, VariableValue},
        Environment,
    },
    translate::{errors::TranslationError, function, utilities, TranslationResult},
};
use llvm_ir::constant::Float;

/// Translate a single llvm_ir::BasicBlock into a vector of Quil instructions, also mutating the environment
/// as needed.
pub fn translate_block(
    env: &mut Environment,
    module: &Module,
    function: &Function,
    block: &BasicBlock,
) -> TranslationResult<Vec<QuilInstruction>> {
    let mut result = vec![QuilInstruction::Label(utilities::prefix_name_for_label(
        &function.name,
        &name_to_string(&block.name),
    ))];

    for instruction in &block.instrs {
        dbg!(&instruction);
        match instruction {
            // TODO These might be better placed in environment/mod.rs
            LLVMInstruction::Alloca(alloc) => {
                let dest = name_to_string(&alloc.dest);
                let value = match alloc.allocated_type.as_ref() {
                    Type::IntegerType { .. } => TupleData::Integer(0),
                    other => {
                        return Err(TranslationError::UnsupportedAllocationType(
                            "Integer".to_string(),
                            format!("{}", other),
                        ))
                    }
                };
                env.local
                    .variables
                    .insert(dest.clone(), VariableValue::Data(value));
            }

            LLVMInstruction::BitCast(cast) => env.bitcast(&cast)?,

            LLVMInstruction::Call(call) => {
                result.extend(function::translate_function_call(
                    env, module, function, call,
                )?);
            }

            LLVMInstruction::Store(store) => {
                let store_address = match &store.address {
                    Operand::LocalOperand { name, .. } => name_to_string(name),
                    _ => return Err(TranslationError::ExpectedLocalOperandForCall),
                };
                let resolved_store_address =
                    env.resolve_alias(&store_address).ok_or_else(|| {
                        TranslationError::CannotResolveLocalVariableName(store_address.clone())
                    })?;
                let resolved_variable_value = env
                    .local
                    .variables
                    .get(&resolved_store_address)
                    .ok_or_else(|| {
                        TranslationError::CannotResolveLocalVariableValue(
                            resolved_store_address.clone(),
                        )
                    })?
                    .clone();

                match &store.value {
                    Operand::LocalOperand {
                        name: value_name, ..
                    } => {
                        let value_name = name_to_string(value_name);
                        let resolved_name = env.resolve_alias(&value_name).unwrap().clone();
                        let resolved_value = env.local.variables.get(&resolved_name).cloned();
                        if let Operand::LocalOperand { .. } = &store.value {
                            if let Some(target_name) = env.resolve_alias(&store_address) {
                                if let Some(VariableValue::Index(target_array_name, _)) =
                                    env.local.variables.clone().get(&target_name)
                                {
                                    // TODO actually use the index
                                    match env.local.variables.get_mut(target_array_name).unwrap() {
                                        VariableValue::Array(target) => {
                                            target.push(TupleData::Name(value_name.clone()));
                                        }
                                        VariableValue::Tuple(target) => {
                                            match resolved_value.unwrap() {
                                                VariableValue::Qubit(q) => {
                                                    target.push(TupleData::Qubit(q.clone()))
                                                }
                                                other => panic!("how to {:?}", other),
                                            }
                                        }
                                        other => panic!("don't know what to do with {:?}", other),
                                    }
                                }
                            }
                        }
                    }
                    Operand::ConstantOperand(value) => match resolved_variable_value {
                        VariableValue::Index(target_name, _) => {
                            let value = match value.as_ref() {
                                Constant::Int { value, .. } => TupleData::Integer(*value),
                                Constant::Float(float) => TupleData::Double(match float {
                                    Float::Single(s) => *s as f64,
                                    Float::Double(d) => *d,
                                    other => panic!("unsupported float type {:?}", other),
                                }),
                                other => panic!("expected Int or Float, got {:?}", other),
                            };
                            match env.local.variables.get_mut(&target_name).unwrap() {
                                VariableValue::Tuple(tuple) => tuple.push(value),
                                VariableValue::Array(array) => array.push(value),
                                other => panic!("don't know how to store into {:?}", other),
                            }
                        }
                        VariableValue::Data(_) => {
                            let value = match value.as_ref() {
                                Constant::Int { value, .. } => TupleData::Integer(*value),
                                Constant::Float(float) => TupleData::Double(match float {
                                    Float::Single(s) => *s as f64,
                                    Float::Double(d) => *d,
                                    other => panic!("unsupported float type {:?}", other),
                                }),
                                other => panic!("expected Int or Float, got {:?}", other),
                            };
                            env.local
                                .variables
                                .insert(store_address.clone(), VariableValue::Data(value));
                        }
                        _ => todo!(),
                    },
                    other => panic!("unsupported store: {:?}", other),
                }
            }

            LLVMInstruction::Load(load) => {
                env.load(load);
            }

            LLVMInstruction::GetElementPtr(getptr) => {
                let address = match &getptr.address {
                    Operand::LocalOperand { name, .. } => {
                        let name = name_to_string(name);
                        env.resolve_alias(&name)
                            .ok_or(TranslationError::CannotResolveLocalVariableName(name))?
                    }
                    other => {
                        return Err(TranslationError::UnexpectedOperandType(
                            "LocalOperand".to_string(),
                            format!("{}", other),
                        ))
                    }
                };
                let destination = name_to_string(&getptr.dest);
                let last_constant = getptr
                    .indices
                    .last()
                    .unwrap()
                    .as_constant()
                    .ok_or(TranslationError::ExpectedConstantOperand)?;
                let index = match last_constant {
                    Constant::Int { value, .. } => *value,
                    _ => return Err(TranslationError::NonIntegerIndex),
                };
                let value = env.local.variables.get(&address).ok_or_else(|| {
                    TranslationError::CannotResolveLocalVariableValue(address.clone())
                })?;
                match value {
                    VariableValue::Tuple(_) => {
                        env.local
                            .variables
                            .insert(destination, VariableValue::Index(address, index as usize));
                    }
                    other => {
                        return Err(TranslationError::UnexpectedVariableType(
                            address.clone(),
                            other.type_of(),
                        ));
                    }
                }
            }

            instruction => {
                // return Err(TranslationError::UnsupportedLLVMInstruction(format!(
                //     "{:?}",
                //     instruction
                // )))
                log::debug!("ignoring LLVM instruction {:#?}", instruction)
            }
        }
    }

    match &block.term {
        llvm_ir::Terminator::Ret(ret) => {
            if let Some(operand) = &ret.return_operand {
                let name = match get_name_from_operand!(operand) {
                    Some(name) => name,
                    None => return Err(TranslationError::MissingOperandName),
                };
                let destination_label = format!("{}__return_value", function.name);
                let source_label = utilities::prefix_name_for_label(&function.name, &name);
                env.global.variables.insert(
                    source_label.clone(), // TODO: determine correct type
                    VariableValue::QuilVariable(VariableType {
                        is_array: false,
                        data_type: VariableDataType::Scalar(ScalarType::Integer),
                    }),
                );
                env.global.variables.insert(
                    destination_label.clone(),
                    // TODO: determine correct type
                    VariableValue::QuilVariable(VariableType {
                        is_array: false,
                        data_type: VariableDataType::Scalar(ScalarType::Integer),
                    }),
                );
                result.push(QuilInstruction::Move {
                    destination: ArithmeticOperand::MemoryReference(MemoryReference {
                        name: destination_label,
                        index: 0,
                    }),
                    source: ArithmeticOperand::MemoryReference(MemoryReference {
                        name: source_label,
                        index: 0,
                    }),
                })
            }
        }

        llvm_ir::Terminator::Br(branch) => {
            let label =
                utilities::prefix_name_for_label(&function.name, &name_to_string(&branch.dest));
            result.push(QuilInstruction::Jump { target: label });
        }

        term => {
            // return Err(TranslationError::UnsupportedLLVMTerminator(format!(
            //     "{:?}",
            //     term
            // )))
            log::debug!("ignoring terminator {:#?}", term)
        }
    }

    Ok(result)
}
