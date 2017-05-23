; ModuleID = 'k_gen_cl_gemm_v1_.cl'
source_filename = "k_gen_cl_gemm_v1_.cl"
target datalayout = "e-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "spir64-unknown-unknown"

@k_gen_cl_gemm_v1_.Awrk = internal unnamed_addr addrspace(3) global [256 x float] undef, align 4
@k_gen_cl_gemm_v1_.Bwrk = internal unnamed_addr addrspace(3) global [256 x float] undef, align 4

; Function Attrs: nounwind
define spir_kernel void @k_gen_cl_gemm_v1_(i32, float addrspace(1)* noalias nocapture, float addrspace(1)* noalias nocapture readonly, float addrspace(1)* noalias nocapture readonly) local_unnamed_addr #0 !kernel_arg_addr_space !4 !kernel_arg_access_qual !5 !kernel_arg_type !6 !kernel_arg_base_type !6 !kernel_arg_type_qual !7 {
  %5 = tail call spir_func i64 @_Z13get_global_idj(i32 0) #4
  %6 = tail call spir_func i64 @_Z13get_global_idj(i32 1) #4
  %7 = tail call spir_func i64 @_Z12get_group_idj(i32 0) #4
  %8 = trunc i64 %7 to i32
  %9 = tail call spir_func i64 @_Z12get_group_idj(i32 1) #4
  %10 = trunc i64 %9 to i32
  %11 = tail call spir_func i64 @_Z12get_local_idj(i32 0) #4
  %12 = trunc i64 %11 to i32
  %13 = tail call spir_func i64 @_Z12get_local_idj(i32 1) #4
  %14 = trunc i64 %13 to i32
  %15 = shl nsw i32 %10, 4
  %16 = shl nsw i32 %8, 13
  %17 = shl nsw i32 %12, 9
  %18 = add i32 %17, %14
  %19 = shl nsw i32 %12, 4
  %20 = add nsw i32 %19, %14
  %21 = sext i32 %20 to i64
  %22 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i64 0, i64 %21
  %23 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i64 0, i64 %21
  %24 = sext i32 %14 to i64
  %25 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i64 0, i64 %24
  %26 = sext i32 %19 to i64
  %27 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i64 0, i64 %26
  %28 = add nsw i32 %14, 16
  %29 = sext i32 %28 to i64
  %30 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i64 0, i64 %29
  %31 = or i32 %19, 1
  %32 = sext i32 %31 to i64
  %33 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i64 0, i64 %32
  %34 = add nsw i32 %14, 32
  %35 = sext i32 %34 to i64
  %36 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i64 0, i64 %35
  %37 = or i32 %19, 2
  %38 = sext i32 %37 to i64
  %39 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i64 0, i64 %38
  %40 = add nsw i32 %14, 48
  %41 = sext i32 %40 to i64
  %42 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i64 0, i64 %41
  %43 = or i32 %19, 3
  %44 = sext i32 %43 to i64
  %45 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i64 0, i64 %44
  %46 = add nsw i32 %14, 64
  %47 = sext i32 %46 to i64
  %48 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i64 0, i64 %47
  %49 = or i32 %19, 4
  %50 = sext i32 %49 to i64
  %51 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i64 0, i64 %50
  %52 = add nsw i32 %14, 80
  %53 = sext i32 %52 to i64
  %54 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i64 0, i64 %53
  %55 = or i32 %19, 5
  %56 = sext i32 %55 to i64
  %57 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i64 0, i64 %56
  %58 = add nsw i32 %14, 96
  %59 = sext i32 %58 to i64
  %60 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i64 0, i64 %59
  %61 = or i32 %19, 6
  %62 = sext i32 %61 to i64
  %63 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i64 0, i64 %62
  %64 = add nsw i32 %14, 112
  %65 = sext i32 %64 to i64
  %66 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i64 0, i64 %65
  %67 = or i32 %19, 7
  %68 = sext i32 %67 to i64
  %69 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i64 0, i64 %68
  %70 = add nsw i32 %14, 128
  %71 = sext i32 %70 to i64
  %72 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i64 0, i64 %71
  %73 = or i32 %19, 8
  %74 = sext i32 %73 to i64
  %75 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i64 0, i64 %74
  %76 = add nsw i32 %14, 144
  %77 = sext i32 %76 to i64
  %78 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i64 0, i64 %77
  %79 = or i32 %19, 9
  %80 = sext i32 %79 to i64
  %81 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i64 0, i64 %80
  %82 = add nsw i32 %14, 160
  %83 = sext i32 %82 to i64
  %84 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i64 0, i64 %83
  %85 = or i32 %19, 10
  %86 = sext i32 %85 to i64
  %87 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i64 0, i64 %86
  %88 = add nsw i32 %14, 176
  %89 = sext i32 %88 to i64
  %90 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i64 0, i64 %89
  %91 = or i32 %19, 11
  %92 = sext i32 %91 to i64
  %93 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i64 0, i64 %92
  %94 = add nsw i32 %14, 192
  %95 = sext i32 %94 to i64
  %96 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i64 0, i64 %95
  %97 = or i32 %19, 12
  %98 = sext i32 %97 to i64
  %99 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i64 0, i64 %98
  %100 = add nsw i32 %14, 208
  %101 = sext i32 %100 to i64
  %102 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i64 0, i64 %101
  %103 = or i32 %19, 13
  %104 = sext i32 %103 to i64
  %105 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i64 0, i64 %104
  %106 = add nsw i32 %14, 224
  %107 = sext i32 %106 to i64
  %108 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i64 0, i64 %107
  %109 = or i32 %19, 14
  %110 = sext i32 %109 to i64
  %111 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i64 0, i64 %110
  %112 = add nsw i32 %14, 240
  %113 = sext i32 %112 to i64
  %114 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i64 0, i64 %113
  %115 = or i32 %19, 15
  %116 = sext i32 %115 to i64
  %117 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i64 0, i64 %116
  br label %118

; <label>:118:                                    ; preds = %4, %118
  %119 = phi float [ 0.000000e+00, %4 ], [ %178, %118 ]
  %120 = phi i32 [ %16, %4 ], [ %180, %118 ]
  %121 = phi i32 [ 0, %4 ], [ %181, %118 ]
  %122 = phi i32 [ %15, %4 ], [ %179, %118 ]
  %123 = add i32 %18, %122
  %124 = sext i32 %123 to i64
  %125 = getelementptr inbounds float, float addrspace(1)* %2, i64 %124
  %126 = load float, float addrspace(1)* %125, align 4, !tbaa !8
  store float %126, float addrspace(3)* %22, align 4, !tbaa !8
  %127 = add i32 %18, %120
  %128 = sext i32 %127 to i64
  %129 = getelementptr inbounds float, float addrspace(1)* %3, i64 %128
  %130 = load float, float addrspace(1)* %129, align 4, !tbaa !8
  store float %130, float addrspace(3)* %23, align 4, !tbaa !8
  tail call spir_func void @_Z7barrierj(i32 1) #5
  %131 = load float, float addrspace(3)* %25, align 4, !tbaa !8
  %132 = load float, float addrspace(3)* %27, align 4, !tbaa !8
  %133 = tail call float @llvm.fmuladd.f32(float %131, float %132, float %119)
  %134 = load float, float addrspace(3)* %30, align 4, !tbaa !8
  %135 = load float, float addrspace(3)* %33, align 4, !tbaa !8
  %136 = tail call float @llvm.fmuladd.f32(float %134, float %135, float %133)
  %137 = load float, float addrspace(3)* %36, align 4, !tbaa !8
  %138 = load float, float addrspace(3)* %39, align 4, !tbaa !8
  %139 = tail call float @llvm.fmuladd.f32(float %137, float %138, float %136)
  %140 = load float, float addrspace(3)* %42, align 4, !tbaa !8
  %141 = load float, float addrspace(3)* %45, align 4, !tbaa !8
  %142 = tail call float @llvm.fmuladd.f32(float %140, float %141, float %139)
  %143 = load float, float addrspace(3)* %48, align 4, !tbaa !8
  %144 = load float, float addrspace(3)* %51, align 4, !tbaa !8
  %145 = tail call float @llvm.fmuladd.f32(float %143, float %144, float %142)
  %146 = load float, float addrspace(3)* %54, align 4, !tbaa !8
  %147 = load float, float addrspace(3)* %57, align 4, !tbaa !8
  %148 = tail call float @llvm.fmuladd.f32(float %146, float %147, float %145)
  %149 = load float, float addrspace(3)* %60, align 4, !tbaa !8
  %150 = load float, float addrspace(3)* %63, align 4, !tbaa !8
  %151 = tail call float @llvm.fmuladd.f32(float %149, float %150, float %148)
  %152 = load float, float addrspace(3)* %66, align 4, !tbaa !8
  %153 = load float, float addrspace(3)* %69, align 4, !tbaa !8
  %154 = tail call float @llvm.fmuladd.f32(float %152, float %153, float %151)
  %155 = load float, float addrspace(3)* %72, align 4, !tbaa !8
  %156 = load float, float addrspace(3)* %75, align 4, !tbaa !8
  %157 = tail call float @llvm.fmuladd.f32(float %155, float %156, float %154)
  %158 = load float, float addrspace(3)* %78, align 4, !tbaa !8
  %159 = load float, float addrspace(3)* %81, align 4, !tbaa !8
  %160 = tail call float @llvm.fmuladd.f32(float %158, float %159, float %157)
  %161 = load float, float addrspace(3)* %84, align 4, !tbaa !8
  %162 = load float, float addrspace(3)* %87, align 4, !tbaa !8
  %163 = tail call float @llvm.fmuladd.f32(float %161, float %162, float %160)
  %164 = load float, float addrspace(3)* %90, align 4, !tbaa !8
  %165 = load float, float addrspace(3)* %93, align 4, !tbaa !8
  %166 = tail call float @llvm.fmuladd.f32(float %164, float %165, float %163)
  %167 = load float, float addrspace(3)* %96, align 4, !tbaa !8
  %168 = load float, float addrspace(3)* %99, align 4, !tbaa !8
  %169 = tail call float @llvm.fmuladd.f32(float %167, float %168, float %166)
  %170 = load float, float addrspace(3)* %102, align 4, !tbaa !8
  %171 = load float, float addrspace(3)* %105, align 4, !tbaa !8
  %172 = tail call float @llvm.fmuladd.f32(float %170, float %171, float %169)
  %173 = load float, float addrspace(3)* %108, align 4, !tbaa !8
  %174 = load float, float addrspace(3)* %111, align 4, !tbaa !8
  %175 = tail call float @llvm.fmuladd.f32(float %173, float %174, float %172)
  %176 = load float, float addrspace(3)* %114, align 4, !tbaa !8
  %177 = load float, float addrspace(3)* %117, align 4, !tbaa !8
  %178 = tail call float @llvm.fmuladd.f32(float %176, float %177, float %175)
  tail call spir_func void @_Z7barrierj(i32 1) #5
  %179 = add nsw i32 %122, 8192
  %180 = add nuw nsw i32 %120, 16
  %181 = add nuw nsw i32 %121, 1
  %182 = icmp slt i32 %121, 31
  br i1 %182, label %118, label %183

; <label>:183:                                    ; preds = %118
  %184 = trunc i64 %5 to i32
  %185 = trunc i64 %6 to i32
  %186 = shl i32 %184, 9
  %187 = add nsw i32 %186, %185
  %188 = sext i32 %187 to i64
  %189 = getelementptr inbounds float, float addrspace(1)* %1, i64 %188
  store float %178, float addrspace(1)* %189, align 4, !tbaa !8
  ret void
}

; Function Attrs: nounwind readnone
declare spir_func i64 @_Z13get_global_idj(i32) local_unnamed_addr #1

; Function Attrs: nounwind readnone
declare spir_func i64 @_Z12get_group_idj(i32) local_unnamed_addr #1

; Function Attrs: nounwind readnone
declare spir_func i64 @_Z12get_local_idj(i32) local_unnamed_addr #1

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
