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
use quil::program::Program;
use std::path::PathBuf;

use structopt::StructOpt;
use translate::errors::TranslationError;
use translate::utilities::module_entrypoint;

#[macro_use]
mod macros;

mod environment;
mod translate;

#[derive(StructOpt, Debug)]
#[structopt(name = "QIRQuilTranslator", about = "Translate QIR to Quil")]
enum QIRQuilCLI {
    #[structopt(
        name = "translate",
        about = "Translate Quil read from stdin into a ControllerJob"
    )]
    Translate {
        #[structopt(
            long = "input-llvm-ir-path",
            about = "relative path to LLVM bytecode (.bc) for translation"
        )]
        llvm_ir_path: PathBuf,
    },
}

fn main() -> Result<(), TranslationError> {
    let opt = QIRQuilCLI::from_args();
    match opt {
        QIRQuilCLI::Translate { llvm_ir_path } => {
            let module = match Module::from_bc_path(llvm_ir_path) {
                Ok(m) => m,
                Err(_) => return Err(TranslationError::InvalidLLVMByteCode),
            };
            let entrypoint = module_entrypoint(&module).ok_or(TranslationError::NoEntryPoint)?;
            let instructions = translate::translate_module(&module, &entrypoint.name)?;
            let mut program = Program::new();
            program.instructions = instructions;

            println!("{}", program.to_string(true));
        }
    }

    Ok(())
}
