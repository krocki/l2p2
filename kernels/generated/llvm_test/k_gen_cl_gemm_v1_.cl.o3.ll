; ModuleID = 'k_gen_cl_gemm_v1_.cl'
source_filename = "k_gen_cl_gemm_v1_.cl"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@k_gen_cl_gemm_v1_.Awrk = internal unnamed_addr global [256 x float] undef, align 16
@k_gen_cl_gemm_v1_.Bwrk = internal unnamed_addr global [256 x float] undef, align 16

; Function Attrs: nounwind uwtable
define void @k_gen_cl_gemm_v1_(i32, float* noalias nocapture, float* noalias nocapture readonly, float* noalias nocapture readonly) local_unnamed_addr #0 !kernel_arg_addr_space !2 !kernel_arg_access_qual !3 !kernel_arg_type !4 !kernel_arg_base_type !4 !kernel_arg_type_qual !5 {
  %5 = tail call i64 @_Z13get_global_idj(i32 0) #4
  %6 = tail call i64 @_Z13get_global_idj(i32 1) #4
  %7 = tail call i64 @_Z12get_group_idj(i32 0) #4
  %8 = trunc i64 %7 to i32
  %9 = tail call i64 @_Z12get_group_idj(i32 1) #4
  %10 = trunc i64 %9 to i32
  %11 = tail call i64 @_Z12get_local_idj(i32 0) #4
  %12 = trunc i64 %11 to i32
  %13 = tail call i64 @_Z12get_local_idj(i32 1) #4
  %14 = trunc i64 %13 to i32
  %15 = shl nsw i32 %10, 4
  %16 = shl nsw i32 %8, 13
  %17 = shl nsw i32 %12, 9
  %18 = add i32 %17, %14
  %19 = shl nsw i32 %12, 4
  %20 = add nsw i32 %19, %14
  %21 = sext i32 %20 to i64
  %22 = getelementptr inbounds [256 x float], [256 x float]* @k_gen_cl_gemm_v1_.Awrk, i64 0, i64 %21
  %23 = bitcast float* %22 to i32*
  %24 = getelementptr inbounds [256 x float], [256 x float]* @k_gen_cl_gemm_v1_.Bwrk, i64 0, i64 %21
  %25 = bitcast float* %24 to i32*
  %26 = sext i32 %19 to i64
  %27 = shl i64 %13, 32
  %28 = ashr exact i64 %27, 32
  %29 = getelementptr inbounds [256 x float], [256 x float]* @k_gen_cl_gemm_v1_.Awrk, i64 0, i64 %28
  %30 = sext i32 %16 to i64
  %31 = sext i32 %15 to i64
  %32 = getelementptr inbounds [256 x float], [256 x float]* @k_gen_cl_gemm_v1_.Bwrk, i64 0, i64 %26
  %33 = add nsw i64 %28, 16
  %34 = getelementptr inbounds [256 x float], [256 x float]* @k_gen_cl_gemm_v1_.Awrk, i64 0, i64 %33
  %35 = or i64 %26, 1
  %36 = getelementptr inbounds [256 x float], [256 x float]* @k_gen_cl_gemm_v1_.Bwrk, i64 0, i64 %35
  %37 = add nsw i64 %28, 32
  %38 = getelementptr inbounds [256 x float], [256 x float]* @k_gen_cl_gemm_v1_.Awrk, i64 0, i64 %37
  %39 = or i64 %26, 2
  %40 = getelementptr inbounds [256 x float], [256 x float]* @k_gen_cl_gemm_v1_.Bwrk, i64 0, i64 %39
  %41 = add nsw i64 %28, 48
  %42 = getelementptr inbounds [256 x float], [256 x float]* @k_gen_cl_gemm_v1_.Awrk, i64 0, i64 %41
  %43 = or i64 %26, 3
  %44 = getelementptr inbounds [256 x float], [256 x float]* @k_gen_cl_gemm_v1_.Bwrk, i64 0, i64 %43
  %45 = add nsw i64 %28, 64
  %46 = getelementptr inbounds [256 x float], [256 x float]* @k_gen_cl_gemm_v1_.Awrk, i64 0, i64 %45
  %47 = or i64 %26, 4
  %48 = getelementptr inbounds [256 x float], [256 x float]* @k_gen_cl_gemm_v1_.Bwrk, i64 0, i64 %47
  %49 = add nsw i64 %28, 80
  %50 = getelementptr inbounds [256 x float], [256 x float]* @k_gen_cl_gemm_v1_.Awrk, i64 0, i64 %49
  %51 = or i64 %26, 5
  %52 = getelementptr inbounds [256 x float], [256 x float]* @k_gen_cl_gemm_v1_.Bwrk, i64 0, i64 %51
  %53 = add nsw i64 %28, 96
  %54 = getelementptr inbounds [256 x float], [256 x float]* @k_gen_cl_gemm_v1_.Awrk, i64 0, i64 %53
  %55 = or i64 %26, 6
  %56 = getelementptr inbounds [256 x float], [256 x float]* @k_gen_cl_gemm_v1_.Bwrk, i64 0, i64 %55
  %57 = add nsw i64 %28, 112
  %58 = getelementptr inbounds [256 x float], [256 x float]* @k_gen_cl_gemm_v1_.Awrk, i64 0, i64 %57
  %59 = or i64 %26, 7
  %60 = getelementptr inbounds [256 x float], [256 x float]* @k_gen_cl_gemm_v1_.Bwrk, i64 0, i64 %59
  %61 = add nsw i64 %28, 128
  %62 = getelementptr inbounds [256 x float], [256 x float]* @k_gen_cl_gemm_v1_.Awrk, i64 0, i64 %61
  %63 = or i64 %26, 8
  %64 = getelementptr inbounds [256 x float], [256 x float]* @k_gen_cl_gemm_v1_.Bwrk, i64 0, i64 %63
  %65 = add nsw i64 %28, 144
  %66 = getelementptr inbounds [256 x float], [256 x float]* @k_gen_cl_gemm_v1_.Awrk, i64 0, i64 %65
  %67 = or i64 %26, 9
  %68 = getelementptr inbounds [256 x float], [256 x float]* @k_gen_cl_gemm_v1_.Bwrk, i64 0, i64 %67
  %69 = add nsw i64 %28, 160
  %70 = getelementptr inbounds [256 x float], [256 x float]* @k_gen_cl_gemm_v1_.Awrk, i64 0, i64 %69
  %71 = or i64 %26, 10
  %72 = getelementptr inbounds [256 x float], [256 x float]* @k_gen_cl_gemm_v1_.Bwrk, i64 0, i64 %71
  %73 = add nsw i64 %28, 176
  %74 = getelementptr inbounds [256 x float], [256 x float]* @k_gen_cl_gemm_v1_.Awrk, i64 0, i64 %73
  %75 = or i64 %26, 11
  %76 = getelementptr inbounds [256 x float], [256 x float]* @k_gen_cl_gemm_v1_.Bwrk, i64 0, i64 %75
  %77 = add nsw i64 %28, 192
  %78 = getelementptr inbounds [256 x float], [256 x float]* @k_gen_cl_gemm_v1_.Awrk, i64 0, i64 %77
  %79 = or i64 %26, 12
  %80 = getelementptr inbounds [256 x float], [256 x float]* @k_gen_cl_gemm_v1_.Bwrk, i64 0, i64 %79
  %81 = add nsw i64 %28, 208
  %82 = getelementptr inbounds [256 x float], [256 x float]* @k_gen_cl_gemm_v1_.Awrk, i64 0, i64 %81
  %83 = or i64 %26, 13
  %84 = getelementptr inbounds [256 x float], [256 x float]* @k_gen_cl_gemm_v1_.Bwrk, i64 0, i64 %83
  %85 = add nsw i64 %28, 224
  %86 = getelementptr inbounds [256 x float], [256 x float]* @k_gen_cl_gemm_v1_.Awrk, i64 0, i64 %85
  %87 = or i64 %26, 14
  %88 = getelementptr inbounds [256 x float], [256 x float]* @k_gen_cl_gemm_v1_.Bwrk, i64 0, i64 %87
  %89 = add nsw i64 %28, 240
  %90 = getelementptr inbounds [256 x float], [256 x float]* @k_gen_cl_gemm_v1_.Awrk, i64 0, i64 %89
  %91 = or i64 %26, 15
  %92 = getelementptr inbounds [256 x float], [256 x float]* @k_gen_cl_gemm_v1_.Bwrk, i64 0, i64 %91
  br label %93

; <label>:93:                                     ; preds = %93, %4
  %94 = phi i64 [ %31, %4 ], [ %158, %93 ]
  %95 = phi i64 [ %30, %4 ], [ %159, %93 ]
  %96 = phi float [ 0.000000e+00, %4 ], [ %157, %93 ]
  %97 = phi i32 [ 0, %4 ], [ %160, %93 ]
  %98 = trunc i64 %94 to i32
  %99 = add i32 %18, %98
  %100 = sext i32 %99 to i64
  %101 = getelementptr inbounds float, float* %2, i64 %100
  %102 = bitcast float* %101 to i32*
  %103 = load i32, i32* %102, align 4, !tbaa !6
  store i32 %103, i32* %23, align 4, !tbaa !6
  %104 = trunc i64 %95 to i32
  %105 = add i32 %18, %104
  %106 = sext i32 %105 to i64
  %107 = getelementptr inbounds float, float* %3, i64 %106
  %108 = bitcast float* %107 to i32*
  %109 = load i32, i32* %108, align 4, !tbaa !6
  store i32 %109, i32* %25, align 4, !tbaa !6
  tail call void @_Z7barrierj(i32 1) #5
  %110 = load float, float* %29, align 4, !tbaa !6
  %111 = load float, float* %32, align 16, !tbaa !6
  %112 = tail call float @llvm.fmuladd.f32(float %110, float %111, float %96)
  %113 = load float, float* %34, align 4, !tbaa !6
  %114 = load float, float* %36, align 4, !tbaa !6
  %115 = tail call float @llvm.fmuladd.f32(float %113, float %114, float %112)
  %116 = load float, float* %38, align 4, !tbaa !6
  %117 = load float, float* %40, align 8, !tbaa !6
  %118 = tail call float @llvm.fmuladd.f32(float %116, float %117, float %115)
  %119 = load float, float* %42, align 4, !tbaa !6
  %120 = load float, float* %44, align 4, !tbaa !6
  %121 = tail call float @llvm.fmuladd.f32(float %119, float %120, float %118)
  %122 = load float, float* %46, align 4, !tbaa !6
  %123 = load float, float* %48, align 16, !tbaa !6
  %124 = tail call float @llvm.fmuladd.f32(float %122, float %123, float %121)
  %125 = load float, float* %50, align 4, !tbaa !6
  %126 = load float, float* %52, align 4, !tbaa !6
  %127 = tail call float @llvm.fmuladd.f32(float %125, float %126, float %124)
  %128 = load float, float* %54, align 4, !tbaa !6
  %129 = load float, float* %56, align 8, !tbaa !6
  %130 = tail call float @llvm.fmuladd.f32(float %128, float %129, float %127)
  %131 = load float, float* %58, align 4, !tbaa !6
  %132 = load float, float* %60, align 4, !tbaa !6
  %133 = tail call float @llvm.fmuladd.f32(float %131, float %132, float %130)
  %134 = load float, float* %62, align 4, !tbaa !6
  %135 = load float, float* %64, align 16, !tbaa !6
  %136 = tail call float @llvm.fmuladd.f32(float %134, float %135, float %133)
  %137 = load float, float* %66, align 4, !tbaa !6
  %138 = load float, float* %68, align 4, !tbaa !6
  %139 = tail call float @llvm.fmuladd.f32(float %137, float %138, float %136)
  %140 = load float, float* %70, align 4, !tbaa !6
  %141 = load float, float* %72, align 8, !tbaa !6
  %142 = tail call float @llvm.fmuladd.f32(float %140, float %141, float %139)
  %143 = load float, float* %74, align 4, !tbaa !6
  %144 = load float, float* %76, align 4, !tbaa !6
  %145 = tail call float @llvm.fmuladd.f32(float %143, float %144, float %142)
  %146 = load float, float* %78, align 4, !tbaa !6
  %147 = load float, float* %80, align 16, !tbaa !6
  %148 = tail call float @llvm.fmuladd.f32(float %146, float %147, float %145)
  %149 = load float, float* %82, align 4, !tbaa !6
  %150 = load float, float* %84, align 4, !tbaa !6
  %151 = tail call float @llvm.fmuladd.f32(float %149, float %150, float %148)
  %152 = load float, float* %86, align 4, !tbaa !6
  %153 = load float, float* %88, align 8, !tbaa !6
  %154 = tail call float @llvm.fmuladd.f32(float %152, float %153, float %151)
  %155 = load float, float* %90, align 4, !tbaa !6
  %156 = load float, float* %92, align 4, !tbaa !6
  %157 = tail call float @llvm.fmuladd.f32(float %155, float %156, float %154)
  tail call void @_Z7barrierj(i32 1) #5
  %158 = add nsw i64 %94, 8192
  %159 = add nsw i64 %95, 16
  %160 = add nuw nsw i32 %97, 1
  %161 = icmp eq i32 %160, 32
  br i1 %161, label %162, label %93

; <label>:162:                                    ; preds = %93
  %163 = trunc i64 %5 to i32
  %164 = trunc i64 %6 to i32
  %165 = shl i32 %163, 9
  %166 = add nsw i32 %165, %164
  %167 = sext i32 %166 to i64
  %168 = getelementptr inbounds float, float* %1, i64 %167
  store float %157, float* %168, align 4, !tbaa !6
  ret void
}

; Function Attrs: nounwind readnone
declare i64 @_Z13get_global_idj(i32) local_unnamed_addr #1

; Function Attrs: nounwind readnone
declare i64 @_Z12get_group_idj(i32) local_unnamed_addr #1

; Function Attrs: nounwind readnone
declare i64 @_Z12get_local_idj(i32) local_unnamed_addr #1

; Function Attrs: convergent
declare void @_Z7barrierj(i32) local_unnamed_addr #2

; Function Attrs: nounwind readnone speculatable
declare float @llvm.fmuladd.f32(float, float, float) #3

attributes #0 = { nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { convergent "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readnone speculatable }
attributes #4 = { nounwind readnone }
attributes #5 = { convergent nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 5.0.0 (git@github.com:krocki/clang.git 088eaf5b7b121f70b2fe6b4328b7d8819c9f2aab) (git@github.com:krocki/llvm.git 7bfd7c00d76359356c3572222f33b03931972c9f)"}
!2 = !{i32 0, i32 1, i32 1, i32 1}
!3 = !{!"none", !"none", !"none", !"none"}
!4 = !{!"int", !"float*", !"float*", !"float*"}
!5 = !{!"", !"restrict", !"restrict const", !"restrict const"}
!6 = !{!7, !7, i64 0}
!7 = !{!"float", !8, i64 0}
!8 = !{!"omnipotent char", !9, i64 0}
!9 = !{!"Simple C/C++ TBAA"}
