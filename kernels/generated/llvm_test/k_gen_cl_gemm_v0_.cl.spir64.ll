; ModuleID = 'k_gen_cl_gemm_v0_.cl'
source_filename = "k_gen_cl_gemm_v0_.cl"
target datalayout = "e-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "spir64-unknown-unknown"

; Function Attrs: nounwind
define spir_kernel void @k_gen_cl_gemm_v0_(i32, float addrspace(1)* nocapture, float addrspace(1)* nocapture readonly, float addrspace(1)* nocapture readonly) local_unnamed_addr #0 !kernel_arg_addr_space !4 !kernel_arg_access_qual !5 !kernel_arg_type !6 !kernel_arg_base_type !6 !kernel_arg_type_qual !7 {
  %5 = tail call spir_func i64 @_Z13get_global_idj(i32 0) #3
  %6 = trunc i64 %5 to i32
  %7 = tail call spir_func i64 @_Z13get_global_idj(i32 1) #3
  %8 = trunc i64 %7 to i32
  %9 = tail call spir_func i64 @_Z15get_global_sizej(i32 0) #3
  %10 = trunc i64 %9 to i32
  %11 = icmp sgt i32 %10, 0
  %12 = mul nsw i32 %10, %6
  br i1 %11, label %18, label %13

; <label>:13:                                     ; preds = %18, %4
  %14 = phi float [ 0.000000e+00, %4 ], [ %30, %18 ]
  %15 = add nsw i32 %12, %8
  %16 = sext i32 %15 to i64
  %17 = getelementptr inbounds float, float addrspace(1)* %1, i64 %16
  store float %14, float addrspace(1)* %17, align 4, !tbaa !8
  ret void

; <label>:18:                                     ; preds = %4, %18
  %19 = phi i32 [ %31, %18 ], [ 0, %4 ]
  %20 = phi float [ %30, %18 ], [ 0.000000e+00, %4 ]
  %21 = mul nsw i32 %19, %10
  %22 = add nsw i32 %21, %8
  %23 = sext i32 %22 to i64
  %24 = getelementptr inbounds float, float addrspace(1)* %2, i64 %23
  %25 = load float, float addrspace(1)* %24, align 4, !tbaa !8
  %26 = add nsw i32 %19, %12
  %27 = sext i32 %26 to i64
  %28 = getelementptr inbounds float, float addrspace(1)* %3, i64 %27
  %29 = load float, float addrspace(1)* %28, align 4, !tbaa !8
  %30 = tail call float @llvm.fmuladd.f32(float %25, float %29, float %20)
  %31 = add nuw nsw i32 %19, 1
  %32 = icmp slt i32 %31, %10
  br i1 %32, label %18, label %13
}

; Function Attrs: nounwind readnone
declare spir_func i64 @_Z13get_global_idj(i32) local_unnamed_addr #1

; Function Attrs: nounwind readnone
declare spir_func i64 @_Z15get_global_sizej(i32) local_unnamed_addr #1

; Function Attrs: nounwind readnone speculatable
declare float @llvm.fmuladd.f32(float, float, float) #2

attributes #0 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone speculatable }
attributes #3 = { nounwind readnone }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}
!opencl.spir.version = !{!2, !2, !2}
!opencl.ocl.version = !{!3, !3, !3}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 5.0.0 (git@github.com:krocki/clang.git 088eaf5b7b121f70b2fe6b4328b7d8819c9f2aab) (git@github.com:krocki/llvm.git 7bfd7c00d76359356c3572222f33b03931972c9f)"}
!2 = !{i32 1, i32 2}
!3 = !{i32 1, i32 0}
!4 = !{i32 0, i32 1, i32 1, i32 1}
!5 = !{!"none", !"none", !"none", !"none"}
!6 = !{!"int", !"float*", !"float*", !"float*"}
!7 = !{!"", !"", !"", !""}
!8 = !{!9, !9, i64 0}
!9 = !{!"float", !10, i64 0}
!10 = !{!"omnipotent char", !11, i64 0}
!11 = !{!"Simple C/C++ TBAA"}
