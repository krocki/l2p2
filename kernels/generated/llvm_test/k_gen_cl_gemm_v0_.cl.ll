; ModuleID = 'k_gen_cl_gemm_v0_.cl'
source_filename = "k_gen_cl_gemm_v0_.cl"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define void @k_gen_cl_gemm_v0_(i32, float* nocapture, float* nocapture readonly, float* nocapture readonly) local_unnamed_addr #0 !kernel_arg_addr_space !2 !kernel_arg_access_qual !3 !kernel_arg_type !4 !kernel_arg_base_type !4 !kernel_arg_type_qual !5 {
  %5 = tail call i64 @_Z13get_global_idj(i32 0) #3
  %6 = tail call i64 @_Z13get_global_idj(i32 1) #3
  %7 = tail call i64 @_Z15get_global_sizej(i32 0) #3
  %8 = trunc i64 %7 to i32
  %9 = icmp sgt i32 %8, 0
  br i1 %9, label %10, label %37

; <label>:10:                                     ; preds = %4
  %11 = mul i64 %7, %5
  %12 = shl i64 %11, 32
  %13 = ashr exact i64 %12, 32
  %14 = shl i64 %7, 32
  %15 = ashr exact i64 %14, 32
  %16 = shl i64 %6, 32
  %17 = ashr exact i64 %16, 32
  %18 = and i64 %7, 4294967295
  %19 = and i64 %7, 1
  %20 = icmp eq i64 %18, 1
  br i1 %20, label %23, label %21

; <label>:21:                                     ; preds = %10
  %22 = sub nsw i64 %18, %19
  br label %44

; <label>:23:                                     ; preds = %44, %10
  %24 = phi float [ undef, %10 ], [ %64, %44 ]
  %25 = phi i64 [ 0, %10 ], [ %65, %44 ]
  %26 = phi float [ 0.000000e+00, %10 ], [ %64, %44 ]
  %27 = icmp eq i64 %19, 0
  br i1 %27, label %37, label %28

; <label>:28:                                     ; preds = %23
  %29 = mul nsw i64 %25, %15
  %30 = add nsw i64 %29, %17
  %31 = getelementptr inbounds float, float* %2, i64 %30
  %32 = load float, float* %31, align 4, !tbaa !6
  %33 = add nsw i64 %25, %13
  %34 = getelementptr inbounds float, float* %3, i64 %33
  %35 = load float, float* %34, align 4, !tbaa !6
  %36 = tail call float @llvm.fmuladd.f32(float %32, float %35, float %26)
  br label %37

; <label>:37:                                     ; preds = %28, %23, %4
  %38 = phi float [ 0.000000e+00, %4 ], [ %24, %23 ], [ %36, %28 ]
  %39 = mul i64 %7, %5
  %40 = add i64 %39, %6
  %41 = shl i64 %40, 32
  %42 = ashr exact i64 %41, 32
  %43 = getelementptr inbounds float, float* %1, i64 %42
  store float %38, float* %43, align 4, !tbaa !6
  ret void

; <label>:44:                                     ; preds = %44, %21
  %45 = phi i64 [ 0, %21 ], [ %65, %44 ]
  %46 = phi float [ 0.000000e+00, %21 ], [ %64, %44 ]
  %47 = phi i64 [ %22, %21 ], [ %66, %44 ]
  %48 = mul nsw i64 %45, %15
  %49 = add nsw i64 %48, %17
  %50 = getelementptr inbounds float, float* %2, i64 %49
  %51 = load float, float* %50, align 4, !tbaa !6
  %52 = add nsw i64 %45, %13
  %53 = getelementptr inbounds float, float* %3, i64 %52
  %54 = load float, float* %53, align 4, !tbaa !6
  %55 = tail call float @llvm.fmuladd.f32(float %51, float %54, float %46)
  %56 = or i64 %45, 1
  %57 = mul nsw i64 %56, %15
  %58 = add nsw i64 %57, %17
  %59 = getelementptr inbounds float, float* %2, i64 %58
  %60 = load float, float* %59, align 4, !tbaa !6
  %61 = add nsw i64 %56, %13
  %62 = getelementptr inbounds float, float* %3, i64 %61
  %63 = load float, float* %62, align 4, !tbaa !6
  %64 = tail call float @llvm.fmuladd.f32(float %60, float %63, float %55)
  %65 = add nsw i64 %45, 2
  %66 = add i64 %47, -2
  %67 = icmp eq i64 %66, 0
  br i1 %67, label %23, label %44
}

; Function Attrs: nounwind readnone
declare i64 @_Z13get_global_idj(i32) local_unnamed_addr #1

; Function Attrs: nounwind readnone
declare i64 @_Z15get_global_sizej(i32) local_unnamed_addr #1

; Function Attrs: nounwind readnone speculatable
declare float @llvm.fmuladd.f32(float, float, float) #2

attributes #0 = { nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone speculatable }
attributes #3 = { nounwind readnone }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 5.0.0 (git@github.com:krocki/clang.git 088eaf5b7b121f70b2fe6b4328b7d8819c9f2aab) (git@github.com:krocki/llvm.git 7bfd7c00d76359356c3572222f33b03931972c9f)"}
!2 = !{i32 0, i32 1, i32 1, i32 1}
!3 = !{!"none", !"none", !"none", !"none"}
!4 = !{!"int", !"float*", !"float*", !"float*"}
!5 = !{!"", !"", !"", !""}
!6 = !{!7, !7, i64 0}
!7 = !{!"float", !8, i64 0}
!8 = !{!"omnipotent char", !9, i64 0}
!9 = !{!"Simple C/C++ TBAA"}
