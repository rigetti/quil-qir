; ModuleID = 'data/BellState.ll'
source_filename = "data/BellState.ll"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx11.0.0"

%Qubit = type opaque
%Array = type opaque
%Result = type opaque
%String = type opaque

define internal fastcc i64 @Microsoft__Quantum__Qir__Emission__BellState__body() unnamed_addr {
entry:
  %q0 = tail call %Qubit* @__quantum__rt__qubit_allocate()
  %q1 = tail call %Qubit* @__quantum__rt__qubit_allocate()
  tail call void @__quantum__qis__h__body(%Qubit* %q0)
  %__controlQubits__.i = tail call %Array* @__quantum__rt__array_create_1d(i32 8, i64 1)
  %0 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %__controlQubits__.i, i64 0)
  %1 = bitcast i8* %0 to %Qubit**
  store %Qubit* %q0, %Qubit** %1, align 8
  tail call void @__quantum__rt__array_update_alias_count(%Array* %__controlQubits__.i, i32 1)
  tail call void @__quantum__qis__x__ctl(%Array* %__controlQubits__.i, %Qubit* %q1)
  tail call void @__quantum__rt__array_update_alias_count(%Array* %__controlQubits__.i, i32 -1)
  tail call void @__quantum__rt__array_update_reference_count(%Array* %__controlQubits__.i, i32 -1)
  %bases.i = tail call %Array* @__quantum__rt__array_create_1d(i32 1, i64 1)
  %2 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %bases.i, i64 0)
  %3 = bitcast i8* %2 to i2*
  store i2 -2, i2* %3, align 1
  tail call void @__quantum__rt__array_update_alias_count(%Array* %bases.i, i32 1)
  %qubits.i = tail call %Array* @__quantum__rt__array_create_1d(i32 8, i64 1)
  %4 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %qubits.i, i64 0)
  %5 = bitcast i8* %4 to %Qubit**
  store %Qubit* %q0, %Qubit** %5, align 8
  tail call void @__quantum__rt__array_update_alias_count(%Array* %qubits.i, i32 1)
  %6 = tail call %Result* @__quantum__qis__measure__body(%Array* %bases.i, %Array* %qubits.i)
  tail call void @__quantum__rt__array_update_alias_count(%Array* %bases.i, i32 -1)
  tail call void @__quantum__rt__array_update_alias_count(%Array* %qubits.i, i32 -1)
  tail call void @__quantum__rt__array_update_reference_count(%Array* %bases.i, i32 -1)
  tail call void @__quantum__rt__array_update_reference_count(%Array* %qubits.i, i32 -1)
  %7 = tail call %Result* @__quantum__rt__result_get_one()
  %8 = tail call i1 @__quantum__rt__result_equal(%Result* %6, %Result* %7)
  %spec.select = zext i1 %8 to i64
  tail call void @__quantum__rt__result_update_reference_count(%Result* %6, i32 -1)
  tail call void @__quantum__rt__qubit_release(%Qubit* %q0)
  tail call void @__quantum__rt__qubit_release(%Qubit* %q1)
  ret i64 %spec.select
}

declare %Qubit* @__quantum__rt__qubit_allocate() local_unnamed_addr

declare void @__quantum__rt__qubit_release(%Qubit*) local_unnamed_addr

declare void @__quantum__qis__h__body(%Qubit*) local_unnamed_addr

declare %Result* @__quantum__rt__result_get_one() local_unnamed_addr

declare i1 @__quantum__rt__result_equal(%Result*, %Result*) local_unnamed_addr

declare void @__quantum__rt__result_update_reference_count(%Result*, i32) local_unnamed_addr

declare void @__quantum__rt__array_update_alias_count(%Array*, i32) local_unnamed_addr

declare void @__quantum__rt__array_update_reference_count(%Array*, i32) local_unnamed_addr

declare %Array* @__quantum__rt__array_create_1d(i32, i64) local_unnamed_addr

declare i8* @__quantum__rt__array_get_element_ptr_1d(%Array*, i64) local_unnamed_addr

declare void @__quantum__qis__x__ctl(%Array*, %Qubit*) local_unnamed_addr

declare %Result* @__quantum__qis__measure__body(%Array*, %Array*) local_unnamed_addr

define i64 @Microsoft__Quantum__Qir__Emission__BellState__Interop(i64 %nrIter) local_unnamed_addr #0 {
entry:
  %0 = tail call fastcc i64 @Microsoft__Quantum__Qir__Emission__BellState__body()
  ret i64 %0
}

define void @Microsoft__Quantum__Qir__Emission__BellState(i64 %nrIter) local_unnamed_addr #1 {
entry:
  %0 = tail call fastcc i64 @Microsoft__Quantum__Qir__Emission__BellState__body()
  %1 = tail call %String* @__quantum__rt__int_to_string(i64 %0)
  tail call void @__quantum__rt__message(%String* %1)
  tail call void @__quantum__rt__string_update_reference_count(%String* %1, i32 -1)
  ret void
}

declare void @__quantum__rt__message(%String*) local_unnamed_addr

declare %String* @__quantum__rt__int_to_string(i64) local_unnamed_addr

declare void @__quantum__rt__string_update_reference_count(%String*, i32) local_unnamed_addr

attributes #0 = { "InteropFriendly" }
attributes #1 = { "EntryPoint" }
