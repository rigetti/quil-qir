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
pub mod block;
pub mod function;

pub mod errors;
pub mod module;
pub mod utilities;

pub use module::translate_module;

type TranslationResult<T> = std::result::Result<T, errors::TranslationError>;

#[cfg(test)]
mod tests {
    use crate::translate::translate_module;
    use crate::translate::utilities::module_entrypoint;
    use std::path::PathBuf;

    /// Some programs are known (and required) to translate, whereas more complex programs are not yet supported
    #[test]
    fn test_known_good_input_programs() {
        let test_data_dir = PathBuf::from(env!("CARGO_MANIFEST_DIR")).join("test/known_good_bc");
        test_data_dir
            .read_dir()
            .expect("failed to read test data directory")
            .for_each(|f| {
                let bc_file_path = f.unwrap().path();
                dbg!(&bc_file_path);
                let module = llvm_ir::Module::from_bc_path(bc_file_path.clone()).unwrap();
                let entrypoint = module_entrypoint(&module).unwrap();

                assert!(
                    translate_module(&module, &entrypoint.name).is_ok(),
                    "failed to translate a previously supported program {:?}",
                    bc_file_path.clone()
                );
            });
    }
}
