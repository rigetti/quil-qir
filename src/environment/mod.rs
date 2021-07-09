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
mod global;
mod local;
pub mod variable;

pub use global::GlobalEnvironment;
pub use local::LocalEnvironment;

/// For convenience and brevity, the two environments for use in compilation may be stored and passed together.
pub struct Environment<'a> {
    pub global: &'a mut global::GlobalEnvironment,
    pub local: &'a mut local::LocalEnvironment,
}
