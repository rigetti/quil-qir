use super::variable::VariableValue;
use std::collections::HashMap;

/// The LocalEnvironment describes the state of the program within a single scope (circuit definition).
#[derive(Clone, Debug, Default)]
pub struct LocalEnvironment {
    pub variables: HashMap<String, VariableValue>,
    pub next_qubit_to_allocate: u64,
}

impl LocalEnvironment {}
