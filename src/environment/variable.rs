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
pub enum TupleData {
    Name(String),
    Qubit(Qubit),
    Double(f64),
    // TODO Oddly, llvm_ir defines its Constant::Int as being u64, but interpretation is actually left up to the LLVM
    // instruction. We'll have to cross that bridge soon.
    Integer(u64),
}

impl TupleData {
    pub fn type_of(&self) -> String {
        match self {
            TupleData::Name(_) => "TupleData::Name".to_string(),
            TupleData::Qubit(_) => "TupleData::Qubit".to_string(),
            TupleData::Double(_) => "TupleData::Double".to_string(),
            TupleData::Integer(_) => "TupleData::Integer".to_string(),
        }
    }
}

#[allow(dead_code)]
#[derive(Clone, Debug)]
pub enum VariableValue {
    Data(TupleData),
    QuilData(ScalarType),
    QuilVariable(VariableType),
    Qubit(Qubit),
    Qubits(Vec<Qubit>),
    Array(Vec<TupleData>),
    Tuple(Vec<TupleData>),
    Alias(String),
    Index(String, usize),
}

impl VariableValue {
    pub fn type_of(&self) -> String {
        match self {
            VariableValue::Data(_) => "VariableValue::".to_string(),
            VariableValue::QuilData(_) => "VariableValue::QuilData".to_string(),
            VariableValue::QuilVariable(_) => "VariableValue::QuilVariable".to_string(),
            VariableValue::Qubit(_) => "VariableValue::Qubit".to_string(),
            VariableValue::Qubits(_) => "VariableValue::Qubits".to_string(),
            VariableValue::Array(_) => "VariableValue::Array".to_string(),
            VariableValue::Tuple(_) => "VariableValue::Tuple".to_string(),
            VariableValue::Alias(_) => "VariableValue::Alias".to_string(),
            VariableValue::Index(_, _) => "VariableValue::Index".to_string(),
        }
    }
}
