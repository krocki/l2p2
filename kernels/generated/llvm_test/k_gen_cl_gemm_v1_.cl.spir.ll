; ModuleID = 'k_gen_cl_gemm_v1_.cl'
source_filename = "k_gen_cl_gemm_v1_.cl"
target datalayout = "e-p:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "spir-unknown-unknown"

@k_gen_cl_gemm_v1_.Awrk = internal unnamed_addr addrspace(3) global [256 x float] undef, align 4
@k_gen_cl_gemm_v1_.Bwrk = internal unnamed_addr addrspace(3) global [256 x float] undef, align 4

; Function Attrs: nounwind
define spir_kernel void @k_gen_cl_gemm_v1_(i32, float addrspace(1)* noalias nocapture, float addrspace(1)* noalias nocapture readonly, float addrspace(1)* noalias nocapture readonly) local_unnamed_addr #0 !kernel_arg_addr_space !4 !kernel_arg_access_qual !5 !kernel_arg_type !6 !kernel_arg_base_type !6 !kernel_arg_type_qual !7 {
  %5 = tail call spir_func i32 @_Z13get_global_idj(i32 0) #4
  %6 = tail call spir_func i32 @_Z12get_group_idj(i32 0) #4
  %7 = tail call spir_func i32 @_Z12get_group_idj(i32 1) #4
  %8 = tail call spir_func i32 @_Z12get_local_idj(i32 0) #4
  %9 = tail call spir_func i32 @_Z12get_local_idj(i32 1) #4
  %10 = shl nsw i32 %7, 4
  %11 = shl nsw i32 %6, 13
  %12 = shl nsw i32 %8, 9
  %13 = add i32 %9, %12
  %14 = shl nsw i32 %8, 4
  %15 = add nsw i32 %14, %9
  %16 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i32 0, i32 %15
  %17 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i32 0, i32 %15
  %18 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i32 0, i32 %9
  %19 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i32 0, i32 %14
  %20 = add nsw i32 %9, 16
  %21 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i32 0, i32 %20
  %22 = or i32 %14, 1
  %23 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i32 0, i32 %22
  %24 = add nsw i32 %9, 32
  %25 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i32 0, i32 %24
  %26 = or i32 %14, 2
  %27 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i32 0, i32 %26
  %28 = add nsw i32 %9, 48
  %29 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i32 0, i32 %28
  %30 = or i32 %14, 3
  %31 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i32 0, i32 %30
  %32 = add nsw i32 %9, 64
  %33 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i32 0, i32 %32
  %34 = or i32 %14, 4
  %35 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i32 0, i32 %34
  %36 = add nsw i32 %9, 80
  %37 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i32 0, i32 %36
  %38 = or i32 %14, 5
  %39 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i32 0, i32 %38
  %40 = add nsw i32 %9, 96
  %41 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i32 0, i32 %40
  %42 = or i32 %14, 6
  %43 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i32 0, i32 %42
  %44 = add nsw i32 %9, 112
  %45 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i32 0, i32 %44
  %46 = or i32 %14, 7
  %47 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i32 0, i32 %46
  %48 = add nsw i32 %9, 128
  %49 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i32 0, i32 %48
  %50 = or i32 %14, 8
  %51 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i32 0, i32 %50
  %52 = add nsw i32 %9, 144
  %53 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i32 0, i32 %52
  %54 = or i32 %14, 9
  %55 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i32 0, i32 %54
  %56 = add nsw i32 %9, 160
  %57 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i32 0, i32 %56
  %58 = or i32 %14, 10
  %59 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i32 0, i32 %58
  %60 = add nsw i32 %9, 176
  %61 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i32 0, i32 %60
  %62 = or i32 %14, 11
  %63 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i32 0, i32 %62
  %64 = add nsw i32 %9, 192
  %65 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i32 0, i32 %64
  %66 = or i32 %14, 12
  %67 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i32 0, i32 %66
  %68 = add nsw i32 %9, 208
  %69 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i32 0, i32 %68
  %70 = or i32 %14, 13
  %71 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i32 0, i32 %70
  %72 = add nsw i32 %9, 224
  %73 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i32 0, i32 %72
  %74 = or i32 %14, 14
  %75 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i32 0, i32 %74
  %76 = add nsw i32 %9, 240
  %77 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i32 0, i32 %76
  %78 = or i32 %14, 15
  %79 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i32 0, i32 %78
  br label %80

; <label>:80:                                     ; preds = %4, %80
  %81 = phi float [ 0.000000e+00, %4 ], [ %138, %80 ]
  %82 = phi i32 [ %11, %4 ], [ %140, %80 ]
  %83 = phi i32 [ 0, %4 ], [ %141, %80 ]
  %84 = phi i32 [ %10, %4 ], [ %139, %80 ]
  %85 = add i32 %13, %84
  %86 = getelementptr inbounds float, float addrspace(1)* %2, i32 %85
  %87 = load float, float addrspace(1)* %86, align 4, !tbaa !8
  store float %87, float addrspace(3)* %16, align 4, !tbaa !8
  %88 = add i32 %13, %82
  %89 = getelementptr inbounds float, float addrspace(1)* %3, i32 %88
  %90 = load float, float addrspace(1)* %89, align 4, !tbaa !8
  store float %90, float addrspace(3)* %17, align 4, !tbaa !8
  tail call spir_func void @_Z7barrierj(i32 1) #5
  %91 = load float, float addrspace(3)* %18, align 4, !tbaa !8
  %92 = load float, float addrspace(3)* %19, align 4, !tbaa !8
  %93 = tail call float @llvm.fmuladd.f32(float %91, float %92, float %81)
  %94 = load float, float addrspace(3)* %21, align 4, !tbaa !8
  %95 = load float, float addrspace(3)* %23, align 4, !tbaa !8
  %96 = tail call float @llvm.fmuladd.f32(float %94, float %95, float %93)
  %97 = load float, float addrspace(3)* %25, align 4, !tbaa !8
  %98 = load float, float addrspace(3)* %27, align 4, !tbaa !8
  %99 = tail call float @llvm.fmuladd.f32(float %97, float %98, float %96)
  %100 = load float, float addrspace(3)* %29, align 4, !tbaa !8
  %101 = load float, float addrspace(3)* %31, align 4, !tbaa !8
  %102 = tail call float @llvm.fmuladd.f32(float %100, float %101, float %99)
  %103 = load float, float addrspace(3)* %33, align 4, !tbaa !8
  %104 = load float, float addrspace(3)* %35, align 4, !tbaa !8
  %105 = tail call float @llvm.fmuladd.f32(float %103, float %104, float %102)
  %106 = load float, float addrspace(3)* %37, align 4, !tbaa !8
  %107 = load float, float addrspace(3)* %39, align 4, !tbaa !8
  %108 = tail call float @llvm.fmuladd.f32(float %106, float %107, float %105)
  %109 = load float, float addrspace(3)* %41, align 4, !tbaa !8
  %110 = load float, float addrspace(3)* %43, align 4, !tbaa !8
  %111 = tail call float @llvm.fmuladd.f32(float %109, float %110, float %108)
  %112 = load float, float addrspace(3)* %45, align 4, !tbaa !8
  %113 = load float, float addrspace(3)* %47, align 4, !tbaa !8
  %114 = tail call float @llvm.fmuladd.f32(float %112, float %113, float %111)
  %115 = load float, float addrspace(3)* %49, align 4, !tbaa !8
  %116 = load float, float addrspace(3)* %51, align 4, !tbaa !8
  %117 = tail call float @llvm.fmuladd.f32(float %115, float %116, float %114)
  %118 = load float, float addrspace(3)* %53, align 4, !tbaa !8
  %119 = load float, float addrspace(3)* %55, align 4, !tbaa !8
  %120 = tail call float @llvm.fmuladd.f32(float %118, float %119, float %117)
  %121 = load float, float addrspace(3)* %57, align 4, !tbaa !8
  %122 = load float, float addrspace(3)* %59, align 4, !tbaa !8
  %123 = tail call float @llvm.fmuladd.f32(float %121, float %122, float %120)
  %124 = load float, float addrspace(3)* %61, align 4, !tbaa !8
  %125 = load float, float addrspace(3)* %63, align 4, !tbaa !8
  %126 = tail call float @llvm.fmuladd.f32(float %124, float %125, float %123)
  %127 = load float, float addrspace(3)* %65, align 4, !tbaa !8
  %128 = load float, float addrspace(3)* %67, align 4, !tbaa !8
  %129 = tail call float @llvm.fmuladd.f32(float %127, float %128, float %126)
  %130 = load float, float addrspace(3)* %69, align 4, !tbaa !8
  %131 = load float, float addrspace(3)* %71, align 4, !tbaa !8
  %132 = tail call float @llvm.fmuladd.f32(float %130, float %131, float %129)
  %133 = load float, float addrspace(3)* %73, align 4, !tbaa !8
  %134 = load float, float addrspace(3)* %75, align 4, !tbaa !8
  %135 = tail call float @llvm.fmuladd.f32(float %133, float %134, float %132)
  %136 = load float, float addrspace(3)* %77, align 4, !tbaa !8
  %137 = load float, float addrspace(3)* %79, align 4, !tbaa !8
  %138 = tail call float @llvm.fmuladd.f32(float %136, float %137, float %135)
  tail call spir_func void @_Z7barrierj(i32 1) #5
  %139 = add nsw i32 %84, 8192
  %140 = add nuw nsw i32 %82, 16
  %141 = add nuw nsw i32 %83, 1
  %142 = icmp slt i32 %83, 31
  br i1 %142, label %80, label %143

; <label>:143:                                    ; preds = %80
  %144 = tail call spir_func i32 @_Z13get_global_idj(i32 1) #4
  %145 = shl i32 %5, 9
  %146 = add nsw i32 %145, %144
  %147 = getelementptr inbounds float, float addrspace(1)* %1, i32 %146
  store float %138, float addrspace(1)* %147, align 4, !tbaa !8
  ret void
}

; Function Attrs: nounwind readnone
declare spir_func i32 @_Z13get_global_idj(i32) local_unnamed_addr #1

; Function Attrs: nounwind readnone
declare spir_func i32 @_Z12get_group_idj(i32) local_unnamed_addr #1

; Function Attrs: nounwind readnone
declare spir_func i32 @_Z12get_local_idj(i32) local_unnamed_addr #1

; Function Attrs: convergent
declare spir_func void @_Z7barrierj(i32) local_unnamed_addr #2

; Function Attrs: nounwind readnone speculatable
declare float @llvm.fmuladd.f32(float, float, float) #3

attributes #0 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { convergent "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readnone speculatable }
attributes #4 = { nounwind readnone }
attributes #5 = { convergent nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}
!opencl.spir.version = !{!2, !2, !2, !2, !2}
!opencl.ocl.version = !{!3, !3, !3, !3, !3}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 5.0.0 (git@github.com:krocki/clang.git 088eaf5b7b121f70b2fe6b4328b7d8819c9f2aab) (git@github.com:krocki/llvm.git 7bfd7c00d76359356c3572222f33b03931972c9f)"}
!2 = !{i32 1, i32 2}
!3 = !{i32 1, i32 0}
!4 = !{i32 0, i32 1, i32 1, i32 1}
!5 = !{!"none", !"none", !"none", !"none"}
!6 = !{!"int", !"float*", !"float*", !"float*"}
!7 = !{!"", !"restrict", !"restrict const", !"restrict const"}
!8 = !{!9, !9, i64 0}
!9 = !{!"float", !10, i64 0}
!10 = !{!"omnipotent char", !11, i64 0}
!11 = !{!"Simple C/C++ TBAA"}
