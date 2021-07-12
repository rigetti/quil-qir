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
use std::fmt;

#[derive(Debug, Clone)]
pub enum TranslationError {
    InvalidLLVMByteCode,
    NoEntryPoint,
    UndefinedEntryPoint(String),
    UnsupportedFunctionCall(String),
    #[allow(dead_code)]
    UnsupportedLLVMInstruction(String),
    #[allow(dead_code)]
    UnsupportedLLVMTerminator(String),
    UnexpectedVariableType(String),
    MissingDestinationForCall,
    MissingOperandName,
    MissingFunctionDefinition(String),
    ExpectedLocalOperandForCall,
    ExpectedConstantOperand,
}

impl fmt::Display for TranslationError {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        use TranslationError::*;
        match self {
            UndefinedEntryPoint(entrypoint) => write!(
                f,
                "could not find entry point named '{}' in module",
                entrypoint
            ),
            NoEntryPoint => {
                write!(f, "could not find entry point in module")
            }
            UnsupportedFunctionCall(s) => {
                write!(f, "unsupported function call '{}'", s)
            }
            UnexpectedVariableType(t) => {
                write!(f, "unexpected variable type '{}'", t)
            }
            MissingDestinationForCall => {
                write!(f, "missing destination for function call")
            }
            ExpectedLocalOperandForCall => {
                write!(f, "expected a local operand for function call")
            }
            MissingOperandName => write!(f, "missing operand name"),
            UnsupportedLLVMInstruction(instr) => {
                write!(f, "unsupported LLVM instruction '{}'", instr)
            }
            UnsupportedLLVMTerminator(term) => {
                write!(f, "unsupported LLVM terminator '{}'", term)
            }
            MissingFunctionDefinition(s) => {
                write!(f, "missing definition for function '{}'", s)
            }
            ExpectedConstantOperand => write!(f, "expected a constant operand"),
            InvalidLLVMByteCode => write!(f, "could not parse LLVM BC file"),
        }
    }
}
