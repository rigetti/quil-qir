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

use quil::instruction::Instruction as QuilInstruction;

use crate::environment::variable::VariableValue;

/// The GlobalEnvironment describes the program as a whole, outside the scope of a single defined circuit.
#[derive(Clone, Debug, Default)]
pub struct GlobalEnvironment {
    /// Because all parameters in Quil are themselves global to the program, we use this map to ensure
    /// that only a single datatype is written to a variable of a given name in any constituent circuit.
    pub variables: HashMap<String, VariableValue>,

    /// We accumulate circuit definitions here as they are constructed in a search through the LLVM call graph.
    pub circuit_definitions: HashMap<String, QuilInstruction>,
}
