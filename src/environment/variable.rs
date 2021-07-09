use llvm_ir::Name;
use quil::instruction::{Qubit, ScalarType};
use std::fmt;

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
            TupleData::Name(_) => format!("TupleData::Name"),
            TupleData::Qubit(_) => format!("TupleData::Qubit"),
            TupleData::Double(_) => format!("TupleData::Double"),
            TupleData::Integer(_) => format!("TupleData::Integer"),
        }
    }
}

#[derive(Clone, Debug)]
pub enum VariableValue {
    #[allow(dead_code)]
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
            VariableValue::Data(_) => format!("VariableValue::"),
            VariableValue::QuilData(_) => format!("VariableValue::QuilData"),
            VariableValue::QuilVariable(_) => format!("VariableValue::QuilVariable"),
            VariableValue::Qubit(_) => format!("VariableValue::Qubit"),
            VariableValue::Qubits(_) => format!("VariableValue::Qubits"),
            VariableValue::Array(_) => format!("VariableValue::Array"),
            VariableValue::Tuple(_) => format!("VariableValue::Tuple"),
            VariableValue::Alias(_) => format!("VariableValue::Alias"),
            VariableValue::Index(_, _) => format!("VariableValue::Index"),
        }
    }
}
