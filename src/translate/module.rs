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
use quil::instruction::{Instruction as QuilInstruction, ScalarType, Vector};

use crate::{
    environment::{
        variable::{VariableDataType, VariableType},
        GlobalEnvironment,
    },
    translate::{errors::TranslationError, function, utilities, TranslationResult},
};

pub fn translate_module(
    module: &Module,
    entrypoint_name: &str,
) -> TranslationResult<Vec<QuilInstruction>> {
    let mut global_env: GlobalEnvironment = Default::default();

    // Look up the name of the entrypoint function and translate its body. The
    // entrypoint function is not included in the output: instead, the body of
    // the entrypoint function is inserted as the "top level" instruction(s)
    // which is typically a call to another function (circuit) where the meat of
    // the program is invoked.
    let function = module
        .get_func_by_name(entrypoint_name)
        .ok_or_else(|| TranslationError::UndefinedEntryPoint(entrypoint_name.to_string()))?;

    // Entrypoint args are treated as globals. Store them in the global
    // environment...
    function.parameters.iter().for_each(|p| {
        let data_type = if is_qubit_type!(p.ty) {
            VariableDataType::Qubit
        } else {
            VariableDataType::Scalar(ScalarType::Integer)
        };

        global_env.variables.insert(
            utilities::name_to_label(entrypoint_name, &p.name),
            // TODO: determine correct type
            VariableType {
                is_array: false,
                data_type,
            },
        );
    });

    let instructions: TranslationResult<Vec<QuilInstruction>> = function
        .parameters
        .iter()
        .map(|p| utilities::parameter_to_declare(p))
        .collect();

    // There must be a way to incorporate this into the above line...
    let mut instructions = instructions?;

    // Recursively translate the body of the entrypoint. This will generally look like:
    //   - find a function call in body
    //   - look up function defition
    //     - define an equivalent circuit in the environment
    //     - recurse
    let entry_instructions = function::translate_function_body(module, &function, &mut global_env)?;

    let circuits: Vec<QuilInstruction> = global_env
        .circuit_definitions
        .into_iter()
        .map(|(_, v)| v)
        .collect();

    // Create DECLARE instructions for all variables used
    instructions.extend(
        global_env
            .variables
            .iter()
            .map(|(p, _)| QuilInstruction::Declaration {
                name: p.clone(),
                size: Vector {
                    data_type: quil::instruction::ScalarType::Integer,
                    length: 1,
                }, // TODO: Implement data types
                sharing: None,
            }),
    );

    instructions.extend(circuits);
    instructions.extend(entry_instructions);

    Ok(instructions)
}
