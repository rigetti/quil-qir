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
    UnexpectedVariableType(String, String),
    MissingDestinationForCall,
    MissingOperandName,
    MissingFunctionDefinition(String),
    ExpectedLocalOperandForCall,
    ExpectedConstantOperand,
    CannotResolveLocalVariableName(String),
    CannotResolveLocalVariableValue(String),
    UnsupportedParameterType(String, String),
    UnsupportedFloatType(String),
    UnexpectedConstantType(String, String),
    UnexpectedOperandType(String, String),
    NonIntegerIndex,
    UnsupportedAllocationType(String, String),
}

impl fmt::Display for TranslationError {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        use TranslationError::*;
        match self {
            UndefinedEntryPoint(entrypoint) => write!(
                f,
                "Could not find entry point named '{}' in module",
                entrypoint
            ),
            NoEntryPoint => {
                write!(f, "Could not find entry point in module")
            }
            UnsupportedFunctionCall(s) => {
                write!(f, "Unsupported function call '{}'", s)
            }
            UnexpectedVariableType(name, expected) => {
                write!(f, "Expected type {} for variable {}", name, expected)
            }
            MissingDestinationForCall => {
                write!(f, "Missing destination for function call")
            }
            ExpectedLocalOperandForCall => {
                write!(f, "Expected a local operand for function call")
            }
            MissingOperandName => write!(f, "Missing operand name"),
            UnsupportedLLVMInstruction(instr) => {
                write!(f, "Unsupported LLVM instruction '{}'", instr)
            }
            UnsupportedLLVMTerminator(term) => {
                write!(f, "Unsupported LLVM terminator '{}'", term)
            }
            MissingFunctionDefinition(s) => {
                write!(f, "Missing definition for function '{}'", s)
            }
            ExpectedConstantOperand => write!(f, "Expected a constant operand"),
            InvalidLLVMByteCode => write!(f, "Could not parse LLVM BC file"),
            CannotResolveLocalVariableName(name) => {
                write!(f, "Could not resolve local variable {}", name)
            }
            CannotResolveLocalVariableValue(name) => {
                write!(f, "Could not resolve local variable {} to a value", name)
            }
            UnsupportedParameterType(name, actual) => {
                write!(f, "Parameter {} has unsupported type {}", name, actual)
            }
            UnsupportedFloatType(actual) => {
                write!(f, "Cannot convert the LLVM float {} to f64", actual)
            }
            UnexpectedConstantType(expected, actual) => {
                write!(f, "Expected {} for constant, got {}", expected, actual)
            }
            UnexpectedOperandType(expected, actual) => {
                write!(f, "Expected operand of type {}, got {}", expected, actual)
            }
            NonIntegerIndex => write!(f, "Cannot index an array with a non-integer value"),
            UnsupportedAllocationType(expected, actual) => {
                write!(
                    f,
                    "Expected an allocation for type {}, got {}",
                    expected, actual
                )
            }
        }
    }
}
