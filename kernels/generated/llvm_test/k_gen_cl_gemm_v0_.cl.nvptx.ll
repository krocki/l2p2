; ModuleID = 'k_gen_cl_gemm_v0_.cl'
source_filename = "k_gen_cl_gemm_v0_.cl"
target datalayout = "e-i64:64-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-unknown-unknown"

; Function Attrs: noinline nounwind
define void @k_gen_cl_gemm_v0_(i32, float addrspace(1)* nocapture, float addrspace(1)* nocapture readonly, float addrspace(1)* nocapture readonly) local_unnamed_addr #0 !kernel_arg_addr_space !3 !kernel_arg_access_qual !4 !kernel_arg_type !5 !kernel_arg_base_type !5 !kernel_arg_type_qual !6 {
  %5 = tail call i64 @_Z13get_global_idj(i32 0) #3
  %6 = tail call i64 @_Z13get_global_idj(i32 1) #3
  %7 = trunc i64 %6 to i32
  %8 = tail call i64 @_Z15get_global_sizej(i32 0) #3
  %9 = trunc i64 %8 to i32
  %10 = icmp sgt i32 %9, 0
  br i1 %10, label %11, label %34

; <label>:11:                                     ; preds = %4
  %12 = trunc i64 %5 to i32
  %13 = mul nsw i32 %9, %12
  %14 = and i32 %9, 1
  %15 = icmp eq i32 %9, 1
  br i1 %15, label %18, label %16

; <label>:16:                                     ; preds = %11
  %17 = sub i32 %9, %14
  br label %41

; <label>:18:                                     ; preds = %41, %11
  %19 = phi float [ undef, %11 ], [ %65, %41 ]
  %20 = phi i32 [ 0, %11 ], [ %66, %41 ]
  %21 = phi float [ 0.000000e+00, %11 ], [ %65, %41 ]
  %22 = icmp eq i32 %14, 0
  br i1 %22, label %34, label %23

; <label>:23:                                     ; preds = %18
  %24 = mul nsw i32 %20, %9
  %25 = add nsw i32 %24, %7
  %26 = sext i32 %25 to i64
  %27 = getelementptr inbounds float, float addrspace(1)* %2, i64 %26
  %28 = load float, float addrspace(1)* %27, align 4, !tbaa !7
  %29 = add nsw i32 %20, %13
  %30 = sext i32 %29 to i64
  %31 = getelementptr inbounds float, float addrspace(1)* %3, i64 %30
  %32 = load float, float addrspace(1)* %31, align 4, !tbaa !7
  %33 = tail call float @llvm.fmuladd.f32(float %28, float %32, float %21)
  br label %34

; <label>:34:                                     ; preds = %23, %18, %4
  %35 = phi float [ 0.000000e+00, %4 ], [ %19, %18 ], [ %33, %23 ]
  %36 = mul i64 %8, %5
  %37 = add i64 %36, %6
  %38 = shl i64 %37, 32
  %39 = ashr exact i64 %38, 32
  %40 = getelementptr inbounds float, float addrspace(1)* %1, i64 %39
  store float %35, float addrspace(1)* %40, align 4, !tbaa !7
  ret void

; <label>:41:                                     ; preds = %41, %16
  %42 = phi i32 [ 0, %16 ], [ %66, %41 ]
  %43 = phi float [ 0.000000e+00, %16 ], [ %65, %41 ]
  %44 = phi i32 [ %17, %16 ], [ %67, %41 ]
  %45 = mul nsw i32 %42, %9
  %46 = add nsw i32 %45, %7
  %47 = sext i32 %46 to i64
  %48 = getelementptr inbounds float, float addrspace(1)* %2, i64 %47
  %49 = load float, float addrspace(1)* %48, align 4, !tbaa !7
  %50 = add nsw i32 %42, %13
  %51 = sext i32 %50 to i64
  %52 = getelementptr inbounds float, float addrspace(1)* %3, i64 %51
  %53 = load float, float addrspace(1)* %52, align 4, !tbaa !7
  %54 = tail call float @llvm.fmuladd.f32(float %49, float %53, float %43)
  %55 = or i32 %42, 1
  %56 = mul nsw i32 %55, %9
  %57 = add nsw i32 %56, %7
  %58 = sext i32 %57 to i64
  %59 = getelementptr inbounds float, float addrspace(1)* %2, i64 %58
  %60 = load float, float addrspace(1)* %59, align 4, !tbaa !7
  %61 = add nsw i32 %55, %13
  %62 = sext i32 %61 to i64
  %63 = getelementptr inbounds float, float addrspace(1)* %3, i64 %62
  %64 = load float, float addrspace(1)* %63, align 4, !tbaa !7
  %65 = tail call float @llvm.fmuladd.f32(float %60, float %64, float %54)
  %66 = add nsw i32 %42, 2
  %67 = add i32 %44, -2
  %68 = icmp eq i32 %67, 0
  br i1 %68, label %18, label %41
}

; Function Attrs: nounwind readnone
declare i64 @_Z13get_global_idj(i32) local_unnamed_addr #1

; Function Attrs: nounwind readnone
declare i64 @_Z15get_global_sizej(i32) local_unnamed_addr #1

; Function Attrs: nounwind readnone speculatable
declare float @llvm.fmuladd.f32(float, float, float) #2

attributes #0 = { noinline nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-features"="-satom" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-features"="-satom" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone speculatable }
attributes #3 = { nounwind readnone }

!nvvm.annotations = !{!0}
!llvm.module.flags = !{!1}
!llvm.ident = !{!2}

!0 = !{void (i32, float addrspace(1)*, float addrspace(1)*, float addrspace(1)*)* @k_gen_cl_gemm_v0_, !"kernel", i32 1}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{!"clang version 5.0.0 (git@github.com:krocki/clang.git 088eaf5b7b121f70b2fe6b4328b7d8819c9f2aab) (git@github.com:krocki/llvm.git 7bfd7c00d76359356c3572222f33b03931972c9f)"}
!3 = !{i32 0, i32 1, i32 1, i32 1}
!4 = !{!"none", !"none", !"none", !"none"}
!5 = !{!"int", !"float*", !"float*", !"float*"}
!6 = !{!"", !"", !"", !""}
!7 = !{!8, !8, i64 0}
!8 = !{!"float", !9, i64 0}
!9 = !{!"omnipotent char", !10, i64 0}
!10 = !{!"Simple C/C++ TBAA"}
