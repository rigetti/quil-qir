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

macro_rules! get_name_from_operand {
    ($operand:expr) => {{
        match $operand {
            llvm_ir::Operand::LocalOperand { name, .. } => Some(name.clone()),
            _ => None,
        }
    }};
}

macro_rules! get_constant_operand_value {
    ($operand:expr) => {{
        match $operand {
            llvm_ir::Operand::ConstantOperand(internal) => match internal.as_ref() {
                llvm_ir::Constant::Int { value, .. } => Some(value),
                _ => None,
            },
            _ => None,
        }
    }};
}

macro_rules! is_qubit_type {
    ($ty:expr) => {
        match $ty.as_ref() {
            llvm_ir::Type::PointerType { pointee_type, .. } => match pointee_type.as_ref() {
                llvm_ir::Type::NamedStructType { ref name } => name == "Qubit",
                _ => false,
            },
            _ => false,
        }
    };
}
