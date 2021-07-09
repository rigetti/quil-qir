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
mod global;
mod local;
pub mod variable;

use crate::environment::variable::TupleData;
use crate::translate::errors::TranslationError;
use crate::translate::utilities::name_to_string;
use crate::translate::TranslationResult;
use either::Either;
pub use global::GlobalEnvironment;
use llvm_ir::function::ParameterAttribute;
use llvm_ir::instruction::{Call, InlineAssembly};
pub use local::LocalEnvironment;
use std::fmt;
pub use variable::VariableValue;

use llvm_ir::{
    instruction::{BitCast, GetElementPtr, Load, Store},
    Constant, Name, Operand, Type, TypeRef,
};
use log::{debug, warn};

// type EnvironmentResult<T> = std::result::Result<T, errors::EnvironmentError>;
//
// #[derive(Debug, Clone)]
// pub enum EnvironmentError {
//     CannotResolveLocalVariableName(String),
//     CannotResolveLocalVariableValue(String),
// }
//
// impl fmt::Display for EnvironmentError {
//     fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
//         use EnvironmentError::*;
//         match self {
//             CannotResolveLocalVariableName(name) => {
//                 write!(f, "Could not resolve local variable {}", name)
//             }
//             CannotResolveLocalVariableValue(name) => {
//                 write!(f, "Could not resolve local variable {} to a value", name)
//             }
//         }
//     }
// }

/// For convenience and brevity, the two environments for use in compilation may be stored and passed together.
pub struct Environment<'a> {
    pub global: &'a mut global::GlobalEnvironment,
    pub local: &'a mut local::LocalEnvironment,
}

impl<'a> Environment<'a> {
    /// Recursively resolve a name to its original definition within a local environment.
    pub fn resolve_alias(&self, source: &String) -> Option<String> {
        let mut alias = source;

        loop {
            match self.local.variables.get(alias) {
                Some(value) => match value {
                    VariableValue::Alias(target) => alias = &target,
                    _ => return Some(alias.clone()),
                },
                None => break,
            }
        }

        loop {
            match self.global.variables.get(alias) {
                Some(value) => match value {
                    VariableValue::Alias(target) => alias = &target,
                    _ => return Some(alias.clone()),
                },
                None => break,
            }
        }

        None
    }

    pub fn store_alias(&mut self, dest: String, op: &Operand) {
        match op {
            Operand::LocalOperand { name, .. } => {
                self.local
                    .variables
                    .insert(dest, VariableValue::Alias(name_to_string(name)));
            }
            Operand::ConstantOperand(cr) => match cr.as_ref() {
                Constant::GlobalReference { name, ty } => {
                    // TODO Should we store the actual constant value?
                    self.local
                        .variables
                        .insert(dest, VariableValue::Alias(name_to_string(name)));
                }
                _ => todo!(),
            },
            Operand::MetadataOperand => todo!(),
        }
    }

    pub fn bitcast(&mut self, cast: &BitCast) -> TranslationResult<()> {
        let dest = name_to_string(&cast.dest);
        self.store_alias(dest.clone(), &cast.operand);

        if let Operand::LocalOperand { name, .. } = &cast.operand {
            let name = name_to_string(name);
            let resolved_name = self.resolve_alias(&name).ok_or(
                TranslationError::CannotResolveLocalVariableName(name.clone()),
            )?;
            let resolved_value = self.local.variables.get(&resolved_name).ok_or(
                TranslationError::CannotResolveLocalVariableValue(resolved_name.clone()),
            )?;
            if let &VariableValue::Tuple(_) = resolved_value {
                // The bitcast for a tuple needs a little care. In QIR it is used both to describe the type of a
                // value *and* as a way to index the *first* item in the tuple. The remaining items in a tuple
                // are accessed with the (IMO) more sensible getptr function. This means we may see two
                // different bitcasts on a tuple, which have different functional utility. As a heuristic (i.e. likely
                // to break) we might discern the first use case from the second by
                // inspecting the casted type: if it is a struct type, then assume this is the former of the
                // options (telling LLVM the tuple type); otherwise, it is equivalent to a getptr for the first
                // tuple element.
                if let Type::PointerType { pointee_type, .. } = &cast.to_type.as_ref() {
                    match pointee_type.as_ref() {
                        Type::StructType { .. } => { /* Do nothing */ }
                        _ => {
                            self.local
                                .variables
                                .insert(dest.clone(), VariableValue::Index(resolved_name, 0));
                        }
                    }
                }
            }
        }

        Ok(())
    }

    pub fn load(&mut self, load: &Load) {
        self.store_alias(name_to_string(&load.dest), &load.address)
    }

    pub fn store(&mut self, store: &Store) -> TranslationResult<()> {
        let variable_name = match &store.address {
            Operand::LocalOperand { name, .. } => name_to_string(name),
            operand => {
                return Err(TranslationError::UnexpectedOperandType(
                    "LocalOperand".to_string(),
                    format!("{}", operand),
                ))
            }
        };

        if let Operand::LocalOperand { name, .. } = &store.value {
            let name = name_to_string(&name);
            let resolved_name = self.resolve_alias(&name).ok_or(
                TranslationError::CannotResolveLocalVariableName(name.clone()),
            )?;

            if let Some(target_name) = self.resolve_alias(&variable_name) {
                if let Some(VariableValue::Array(target_array)) =
                    self.local.variables.get_mut(&target_name)
                {
                    target_array.push(TupleData::Name(resolved_name));
                    return Ok(());
                }
            }
        }

        Ok(())
    }

    pub fn getelementptr(&mut self, gep: &GetElementPtr) -> TranslationResult<()> {
        // getelementptr provides a pointer to a subelement of an aggregate data
        // type
        //
        // the first argument is the type used for pointer arithmetic
        // the second argument is the base address of pointer arithmetic
        // the remaining arguments are indices into the aggregate object
        //
        // so
        // %8 = getelementptr inbounds { double, %Qubit* }, { double, %Qubit* }* %7, i32 0, i32 0
        // uses { double, %Qubit* } as the type for pointer arithmetic
        // uses { double, %Qubit* }* %7 as the base address
        // uses i32 0, i32 0 to index the object
        // i.e. assign to %8 the first element in the first tuple of %7
        let dest = gep.dest.clone();
        let source = match &gep.address {
            Operand::LocalOperand { name, .. } => name,
            op => {
                return Err(TranslationError::UnexpectedOperandType(
                    "LocalOperand".to_string(),
                    format!("{}", op),
                ))
            }
        };

        let first_constant = gep.indices[0]
            .as_constant()
            .ok_or(TranslationError::ExpectedConstantOperand)?;
        let first_index = match first_constant {
            Constant::Int { value, .. } => {
                assert_eq!(value.clone(), 0);
                value.clone()
            }
            _ => return Err(TranslationError::NonIntegerIndex),
        };

        let second_constant = gep.indices[1]
            .as_constant()
            .ok_or(TranslationError::ExpectedConstantOperand);
        let second_index = match second_constant.unwrap() {
            Constant::Int { value, .. } => value.clone(),
            _ => return Err(TranslationError::NonIntegerIndex),
        };

        Ok(())
    }

    pub fn allocate_tuple(&mut self, name: &Name) {
        self.local
            .variables
            .insert(name_to_string(name), VariableValue::Tuple(vec![]));
    }
}

#[cfg(test)]
mod tests {
    use crate::environment::Environment;

    #[test]
    fn test_resolve_alias() {}
}
