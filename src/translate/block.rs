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

use llvm_ir::{BasicBlock, Function, Instruction as LLVMInstruction, Module, Operand};
use quil::instruction::{
    ArithmeticOperand, Instruction as QuilInstruction, MemoryReference, ScalarType,
};

use crate::{
    environment::{
        variable::{VariableDataType, VariableType, VariableValue},
        Environment,
    },
    translate::{errors::TranslationError, function, utilities, TranslationResult},
};

/// Translate a single llvm_ir::BasicBlock into a vector of Quil instructions, also mutating the environment
/// as needed.
pub fn translate_block(
    env: &mut Environment,
    module: &Module,
    function: &Function,
    block: &BasicBlock,
) -> TranslationResult<Vec<QuilInstruction>> {
    let mut result = vec![QuilInstruction::Label(utilities::name_to_label(
        &function.name,
        &block.name,
    ))];

    for instruction in &block.instrs {
        match instruction {
            LLVMInstruction::BitCast(cast) => env.local.store_alias(&cast.dest, &cast.operand),

            LLVMInstruction::Call(call) => {
                result.extend(function::translate_function_call(
                    env, module, function, call,
                )?);
            }

            LLVMInstruction::Store(store) => {
                let variable_name = match &store.address {
                    Operand::LocalOperand { name, .. } => name,
                    _ => return Err(TranslationError::ExpectedLocalOperandForCall),
                };

                if let Operand::LocalOperand { name, ty } = &store.value {
                    if is_qubit_type!(ty) {
                        if let Some(target_name) = env.local.resolve_alias(variable_name) {
                            if let Some(VariableValue::Array(target_array)) =
                                env.local.variables.get_mut(&target_name)
                            {
                                target_array.push(name.clone());
                            }
                        }
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
                let source_label = utilities::name_to_label(&function.name, &name);
                env.global.variables.insert(
                    source_label.clone(), // TODO: determine correct type
                    VariableType {
                        is_array: false,
                        data_type: VariableDataType::Scalar(ScalarType::Integer),
                    },
                );
                env.global.variables.insert(
                    destination_label.clone(),
                    // TODO: determine correct type
                    VariableType {
                        is_array: false,
                        data_type: VariableDataType::Scalar(ScalarType::Integer),
                    },
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
            let label = utilities::name_to_label(&function.name, &branch.dest);
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
