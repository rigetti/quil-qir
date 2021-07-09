use crate::translate::utilities::module_entrypoint;
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
use llvm_ir::Module;
use pyo3::{exceptions::PyOSError, prelude::*, wrap_pyfunction};
use quil::program::Program;
use translate::errors::TranslationError;

#[macro_use]
mod macros;
mod environment;
mod translate;

impl std::convert::From<TranslationError> for PyErr {
    fn from(err: TranslationError) -> PyErr {
        PyOSError::new_err(err.to_string())
    }
}

/// Transpile the LLVM-assembled QIR into Quil
#[pyfunction]
fn to_quil(bc_path: String) -> PyResult<String> {
    let module = match Module::from_bc_path(bc_path) {
        Ok(m) => m,
        Err(s) => return Err(PyOSError::new_err(s)),
    };
    let entrypoint = module_entrypoint(&module).ok_or(TranslationError::NoEntryPoint)?;
    let instructions = translate::translate_module(&module, &entrypoint.name)?;

    let mut program = Program::new();
    program.instructions = instructions;

    Ok(program.to_string(true))
}

#[pymodule]
fn quil_qir(_py: Python, m: &PyModule) -> PyResult<()> {
    m.add_function(wrap_pyfunction!(to_quil, m)?)?;

    Ok(())
}
