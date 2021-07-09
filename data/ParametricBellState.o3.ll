; ModuleID = 'qir/helloworlq.ll'
source_filename = "qir/helloworlq.ll"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx11.0.0"

%Result = type opaque
%Array = type opaque
%Qubit = type opaque
%String = type opaque

define internal fastcc %Result* @Microsoft__Quantum__Qir__Emission__BellState__body() unnamed_addr {
entry:
  %qubits = tail call %Array* @__quantum__rt__qubit_allocate_array(i64 3)
  tail call void @__quantum__rt__array_update_alias_count(%Array* %qubits, i32 1)
  %0 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %qubits, i64 0)
  %1 = bitcast i8* %0 to %Qubit**
  %2 = load %Qubit*, %Qubit** %1, align 8
  tail call void @__quantum__qis__rx(double 0x3FF921FB54442D18, %Qubit* %2)
  %3 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %qubits, i64 0)
  %4 = bitcast i8* %3 to %Qubit**
  %5 = load %Qubit*, %Qubit** %4, align 8
  %6 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %qubits, i64 1)
  %7 = bitcast i8* %6 to %Qubit**
  %8 = load %Qubit*, %Qubit** %7, align 8
  tail call void @__quantum__qis__cnot(%Qubit* %5, %Qubit* %8)
  %9 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %qubits, i64 0)
  %10 = bitcast i8* %9 to %Qubit**
  %qubit = load %Qubit*, %Qubit** %10, align 8
  %res = tail call %Result* @__quantum__qis__m__body(%Qubit* %qubit)
  tail call void @__quantum__rt__array_update_alias_count(%Array* %qubits, i32 -1)
  tail call void @__quantum__rt__qubit_release_array(%Array* %qubits)
  ret %Result* %res
}

declare %Array* @__quantum__rt__qubit_allocate_array(i64) local_unnamed_addr

declare void @__quantum__rt__qubit_release_array(%Array*) local_unnamed_addr

declare void @__quantum__rt__array_update_alias_count(%Array*, i32) local_unnamed_addr

declare i8* @__quantum__rt__array_get_element_ptr_1d(%Array*, i64) local_unnamed_addr

declare %Result* @__quantum__qis__m__body(%Qubit*) local_unnamed_addr

declare void @__quantum__rt__string_update_reference_count(%String*, i32) local_unnamed_addr

declare void @__quantum__qis__cnot(%Qubit*, %Qubit*) local_unnamed_addr

declare void @__quantum__qis__rx(double, %Qubit*) local_unnamed_addr

define i8 @Microsoft__Quantum__Qir__Emission__BellState__Interop() local_unnamed_addr #0 {
entry:
  %0 = tail call fastcc %Result* @Microsoft__Quantum__Qir__Emission__BellState__body()
  %1 = tail call %Result* @__quantum__rt__result_get_zero()
  %2 = tail call i1 @__quantum__rt__result_equal(%Result* %0, %Result* %1)
  %not. = xor i1 %2, true
  %3 = sext i1 %not. to i8
  tail call void @__quantum__rt__result_update_reference_count(%Result* %0, i32 -1)
  ret i8 %3
}

declare %Result* @__quantum__rt__result_get_zero() local_unnamed_addr

declare i1 @__quantum__rt__result_equal(%Result*, %Result*) local_unnamed_addr

declare void @__quantum__rt__result_update_reference_count(%Result*, i32) local_unnamed_addr

define void @Microsoft__Quantum__Qir__Emission__BellState() local_unnamed_addr #1 {
entry:
  %0 = tail call fastcc %Result* @Microsoft__Quantum__Qir__Emission__BellState__body()
  %1 = tail call %String* @__quantum__rt__result_to_string(%Result* %0)
  tail call void @__quantum__rt__message(%String* %1)
  tail call void @__quantum__rt__result_update_reference_count(%Result* %0, i32 -1)
  tail call void @__quantum__rt__string_update_reference_count(%String* %1, i32 -1)
  ret void
}

declare void @__quantum__rt__message(%String*) local_unnamed_addr

declare %String* @__quantum__rt__result_to_string(%Result*) local_unnamed_addr

attributes #0 = { "InteropFriendly" }
attributes #1 = { "EntryPoint" }
