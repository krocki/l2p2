; ModuleID = 'gemm4x4.cl'
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.10.0"

; Function Attrs: nounwind ssp uwtable
define void @k_gen_4_4_cl_gemm_v3_(<4 x float>* noalias nocapture %Z, <4 x float>* noalias nocapture readonly %X, <4 x float>* noalias nocapture readonly %Y) #0 {
  %1 = load <4 x float>* %X, align 16, !tbaa !8
  %2 = getelementptr inbounds <4 x float>* %X, i64 1
  %3 = load <4 x float>* %2, align 16, !tbaa !8
  %4 = getelementptr inbounds <4 x float>* %X, i64 2
  %5 = load <4 x float>* %4, align 16, !tbaa !8
  %6 = getelementptr inbounds <4 x float>* %X, i64 3
  %7 = load <4 x float>* %6, align 16, !tbaa !8
  %8 = load <4 x float>* %Y, align 16, !tbaa !8
  %9 = getelementptr inbounds <4 x float>* %Y, i64 1
  %10 = load <4 x float>* %9, align 16, !tbaa !8
  %11 = getelementptr inbounds <4 x float>* %Y, i64 2
  %12 = load <4 x float>* %11, align 16, !tbaa !8
  %13 = getelementptr inbounds <4 x float>* %Y, i64 3
  %14 = load <4 x float>* %13, align 16, !tbaa !8
  %15 = shufflevector <4 x float> %8, <4 x float> undef, <4 x i32> zeroinitializer
  %16 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %1, <4 x float> %15, <4 x float> zeroinitializer)
  %17 = shufflevector <4 x float> %10, <4 x float> undef, <4 x i32> zeroinitializer
  %18 = fmul <4 x float> %1, %17
  %19 = fadd <4 x float> %18, zeroinitializer
  %20 = shufflevector <4 x float> %12, <4 x float> undef, <4 x i32> zeroinitializer
  %21 = fmul <4 x float> %1, %20
  %22 = fadd <4 x float> %21, zeroinitializer
  %23 = shufflevector <4 x float> %14, <4 x float> undef, <4 x i32> zeroinitializer
  %24 = fmul <4 x float> %1, %23
  %25 = fadd <4 x float> %24, zeroinitializer
  %26 = shufflevector <4 x float> %8, <4 x float> undef, <4 x i32> <i32 1, i32 1, i32 1, i32 1>
  %27 = fmul <4 x float> %3, %26
  %28 = fadd <4 x float> %27, %16
  %29 = shufflevector <4 x float> %10, <4 x float> undef, <4 x i32> <i32 1, i32 1, i32 1, i32 1>
  %30 = fmul <4 x float> %3, %29
  %31 = fadd <4 x float> %30, %19
  %32 = shufflevector <4 x float> %12, <4 x float> undef, <4 x i32> <i32 1, i32 1, i32 1, i32 1>
  %33 = fmul <4 x float> %3, %32
  %34 = fadd <4 x float> %33, %22
  %35 = shufflevector <4 x float> %14, <4 x float> undef, <4 x i32> <i32 1, i32 1, i32 1, i32 1>
  %36 = fmul <4 x float> %3, %35
  %37 = fadd <4 x float> %36, %25
  %38 = shufflevector <4 x float> %8, <4 x float> undef, <4 x i32> <i32 2, i32 2, i32 2, i32 2>
  %39 = fmul <4 x float> %5, %38
  %40 = fadd <4 x float> %39, %28
  %41 = shufflevector <4 x float> %10, <4 x float> undef, <4 x i32> <i32 2, i32 2, i32 2, i32 2>
  %42 = fmul <4 x float> %5, %41
  %43 = fadd <4 x float> %42, %31
  %44 = shufflevector <4 x float> %12, <4 x float> undef, <4 x i32> <i32 2, i32 2, i32 2, i32 2>
  %45 = fmul <4 x float> %5, %44
  %46 = fadd <4 x float> %45, %34
  %47 = shufflevector <4 x float> %14, <4 x float> undef, <4 x i32> <i32 2, i32 2, i32 2, i32 2>
  %48 = fmul <4 x float> %5, %47
  %49 = fadd <4 x float> %48, %37
  %50 = shufflevector <4 x float> %8, <4 x float> undef, <4 x i32> <i32 3, i32 3, i32 3, i32 3>
  %51 = fmul <4 x float> %7, %50
  %52 = fadd <4 x float> %51, %40
  %53 = shufflevector <4 x float> %10, <4 x float> undef, <4 x i32> <i32 3, i32 3, i32 3, i32 3>
  %54 = fmul <4 x float> %7, %53
  %55 = fadd <4 x float> %54, %43
  %56 = shufflevector <4 x float> %12, <4 x float> undef, <4 x i32> <i32 3, i32 3, i32 3, i32 3>
  %57 = fmul <4 x float> %7, %56
  %58 = fadd <4 x float> %57, %46
  %59 = shufflevector <4 x float> %14, <4 x float> undef, <4 x i32> <i32 3, i32 3, i32 3, i32 3>
  %60 = fmul <4 x float> %7, %59
  %61 = fadd <4 x float> %60, %49
  store <4 x float> %52, <4 x float>* %Z, align 16, !tbaa !8
  %62 = getelementptr inbounds <4 x float>* %Z, i64 1
  store <4 x float> %55, <4 x float>* %62, align 16, !tbaa !8
  %63 = getelementptr inbounds <4 x float>* %Z, i64 2
  store <4 x float> %58, <4 x float>* %63, align 16, !tbaa !8
  %64 = getelementptr inbounds <4 x float>* %Z, i64 3
  store <4 x float> %61, <4 x float>* %64, align 16, !tbaa !8
  ret void
}

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.fmuladd.v4f32(<4 x float>, <4 x float>, <4 x float>) #1

attributes #0 = { nounwind ssp uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+ssse3,+cx16,+sse,+sse2,+sse3" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }

!opencl.kernels = !{!0}
!llvm.module.flags = !{!6}
!llvm.ident = !{!7}

!0 = !{void (<4 x float>*, <4 x float>*, <4 x float>*)* @k_gen_4_4_cl_gemm_v3_, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 0, i32 0, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"float4*", !"float4*", !"float4*"}
!4 = !{!"kernel_arg_base_type", !"float __attribute__((ext_vector_type(4)))*", !"float __attribute__((ext_vector_type(4)))*", !"float __attribute__((ext_vector_type(4)))*"}
!5 = !{!"kernel_arg_type_qual", !"restrict", !"restrict const", !"restrict const"}
!6 = !{i32 1, !"PIC Level", i32 2}
!7 = !{!"Apple LLVM version 7.0.2 (clang-700.1.81)"}
!8 = !{!9, !9, i64 0}
!9 = !{!"omnipotent char", !10, i64 0}
!10 = !{!"Simple C/C++ TBAA"}
