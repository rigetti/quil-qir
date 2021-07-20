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

use crate::translate::errors::TranslationError;
use crate::translate::utilities::name_to_string;
use crate::translate::TranslationResult;

pub use global::GlobalEnvironment;
pub use local::LocalEnvironment;
pub use variable::VariableValue;

use llvm_ir::{
    instruction::{BitCast, Load},
    Constant, Name, Operand, Type,
};

/// For convenience and brevity, the two environments for use in compilation may be stored and passed together.
pub struct Environment<'a> {
    pub global: &'a mut global::GlobalEnvironment,
    pub local: &'a mut local::LocalEnvironment,
}

impl<'a> Environment<'a> {
    /// Recursively resolve a name to its original definition within a local environment.
    pub fn resolve_alias(&self, source: &str) -> Option<String> {
        let mut alias = source;

        while let Some(value) = self.local.variables.get(alias) {
            match value {
                VariableValue::Alias(target) => alias = &target,
                _ => return Some(alias.to_string()),
            }
        }

        while let Some(value) = self.global.variables.get(alias) {
            match value {
                VariableValue::Alias(target) => alias = &target,
                _ => return Some(alias.to_string()),
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
                Constant::GlobalReference { name, .. } => {
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
            let resolved_name = self
                .resolve_alias(&name)
                .ok_or_else(|| TranslationError::CannotResolveLocalVariableName(name.clone()))?;
            let resolved_value = self.local.variables.get(&resolved_name).ok_or_else(|| {
                TranslationError::CannotResolveLocalVariableValue(resolved_name.clone())
            })?;
            if let VariableValue::Tuple(_) = *resolved_value {
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
                                .insert(dest, VariableValue::Index(resolved_name, 0));
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

    pub fn allocate_tuple(&mut self, name: &Name) {
        self.local
            .variables
            .insert(name_to_string(name), VariableValue::Tuple(vec![]));
    }
}
