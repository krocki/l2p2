; ModuleID = 'k_gen_1048576_1_1_4_65536_4_float4_0_1_c_map_gmem_2d_copy.omp.c'
source_filename = "k_gen_1048576_1_1_4_65536_4_float4_0_1_c_map_gmem_2d_copy.omp.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%ident_t = type { i32, i32, i32, i32, i8* }

@.str = private unnamed_addr constant [23 x i8] c";unknown;unknown;0;0;;\00", align 1
@0 = private unnamed_addr constant %ident_t { i32 0, i32 2, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str, i32 0, i32 0) }, align 8

; Function Attrs: noinline nounwind uwtable
define void @k_gen_1048576_1_1_4_65536_4_float4_0_1_c_map_gmem_2d_copy(<4 x float>* noalias, <4 x float>* noalias) #0 {
  %3 = alloca <4 x float>*, align 8
  %4 = alloca <4 x float>*, align 8
  %5 = call i32 @__kmpc_global_thread_num(%ident_t* @0)
  store <4 x float>* %0, <4 x float>** %3, align 8
  store <4 x float>* %1, <4 x float>** %4, align 8
  call void @__kmpc_push_num_threads(%ident_t* @0, i32 %5, i32 16)
  call void (%ident_t*, i32, void (i32*, i32*, ...)*, ...) @__kmpc_fork_call(%ident_t* @0, i32 2, void (i32*, i32*, ...)* bitcast (void (i32*, i32*, <4 x float>**, <4 x float>**)* @.omp_outlined. to void (i32*, i32*, ...)*), <4 x float>** %3, <4 x float>** %4)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define internal void @.omp_outlined.(i32* noalias, i32* noalias, <4 x float>** dereferenceable(8), <4 x float>** dereferenceable(8)) #0 {
  %5 = alloca i32*, align 8
  %6 = alloca i32*, align 8
  %7 = alloca <4 x float>**, align 8
  %8 = alloca <4 x float>**, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  store i32* %0, i32** %5, align 8
  store i32* %1, i32** %6, align 8
  store <4 x float>** %2, <4 x float>*** %7, align 8
  store <4 x float>** %3, <4 x float>*** %8, align 8
  %15 = load <4 x float>**, <4 x float>*** %7, align 8
  %16 = load <4 x float>**, <4 x float>*** %8, align 8
  store i32 0, i32* %10, align 4
  store i32 262143, i32* %11, align 4
  store i32 1, i32* %12, align 4
  store i32 0, i32* %13, align 4
  %17 = load i32*, i32** %5, align 8
  %18 = load i32, i32* %17, align 4
  call void @__kmpc_for_static_init_4(%ident_t* @0, i32 %18, i32 34, i32* %13, i32* %10, i32* %11, i32* %12, i32 1, i32 1)
  %19 = load i32, i32* %11, align 4
  %20 = icmp sgt i32 %19, 262143
  br i1 %20, label %21, label %22

; <label>:21:                                     ; preds = %4
  br label %24

; <label>:22:                                     ; preds = %4
  %23 = load i32, i32* %11, align 4
  br label %24

; <label>:24:                                     ; preds = %22, %21
  %25 = phi i32 [ 262143, %21 ], [ %23, %22 ]
  store i32 %25, i32* %11, align 4
  %26 = load i32, i32* %10, align 4
  store i32 %26, i32* %9, align 4
  br label %27

; <label>:27:                                     ; preds = %45, %24
  %28 = load i32, i32* %9, align 4
  %29 = load i32, i32* %11, align 4
  %30 = icmp sle i32 %28, %29
  br i1 %30, label %31, label %48

; <label>:31:                                     ; preds = %27
  %32 = load i32, i32* %9, align 4
  %33 = mul nsw i32 %32, 1
  %34 = add nsw i32 0, %33
  store i32 %34, i32* %14, align 4
  %35 = load <4 x float>*, <4 x float>** %16, align 8
  %36 = load i32, i32* %14, align 4
  %37 = sext i32 %36 to i64
  %38 = getelementptr inbounds <4 x float>, <4 x float>* %35, i64 %37
  %39 = load <4 x float>, <4 x float>* %38, align 16
  %40 = load <4 x float>*, <4 x float>** %15, align 8
  %41 = load i32, i32* %14, align 4
  %42 = sext i32 %41 to i64
  %43 = getelementptr inbounds <4 x float>, <4 x float>* %40, i64 %42
  store <4 x float> %39, <4 x float>* %43, align 16
  br label %44

; <label>:44:                                     ; preds = %31
  br label %45

; <label>:45:                                     ; preds = %44
  %46 = load i32, i32* %9, align 4
  %47 = add nsw i32 %46, 1
  store i32 %47, i32* %9, align 4
  br label %27, !llvm.loop !2

; <label>:48:                                     ; preds = %27
  br label %49

; <label>:49:                                     ; preds = %48
  call void @__kmpc_for_static_fini(%ident_t* @0, i32 %18)
  %50 = load i32, i32* %13, align 4
  %51 = icmp ne i32 %50, 0
  br i1 %51, label %52, label %53

; <label>:52:                                     ; preds = %49
  store i32 262144, i32* %14, align 4
  br label %53

; <label>:53:                                     ; preds = %52, %49
  ret void
}

declare void @__kmpc_for_static_init_4(%ident_t*, i32, i32, i32*, i32*, i32*, i32*, i32, i32)

declare void @__kmpc_for_static_fini(%ident_t*, i32)

declare i32 @__kmpc_global_thread_num(%ident_t*)

declare void @__kmpc_push_num_threads(%ident_t*, i32, i32)

declare void @__kmpc_fork_call(%ident_t*, i32, void (i32*, i32*, ...)*, ...)

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 5.0.0 (git@github.com:krocki/clang.git 088eaf5b7b121f70b2fe6b4328b7d8819c9f2aab) (git@github.com:krocki/llvm.git 7bfd7c00d76359356c3572222f33b03931972c9f)"}
!2 = distinct !{!2, !3}
!3 = !{!"llvm.loop.vectorize.enable", i1 true}
