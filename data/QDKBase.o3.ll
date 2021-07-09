; ModuleID = 'data/QDKBase.ll'
source_filename = "data/QDKBase.ll"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx11.0.0"

%Tuple = type opaque
%Qubit = type opaque
%Array = type opaque
%Result = type opaque
%Callable = type opaque

@Microsoft__Quantum__Intrinsic__H = internal constant [4 x void (%Tuple*, %Tuple*, %Tuple*)*] [void (%Tuple*, %Tuple*, %Tuple*)* @Microsoft__Quantum__Intrinsic__H__body__wrapper, void (%Tuple*, %Tuple*, %Tuple*)* @Microsoft__Quantum__Intrinsic__H__adj__wrapper, void (%Tuple*, %Tuple*, %Tuple*)* @Microsoft__Quantum__Intrinsic__H__ctl__wrapper, void (%Tuple*, %Tuple*, %Tuple*)* @Microsoft__Quantum__Intrinsic__H__ctladj__wrapper]
@Microsoft__Quantum__Intrinsic__Rx = internal constant [4 x void (%Tuple*, %Tuple*, %Tuple*)*] [void (%Tuple*, %Tuple*, %Tuple*)* @Microsoft__Quantum__Intrinsic__Rx__body__wrapper, void (%Tuple*, %Tuple*, %Tuple*)* @Microsoft__Quantum__Intrinsic__Rx__adj__wrapper, void (%Tuple*, %Tuple*, %Tuple*)* @Microsoft__Quantum__Intrinsic__Rx__ctl__wrapper, void (%Tuple*, %Tuple*, %Tuple*)* @Microsoft__Quantum__Intrinsic__Rx__ctladj__wrapper]
@Microsoft__Quantum__Intrinsic__Ry = internal constant [4 x void (%Tuple*, %Tuple*, %Tuple*)*] [void (%Tuple*, %Tuple*, %Tuple*)* @Microsoft__Quantum__Intrinsic__Ry__body__wrapper, void (%Tuple*, %Tuple*, %Tuple*)* @Microsoft__Quantum__Intrinsic__Ry__adj__wrapper, void (%Tuple*, %Tuple*, %Tuple*)* @Microsoft__Quantum__Intrinsic__Ry__ctl__wrapper, void (%Tuple*, %Tuple*, %Tuple*)* @Microsoft__Quantum__Intrinsic__Ry__ctladj__wrapper]
@Microsoft__Quantum__Intrinsic__Rz = internal constant [4 x void (%Tuple*, %Tuple*, %Tuple*)*] [void (%Tuple*, %Tuple*, %Tuple*)* @Microsoft__Quantum__Intrinsic__Rz__body__wrapper, void (%Tuple*, %Tuple*, %Tuple*)* @Microsoft__Quantum__Intrinsic__Rz__adj__wrapper, void (%Tuple*, %Tuple*, %Tuple*)* @Microsoft__Quantum__Intrinsic__Rz__ctl__wrapper, void (%Tuple*, %Tuple*, %Tuple*)* @Microsoft__Quantum__Intrinsic__Rz__ctladj__wrapper]
@Microsoft__Quantum__Intrinsic__S = internal constant [4 x void (%Tuple*, %Tuple*, %Tuple*)*] [void (%Tuple*, %Tuple*, %Tuple*)* @Microsoft__Quantum__Intrinsic__S__body__wrapper, void (%Tuple*, %Tuple*, %Tuple*)* @Microsoft__Quantum__Intrinsic__S__adj__wrapper, void (%Tuple*, %Tuple*, %Tuple*)* @Microsoft__Quantum__Intrinsic__S__ctl__wrapper, void (%Tuple*, %Tuple*, %Tuple*)* @Microsoft__Quantum__Intrinsic__S__ctladj__wrapper]
@Microsoft__Quantum__Intrinsic__T = internal constant [4 x void (%Tuple*, %Tuple*, %Tuple*)*] [void (%Tuple*, %Tuple*, %Tuple*)* @Microsoft__Quantum__Intrinsic__T__body__wrapper, void (%Tuple*, %Tuple*, %Tuple*)* @Microsoft__Quantum__Intrinsic__T__adj__wrapper, void (%Tuple*, %Tuple*, %Tuple*)* @Microsoft__Quantum__Intrinsic__T__ctl__wrapper, void (%Tuple*, %Tuple*, %Tuple*)* @Microsoft__Quantum__Intrinsic__T__ctladj__wrapper]
@Microsoft__Quantum__Intrinsic__X = internal constant [4 x void (%Tuple*, %Tuple*, %Tuple*)*] [void (%Tuple*, %Tuple*, %Tuple*)* @Microsoft__Quantum__Intrinsic__X__body__wrapper, void (%Tuple*, %Tuple*, %Tuple*)* @Microsoft__Quantum__Intrinsic__X__adj__wrapper, void (%Tuple*, %Tuple*, %Tuple*)* @Microsoft__Quantum__Intrinsic__X__ctl__wrapper, void (%Tuple*, %Tuple*, %Tuple*)* @Microsoft__Quantum__Intrinsic__X__ctladj__wrapper]
@Microsoft__Quantum__Intrinsic__Y = internal constant [4 x void (%Tuple*, %Tuple*, %Tuple*)*] [void (%Tuple*, %Tuple*, %Tuple*)* @Microsoft__Quantum__Intrinsic__Y__body__wrapper, void (%Tuple*, %Tuple*, %Tuple*)* @Microsoft__Quantum__Intrinsic__Y__adj__wrapper, void (%Tuple*, %Tuple*, %Tuple*)* @Microsoft__Quantum__Intrinsic__Y__ctl__wrapper, void (%Tuple*, %Tuple*, %Tuple*)* @Microsoft__Quantum__Intrinsic__Y__ctladj__wrapper]
@Microsoft__Quantum__Intrinsic__Z = internal constant [4 x void (%Tuple*, %Tuple*, %Tuple*)*] [void (%Tuple*, %Tuple*, %Tuple*)* @Microsoft__Quantum__Intrinsic__Z__body__wrapper, void (%Tuple*, %Tuple*, %Tuple*)* @Microsoft__Quantum__Intrinsic__Z__adj__wrapper, void (%Tuple*, %Tuple*, %Tuple*)* @Microsoft__Quantum__Intrinsic__Z__ctl__wrapper, void (%Tuple*, %Tuple*, %Tuple*)* @Microsoft__Quantum__Intrinsic__Z__ctladj__wrapper]

define internal fastcc void @Microsoft__Quantum__Qir__Emission__BellState__body() unnamed_addr {
entry:
  %q0 = tail call %Qubit* @__quantum__rt__qubit_allocate()
  %q1 = tail call %Qubit* @__quantum__rt__qubit_allocate()
  %q2 = tail call %Qubit* @__quantum__rt__qubit_allocate()
  %0 = tail call %Array* @__quantum__rt__array_create_1d(i32 8, i64 1)
  %1 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %0, i64 0)
  %2 = bitcast i8* %1 to %Qubit**
  store %Qubit* %q0, %Qubit** %2, align 8
  tail call void @__quantum__rt__array_update_alias_count(%Array* %0, i32 1)
  tail call void @__quantum__rt__array_update_alias_count(%Array* %0, i32 -1)
  tail call void @__quantum__qis__rx(double 0x400921FB54442D18, %Qubit* %q0)
  tail call void @__quantum__qis__rx(double 0xC00921FB54442D18, %Qubit* %q0)
  %3 = tail call %Array* @__quantum__rt__array_create_1d(i32 8, i64 1)
  %4 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %3, i64 0)
  %5 = bitcast i8* %4 to %Qubit**
  store %Qubit* %q0, %Qubit** %5, align 8
  %6 = tail call %Tuple* @__quantum__rt__tuple_create(i64 16)
  %7 = bitcast %Tuple* %6 to { double, %Qubit* }*
  %8 = bitcast %Tuple* %6 to double*
  %9 = getelementptr inbounds { double, %Qubit* }, { double, %Qubit* }* %7, i64 0, i32 1
  store double 0x400921FB54442D18, double* %8, align 8
  store %Qubit* %q1, %Qubit** %9, align 8
  tail call fastcc void @Microsoft__Quantum__Intrinsic__Rx__ctl(%Array* %3, { double, %Qubit* }* %7)
  tail call void @__quantum__qis__ry(double 0x3FF921FB54442D18, %Qubit* %q1)
  tail call void @__quantum__qis__ry(double 0xBFF921FB54442D18, %Qubit* %q1)
  %10 = tail call %Array* @__quantum__rt__array_create_1d(i32 8, i64 1)
  %11 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %10, i64 0)
  %12 = bitcast i8* %11 to %Qubit**
  store %Qubit* %q1, %Qubit** %12, align 8
  %13 = tail call %Tuple* @__quantum__rt__tuple_create(i64 16)
  %14 = bitcast %Tuple* %13 to { double, %Qubit* }*
  %15 = bitcast %Tuple* %13 to double*
  %16 = getelementptr inbounds { double, %Qubit* }, { double, %Qubit* }* %14, i64 0, i32 1
  store double 0x3FF921FB54442D18, double* %15, align 8
  store %Qubit* %q2, %Qubit** %16, align 8
  tail call fastcc void @Microsoft__Quantum__Intrinsic__Ry__ctl(%Array* %10, { double, %Qubit* }* %14)
  tail call void @__quantum__qis__rz(double 0x3FF0C152382D7365, %Qubit* %q2)
  tail call void @__quantum__qis__rz(double 0xBFF0C152382D7365, %Qubit* %q2)
  %17 = tail call %Array* @__quantum__rt__array_create_1d(i32 8, i64 1)
  %18 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %17, i64 0)
  %19 = bitcast i8* %18 to %Qubit**
  store %Qubit* %q1, %Qubit** %19, align 8
  %20 = tail call %Tuple* @__quantum__rt__tuple_create(i64 16)
  %21 = bitcast %Tuple* %20 to { double, %Qubit* }*
  %22 = bitcast %Tuple* %20 to double*
  %23 = getelementptr inbounds { double, %Qubit* }, { double, %Qubit* }* %21, i64 0, i32 1
  store double 0x3FF0C152382D7365, double* %22, align 8
  store %Qubit* %q2, %Qubit** %23, align 8
  tail call fastcc void @Microsoft__Quantum__Intrinsic__Rz__ctl(%Array* %17, { double, %Qubit* }* %21)
  tail call void @__quantum__qis__x(%Qubit* %q0)
  tail call void @__quantum__qis__x(%Qubit* %q0)
  %24 = tail call %Array* @__quantum__rt__array_create_1d(i32 8, i64 1)
  %25 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %24, i64 0)
  %26 = bitcast i8* %25 to %Qubit**
  store %Qubit* %q0, %Qubit** %26, align 8
  tail call fastcc void @Microsoft__Quantum__Intrinsic__X__ctl(%Array* %24, %Qubit* %q1)
  tail call void @__quantum__qis__y(%Qubit* %q1)
  tail call void @__quantum__qis__y(%Qubit* %q1)
  %27 = tail call %Array* @__quantum__rt__array_create_1d(i32 8, i64 1)
  %28 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %27, i64 0)
  %29 = bitcast i8* %28 to %Qubit**
  store %Qubit* %q1, %Qubit** %29, align 8
  tail call fastcc void @Microsoft__Quantum__Intrinsic__Y__ctl(%Array* %27, %Qubit* %q2)
  tail call void @__quantum__qis__z(%Qubit* %q2)
  tail call void @__quantum__qis__z(%Qubit* %q2)
  %30 = tail call %Array* @__quantum__rt__array_create_1d(i32 8, i64 1)
  %31 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %30, i64 0)
  %32 = bitcast i8* %31 to %Qubit**
  store %Qubit* %q1, %Qubit** %32, align 8
  tail call fastcc void @Microsoft__Quantum__Intrinsic__Z__ctl(%Array* %30, %Qubit* %q2)
  tail call void @__quantum__qis__h(%Qubit* %q0)
  tail call void @__quantum__qis__h(%Qubit* %q0)
  %33 = tail call %Array* @__quantum__rt__array_create_1d(i32 8, i64 1)
  %34 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %33, i64 0)
  %35 = bitcast i8* %34 to %Qubit**
  store %Qubit* %q0, %Qubit** %35, align 8
  tail call fastcc void @Microsoft__Quantum__Intrinsic__H__ctl(%Array* %33, %Qubit* %q1)
  tail call void @__quantum__qis__t(%Qubit* %q0)
  tail call void @__quantum__qis__tadj(%Qubit* %q0)
  %36 = tail call %Array* @__quantum__rt__array_create_1d(i32 8, i64 1)
  %37 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %36, i64 0)
  %38 = bitcast i8* %37 to %Qubit**
  store %Qubit* %q0, %Qubit** %38, align 8
  tail call fastcc void @Microsoft__Quantum__Intrinsic__T__ctl(%Array* %36, %Qubit* %q1)
  tail call void @__quantum__qis__s(%Qubit* %q0)
  tail call void @__quantum__qis__sadj(%Qubit* %q0)
  %39 = tail call %Array* @__quantum__rt__array_create_1d(i32 8, i64 1)
  %40 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %39, i64 0)
  %41 = bitcast i8* %40 to %Qubit**
  store %Qubit* %q0, %Qubit** %41, align 8
  tail call fastcc void @Microsoft__Quantum__Intrinsic__S__ctl(%Array* %39, %Qubit* %q1)
  tail call void @__quantum__qis__swap(%Qubit* %q0, %Qubit* %q2)
  tail call void @__quantum__qis__cnot(%Qubit* %q0, %Qubit* %q1)
  tail call void @__quantum__qis__h(%Qubit* %q2)
  %42 = tail call %Array* @__quantum__rt__array_create_1d(i32 8, i64 2)
  %43 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %42, i64 0)
  %44 = bitcast i8* %43 to %Qubit**
  %45 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %42, i64 1)
  %46 = bitcast i8* %45 to %Qubit**
  store %Qubit* %q0, %Qubit** %44, align 8
  store %Qubit* %q1, %Qubit** %46, align 8
  tail call fastcc void @Microsoft__Quantum__Intrinsic__Z__ctl(%Array* %42, %Qubit* %q2)
  tail call void @__quantum__qis__h(%Qubit* %q2)
  tail call void @__quantum__rt__array_update_reference_count(%Array* %42, i32 -1)
  %47 = tail call %Result* @__quantum__qis__m__body(%Qubit* %q0)
  %48 = tail call %Result* @__quantum__qis__m__body(%Qubit* %q1)
  %49 = tail call %Result* @__quantum__qis__m__body(%Qubit* %q2)
  tail call void @__quantum__rt__array_update_reference_count(%Array* %0, i32 -1)
  tail call void @__quantum__rt__array_update_reference_count(%Array* %3, i32 -1)
  tail call void @__quantum__rt__tuple_update_reference_count(%Tuple* %6, i32 -1)
  tail call void @__quantum__rt__array_update_reference_count(%Array* %10, i32 -1)
  tail call void @__quantum__rt__tuple_update_reference_count(%Tuple* %13, i32 -1)
  tail call void @__quantum__rt__array_update_reference_count(%Array* %17, i32 -1)
  tail call void @__quantum__rt__tuple_update_reference_count(%Tuple* %20, i32 -1)
  tail call void @__quantum__rt__array_update_reference_count(%Array* %24, i32 -1)
  tail call void @__quantum__rt__array_update_reference_count(%Array* %27, i32 -1)
  tail call void @__quantum__rt__array_update_reference_count(%Array* %30, i32 -1)
  tail call void @__quantum__rt__array_update_reference_count(%Array* %33, i32 -1)
  tail call void @__quantum__rt__array_update_reference_count(%Array* %36, i32 -1)
  tail call void @__quantum__rt__array_update_reference_count(%Array* %39, i32 -1)
  tail call void @__quantum__rt__result_update_reference_count(%Result* %47, i32 -1)
  tail call void @__quantum__rt__result_update_reference_count(%Result* %48, i32 -1)
  tail call void @__quantum__rt__result_update_reference_count(%Result* %49, i32 -1)
  tail call void @__quantum__rt__qubit_release(%Qubit* %q0)
  tail call void @__quantum__rt__qubit_release(%Qubit* %q1)
  tail call void @__quantum__rt__qubit_release(%Qubit* %q2)
  ret void
}

declare %Qubit* @__quantum__rt__qubit_allocate() local_unnamed_addr

declare %Array* @__quantum__rt__qubit_allocate_array(i64) local_unnamed_addr

declare void @__quantum__rt__qubit_release(%Qubit*) local_unnamed_addr

declare %Array* @__quantum__rt__array_create_1d(i32, i64) local_unnamed_addr

declare i8* @__quantum__rt__array_get_element_ptr_1d(%Array*, i64) local_unnamed_addr

define internal fastcc void @Microsoft__Quantum__Intrinsic__Rx__ctl(%Array* %ctls, { double, %Qubit* }* nocapture readonly %0) unnamed_addr {
entry:
  tail call void @__quantum__rt__array_update_alias_count(%Array* %ctls, i32 1)
  %1 = getelementptr inbounds { double, %Qubit* }, { double, %Qubit* }* %0, i64 0, i32 0
  %theta = load double, double* %1, align 8
  %2 = getelementptr inbounds { double, %Qubit* }, { double, %Qubit* }* %0, i64 0, i32 1
  %qubit = load %Qubit*, %Qubit** %2, align 8
  %3 = tail call i64 @__quantum__rt__array_get_size_1d(%Array* %ctls)
  %4 = icmp eq i64 %3, 0
  br i1 %4, label %then0__1, label %test1__1

then0__1:                                         ; preds = %entry
  tail call void @__quantum__qis__rx(double %theta, %Qubit* %qubit)
  br label %continue__1

test1__1:                                         ; preds = %entry
  %5 = tail call i64 @__quantum__rt__array_get_size_1d(%Array* %ctls)
  %6 = icmp eq i64 %5, 1
  br i1 %6, label %then1__1, label %else__1

then1__1:                                         ; preds = %test1__1
  tail call void @__quantum__qis__h(%Qubit* %qubit)
  %7 = tail call %Tuple* @__quantum__rt__tuple_create(i64 16)
  %8 = bitcast %Tuple* %7 to { double, %Qubit* }*
  %9 = bitcast %Tuple* %7 to double*
  %10 = getelementptr inbounds { double, %Qubit* }, { double, %Qubit* }* %8, i64 0, i32 1
  store double %theta, double* %9, align 8
  store %Qubit* %qubit, %Qubit** %10, align 8
  tail call fastcc void @Microsoft__Quantum__Intrinsic__Rz__ctl(%Array* %ctls, { double, %Qubit* }* %8)
  tail call void @__quantum__qis__h(%Qubit* %qubit)
  tail call void @__quantum__rt__tuple_update_reference_count(%Tuple* %7, i32 -1)
  br label %continue__1

else__1:                                          ; preds = %test1__1
  %11 = tail call %Callable* @__quantum__rt__callable_create([4 x void (%Tuple*, %Tuple*, %Tuple*)*]* nonnull @Microsoft__Quantum__Intrinsic__Rx, [2 x void (%Tuple*, i32)*]* null, %Tuple* null)
  tail call void @__quantum__rt__callable_make_controlled(%Callable* %11)
  %12 = tail call %Tuple* @__quantum__rt__tuple_create(i64 16)
  %13 = bitcast %Tuple* %12 to { %Array*, { double, %Qubit* }* }*
  %14 = bitcast %Tuple* %12 to %Array**
  %15 = getelementptr inbounds { %Array*, { double, %Qubit* }* }, { %Array*, { double, %Qubit* }* }* %13, i64 0, i32 1
  tail call void @__quantum__rt__array_update_reference_count(%Array* %ctls, i32 1)
  %16 = tail call %Tuple* @__quantum__rt__tuple_create(i64 16)
  %17 = bitcast %Tuple* %16 to { double, %Qubit* }*
  %18 = bitcast %Tuple* %16 to double*
  %19 = getelementptr inbounds { double, %Qubit* }, { double, %Qubit* }* %17, i64 0, i32 1
  store double %theta, double* %18, align 8
  store %Qubit* %qubit, %Qubit** %19, align 8
  store %Array* %ctls, %Array** %14, align 8
  %20 = bitcast { double, %Qubit* }** %15 to %Tuple**
  store %Tuple* %16, %Tuple** %20, align 8
  tail call fastcc void @Microsoft__Quantum__Intrinsic___109d0035958c411fac59e9f8a62cbed1___QsRef23__ApplyWithLessControlsA____body(%Callable* %11, { %Array*, { double, %Qubit* }* }* %13)
  tail call void @__quantum__rt__capture_update_reference_count(%Callable* %11, i32 -1)
  tail call void @__quantum__rt__callable_update_reference_count(%Callable* %11, i32 -1)
  tail call void @__quantum__rt__array_update_reference_count(%Array* %ctls, i32 -1)
  tail call void @__quantum__rt__tuple_update_reference_count(%Tuple* %16, i32 -1)
  tail call void @__quantum__rt__tuple_update_reference_count(%Tuple* %12, i32 -1)
  br label %continue__1

continue__1:                                      ; preds = %else__1, %then1__1, %then0__1
  tail call void @__quantum__rt__array_update_alias_count(%Array* %ctls, i32 -1)
  ret void
}

declare %Tuple* @__quantum__rt__tuple_create(i64) local_unnamed_addr

define internal fastcc void @Microsoft__Quantum__Intrinsic__Ry__ctl(%Array* %ctls, { double, %Qubit* }* nocapture readonly %0) unnamed_addr {
entry:
  tail call void @__quantum__rt__array_update_alias_count(%Array* %ctls, i32 1)
  %1 = getelementptr inbounds { double, %Qubit* }, { double, %Qubit* }* %0, i64 0, i32 0
  %theta = load double, double* %1, align 8
  %2 = getelementptr inbounds { double, %Qubit* }, { double, %Qubit* }* %0, i64 0, i32 1
  %qubit = load %Qubit*, %Qubit** %2, align 8
  %3 = tail call i64 @__quantum__rt__array_get_size_1d(%Array* %ctls)
  %4 = icmp eq i64 %3, 0
  br i1 %4, label %then0__1, label %test1__1

then0__1:                                         ; preds = %entry
  tail call void @__quantum__qis__ry(double %theta, %Qubit* %qubit)
  br label %continue__1

test1__1:                                         ; preds = %entry
  %5 = tail call i64 @__quantum__rt__array_get_size_1d(%Array* %ctls)
  %6 = icmp eq i64 %5, 1
  br i1 %6, label %then1__1, label %else__1

then1__1:                                         ; preds = %test1__1
  tail call void @__quantum__qis__h(%Qubit* %qubit)
  tail call void @__quantum__qis__s(%Qubit* %qubit)
  tail call void @__quantum__qis__h(%Qubit* %qubit)
  %7 = tail call %Tuple* @__quantum__rt__tuple_create(i64 16)
  %8 = bitcast %Tuple* %7 to { double, %Qubit* }*
  %9 = bitcast %Tuple* %7 to double*
  %10 = getelementptr inbounds { double, %Qubit* }, { double, %Qubit* }* %8, i64 0, i32 1
  store double %theta, double* %9, align 8
  store %Qubit* %qubit, %Qubit** %10, align 8
  tail call fastcc void @Microsoft__Quantum__Intrinsic__Rz__ctl(%Array* %ctls, { double, %Qubit* }* %8)
  tail call void @__quantum__qis__h(%Qubit* %qubit)
  tail call void @__quantum__qis__sadj(%Qubit* %qubit)
  tail call void @__quantum__qis__h(%Qubit* %qubit)
  tail call void @__quantum__rt__tuple_update_reference_count(%Tuple* %7, i32 -1)
  br label %continue__1

else__1:                                          ; preds = %test1__1
  %11 = tail call %Callable* @__quantum__rt__callable_create([4 x void (%Tuple*, %Tuple*, %Tuple*)*]* nonnull @Microsoft__Quantum__Intrinsic__Ry, [2 x void (%Tuple*, i32)*]* null, %Tuple* null)
  tail call void @__quantum__rt__callable_make_controlled(%Callable* %11)
  %12 = tail call %Tuple* @__quantum__rt__tuple_create(i64 16)
  %13 = bitcast %Tuple* %12 to { %Array*, { double, %Qubit* }* }*
  %14 = bitcast %Tuple* %12 to %Array**
  %15 = getelementptr inbounds { %Array*, { double, %Qubit* }* }, { %Array*, { double, %Qubit* }* }* %13, i64 0, i32 1
  tail call void @__quantum__rt__array_update_reference_count(%Array* %ctls, i32 1)
  %16 = tail call %Tuple* @__quantum__rt__tuple_create(i64 16)
  %17 = bitcast %Tuple* %16 to { double, %Qubit* }*
  %18 = bitcast %Tuple* %16 to double*
  %19 = getelementptr inbounds { double, %Qubit* }, { double, %Qubit* }* %17, i64 0, i32 1
  store double %theta, double* %18, align 8
  store %Qubit* %qubit, %Qubit** %19, align 8
  store %Array* %ctls, %Array** %14, align 8
  %20 = bitcast { double, %Qubit* }** %15 to %Tuple**
  store %Tuple* %16, %Tuple** %20, align 8
  tail call fastcc void @Microsoft__Quantum__Intrinsic___109d0035958c411fac59e9f8a62cbed1___QsRef23__ApplyWithLessControlsA____body(%Callable* %11, { %Array*, { double, %Qubit* }* }* %13)
  tail call void @__quantum__rt__capture_update_reference_count(%Callable* %11, i32 -1)
  tail call void @__quantum__rt__callable_update_reference_count(%Callable* %11, i32 -1)
  tail call void @__quantum__rt__array_update_reference_count(%Array* %ctls, i32 -1)
  tail call void @__quantum__rt__tuple_update_reference_count(%Tuple* %16, i32 -1)
  tail call void @__quantum__rt__tuple_update_reference_count(%Tuple* %12, i32 -1)
  br label %continue__1

continue__1:                                      ; preds = %else__1, %then1__1, %then0__1
  tail call void @__quantum__rt__array_update_alias_count(%Array* %ctls, i32 -1)
  ret void
}

define internal fastcc void @Microsoft__Quantum__Intrinsic__Rz__ctl(%Array* %ctls, { double, %Qubit* }* nocapture readonly %0) unnamed_addr {
entry:
  tail call void @__quantum__rt__array_update_alias_count(%Array* %ctls, i32 1)
  %1 = getelementptr inbounds { double, %Qubit* }, { double, %Qubit* }* %0, i64 0, i32 0
  %theta = load double, double* %1, align 8
  %2 = getelementptr inbounds { double, %Qubit* }, { double, %Qubit* }* %0, i64 0, i32 1
  %qubit = load %Qubit*, %Qubit** %2, align 8
  %3 = tail call i64 @__quantum__rt__array_get_size_1d(%Array* %ctls)
  %4 = icmp eq i64 %3, 0
  br i1 %4, label %then0__1, label %test1__1

then0__1:                                         ; preds = %entry
  tail call void @__quantum__qis__rz(double %theta, %Qubit* %qubit)
  br label %continue__1

test1__1:                                         ; preds = %entry
  %5 = tail call i64 @__quantum__rt__array_get_size_1d(%Array* %ctls)
  %6 = icmp eq i64 %5, 1
  br i1 %6, label %then1__1, label %else__1

then1__1:                                         ; preds = %test1__1
  %7 = fmul double %theta, 5.000000e-01
  tail call void @__quantum__qis__rz(double %7, %Qubit* %qubit)
  %8 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %ctls, i64 0)
  %9 = bitcast i8* %8 to %Qubit**
  %10 = load %Qubit*, %Qubit** %9, align 8
  tail call void @__quantum__qis__cnot(%Qubit* %10, %Qubit* %qubit)
  %11 = fmul double %theta, -5.000000e-01
  tail call void @__quantum__qis__rz(double %11, %Qubit* %qubit)
  %12 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %ctls, i64 0)
  %13 = bitcast i8* %12 to %Qubit**
  %14 = load %Qubit*, %Qubit** %13, align 8
  tail call void @__quantum__qis__cnot(%Qubit* %14, %Qubit* %qubit)
  br label %continue__1

else__1:                                          ; preds = %test1__1
  %15 = tail call %Callable* @__quantum__rt__callable_create([4 x void (%Tuple*, %Tuple*, %Tuple*)*]* nonnull @Microsoft__Quantum__Intrinsic__Rz, [2 x void (%Tuple*, i32)*]* null, %Tuple* null)
  tail call void @__quantum__rt__callable_make_controlled(%Callable* %15)
  %16 = tail call %Tuple* @__quantum__rt__tuple_create(i64 16)
  %17 = bitcast %Tuple* %16 to { %Array*, { double, %Qubit* }* }*
  %18 = bitcast %Tuple* %16 to %Array**
  %19 = getelementptr inbounds { %Array*, { double, %Qubit* }* }, { %Array*, { double, %Qubit* }* }* %17, i64 0, i32 1
  tail call void @__quantum__rt__array_update_reference_count(%Array* %ctls, i32 1)
  %20 = tail call %Tuple* @__quantum__rt__tuple_create(i64 16)
  %21 = bitcast %Tuple* %20 to { double, %Qubit* }*
  %22 = bitcast %Tuple* %20 to double*
  %23 = getelementptr inbounds { double, %Qubit* }, { double, %Qubit* }* %21, i64 0, i32 1
  store double %theta, double* %22, align 8
  store %Qubit* %qubit, %Qubit** %23, align 8
  store %Array* %ctls, %Array** %18, align 8
  %24 = bitcast { double, %Qubit* }** %19 to %Tuple**
  store %Tuple* %20, %Tuple** %24, align 8
  tail call fastcc void @Microsoft__Quantum__Intrinsic___109d0035958c411fac59e9f8a62cbed1___QsRef23__ApplyWithLessControlsA____body(%Callable* %15, { %Array*, { double, %Qubit* }* }* %17)
  tail call void @__quantum__rt__capture_update_reference_count(%Callable* %15, i32 -1)
  tail call void @__quantum__rt__callable_update_reference_count(%Callable* %15, i32 -1)
  tail call void @__quantum__rt__array_update_reference_count(%Array* %ctls, i32 -1)
  tail call void @__quantum__rt__tuple_update_reference_count(%Tuple* %20, i32 -1)
  tail call void @__quantum__rt__tuple_update_reference_count(%Tuple* %16, i32 -1)
  br label %continue__1

continue__1:                                      ; preds = %else__1, %then1__1, %then0__1
  tail call void @__quantum__rt__array_update_alias_count(%Array* %ctls, i32 -1)
  ret void
}

define internal fastcc void @Microsoft__Quantum__Intrinsic__X__ctl(%Array* %ctls, %Qubit* %qubit) unnamed_addr {
entry:
  tail call void @__quantum__rt__array_update_alias_count(%Array* %ctls, i32 1)
  %0 = tail call i64 @__quantum__rt__array_get_size_1d(%Array* %ctls)
  %1 = icmp eq i64 %0, 0
  br i1 %1, label %then0__1, label %test1__1

then0__1:                                         ; preds = %entry
  tail call void @__quantum__qis__x(%Qubit* %qubit)
  br label %continue__1

test1__1:                                         ; preds = %entry
  %2 = tail call i64 @__quantum__rt__array_get_size_1d(%Array* %ctls)
  %3 = icmp eq i64 %2, 1
  br i1 %3, label %then1__1, label %test2__1

then1__1:                                         ; preds = %test1__1
  %4 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %ctls, i64 0)
  %5 = bitcast i8* %4 to %Qubit**
  %control = load %Qubit*, %Qubit** %5, align 8
  tail call void @__quantum__qis__cnot(%Qubit* %control, %Qubit* %qubit)
  br label %continue__1

test2__1:                                         ; preds = %test1__1
  %6 = tail call i64 @__quantum__rt__array_get_size_1d(%Array* %ctls)
  %7 = icmp eq i64 %6, 2
  br i1 %7, label %then2__1, label %else__1

then2__1:                                         ; preds = %test2__1
  %8 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %ctls, i64 0)
  %9 = bitcast i8* %8 to %Qubit**
  %10 = load %Qubit*, %Qubit** %9, align 8
  %11 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %ctls, i64 1)
  %12 = bitcast i8* %11 to %Qubit**
  %13 = load %Qubit*, %Qubit** %12, align 8
  tail call void @__quantum__qis__h(%Qubit* %qubit)
  %14 = tail call %Array* @__quantum__rt__array_create_1d(i32 8, i64 2)
  %15 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %14, i64 0)
  %16 = bitcast i8* %15 to %Qubit**
  %17 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %14, i64 1)
  %18 = bitcast i8* %17 to %Qubit**
  store %Qubit* %10, %Qubit** %16, align 8
  store %Qubit* %13, %Qubit** %18, align 8
  tail call fastcc void @Microsoft__Quantum__Intrinsic__Z__ctl(%Array* %14, %Qubit* %qubit)
  tail call void @__quantum__qis__h(%Qubit* %qubit)
  tail call void @__quantum__rt__array_update_reference_count(%Array* %14, i32 -1)
  br label %continue__1

else__1:                                          ; preds = %test2__1
  %19 = tail call %Callable* @__quantum__rt__callable_create([4 x void (%Tuple*, %Tuple*, %Tuple*)*]* nonnull @Microsoft__Quantum__Intrinsic__X, [2 x void (%Tuple*, i32)*]* null, %Tuple* null)
  tail call void @__quantum__rt__callable_make_controlled(%Callable* %19)
  %20 = tail call %Tuple* @__quantum__rt__tuple_create(i64 16)
  %21 = bitcast %Tuple* %20 to { %Array*, %Qubit* }*
  %22 = bitcast %Tuple* %20 to %Array**
  %23 = getelementptr inbounds { %Array*, %Qubit* }, { %Array*, %Qubit* }* %21, i64 0, i32 1
  tail call void @__quantum__rt__array_update_reference_count(%Array* %ctls, i32 1)
  store %Array* %ctls, %Array** %22, align 8
  store %Qubit* %qubit, %Qubit** %23, align 8
  tail call fastcc void @Microsoft__Quantum__Intrinsic___10914a55af804e59be3c44a0b98ca5ac___QsRef23__ApplyWithLessControlsA____body(%Callable* %19, { %Array*, %Qubit* }* %21)
  tail call void @__quantum__rt__capture_update_reference_count(%Callable* %19, i32 -1)
  tail call void @__quantum__rt__callable_update_reference_count(%Callable* %19, i32 -1)
  tail call void @__quantum__rt__array_update_reference_count(%Array* %ctls, i32 -1)
  tail call void @__quantum__rt__tuple_update_reference_count(%Tuple* %20, i32 -1)
  br label %continue__1

continue__1:                                      ; preds = %else__1, %then2__1, %then1__1, %then0__1
  tail call void @__quantum__rt__array_update_alias_count(%Array* %ctls, i32 -1)
  ret void
}

define internal fastcc void @Microsoft__Quantum__Intrinsic__Y__ctl(%Array* %ctls, %Qubit* %qubit) unnamed_addr {
entry:
  tail call void @__quantum__rt__array_update_alias_count(%Array* %ctls, i32 1)
  %0 = tail call i64 @__quantum__rt__array_get_size_1d(%Array* %ctls)
  %1 = icmp eq i64 %0, 0
  br i1 %1, label %then0__1, label %test1__1

then0__1:                                         ; preds = %entry
  tail call void @__quantum__qis__y(%Qubit* %qubit)
  br label %continue__1

test1__1:                                         ; preds = %entry
  %2 = tail call i64 @__quantum__rt__array_get_size_1d(%Array* %ctls)
  %3 = icmp eq i64 %2, 1
  br i1 %3, label %then1__1, label %test2__1

then1__1:                                         ; preds = %test1__1
  tail call void @__quantum__qis__sadj(%Qubit* %qubit)
  %4 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %ctls, i64 0)
  %5 = bitcast i8* %4 to %Qubit**
  %6 = load %Qubit*, %Qubit** %5, align 8
  tail call void @__quantum__qis__cnot(%Qubit* %6, %Qubit* %qubit)
  tail call void @__quantum__qis__s(%Qubit* %qubit)
  br label %continue__1

test2__1:                                         ; preds = %test1__1
  %7 = tail call i64 @__quantum__rt__array_get_size_1d(%Array* %ctls)
  %8 = icmp eq i64 %7, 2
  br i1 %8, label %then2__1, label %else__1

then2__1:                                         ; preds = %test2__1
  tail call void @__quantum__qis__h(%Qubit* %qubit)
  tail call void @__quantum__qis__s(%Qubit* %qubit)
  tail call void @__quantum__qis__h(%Qubit* %qubit)
  tail call fastcc void @Microsoft__Quantum__Intrinsic__Z__ctl(%Array* %ctls, %Qubit* %qubit)
  tail call void @__quantum__qis__h(%Qubit* %qubit)
  tail call void @__quantum__qis__sadj(%Qubit* %qubit)
  tail call void @__quantum__qis__h(%Qubit* %qubit)
  br label %continue__1

else__1:                                          ; preds = %test2__1
  %9 = tail call %Callable* @__quantum__rt__callable_create([4 x void (%Tuple*, %Tuple*, %Tuple*)*]* nonnull @Microsoft__Quantum__Intrinsic__Y, [2 x void (%Tuple*, i32)*]* null, %Tuple* null)
  tail call void @__quantum__rt__callable_make_controlled(%Callable* %9)
  %10 = tail call %Tuple* @__quantum__rt__tuple_create(i64 16)
  %11 = bitcast %Tuple* %10 to { %Array*, %Qubit* }*
  %12 = bitcast %Tuple* %10 to %Array**
  %13 = getelementptr inbounds { %Array*, %Qubit* }, { %Array*, %Qubit* }* %11, i64 0, i32 1
  tail call void @__quantum__rt__array_update_reference_count(%Array* %ctls, i32 1)
  store %Array* %ctls, %Array** %12, align 8
  store %Qubit* %qubit, %Qubit** %13, align 8
  tail call fastcc void @Microsoft__Quantum__Intrinsic___10914a55af804e59be3c44a0b98ca5ac___QsRef23__ApplyWithLessControlsA____body(%Callable* %9, { %Array*, %Qubit* }* %11)
  tail call void @__quantum__rt__capture_update_reference_count(%Callable* %9, i32 -1)
  tail call void @__quantum__rt__callable_update_reference_count(%Callable* %9, i32 -1)
  tail call void @__quantum__rt__array_update_reference_count(%Array* %ctls, i32 -1)
  tail call void @__quantum__rt__tuple_update_reference_count(%Tuple* %10, i32 -1)
  br label %continue__1

continue__1:                                      ; preds = %else__1, %then2__1, %then1__1, %then0__1
  tail call void @__quantum__rt__array_update_alias_count(%Array* %ctls, i32 -1)
  ret void
}

define internal fastcc void @Microsoft__Quantum__Intrinsic__Z__ctl(%Array* %ctls, %Qubit* %qubit) unnamed_addr {
entry:
  tail call void @__quantum__rt__array_update_alias_count(%Array* %ctls, i32 1)
  %0 = tail call i64 @__quantum__rt__array_get_size_1d(%Array* %ctls)
  %1 = icmp eq i64 %0, 0
  br i1 %1, label %then0__1, label %test1__1

then0__1:                                         ; preds = %entry
  tail call void @__quantum__qis__z(%Qubit* %qubit)
  br label %continue__1

test1__1:                                         ; preds = %entry
  %2 = tail call i64 @__quantum__rt__array_get_size_1d(%Array* %ctls)
  %3 = icmp eq i64 %2, 1
  br i1 %3, label %then1__1, label %test2__1

then1__1:                                         ; preds = %test1__1
  %4 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %ctls, i64 0)
  %5 = bitcast i8* %4 to %Qubit**
  %control = load %Qubit*, %Qubit** %5, align 8
  tail call void @__quantum__qis__cz(%Qubit* %control, %Qubit* %qubit)
  br label %continue__1

test2__1:                                         ; preds = %test1__1
  %6 = tail call i64 @__quantum__rt__array_get_size_1d(%Array* %ctls)
  %7 = icmp eq i64 %6, 2
  br i1 %7, label %then2__1, label %else__1

then2__1:                                         ; preds = %test2__1
  %8 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %ctls, i64 0)
  %9 = bitcast i8* %8 to %Qubit**
  %10 = load %Qubit*, %Qubit** %9, align 8
  tail call void @__quantum__qis__tadj(%Qubit* %10)
  %11 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %ctls, i64 1)
  %12 = bitcast i8* %11 to %Qubit**
  %13 = load %Qubit*, %Qubit** %12, align 8
  tail call void @__quantum__qis__tadj(%Qubit* %13)
  %14 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %ctls, i64 0)
  %15 = bitcast i8* %14 to %Qubit**
  %16 = load %Qubit*, %Qubit** %15, align 8
  tail call void @__quantum__qis__cnot(%Qubit* %qubit, %Qubit* %16)
  %17 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %ctls, i64 0)
  %18 = bitcast i8* %17 to %Qubit**
  %19 = load %Qubit*, %Qubit** %18, align 8
  tail call void @__quantum__qis__t(%Qubit* %19)
  %20 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %ctls, i64 1)
  %21 = bitcast i8* %20 to %Qubit**
  %22 = load %Qubit*, %Qubit** %21, align 8
  tail call void @__quantum__qis__cnot(%Qubit* %22, %Qubit* %qubit)
  %23 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %ctls, i64 1)
  %24 = bitcast i8* %23 to %Qubit**
  %25 = load %Qubit*, %Qubit** %24, align 8
  %26 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %ctls, i64 0)
  %27 = bitcast i8* %26 to %Qubit**
  %28 = load %Qubit*, %Qubit** %27, align 8
  tail call void @__quantum__qis__cnot(%Qubit* %25, %Qubit* %28)
  tail call void @__quantum__qis__t(%Qubit* %qubit)
  %29 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %ctls, i64 0)
  %30 = bitcast i8* %29 to %Qubit**
  %31 = load %Qubit*, %Qubit** %30, align 8
  tail call void @__quantum__qis__tadj(%Qubit* %31)
  %32 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %ctls, i64 1)
  %33 = bitcast i8* %32 to %Qubit**
  %34 = load %Qubit*, %Qubit** %33, align 8
  tail call void @__quantum__qis__cnot(%Qubit* %34, %Qubit* %qubit)
  %35 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %ctls, i64 0)
  %36 = bitcast i8* %35 to %Qubit**
  %37 = load %Qubit*, %Qubit** %36, align 8
  tail call void @__quantum__qis__cnot(%Qubit* %qubit, %Qubit* %37)
  tail call void @__quantum__qis__tadj(%Qubit* %qubit)
  %38 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %ctls, i64 0)
  %39 = bitcast i8* %38 to %Qubit**
  %40 = load %Qubit*, %Qubit** %39, align 8
  tail call void @__quantum__qis__t(%Qubit* %40)
  %41 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %ctls, i64 1)
  %42 = bitcast i8* %41 to %Qubit**
  %43 = load %Qubit*, %Qubit** %42, align 8
  %44 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %ctls, i64 0)
  %45 = bitcast i8* %44 to %Qubit**
  %46 = load %Qubit*, %Qubit** %45, align 8
  tail call void @__quantum__qis__cnot(%Qubit* %43, %Qubit* %46)
  br label %continue__1

else__1:                                          ; preds = %test2__1
  %47 = tail call %Callable* @__quantum__rt__callable_create([4 x void (%Tuple*, %Tuple*, %Tuple*)*]* nonnull @Microsoft__Quantum__Intrinsic__Z, [2 x void (%Tuple*, i32)*]* null, %Tuple* null)
  tail call void @__quantum__rt__callable_make_controlled(%Callable* %47)
  %48 = tail call %Tuple* @__quantum__rt__tuple_create(i64 16)
  %49 = bitcast %Tuple* %48 to { %Array*, %Qubit* }*
  %50 = bitcast %Tuple* %48 to %Array**
  %51 = getelementptr inbounds { %Array*, %Qubit* }, { %Array*, %Qubit* }* %49, i64 0, i32 1
  tail call void @__quantum__rt__array_update_reference_count(%Array* %ctls, i32 1)
  store %Array* %ctls, %Array** %50, align 8
  store %Qubit* %qubit, %Qubit** %51, align 8
  tail call fastcc void @Microsoft__Quantum__Intrinsic___10914a55af804e59be3c44a0b98ca5ac___QsRef23__ApplyWithLessControlsA____body(%Callable* %47, { %Array*, %Qubit* }* %49)
  tail call void @__quantum__rt__capture_update_reference_count(%Callable* %47, i32 -1)
  tail call void @__quantum__rt__callable_update_reference_count(%Callable* %47, i32 -1)
  tail call void @__quantum__rt__array_update_reference_count(%Array* %ctls, i32 -1)
  tail call void @__quantum__rt__tuple_update_reference_count(%Tuple* %48, i32 -1)
  br label %continue__1

continue__1:                                      ; preds = %else__1, %then2__1, %then1__1, %then0__1
  tail call void @__quantum__rt__array_update_alias_count(%Array* %ctls, i32 -1)
  ret void
}

define internal fastcc void @Microsoft__Quantum__Intrinsic__H__ctl(%Array* %ctls, %Qubit* %qubit) unnamed_addr {
entry:
  tail call void @__quantum__rt__array_update_alias_count(%Array* %ctls, i32 1)
  %0 = tail call i64 @__quantum__rt__array_get_size_1d(%Array* %ctls)
  %1 = icmp eq i64 %0, 0
  br i1 %1, label %then0__1, label %test1__1

then0__1:                                         ; preds = %entry
  tail call void @__quantum__qis__h(%Qubit* %qubit)
  br label %continue__1

test1__1:                                         ; preds = %entry
  %2 = tail call i64 @__quantum__rt__array_get_size_1d(%Array* %ctls)
  %3 = icmp eq i64 %2, 1
  br i1 %3, label %then1__1, label %else__1

then1__1:                                         ; preds = %test1__1
  tail call void @__quantum__qis__s(%Qubit* %qubit)
  tail call void @__quantum__qis__h(%Qubit* %qubit)
  tail call void @__quantum__qis__t(%Qubit* %qubit)
  %4 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %ctls, i64 0)
  %5 = bitcast i8* %4 to %Qubit**
  %6 = load %Qubit*, %Qubit** %5, align 8
  tail call void @__quantum__qis__cnot(%Qubit* %6, %Qubit* %qubit)
  tail call void @__quantum__qis__tadj(%Qubit* %qubit)
  tail call void @__quantum__qis__h(%Qubit* %qubit)
  tail call void @__quantum__qis__sadj(%Qubit* %qubit)
  br label %continue__1

else__1:                                          ; preds = %test1__1
  %7 = tail call %Callable* @__quantum__rt__callable_create([4 x void (%Tuple*, %Tuple*, %Tuple*)*]* nonnull @Microsoft__Quantum__Intrinsic__H, [2 x void (%Tuple*, i32)*]* null, %Tuple* null)
  tail call void @__quantum__rt__callable_make_controlled(%Callable* %7)
  %8 = tail call %Tuple* @__quantum__rt__tuple_create(i64 16)
  %9 = bitcast %Tuple* %8 to { %Array*, %Qubit* }*
  %10 = bitcast %Tuple* %8 to %Array**
  %11 = getelementptr inbounds { %Array*, %Qubit* }, { %Array*, %Qubit* }* %9, i64 0, i32 1
  tail call void @__quantum__rt__array_update_reference_count(%Array* %ctls, i32 1)
  store %Array* %ctls, %Array** %10, align 8
  store %Qubit* %qubit, %Qubit** %11, align 8
  tail call fastcc void @Microsoft__Quantum__Intrinsic___10914a55af804e59be3c44a0b98ca5ac___QsRef23__ApplyWithLessControlsA____body(%Callable* %7, { %Array*, %Qubit* }* %9)
  tail call void @__quantum__rt__capture_update_reference_count(%Callable* %7, i32 -1)
  tail call void @__quantum__rt__callable_update_reference_count(%Callable* %7, i32 -1)
  tail call void @__quantum__rt__array_update_reference_count(%Array* %ctls, i32 -1)
  tail call void @__quantum__rt__tuple_update_reference_count(%Tuple* %8, i32 -1)
  br label %continue__1

continue__1:                                      ; preds = %else__1, %then1__1, %then0__1
  tail call void @__quantum__rt__array_update_alias_count(%Array* %ctls, i32 -1)
  ret void
}

define internal fastcc void @Microsoft__Quantum__Intrinsic__T__ctl(%Array* %ctls, %Qubit* %qubit) unnamed_addr {
entry:
  tail call void @__quantum__rt__array_update_alias_count(%Array* %ctls, i32 1)
  %0 = tail call i64 @__quantum__rt__array_get_size_1d(%Array* %ctls)
  %1 = icmp eq i64 %0, 0
  br i1 %1, label %then0__1, label %test1__1

then0__1:                                         ; preds = %entry
  tail call void @__quantum__qis__t(%Qubit* %qubit)
  br label %continue__1

test1__1:                                         ; preds = %entry
  %2 = tail call i64 @__quantum__rt__array_get_size_1d(%Array* %ctls)
  %3 = icmp eq i64 %2, 1
  br i1 %3, label %then1__1, label %else__1

then1__1:                                         ; preds = %test1__1
  %4 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %ctls, i64 0)
  %5 = bitcast i8* %4 to %Qubit**
  %6 = load %Qubit*, %Qubit** %5, align 8
  tail call void @__quantum__qis__rz(double 0x3FD921FB54442D18, %Qubit* %6)
  tail call void @__quantum__qis__rz(double 0x3FD921FB54442D18, %Qubit* %qubit)
  %7 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %ctls, i64 0)
  %8 = bitcast i8* %7 to %Qubit**
  %9 = load %Qubit*, %Qubit** %8, align 8
  tail call void @__quantum__qis__cnot(%Qubit* %9, %Qubit* %qubit)
  tail call void @__quantum__qis__rz(double 0xBFD921FB54442D18, %Qubit* %qubit)
  %10 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %ctls, i64 0)
  %11 = bitcast i8* %10 to %Qubit**
  %12 = load %Qubit*, %Qubit** %11, align 8
  tail call void @__quantum__qis__cnot(%Qubit* %12, %Qubit* %qubit)
  br label %continue__1

else__1:                                          ; preds = %test1__1
  %13 = tail call %Callable* @__quantum__rt__callable_create([4 x void (%Tuple*, %Tuple*, %Tuple*)*]* nonnull @Microsoft__Quantum__Intrinsic__T, [2 x void (%Tuple*, i32)*]* null, %Tuple* null)
  tail call void @__quantum__rt__callable_make_controlled(%Callable* %13)
  %14 = tail call %Tuple* @__quantum__rt__tuple_create(i64 16)
  %15 = bitcast %Tuple* %14 to { %Array*, %Qubit* }*
  %16 = bitcast %Tuple* %14 to %Array**
  %17 = getelementptr inbounds { %Array*, %Qubit* }, { %Array*, %Qubit* }* %15, i64 0, i32 1
  tail call void @__quantum__rt__array_update_reference_count(%Array* %ctls, i32 1)
  store %Array* %ctls, %Array** %16, align 8
  store %Qubit* %qubit, %Qubit** %17, align 8
  tail call fastcc void @Microsoft__Quantum__Intrinsic___10914a55af804e59be3c44a0b98ca5ac___QsRef23__ApplyWithLessControlsA____body(%Callable* %13, { %Array*, %Qubit* }* %15)
  tail call void @__quantum__rt__capture_update_reference_count(%Callable* %13, i32 -1)
  tail call void @__quantum__rt__callable_update_reference_count(%Callable* %13, i32 -1)
  tail call void @__quantum__rt__array_update_reference_count(%Array* %ctls, i32 -1)
  tail call void @__quantum__rt__tuple_update_reference_count(%Tuple* %14, i32 -1)
  br label %continue__1

continue__1:                                      ; preds = %else__1, %then1__1, %then0__1
  tail call void @__quantum__rt__array_update_alias_count(%Array* %ctls, i32 -1)
  ret void
}

define internal fastcc void @Microsoft__Quantum__Intrinsic__S__ctl(%Array* %ctls, %Qubit* %qubit) unnamed_addr {
entry:
  tail call void @__quantum__rt__array_update_alias_count(%Array* %ctls, i32 1)
  %0 = tail call i64 @__quantum__rt__array_get_size_1d(%Array* %ctls)
  %1 = icmp eq i64 %0, 0
  br i1 %1, label %then0__1, label %test1__1

then0__1:                                         ; preds = %entry
  tail call void @__quantum__qis__s(%Qubit* %qubit)
  br label %continue__1

test1__1:                                         ; preds = %entry
  %2 = tail call i64 @__quantum__rt__array_get_size_1d(%Array* %ctls)
  %3 = icmp eq i64 %2, 1
  br i1 %3, label %then1__1, label %else__1

then1__1:                                         ; preds = %test1__1
  %4 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %ctls, i64 0)
  %5 = bitcast i8* %4 to %Qubit**
  %6 = load %Qubit*, %Qubit** %5, align 8
  tail call void @__quantum__qis__t(%Qubit* %6)
  tail call void @__quantum__qis__t(%Qubit* %qubit)
  %7 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %ctls, i64 0)
  %8 = bitcast i8* %7 to %Qubit**
  %9 = load %Qubit*, %Qubit** %8, align 8
  tail call void @__quantum__qis__cnot(%Qubit* %9, %Qubit* %qubit)
  tail call void @__quantum__qis__tadj(%Qubit* %qubit)
  %10 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %ctls, i64 0)
  %11 = bitcast i8* %10 to %Qubit**
  %12 = load %Qubit*, %Qubit** %11, align 8
  tail call void @__quantum__qis__cnot(%Qubit* %12, %Qubit* %qubit)
  br label %continue__1

else__1:                                          ; preds = %test1__1
  %13 = tail call %Callable* @__quantum__rt__callable_create([4 x void (%Tuple*, %Tuple*, %Tuple*)*]* nonnull @Microsoft__Quantum__Intrinsic__S, [2 x void (%Tuple*, i32)*]* null, %Tuple* null)
  tail call void @__quantum__rt__callable_make_controlled(%Callable* %13)
  %14 = tail call %Tuple* @__quantum__rt__tuple_create(i64 16)
  %15 = bitcast %Tuple* %14 to { %Array*, %Qubit* }*
  %16 = bitcast %Tuple* %14 to %Array**
  %17 = getelementptr inbounds { %Array*, %Qubit* }, { %Array*, %Qubit* }* %15, i64 0, i32 1
  tail call void @__quantum__rt__array_update_reference_count(%Array* %ctls, i32 1)
  store %Array* %ctls, %Array** %16, align 8
  store %Qubit* %qubit, %Qubit** %17, align 8
  tail call fastcc void @Microsoft__Quantum__Intrinsic___10914a55af804e59be3c44a0b98ca5ac___QsRef23__ApplyWithLessControlsA____body(%Callable* %13, { %Array*, %Qubit* }* %15)
  tail call void @__quantum__rt__capture_update_reference_count(%Callable* %13, i32 -1)
  tail call void @__quantum__rt__callable_update_reference_count(%Callable* %13, i32 -1)
  tail call void @__quantum__rt__array_update_reference_count(%Array* %ctls, i32 -1)
  tail call void @__quantum__rt__tuple_update_reference_count(%Tuple* %14, i32 -1)
  br label %continue__1

continue__1:                                      ; preds = %else__1, %then1__1, %then0__1
  tail call void @__quantum__rt__array_update_alias_count(%Array* %ctls, i32 -1)
  ret void
}

declare %Result* @__quantum__qis__m__body(%Qubit*) local_unnamed_addr

declare void @__quantum__rt__array_update_reference_count(%Array*, i32) local_unnamed_addr

declare void @__quantum__rt__tuple_update_reference_count(%Tuple*, i32) local_unnamed_addr

declare void @__quantum__rt__result_update_reference_count(%Result*, i32) local_unnamed_addr

declare void @__quantum__qis__cnot(%Qubit*, %Qubit*) local_unnamed_addr

declare void @__quantum__qis__cz(%Qubit*, %Qubit*) local_unnamed_addr

declare void @__quantum__rt__array_update_alias_count(%Array*, i32) local_unnamed_addr

declare i64 @__quantum__rt__array_get_size_1d(%Array*) local_unnamed_addr

declare void @__quantum__qis__h(%Qubit*) local_unnamed_addr

declare void @__quantum__qis__x(%Qubit*) local_unnamed_addr

declare void @__quantum__qis__y(%Qubit*) local_unnamed_addr

declare void @__quantum__qis__z(%Qubit*) local_unnamed_addr

declare void @__quantum__qis__swap(%Qubit*, %Qubit*) local_unnamed_addr

declare %Array* @__quantum__rt__array_concatenate(%Array*, %Array*) local_unnamed_addr

declare %Callable* @__quantum__rt__callable_create([4 x void (%Tuple*, %Tuple*, %Tuple*)*]*, [2 x void (%Tuple*, i32)*]*, %Tuple*) local_unnamed_addr

declare void @__quantum__rt__callable_make_controlled(%Callable*) local_unnamed_addr

declare void @__quantum__rt__capture_update_reference_count(%Callable*, i32) local_unnamed_addr

declare void @__quantum__rt__callable_update_reference_count(%Callable*, i32) local_unnamed_addr

define internal fastcc void @Microsoft__Quantum__Intrinsic___10914a55af804e59be3c44a0b98ca5ac___QsRef23__ApplyWithLessControlsA____body(%Callable* %op, { %Array*, %Qubit* }* nocapture readonly %0) unnamed_addr {
entry:
  tail call void @__quantum__rt__capture_update_alias_count(%Callable* %op, i32 1)
  tail call void @__quantum__rt__callable_update_alias_count(%Callable* %op, i32 1)
  %1 = getelementptr inbounds { %Array*, %Qubit* }, { %Array*, %Qubit* }* %0, i64 0, i32 0
  %controls = load %Array*, %Array** %1, align 8
  tail call void @__quantum__rt__array_update_alias_count(%Array* %controls, i32 1)
  %2 = getelementptr inbounds { %Array*, %Qubit* }, { %Array*, %Qubit* }* %0, i64 0, i32 1
  %arg = load %Qubit*, %Qubit** %2, align 8
  %numControls = tail call i64 @__quantum__rt__array_get_size_1d(%Array* %controls)
  %numControlPairs = lshr i64 %numControls, 1
  %temps = tail call %Array* @__quantum__rt__qubit_allocate_array(i64 %numControlPairs)
  tail call void @__quantum__rt__array_update_alias_count(%Array* %temps, i32 1)
  %.not.not3.not = icmp eq i64 %numControlPairs, 0
  br i1 %.not.not3.not, label %exit__1, label %body__1

body__1:                                          ; preds = %entry, %body__1
  %__qsVar0__numPair__4 = phi i64 [ %14, %body__1 ], [ 0, %entry ]
  %3 = shl nuw i64 %__qsVar0__numPair__4, 1
  %4 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %controls, i64 %3)
  %5 = bitcast i8* %4 to %Qubit**
  %6 = load %Qubit*, %Qubit** %5, align 8
  %7 = or i64 %3, 1
  %8 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %controls, i64 %7)
  %9 = bitcast i8* %8 to %Qubit**
  %10 = load %Qubit*, %Qubit** %9, align 8
  %11 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %temps, i64 %__qsVar0__numPair__4)
  %12 = bitcast i8* %11 to %Qubit**
  %13 = load %Qubit*, %Qubit** %12, align 8
  tail call void @__quantum__qis__h(%Qubit* %13)
  tail call void @__quantum__qis__cnot(%Qubit* %13, %Qubit* %6)
  tail call void @__quantum__qis__cnot(%Qubit* %6, %Qubit* %10)
  tail call void @__quantum__qis__t(%Qubit* %10)
  tail call void @__quantum__qis__tadj(%Qubit* %6)
  tail call void @__quantum__qis__t(%Qubit* %13)
  tail call void @__quantum__qis__cnot(%Qubit* %13, %Qubit* %6)
  tail call void @__quantum__qis__cnot(%Qubit* %6, %Qubit* %10)
  tail call void @__quantum__qis__tadj(%Qubit* %10)
  tail call void @__quantum__qis__cnot(%Qubit* %13, %Qubit* %10)
  tail call void @__quantum__qis__h(%Qubit* %13)
  %14 = add nuw nsw i64 %__qsVar0__numPair__4, 1
  %exitcond.not = icmp eq i64 %14, %numControlPairs
  br i1 %exitcond.not, label %exit__1, label %body__1

exit__1:                                          ; preds = %body__1, %entry
  %15 = and i64 %numControls, 1
  %16 = icmp eq i64 %15, 0
  br i1 %16, label %condTrue__1, label %condFalse__1

condTrue__1:                                      ; preds = %exit__1
  tail call void @__quantum__rt__array_update_reference_count(%Array* %temps, i32 1)
  br label %condContinue__1

condFalse__1:                                     ; preds = %exit__1
  %17 = tail call %Array* @__quantum__rt__array_create_1d(i32 8, i64 1)
  %18 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %17, i64 0)
  %19 = bitcast i8* %18 to %Qubit**
  %20 = add i64 %numControls, -1
  %21 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %controls, i64 %20)
  %22 = bitcast i8* %21 to %Qubit**
  %23 = load %Qubit*, %Qubit** %22, align 8
  store %Qubit* %23, %Qubit** %19, align 8
  %24 = tail call %Array* @__quantum__rt__array_concatenate(%Array* %temps, %Array* %17)
  tail call void @__quantum__rt__array_update_reference_count(%Array* %24, i32 1)
  tail call void @__quantum__rt__array_update_reference_count(%Array* %17, i32 -1)
  tail call void @__quantum__rt__array_update_reference_count(%Array* %24, i32 -1)
  br label %condContinue__1

condContinue__1:                                  ; preds = %condFalse__1, %condTrue__1
  %__qsVar1__newControls__ = phi %Array* [ %temps, %condTrue__1 ], [ %24, %condFalse__1 ]
  tail call void @__quantum__rt__array_update_alias_count(%Array* %__qsVar1__newControls__, i32 1)
  %25 = tail call %Tuple* @__quantum__rt__tuple_create(i64 16)
  %26 = bitcast %Tuple* %25 to { %Array*, %Qubit* }*
  %27 = bitcast %Tuple* %25 to %Array**
  %28 = getelementptr inbounds { %Array*, %Qubit* }, { %Array*, %Qubit* }* %26, i64 0, i32 1
  tail call void @__quantum__rt__array_update_reference_count(%Array* %__qsVar1__newControls__, i32 1)
  store %Array* %__qsVar1__newControls__, %Array** %27, align 8
  store %Qubit* %arg, %Qubit** %28, align 8
  tail call void @__quantum__rt__callable_invoke(%Callable* %op, %Tuple* %25, %Tuple* null)
  br i1 %.not.not3.not, label %exit__2, label %body__2

body__2:                                          ; preds = %condContinue__1, %body__2
  %__qsVar0____qsVar0__numPair____2.in = phi i64 [ %__qsVar0____qsVar0__numPair____2, %body__2 ], [ %numControlPairs, %condContinue__1 ]
  %__qsVar0____qsVar0__numPair____2 = add nsw i64 %__qsVar0____qsVar0__numPair____2.in, -1
  %29 = shl nuw i64 %__qsVar0____qsVar0__numPair____2, 1
  %30 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %controls, i64 %29)
  %31 = bitcast i8* %30 to %Qubit**
  %32 = load %Qubit*, %Qubit** %31, align 8
  %33 = or i64 %29, 1
  %34 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %controls, i64 %33)
  %35 = bitcast i8* %34 to %Qubit**
  %36 = load %Qubit*, %Qubit** %35, align 8
  %37 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %temps, i64 %__qsVar0____qsVar0__numPair____2)
  %38 = bitcast i8* %37 to %Qubit**
  %39 = load %Qubit*, %Qubit** %38, align 8
  tail call void @__quantum__qis__h(%Qubit* %39)
  tail call void @__quantum__qis__cnot(%Qubit* %39, %Qubit* %36)
  tail call void @__quantum__qis__t(%Qubit* %36)
  tail call void @__quantum__qis__cnot(%Qubit* %32, %Qubit* %36)
  tail call void @__quantum__qis__cnot(%Qubit* %39, %Qubit* %32)
  tail call void @__quantum__qis__tadj(%Qubit* %39)
  tail call void @__quantum__qis__t(%Qubit* %32)
  tail call void @__quantum__qis__tadj(%Qubit* %36)
  tail call void @__quantum__qis__cnot(%Qubit* %32, %Qubit* %36)
  tail call void @__quantum__qis__cnot(%Qubit* %39, %Qubit* %32)
  tail call void @__quantum__qis__h(%Qubit* %39)
  %40 = icmp sgt i64 %__qsVar0____qsVar0__numPair____2.in, 1
  br i1 %40, label %body__2, label %exit__2

exit__2:                                          ; preds = %body__2, %condContinue__1
  tail call void @__quantum__rt__array_update_alias_count(%Array* %temps, i32 -1)
  tail call void @__quantum__rt__array_update_alias_count(%Array* %__qsVar1__newControls__, i32 -1)
  tail call void @__quantum__rt__array_update_reference_count(%Array* %__qsVar1__newControls__, i32 -1)
  tail call void @__quantum__rt__array_update_reference_count(%Array* %__qsVar1__newControls__, i32 -1)
  tail call void @__quantum__rt__tuple_update_reference_count(%Tuple* %25, i32 -1)
  tail call void @__quantum__rt__qubit_release_array(%Array* %temps)
  tail call void @__quantum__rt__capture_update_alias_count(%Callable* %op, i32 -1)
  tail call void @__quantum__rt__callable_update_alias_count(%Callable* %op, i32 -1)
  tail call void @__quantum__rt__array_update_alias_count(%Array* %controls, i32 -1)
  ret void
}

define internal void @Microsoft__Quantum__Intrinsic__H__body__wrapper(%Tuple* nocapture readnone %capture-tuple, %Tuple* nocapture readonly %arg-tuple, %Tuple* nocapture readnone %result-tuple) {
entry:
  %0 = bitcast %Tuple* %arg-tuple to %Qubit**
  %1 = load %Qubit*, %Qubit** %0, align 8
  tail call void @__quantum__qis__h(%Qubit* %1)
  ret void
}

define internal void @Microsoft__Quantum__Intrinsic__H__adj__wrapper(%Tuple* nocapture readnone %capture-tuple, %Tuple* nocapture readonly %arg-tuple, %Tuple* nocapture readnone %result-tuple) {
entry:
  %0 = bitcast %Tuple* %arg-tuple to %Qubit**
  %1 = load %Qubit*, %Qubit** %0, align 8
  tail call void @__quantum__qis__h(%Qubit* %1)
  ret void
}

define internal void @Microsoft__Quantum__Intrinsic__H__ctl__wrapper(%Tuple* nocapture readnone %capture-tuple, %Tuple* nocapture readonly %arg-tuple, %Tuple* nocapture readnone %result-tuple) {
entry:
  %0 = bitcast %Tuple* %arg-tuple to { %Array*, %Qubit* }*
  %1 = bitcast %Tuple* %arg-tuple to %Array**
  %2 = getelementptr inbounds { %Array*, %Qubit* }, { %Array*, %Qubit* }* %0, i64 0, i32 1
  %3 = load %Array*, %Array** %1, align 8
  %4 = load %Qubit*, %Qubit** %2, align 8
  tail call fastcc void @Microsoft__Quantum__Intrinsic__H__ctl(%Array* %3, %Qubit* %4)
  ret void
}

define internal void @Microsoft__Quantum__Intrinsic__H__ctladj__wrapper(%Tuple* nocapture readnone %capture-tuple, %Tuple* nocapture readonly %arg-tuple, %Tuple* nocapture readnone %result-tuple) {
entry:
  %0 = bitcast %Tuple* %arg-tuple to { %Array*, %Qubit* }*
  %1 = bitcast %Tuple* %arg-tuple to %Array**
  %2 = getelementptr inbounds { %Array*, %Qubit* }, { %Array*, %Qubit* }* %0, i64 0, i32 1
  %3 = load %Array*, %Array** %1, align 8
  %4 = load %Qubit*, %Qubit** %2, align 8
  tail call void @__quantum__rt__array_update_alias_count(%Array* %3, i32 1)
  tail call fastcc void @Microsoft__Quantum__Intrinsic__H__ctl(%Array* %3, %Qubit* %4)
  tail call void @__quantum__rt__array_update_alias_count(%Array* %3, i32 -1)
  ret void
}

declare void @__quantum__qis__rx(double, %Qubit*) local_unnamed_addr

define internal fastcc void @Microsoft__Quantum__Intrinsic___109d0035958c411fac59e9f8a62cbed1___QsRef23__ApplyWithLessControlsA____body(%Callable* %op, { %Array*, { double, %Qubit* }* }* nocapture readonly %0) unnamed_addr {
entry:
  tail call void @__quantum__rt__capture_update_alias_count(%Callable* %op, i32 1)
  tail call void @__quantum__rt__callable_update_alias_count(%Callable* %op, i32 1)
  %1 = getelementptr inbounds { %Array*, { double, %Qubit* }* }, { %Array*, { double, %Qubit* }* }* %0, i64 0, i32 0
  %controls = load %Array*, %Array** %1, align 8
  tail call void @__quantum__rt__array_update_alias_count(%Array* %controls, i32 1)
  %2 = getelementptr inbounds { %Array*, { double, %Qubit* }* }, { %Array*, { double, %Qubit* }* }* %0, i64 0, i32 1
  %arg = load { double, %Qubit* }*, { double, %Qubit* }** %2, align 8
  %3 = bitcast { double, %Qubit* }* %arg to %Tuple*
  tail call void @__quantum__rt__tuple_update_alias_count(%Tuple* %3, i32 1)
  %numControls = tail call i64 @__quantum__rt__array_get_size_1d(%Array* %controls)
  %numControlPairs = lshr i64 %numControls, 1
  %temps = tail call %Array* @__quantum__rt__qubit_allocate_array(i64 %numControlPairs)
  tail call void @__quantum__rt__array_update_alias_count(%Array* %temps, i32 1)
  %.not.not3.not = icmp eq i64 %numControlPairs, 0
  br i1 %.not.not3.not, label %exit__1, label %body__1

body__1:                                          ; preds = %entry, %body__1
  %__qsVar0__numPair__4 = phi i64 [ %15, %body__1 ], [ 0, %entry ]
  %4 = shl nuw i64 %__qsVar0__numPair__4, 1
  %5 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %controls, i64 %4)
  %6 = bitcast i8* %5 to %Qubit**
  %7 = load %Qubit*, %Qubit** %6, align 8
  %8 = or i64 %4, 1
  %9 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %controls, i64 %8)
  %10 = bitcast i8* %9 to %Qubit**
  %11 = load %Qubit*, %Qubit** %10, align 8
  %12 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %temps, i64 %__qsVar0__numPair__4)
  %13 = bitcast i8* %12 to %Qubit**
  %14 = load %Qubit*, %Qubit** %13, align 8
  tail call void @__quantum__qis__h(%Qubit* %14)
  tail call void @__quantum__qis__cnot(%Qubit* %14, %Qubit* %7)
  tail call void @__quantum__qis__cnot(%Qubit* %7, %Qubit* %11)
  tail call void @__quantum__qis__t(%Qubit* %11)
  tail call void @__quantum__qis__tadj(%Qubit* %7)
  tail call void @__quantum__qis__t(%Qubit* %14)
  tail call void @__quantum__qis__cnot(%Qubit* %14, %Qubit* %7)
  tail call void @__quantum__qis__cnot(%Qubit* %7, %Qubit* %11)
  tail call void @__quantum__qis__tadj(%Qubit* %11)
  tail call void @__quantum__qis__cnot(%Qubit* %14, %Qubit* %11)
  tail call void @__quantum__qis__h(%Qubit* %14)
  %15 = add nuw nsw i64 %__qsVar0__numPair__4, 1
  %exitcond.not = icmp eq i64 %15, %numControlPairs
  br i1 %exitcond.not, label %exit__1, label %body__1

exit__1:                                          ; preds = %body__1, %entry
  %16 = and i64 %numControls, 1
  %17 = icmp eq i64 %16, 0
  br i1 %17, label %condTrue__1, label %condFalse__1

condTrue__1:                                      ; preds = %exit__1
  tail call void @__quantum__rt__array_update_reference_count(%Array* %temps, i32 1)
  br label %condContinue__1

condFalse__1:                                     ; preds = %exit__1
  %18 = tail call %Array* @__quantum__rt__array_create_1d(i32 8, i64 1)
  %19 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %18, i64 0)
  %20 = bitcast i8* %19 to %Qubit**
  %21 = add i64 %numControls, -1
  %22 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %controls, i64 %21)
  %23 = bitcast i8* %22 to %Qubit**
  %24 = load %Qubit*, %Qubit** %23, align 8
  store %Qubit* %24, %Qubit** %20, align 8
  %25 = tail call %Array* @__quantum__rt__array_concatenate(%Array* %temps, %Array* %18)
  tail call void @__quantum__rt__array_update_reference_count(%Array* %25, i32 1)
  tail call void @__quantum__rt__array_update_reference_count(%Array* %18, i32 -1)
  tail call void @__quantum__rt__array_update_reference_count(%Array* %25, i32 -1)
  br label %condContinue__1

condContinue__1:                                  ; preds = %condFalse__1, %condTrue__1
  %__qsVar1__newControls__ = phi %Array* [ %temps, %condTrue__1 ], [ %25, %condFalse__1 ]
  tail call void @__quantum__rt__array_update_alias_count(%Array* %__qsVar1__newControls__, i32 1)
  %26 = tail call %Tuple* @__quantum__rt__tuple_create(i64 16)
  %27 = bitcast %Tuple* %26 to { %Array*, { double, %Qubit* }* }*
  %28 = bitcast %Tuple* %26 to %Array**
  %29 = getelementptr inbounds { %Array*, { double, %Qubit* }* }, { %Array*, { double, %Qubit* }* }* %27, i64 0, i32 1
  tail call void @__quantum__rt__array_update_reference_count(%Array* %__qsVar1__newControls__, i32 1)
  tail call void @__quantum__rt__tuple_update_reference_count(%Tuple* %3, i32 1)
  store %Array* %__qsVar1__newControls__, %Array** %28, align 8
  store { double, %Qubit* }* %arg, { double, %Qubit* }** %29, align 8
  tail call void @__quantum__rt__callable_invoke(%Callable* %op, %Tuple* %26, %Tuple* null)
  br i1 %.not.not3.not, label %exit__2, label %body__2

body__2:                                          ; preds = %condContinue__1, %body__2
  %__qsVar0____qsVar0__numPair____2.in = phi i64 [ %__qsVar0____qsVar0__numPair____2, %body__2 ], [ %numControlPairs, %condContinue__1 ]
  %__qsVar0____qsVar0__numPair____2 = add nsw i64 %__qsVar0____qsVar0__numPair____2.in, -1
  %30 = shl nuw i64 %__qsVar0____qsVar0__numPair____2, 1
  %31 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %controls, i64 %30)
  %32 = bitcast i8* %31 to %Qubit**
  %33 = load %Qubit*, %Qubit** %32, align 8
  %34 = or i64 %30, 1
  %35 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %controls, i64 %34)
  %36 = bitcast i8* %35 to %Qubit**
  %37 = load %Qubit*, %Qubit** %36, align 8
  %38 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %temps, i64 %__qsVar0____qsVar0__numPair____2)
  %39 = bitcast i8* %38 to %Qubit**
  %40 = load %Qubit*, %Qubit** %39, align 8
  tail call void @__quantum__qis__h(%Qubit* %40)
  tail call void @__quantum__qis__cnot(%Qubit* %40, %Qubit* %37)
  tail call void @__quantum__qis__t(%Qubit* %37)
  tail call void @__quantum__qis__cnot(%Qubit* %33, %Qubit* %37)
  tail call void @__quantum__qis__cnot(%Qubit* %40, %Qubit* %33)
  tail call void @__quantum__qis__tadj(%Qubit* %40)
  tail call void @__quantum__qis__t(%Qubit* %33)
  tail call void @__quantum__qis__tadj(%Qubit* %37)
  tail call void @__quantum__qis__cnot(%Qubit* %33, %Qubit* %37)
  tail call void @__quantum__qis__cnot(%Qubit* %40, %Qubit* %33)
  tail call void @__quantum__qis__h(%Qubit* %40)
  %41 = icmp sgt i64 %__qsVar0____qsVar0__numPair____2.in, 1
  br i1 %41, label %body__2, label %exit__2

exit__2:                                          ; preds = %body__2, %condContinue__1
  tail call void @__quantum__rt__array_update_alias_count(%Array* %temps, i32 -1)
  tail call void @__quantum__rt__array_update_alias_count(%Array* %__qsVar1__newControls__, i32 -1)
  tail call void @__quantum__rt__array_update_reference_count(%Array* %__qsVar1__newControls__, i32 -1)
  tail call void @__quantum__rt__array_update_reference_count(%Array* %__qsVar1__newControls__, i32 -1)
  tail call void @__quantum__rt__tuple_update_reference_count(%Tuple* %3, i32 -1)
  tail call void @__quantum__rt__tuple_update_reference_count(%Tuple* %26, i32 -1)
  tail call void @__quantum__rt__qubit_release_array(%Array* %temps)
  tail call void @__quantum__rt__capture_update_alias_count(%Callable* %op, i32 -1)
  tail call void @__quantum__rt__callable_update_alias_count(%Callable* %op, i32 -1)
  tail call void @__quantum__rt__array_update_alias_count(%Array* %controls, i32 -1)
  tail call void @__quantum__rt__tuple_update_alias_count(%Tuple* %3, i32 -1)
  ret void
}

define internal void @Microsoft__Quantum__Intrinsic__Rx__body__wrapper(%Tuple* nocapture readnone %capture-tuple, %Tuple* nocapture readonly %arg-tuple, %Tuple* nocapture readnone %result-tuple) {
entry:
  %0 = bitcast %Tuple* %arg-tuple to { double, %Qubit* }*
  %1 = bitcast %Tuple* %arg-tuple to double*
  %2 = getelementptr inbounds { double, %Qubit* }, { double, %Qubit* }* %0, i64 0, i32 1
  %3 = load double, double* %1, align 8
  %4 = load %Qubit*, %Qubit** %2, align 8
  tail call void @__quantum__qis__rx(double %3, %Qubit* %4)
  ret void
}

define internal void @Microsoft__Quantum__Intrinsic__Rx__adj__wrapper(%Tuple* nocapture readnone %capture-tuple, %Tuple* nocapture readonly %arg-tuple, %Tuple* nocapture readnone %result-tuple) {
entry:
  %0 = bitcast %Tuple* %arg-tuple to { double, %Qubit* }*
  %1 = bitcast %Tuple* %arg-tuple to double*
  %2 = getelementptr inbounds { double, %Qubit* }, { double, %Qubit* }* %0, i64 0, i32 1
  %3 = load double, double* %1, align 8
  %4 = load %Qubit*, %Qubit** %2, align 8
  %5 = fneg double %3
  tail call void @__quantum__qis__rx(double %5, %Qubit* %4)
  ret void
}

define internal void @Microsoft__Quantum__Intrinsic__Rx__ctl__wrapper(%Tuple* nocapture readnone %capture-tuple, %Tuple* nocapture readonly %arg-tuple, %Tuple* nocapture readnone %result-tuple) {
entry:
  %0 = bitcast %Tuple* %arg-tuple to { %Array*, { double, %Qubit* }* }*
  %1 = bitcast %Tuple* %arg-tuple to %Array**
  %2 = getelementptr inbounds { %Array*, { double, %Qubit* }* }, { %Array*, { double, %Qubit* }* }* %0, i64 0, i32 1
  %3 = load %Array*, %Array** %1, align 8
  %4 = load { double, %Qubit* }*, { double, %Qubit* }** %2, align 8
  tail call fastcc void @Microsoft__Quantum__Intrinsic__Rx__ctl(%Array* %3, { double, %Qubit* }* %4)
  ret void
}

define internal void @Microsoft__Quantum__Intrinsic__Rx__ctladj__wrapper(%Tuple* nocapture readnone %capture-tuple, %Tuple* nocapture readonly %arg-tuple, %Tuple* nocapture readnone %result-tuple) {
entry:
  %0 = bitcast %Tuple* %arg-tuple to { %Array*, { double, %Qubit* }* }*
  %1 = bitcast %Tuple* %arg-tuple to %Array**
  %2 = getelementptr inbounds { %Array*, { double, %Qubit* }* }, { %Array*, { double, %Qubit* }* }* %0, i64 0, i32 1
  %3 = load %Array*, %Array** %1, align 8
  %4 = load { double, %Qubit* }*, { double, %Qubit* }** %2, align 8
  tail call void @__quantum__rt__array_update_alias_count(%Array* %3, i32 1)
  %5 = getelementptr inbounds { double, %Qubit* }, { double, %Qubit* }* %4, i64 0, i32 0
  %theta.i = load double, double* %5, align 8
  %6 = getelementptr inbounds { double, %Qubit* }, { double, %Qubit* }* %4, i64 0, i32 1
  %qubit.i = load %Qubit*, %Qubit** %6, align 8
  %7 = tail call %Tuple* @__quantum__rt__tuple_create(i64 16)
  %8 = bitcast %Tuple* %7 to { double, %Qubit* }*
  %9 = bitcast %Tuple* %7 to double*
  %10 = getelementptr inbounds { double, %Qubit* }, { double, %Qubit* }* %8, i64 0, i32 1
  %11 = fneg double %theta.i
  store double %11, double* %9, align 8
  store %Qubit* %qubit.i, %Qubit** %10, align 8
  tail call fastcc void @Microsoft__Quantum__Intrinsic__Rx__ctl(%Array* %3, { double, %Qubit* }* %8)
  tail call void @__quantum__rt__array_update_alias_count(%Array* %3, i32 -1)
  tail call void @__quantum__rt__tuple_update_reference_count(%Tuple* %7, i32 -1)
  ret void
}

declare void @__quantum__qis__ry(double, %Qubit*) local_unnamed_addr

define internal void @Microsoft__Quantum__Intrinsic__Ry__body__wrapper(%Tuple* nocapture readnone %capture-tuple, %Tuple* nocapture readonly %arg-tuple, %Tuple* nocapture readnone %result-tuple) {
entry:
  %0 = bitcast %Tuple* %arg-tuple to { double, %Qubit* }*
  %1 = bitcast %Tuple* %arg-tuple to double*
  %2 = getelementptr inbounds { double, %Qubit* }, { double, %Qubit* }* %0, i64 0, i32 1
  %3 = load double, double* %1, align 8
  %4 = load %Qubit*, %Qubit** %2, align 8
  tail call void @__quantum__qis__ry(double %3, %Qubit* %4)
  ret void
}

define internal void @Microsoft__Quantum__Intrinsic__Ry__adj__wrapper(%Tuple* nocapture readnone %capture-tuple, %Tuple* nocapture readonly %arg-tuple, %Tuple* nocapture readnone %result-tuple) {
entry:
  %0 = bitcast %Tuple* %arg-tuple to { double, %Qubit* }*
  %1 = bitcast %Tuple* %arg-tuple to double*
  %2 = getelementptr inbounds { double, %Qubit* }, { double, %Qubit* }* %0, i64 0, i32 1
  %3 = load double, double* %1, align 8
  %4 = load %Qubit*, %Qubit** %2, align 8
  %5 = fneg double %3
  tail call void @__quantum__qis__ry(double %5, %Qubit* %4)
  ret void
}

define internal void @Microsoft__Quantum__Intrinsic__Ry__ctl__wrapper(%Tuple* nocapture readnone %capture-tuple, %Tuple* nocapture readonly %arg-tuple, %Tuple* nocapture readnone %result-tuple) {
entry:
  %0 = bitcast %Tuple* %arg-tuple to { %Array*, { double, %Qubit* }* }*
  %1 = bitcast %Tuple* %arg-tuple to %Array**
  %2 = getelementptr inbounds { %Array*, { double, %Qubit* }* }, { %Array*, { double, %Qubit* }* }* %0, i64 0, i32 1
  %3 = load %Array*, %Array** %1, align 8
  %4 = load { double, %Qubit* }*, { double, %Qubit* }** %2, align 8
  tail call fastcc void @Microsoft__Quantum__Intrinsic__Ry__ctl(%Array* %3, { double, %Qubit* }* %4)
  ret void
}

define internal void @Microsoft__Quantum__Intrinsic__Ry__ctladj__wrapper(%Tuple* nocapture readnone %capture-tuple, %Tuple* nocapture readonly %arg-tuple, %Tuple* nocapture readnone %result-tuple) {
entry:
  %0 = bitcast %Tuple* %arg-tuple to { %Array*, { double, %Qubit* }* }*
  %1 = bitcast %Tuple* %arg-tuple to %Array**
  %2 = getelementptr inbounds { %Array*, { double, %Qubit* }* }, { %Array*, { double, %Qubit* }* }* %0, i64 0, i32 1
  %3 = load %Array*, %Array** %1, align 8
  %4 = load { double, %Qubit* }*, { double, %Qubit* }** %2, align 8
  tail call void @__quantum__rt__array_update_alias_count(%Array* %3, i32 1)
  %5 = getelementptr inbounds { double, %Qubit* }, { double, %Qubit* }* %4, i64 0, i32 0
  %theta.i = load double, double* %5, align 8
  %6 = getelementptr inbounds { double, %Qubit* }, { double, %Qubit* }* %4, i64 0, i32 1
  %qubit.i = load %Qubit*, %Qubit** %6, align 8
  %7 = tail call %Tuple* @__quantum__rt__tuple_create(i64 16)
  %8 = bitcast %Tuple* %7 to { double, %Qubit* }*
  %9 = bitcast %Tuple* %7 to double*
  %10 = getelementptr inbounds { double, %Qubit* }, { double, %Qubit* }* %8, i64 0, i32 1
  %11 = fneg double %theta.i
  store double %11, double* %9, align 8
  store %Qubit* %qubit.i, %Qubit** %10, align 8
  tail call fastcc void @Microsoft__Quantum__Intrinsic__Ry__ctl(%Array* %3, { double, %Qubit* }* %8)
  tail call void @__quantum__rt__array_update_alias_count(%Array* %3, i32 -1)
  tail call void @__quantum__rt__tuple_update_reference_count(%Tuple* %7, i32 -1)
  ret void
}

declare void @__quantum__qis__rz(double, %Qubit*) local_unnamed_addr

define internal void @Microsoft__Quantum__Intrinsic__Rz__body__wrapper(%Tuple* nocapture readnone %capture-tuple, %Tuple* nocapture readonly %arg-tuple, %Tuple* nocapture readnone %result-tuple) {
entry:
  %0 = bitcast %Tuple* %arg-tuple to { double, %Qubit* }*
  %1 = bitcast %Tuple* %arg-tuple to double*
  %2 = getelementptr inbounds { double, %Qubit* }, { double, %Qubit* }* %0, i64 0, i32 1
  %3 = load double, double* %1, align 8
  %4 = load %Qubit*, %Qubit** %2, align 8
  tail call void @__quantum__qis__rz(double %3, %Qubit* %4)
  ret void
}

define internal void @Microsoft__Quantum__Intrinsic__Rz__adj__wrapper(%Tuple* nocapture readnone %capture-tuple, %Tuple* nocapture readonly %arg-tuple, %Tuple* nocapture readnone %result-tuple) {
entry:
  %0 = bitcast %Tuple* %arg-tuple to { double, %Qubit* }*
  %1 = bitcast %Tuple* %arg-tuple to double*
  %2 = getelementptr inbounds { double, %Qubit* }, { double, %Qubit* }* %0, i64 0, i32 1
  %3 = load double, double* %1, align 8
  %4 = load %Qubit*, %Qubit** %2, align 8
  %5 = fneg double %3
  tail call void @__quantum__qis__rz(double %5, %Qubit* %4)
  ret void
}

define internal void @Microsoft__Quantum__Intrinsic__Rz__ctl__wrapper(%Tuple* nocapture readnone %capture-tuple, %Tuple* nocapture readonly %arg-tuple, %Tuple* nocapture readnone %result-tuple) {
entry:
  %0 = bitcast %Tuple* %arg-tuple to { %Array*, { double, %Qubit* }* }*
  %1 = bitcast %Tuple* %arg-tuple to %Array**
  %2 = getelementptr inbounds { %Array*, { double, %Qubit* }* }, { %Array*, { double, %Qubit* }* }* %0, i64 0, i32 1
  %3 = load %Array*, %Array** %1, align 8
  %4 = load { double, %Qubit* }*, { double, %Qubit* }** %2, align 8
  tail call fastcc void @Microsoft__Quantum__Intrinsic__Rz__ctl(%Array* %3, { double, %Qubit* }* %4)
  ret void
}

define internal void @Microsoft__Quantum__Intrinsic__Rz__ctladj__wrapper(%Tuple* nocapture readnone %capture-tuple, %Tuple* nocapture readonly %arg-tuple, %Tuple* nocapture readnone %result-tuple) {
entry:
  %0 = bitcast %Tuple* %arg-tuple to { %Array*, { double, %Qubit* }* }*
  %1 = bitcast %Tuple* %arg-tuple to %Array**
  %2 = getelementptr inbounds { %Array*, { double, %Qubit* }* }, { %Array*, { double, %Qubit* }* }* %0, i64 0, i32 1
  %3 = load %Array*, %Array** %1, align 8
  %4 = load { double, %Qubit* }*, { double, %Qubit* }** %2, align 8
  tail call void @__quantum__rt__array_update_alias_count(%Array* %3, i32 1)
  %5 = getelementptr inbounds { double, %Qubit* }, { double, %Qubit* }* %4, i64 0, i32 0
  %theta.i = load double, double* %5, align 8
  %6 = getelementptr inbounds { double, %Qubit* }, { double, %Qubit* }* %4, i64 0, i32 1
  %qubit.i = load %Qubit*, %Qubit** %6, align 8
  %7 = tail call %Tuple* @__quantum__rt__tuple_create(i64 16)
  %8 = bitcast %Tuple* %7 to { double, %Qubit* }*
  %9 = bitcast %Tuple* %7 to double*
  %10 = getelementptr inbounds { double, %Qubit* }, { double, %Qubit* }* %8, i64 0, i32 1
  %11 = fneg double %theta.i
  store double %11, double* %9, align 8
  store %Qubit* %qubit.i, %Qubit** %10, align 8
  tail call fastcc void @Microsoft__Quantum__Intrinsic__Rz__ctl(%Array* %3, { double, %Qubit* }* %8)
  tail call void @__quantum__rt__array_update_alias_count(%Array* %3, i32 -1)
  tail call void @__quantum__rt__tuple_update_reference_count(%Tuple* %7, i32 -1)
  ret void
}

declare void @__quantum__qis__s(%Qubit*) local_unnamed_addr

declare void @__quantum__qis__sadj(%Qubit*) local_unnamed_addr

define internal void @Microsoft__Quantum__Intrinsic__S__body__wrapper(%Tuple* nocapture readnone %capture-tuple, %Tuple* nocapture readonly %arg-tuple, %Tuple* nocapture readnone %result-tuple) {
entry:
  %0 = bitcast %Tuple* %arg-tuple to %Qubit**
  %1 = load %Qubit*, %Qubit** %0, align 8
  tail call void @__quantum__qis__s(%Qubit* %1)
  ret void
}

define internal void @Microsoft__Quantum__Intrinsic__S__adj__wrapper(%Tuple* nocapture readnone %capture-tuple, %Tuple* nocapture readonly %arg-tuple, %Tuple* nocapture readnone %result-tuple) {
entry:
  %0 = bitcast %Tuple* %arg-tuple to %Qubit**
  %1 = load %Qubit*, %Qubit** %0, align 8
  tail call void @__quantum__qis__sadj(%Qubit* %1)
  ret void
}

define internal void @Microsoft__Quantum__Intrinsic__S__ctl__wrapper(%Tuple* nocapture readnone %capture-tuple, %Tuple* nocapture readonly %arg-tuple, %Tuple* nocapture readnone %result-tuple) {
entry:
  %0 = bitcast %Tuple* %arg-tuple to { %Array*, %Qubit* }*
  %1 = bitcast %Tuple* %arg-tuple to %Array**
  %2 = getelementptr inbounds { %Array*, %Qubit* }, { %Array*, %Qubit* }* %0, i64 0, i32 1
  %3 = load %Array*, %Array** %1, align 8
  %4 = load %Qubit*, %Qubit** %2, align 8
  tail call fastcc void @Microsoft__Quantum__Intrinsic__S__ctl(%Array* %3, %Qubit* %4)
  ret void
}

define internal void @Microsoft__Quantum__Intrinsic__S__ctladj__wrapper(%Tuple* nocapture readnone %capture-tuple, %Tuple* nocapture readonly %arg-tuple, %Tuple* nocapture readnone %result-tuple) {
entry:
  %0 = bitcast %Tuple* %arg-tuple to { %Array*, %Qubit* }*
  %1 = bitcast %Tuple* %arg-tuple to %Array**
  %2 = getelementptr inbounds { %Array*, %Qubit* }, { %Array*, %Qubit* }* %0, i64 0, i32 1
  %3 = load %Array*, %Array** %1, align 8
  %4 = load %Qubit*, %Qubit** %2, align 8
  tail call void @__quantum__rt__array_update_alias_count(%Array* %3, i32 1)
  %5 = tail call i64 @__quantum__rt__array_get_size_1d(%Array* %3)
  %6 = icmp eq i64 %5, 0
  br i1 %6, label %then0__1.i, label %test1__1.i

then0__1.i:                                       ; preds = %entry
  tail call void @__quantum__qis__sadj(%Qubit* %4)
  br label %Microsoft__Quantum__Intrinsic__S__ctladj.exit

test1__1.i:                                       ; preds = %entry
  %7 = tail call i64 @__quantum__rt__array_get_size_1d(%Array* %3)
  %8 = icmp eq i64 %7, 1
  br i1 %8, label %then1__1.i, label %else__1.i

then1__1.i:                                       ; preds = %test1__1.i
  %9 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %3, i64 0)
  %10 = bitcast i8* %9 to %Qubit**
  %11 = load %Qubit*, %Qubit** %10, align 8
  tail call void @__quantum__qis__tadj(%Qubit* %11)
  tail call void @__quantum__qis__tadj(%Qubit* %4)
  %12 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %3, i64 0)
  %13 = bitcast i8* %12 to %Qubit**
  %14 = load %Qubit*, %Qubit** %13, align 8
  tail call void @__quantum__qis__cnot(%Qubit* %14, %Qubit* %4)
  tail call void @__quantum__qis__t(%Qubit* %4)
  %15 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %3, i64 0)
  %16 = bitcast i8* %15 to %Qubit**
  %17 = load %Qubit*, %Qubit** %16, align 8
  tail call void @__quantum__qis__cnot(%Qubit* %17, %Qubit* %4)
  br label %Microsoft__Quantum__Intrinsic__S__ctladj.exit

else__1.i:                                        ; preds = %test1__1.i
  %18 = tail call %Callable* @__quantum__rt__callable_create([4 x void (%Tuple*, %Tuple*, %Tuple*)*]* nonnull @Microsoft__Quantum__Intrinsic__S, [2 x void (%Tuple*, i32)*]* null, %Tuple* null)
  tail call void @__quantum__rt__callable_make_adjoint(%Callable* %18)
  tail call void @__quantum__rt__callable_make_controlled(%Callable* %18)
  %19 = tail call %Tuple* @__quantum__rt__tuple_create(i64 16)
  %20 = bitcast %Tuple* %19 to { %Array*, %Qubit* }*
  %21 = bitcast %Tuple* %19 to %Array**
  %22 = getelementptr inbounds { %Array*, %Qubit* }, { %Array*, %Qubit* }* %20, i64 0, i32 1
  tail call void @__quantum__rt__array_update_reference_count(%Array* %3, i32 1)
  store %Array* %3, %Array** %21, align 8
  store %Qubit* %4, %Qubit** %22, align 8
  tail call fastcc void @Microsoft__Quantum__Intrinsic___10914a55af804e59be3c44a0b98ca5ac___QsRef23__ApplyWithLessControlsA____body(%Callable* %18, { %Array*, %Qubit* }* %20)
  tail call void @__quantum__rt__capture_update_reference_count(%Callable* %18, i32 -1)
  tail call void @__quantum__rt__callable_update_reference_count(%Callable* %18, i32 -1)
  tail call void @__quantum__rt__array_update_reference_count(%Array* %3, i32 -1)
  tail call void @__quantum__rt__tuple_update_reference_count(%Tuple* %19, i32 -1)
  br label %Microsoft__Quantum__Intrinsic__S__ctladj.exit

Microsoft__Quantum__Intrinsic__S__ctladj.exit:    ; preds = %then0__1.i, %then1__1.i, %else__1.i
  tail call void @__quantum__rt__array_update_alias_count(%Array* %3, i32 -1)
  ret void
}

declare void @__quantum__rt__callable_make_adjoint(%Callable*) local_unnamed_addr

declare void @__quantum__qis__t(%Qubit*) local_unnamed_addr

declare void @__quantum__qis__tadj(%Qubit*) local_unnamed_addr

define internal void @Microsoft__Quantum__Intrinsic__T__body__wrapper(%Tuple* nocapture readnone %capture-tuple, %Tuple* nocapture readonly %arg-tuple, %Tuple* nocapture readnone %result-tuple) {
entry:
  %0 = bitcast %Tuple* %arg-tuple to %Qubit**
  %1 = load %Qubit*, %Qubit** %0, align 8
  tail call void @__quantum__qis__t(%Qubit* %1)
  ret void
}

define internal void @Microsoft__Quantum__Intrinsic__T__adj__wrapper(%Tuple* nocapture readnone %capture-tuple, %Tuple* nocapture readonly %arg-tuple, %Tuple* nocapture readnone %result-tuple) {
entry:
  %0 = bitcast %Tuple* %arg-tuple to %Qubit**
  %1 = load %Qubit*, %Qubit** %0, align 8
  tail call void @__quantum__qis__tadj(%Qubit* %1)
  ret void
}

define internal void @Microsoft__Quantum__Intrinsic__T__ctl__wrapper(%Tuple* nocapture readnone %capture-tuple, %Tuple* nocapture readonly %arg-tuple, %Tuple* nocapture readnone %result-tuple) {
entry:
  %0 = bitcast %Tuple* %arg-tuple to { %Array*, %Qubit* }*
  %1 = bitcast %Tuple* %arg-tuple to %Array**
  %2 = getelementptr inbounds { %Array*, %Qubit* }, { %Array*, %Qubit* }* %0, i64 0, i32 1
  %3 = load %Array*, %Array** %1, align 8
  %4 = load %Qubit*, %Qubit** %2, align 8
  tail call fastcc void @Microsoft__Quantum__Intrinsic__T__ctl(%Array* %3, %Qubit* %4)
  ret void
}

define internal void @Microsoft__Quantum__Intrinsic__T__ctladj__wrapper(%Tuple* nocapture readnone %capture-tuple, %Tuple* nocapture readonly %arg-tuple, %Tuple* nocapture readnone %result-tuple) {
entry:
  %0 = bitcast %Tuple* %arg-tuple to { %Array*, %Qubit* }*
  %1 = bitcast %Tuple* %arg-tuple to %Array**
  %2 = getelementptr inbounds { %Array*, %Qubit* }, { %Array*, %Qubit* }* %0, i64 0, i32 1
  %3 = load %Array*, %Array** %1, align 8
  %4 = load %Qubit*, %Qubit** %2, align 8
  tail call void @__quantum__rt__array_update_alias_count(%Array* %3, i32 1)
  %5 = tail call i64 @__quantum__rt__array_get_size_1d(%Array* %3)
  %6 = icmp eq i64 %5, 0
  br i1 %6, label %then0__1.i, label %test1__1.i

then0__1.i:                                       ; preds = %entry
  tail call void @__quantum__qis__tadj(%Qubit* %4)
  br label %Microsoft__Quantum__Intrinsic__T__ctladj.exit

test1__1.i:                                       ; preds = %entry
  %7 = tail call i64 @__quantum__rt__array_get_size_1d(%Array* %3)
  %8 = icmp eq i64 %7, 1
  br i1 %8, label %then1__1.i, label %else__1.i

then1__1.i:                                       ; preds = %test1__1.i
  %9 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %3, i64 0)
  %10 = bitcast i8* %9 to %Qubit**
  %11 = load %Qubit*, %Qubit** %10, align 8
  tail call void @__quantum__qis__rz(double 0xBFD921FB54442D18, %Qubit* %11)
  tail call void @__quantum__qis__rz(double 0xBFD921FB54442D18, %Qubit* %4)
  %12 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %3, i64 0)
  %13 = bitcast i8* %12 to %Qubit**
  %14 = load %Qubit*, %Qubit** %13, align 8
  tail call void @__quantum__qis__cnot(%Qubit* %14, %Qubit* %4)
  tail call void @__quantum__qis__rz(double 0x3FD921FB54442D18, %Qubit* %4)
  %15 = tail call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %3, i64 0)
  %16 = bitcast i8* %15 to %Qubit**
  %17 = load %Qubit*, %Qubit** %16, align 8
  tail call void @__quantum__qis__cnot(%Qubit* %17, %Qubit* %4)
  br label %Microsoft__Quantum__Intrinsic__T__ctladj.exit

else__1.i:                                        ; preds = %test1__1.i
  %18 = tail call %Callable* @__quantum__rt__callable_create([4 x void (%Tuple*, %Tuple*, %Tuple*)*]* nonnull @Microsoft__Quantum__Intrinsic__T, [2 x void (%Tuple*, i32)*]* null, %Tuple* null)
  tail call void @__quantum__rt__callable_make_adjoint(%Callable* %18)
  tail call void @__quantum__rt__callable_make_controlled(%Callable* %18)
  %19 = tail call %Tuple* @__quantum__rt__tuple_create(i64 16)
  %20 = bitcast %Tuple* %19 to { %Array*, %Qubit* }*
  %21 = bitcast %Tuple* %19 to %Array**
  %22 = getelementptr inbounds { %Array*, %Qubit* }, { %Array*, %Qubit* }* %20, i64 0, i32 1
  tail call void @__quantum__rt__array_update_reference_count(%Array* %3, i32 1)
  store %Array* %3, %Array** %21, align 8
  store %Qubit* %4, %Qubit** %22, align 8
  tail call fastcc void @Microsoft__Quantum__Intrinsic___10914a55af804e59be3c44a0b98ca5ac___QsRef23__ApplyWithLessControlsA____body(%Callable* %18, { %Array*, %Qubit* }* %20)
  tail call void @__quantum__rt__capture_update_reference_count(%Callable* %18, i32 -1)
  tail call void @__quantum__rt__callable_update_reference_count(%Callable* %18, i32 -1)
  tail call void @__quantum__rt__array_update_reference_count(%Array* %3, i32 -1)
  tail call void @__quantum__rt__tuple_update_reference_count(%Tuple* %19, i32 -1)
  br label %Microsoft__Quantum__Intrinsic__T__ctladj.exit

Microsoft__Quantum__Intrinsic__T__ctladj.exit:    ; preds = %then0__1.i, %then1__1.i, %else__1.i
  tail call void @__quantum__rt__array_update_alias_count(%Array* %3, i32 -1)
  ret void
}

define internal void @Microsoft__Quantum__Intrinsic__X__body__wrapper(%Tuple* nocapture readnone %capture-tuple, %Tuple* nocapture readonly %arg-tuple, %Tuple* nocapture readnone %result-tuple) {
entry:
  %0 = bitcast %Tuple* %arg-tuple to %Qubit**
  %1 = load %Qubit*, %Qubit** %0, align 8
  tail call void @__quantum__qis__x(%Qubit* %1)
  ret void
}

define internal void @Microsoft__Quantum__Intrinsic__X__adj__wrapper(%Tuple* nocapture readnone %capture-tuple, %Tuple* nocapture readonly %arg-tuple, %Tuple* nocapture readnone %result-tuple) {
entry:
  %0 = bitcast %Tuple* %arg-tuple to %Qubit**
  %1 = load %Qubit*, %Qubit** %0, align 8
  tail call void @__quantum__qis__x(%Qubit* %1)
  ret void
}

define internal void @Microsoft__Quantum__Intrinsic__X__ctl__wrapper(%Tuple* nocapture readnone %capture-tuple, %Tuple* nocapture readonly %arg-tuple, %Tuple* nocapture readnone %result-tuple) {
entry:
  %0 = bitcast %Tuple* %arg-tuple to { %Array*, %Qubit* }*
  %1 = bitcast %Tuple* %arg-tuple to %Array**
  %2 = getelementptr inbounds { %Array*, %Qubit* }, { %Array*, %Qubit* }* %0, i64 0, i32 1
  %3 = load %Array*, %Array** %1, align 8
  %4 = load %Qubit*, %Qubit** %2, align 8
  tail call fastcc void @Microsoft__Quantum__Intrinsic__X__ctl(%Array* %3, %Qubit* %4)
  ret void
}

define internal void @Microsoft__Quantum__Intrinsic__X__ctladj__wrapper(%Tuple* nocapture readnone %capture-tuple, %Tuple* nocapture readonly %arg-tuple, %Tuple* nocapture readnone %result-tuple) {
entry:
  %0 = bitcast %Tuple* %arg-tuple to { %Array*, %Qubit* }*
  %1 = bitcast %Tuple* %arg-tuple to %Array**
  %2 = getelementptr inbounds { %Array*, %Qubit* }, { %Array*, %Qubit* }* %0, i64 0, i32 1
  %3 = load %Array*, %Array** %1, align 8
  %4 = load %Qubit*, %Qubit** %2, align 8
  tail call void @__quantum__rt__array_update_alias_count(%Array* %3, i32 1)
  tail call fastcc void @Microsoft__Quantum__Intrinsic__X__ctl(%Array* %3, %Qubit* %4)
  tail call void @__quantum__rt__array_update_alias_count(%Array* %3, i32 -1)
  ret void
}

define internal void @Microsoft__Quantum__Intrinsic__Y__body__wrapper(%Tuple* nocapture readnone %capture-tuple, %Tuple* nocapture readonly %arg-tuple, %Tuple* nocapture readnone %result-tuple) {
entry:
  %0 = bitcast %Tuple* %arg-tuple to %Qubit**
  %1 = load %Qubit*, %Qubit** %0, align 8
  tail call void @__quantum__qis__y(%Qubit* %1)
  ret void
}

define internal void @Microsoft__Quantum__Intrinsic__Y__adj__wrapper(%Tuple* nocapture readnone %capture-tuple, %Tuple* nocapture readonly %arg-tuple, %Tuple* nocapture readnone %result-tuple) {
entry:
  %0 = bitcast %Tuple* %arg-tuple to %Qubit**
  %1 = load %Qubit*, %Qubit** %0, align 8
  tail call void @__quantum__qis__y(%Qubit* %1)
  ret void
}

define internal void @Microsoft__Quantum__Intrinsic__Y__ctl__wrapper(%Tuple* nocapture readnone %capture-tuple, %Tuple* nocapture readonly %arg-tuple, %Tuple* nocapture readnone %result-tuple) {
entry:
  %0 = bitcast %Tuple* %arg-tuple to { %Array*, %Qubit* }*
  %1 = bitcast %Tuple* %arg-tuple to %Array**
  %2 = getelementptr inbounds { %Array*, %Qubit* }, { %Array*, %Qubit* }* %0, i64 0, i32 1
  %3 = load %Array*, %Array** %1, align 8
  %4 = load %Qubit*, %Qubit** %2, align 8
  tail call fastcc void @Microsoft__Quantum__Intrinsic__Y__ctl(%Array* %3, %Qubit* %4)
  ret void
}

define internal void @Microsoft__Quantum__Intrinsic__Y__ctladj__wrapper(%Tuple* nocapture readnone %capture-tuple, %Tuple* nocapture readonly %arg-tuple, %Tuple* nocapture readnone %result-tuple) {
entry:
  %0 = bitcast %Tuple* %arg-tuple to { %Array*, %Qubit* }*
  %1 = bitcast %Tuple* %arg-tuple to %Array**
  %2 = getelementptr inbounds { %Array*, %Qubit* }, { %Array*, %Qubit* }* %0, i64 0, i32 1
  %3 = load %Array*, %Array** %1, align 8
  %4 = load %Qubit*, %Qubit** %2, align 8
  tail call void @__quantum__rt__array_update_alias_count(%Array* %3, i32 1)
  tail call fastcc void @Microsoft__Quantum__Intrinsic__Y__ctl(%Array* %3, %Qubit* %4)
  tail call void @__quantum__rt__array_update_alias_count(%Array* %3, i32 -1)
  ret void
}

define internal void @Microsoft__Quantum__Intrinsic__Z__body__wrapper(%Tuple* nocapture readnone %capture-tuple, %Tuple* nocapture readonly %arg-tuple, %Tuple* nocapture readnone %result-tuple) {
entry:
  %0 = bitcast %Tuple* %arg-tuple to %Qubit**
  %1 = load %Qubit*, %Qubit** %0, align 8
  tail call void @__quantum__qis__z(%Qubit* %1)
  ret void
}

define internal void @Microsoft__Quantum__Intrinsic__Z__adj__wrapper(%Tuple* nocapture readnone %capture-tuple, %Tuple* nocapture readonly %arg-tuple, %Tuple* nocapture readnone %result-tuple) {
entry:
  %0 = bitcast %Tuple* %arg-tuple to %Qubit**
  %1 = load %Qubit*, %Qubit** %0, align 8
  tail call void @__quantum__qis__z(%Qubit* %1)
  ret void
}

define internal void @Microsoft__Quantum__Intrinsic__Z__ctl__wrapper(%Tuple* nocapture readnone %capture-tuple, %Tuple* nocapture readonly %arg-tuple, %Tuple* nocapture readnone %result-tuple) {
entry:
  %0 = bitcast %Tuple* %arg-tuple to { %Array*, %Qubit* }*
  %1 = bitcast %Tuple* %arg-tuple to %Array**
  %2 = getelementptr inbounds { %Array*, %Qubit* }, { %Array*, %Qubit* }* %0, i64 0, i32 1
  %3 = load %Array*, %Array** %1, align 8
  %4 = load %Qubit*, %Qubit** %2, align 8
  tail call fastcc void @Microsoft__Quantum__Intrinsic__Z__ctl(%Array* %3, %Qubit* %4)
  ret void
}

define internal void @Microsoft__Quantum__Intrinsic__Z__ctladj__wrapper(%Tuple* nocapture readnone %capture-tuple, %Tuple* nocapture readonly %arg-tuple, %Tuple* nocapture readnone %result-tuple) {
entry:
  %0 = bitcast %Tuple* %arg-tuple to { %Array*, %Qubit* }*
  %1 = bitcast %Tuple* %arg-tuple to %Array**
  %2 = getelementptr inbounds { %Array*, %Qubit* }, { %Array*, %Qubit* }* %0, i64 0, i32 1
  %3 = load %Array*, %Array** %1, align 8
  %4 = load %Qubit*, %Qubit** %2, align 8
  tail call void @__quantum__rt__array_update_alias_count(%Array* %3, i32 1)
  tail call fastcc void @Microsoft__Quantum__Intrinsic__Z__ctl(%Array* %3, %Qubit* %4)
  tail call void @__quantum__rt__array_update_alias_count(%Array* %3, i32 -1)
  ret void
}

declare void @__quantum__rt__capture_update_alias_count(%Callable*, i32) local_unnamed_addr

declare void @__quantum__rt__callable_update_alias_count(%Callable*, i32) local_unnamed_addr

declare void @__quantum__rt__tuple_update_alias_count(%Tuple*, i32) local_unnamed_addr

declare void @__quantum__rt__qubit_release_array(%Array*) local_unnamed_addr

declare void @__quantum__rt__callable_invoke(%Callable*, %Tuple*, %Tuple*) local_unnamed_addr

define void @Microsoft__Quantum__Qir__Emission__BellState__Interop(i64 %nrIter) local_unnamed_addr #0 {
entry:
  tail call fastcc void @Microsoft__Quantum__Qir__Emission__BellState__body()
  ret void
}

define void @Microsoft__Quantum__Qir__Emission__BellState(i64 %nrIter) local_unnamed_addr #1 {
entry:
  tail call fastcc void @Microsoft__Quantum__Qir__Emission__BellState__body()
  ret void
}

attributes #0 = { "InteropFriendly" }
attributes #1 = { "EntryPoint" }
