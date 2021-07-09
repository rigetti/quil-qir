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
use std::collections::HashMap;

use llvm_ir::{Name, Operand};

use super::variable::VariableValue;

/// The LocalEnvironment describes the state of the program within a single scope (circuit definition).
#[derive(Clone, Debug, Default)]
pub struct LocalEnvironment {
    pub variables: HashMap<Name, VariableValue>,
    pub next_qubit_to_allocate: u64,
}

impl LocalEnvironment {
    pub fn store_alias(&mut self, dest: &Name, op: &Operand) {
        if let Operand::LocalOperand {
            name: source_name, ..
        } = op
        {
            let dest_name = dest;

            // println!(
            //     "Storing bitcast: %{} = bitcast %{}",
            //     name_to_string(dest_name),
            //     name_to_string(source_name)
            // );

            self.variables
                .insert(dest_name.clone(), VariableValue::Alias(source_name.clone()));

            //println!("Env after bitcast: {:#?}", env.variables)
        }
    }

    /// Recursively resolve a name to its original definition within a local environment.
    pub fn resolve_alias(&self, source: &Name) -> Option<Name> {
        if let Some(target) = self.variables.get(source) {
            match target {
                VariableValue::Qubit(_) => return Some(source.clone()),
                //Variable::Qubits(_) => return Some((source.clone(), target.to_owned())),
                VariableValue::Array(_) => return Some(source.clone()),
                VariableValue::Alias(target) => return self.resolve_alias(&target),
                VariableValue::Data(_) => todo!(),
            }
        }

        None
    }
}
