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
use llvm_ir::Name;
use quil::instruction::{Qubit, ScalarType};

/// A VariableType describes the type of a variable reference in a way that's structured for use by Quil.
/// Is it a qubit, or is it scalar data - and in either case, is it an array of the same?
#[derive(Clone, Debug)]
pub struct VariableType {
    /// Whether the corresponding variable represents zero or more of the type. Note that this requires
    /// an array to be of a single type.
    pub is_array: bool,

    /// Which data type may be stored at this reference
    pub data_type: VariableDataType,
}

/// Which type of data may be stored at the reference described by this type.
#[derive(Clone, Debug)]
pub enum VariableDataType {
    Qubit,
    Scalar(ScalarType),
}

#[derive(Clone, Debug)]
pub enum VariableValue {
    #[allow(dead_code)]
    Data(ScalarType),
    Qubit(Qubit),
    //Qubits(Vec<Qubit>),
    Array(Vec<Name>),
    Alias(Name),
}
