; ModuleID = 'k_gen_cl_gemm_v0_.cl'
source_filename = "k_gen_cl_gemm_v0_.cl"
target datalayout = "e-p:32:32-p1:64:64-p2:64:64-p3:32:32-p4:64:64-p5:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64"
target triple = "amdgcn-amd-amdhsa-opencl"

; Function Attrs: nounwind
define amdgpu_kernel void @k_gen_cl_gemm_v0_(i32, float addrspace(1)* nocapture, float addrspace(1)* nocapture readonly, float addrspace(1)* nocapture readonly) local_unnamed_addr #0 !kernel_arg_addr_space !3 !kernel_arg_access_qual !4 !kernel_arg_type !5 !kernel_arg_base_type !5 !kernel_arg_type_qual !6 {
  %5 = tail call i64 @_Z13get_global_idj(i32 0) #3
  %6 = tail call i64 @_Z13get_global_idj(i32 1) #3
  %7 = trunc i64 %6 to i32
  %8 = tail call i64 @_Z15get_global_sizej(i32 0) #3
  %9 = trunc i64 %8 to i32
  %10 = icmp sgt i32 %9, 0
  br i1 %10, label %11, label %14

; <label>:11:                                     ; preds = %4
  %12 = trunc i64 %5 to i32
  %13 = mul nsw i32 %9, %12
  br label %21

; <label>:14:                                     ; preds = %21, %4
  %15 = phi float [ 0.000000e+00, %4 ], [ %33, %21 ]
  %16 = mul i64 %8, %5
  %17 = add i64 %16, %6
  %18 = shl i64 %17, 32
  %19 = ashr exact i64 %18, 32
  %20 = getelementptr inbounds float, float addrspace(1)* %1, i64 %19
  store float %15, float addrspace(1)* %20, align 4, !tbaa !7
  ret void

; <label>:21:                                     ; preds = %21, %11
  %22 = phi i32 [ 0, %11 ], [ %34, %21 ]
  %23 = phi float [ 0.000000e+00, %11 ], [ %33, %21 ]
  %24 = mul nsw i32 %22, %9
  %25 = add nsw i32 %24, %7
  %26 = sext i32 %25 to i64
  %27 = getelementptr inbounds float, float addrspace(1)* %2, i64 %26
  %28 = load float, float addrspace(1)* %27, align 4, !tbaa !7
  %29 = add nsw i32 %22, %13
  %30 = sext i32 %29 to i64
  %31 = getelementptr inbounds float, float addrspace(1)* %3, i64 %30
  %32 = load float, float addrspace(1)* %31, align 4, !tbaa !7
  %33 = tail call float @llvm.fmuladd.f32(float %28, float %32, float %23)
  %34 = add nuw nsw i32 %22, 1
  %35 = icmp eq i32 %34, %9
  br i1 %35, label %14, label %21
}

; Function Attrs: nounwind readnone
declare i64 @_Z13get_global_idj(i32) local_unnamed_addr #1

; Function Attrs: nounwind readnone
declare i64 @_Z15get_global_sizej(i32) local_unnamed_addr #1

; Function Attrs: nounwind readnone speculatable
declare float @llvm.fmuladd.f32(float, float, float) #2

attributes #0 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-features"="+fp64-fp16-denormals,-fp32-denormals" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-features"="+fp64-fp16-denormals,-fp32-denormals" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone speculatable }
attributes #3 = { nounwind readnone }

!opencl.ocl.version = !{!0}
!llvm.module.flags = !{!1}
!llvm.ident = !{!2}

!0 = !{i32 1, i32 0}
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
