use std::collections::HashMap;

use llvm_ir::{
    instruction::{BitCast, GetElementPtr, Load, Store},
    Constant, Name, Operand, Type, TypeRef,
};
use log::{debug, warn};

use super::variable::VariableValue;
use either::Either;
use llvm_ir::function::ParameterAttribute;
use llvm_ir::instruction::{Call, InlineAssembly};
use std::ops::Deref;

/// The LocalEnvironment describes the state of the program within a single scope (circuit definition).
#[derive(Clone, Debug, Default)]
pub struct LocalEnvironment {
    pub variables: HashMap<String, VariableValue>,
    pub next_qubit_to_allocate: u64,
}

impl LocalEnvironment {}
