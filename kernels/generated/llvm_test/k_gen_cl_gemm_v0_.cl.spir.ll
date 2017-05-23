; ModuleID = 'k_gen_cl_gemm_v0_.cl'
source_filename = "k_gen_cl_gemm_v0_.cl"
target datalayout = "e-p:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "spir-unknown-unknown"

; Function Attrs: nounwind
define spir_kernel void @k_gen_cl_gemm_v0_(i32, float addrspace(1)* nocapture, float addrspace(1)* nocapture readonly, float addrspace(1)* nocapture readonly) local_unnamed_addr #0 !kernel_arg_addr_space !4 !kernel_arg_access_qual !5 !kernel_arg_type !6 !kernel_arg_base_type !6 !kernel_arg_type_qual !7 {
  %5 = tail call spir_func i32 @_Z13get_global_idj(i32 0) #3
  %6 = tail call spir_func i32 @_Z13get_global_idj(i32 1) #3
  %7 = tail call spir_func i32 @_Z15get_global_sizej(i32 0) #3
  %8 = icmp sgt i32 %7, 0
  %9 = mul nsw i32 %7, %5
  br i1 %8, label %14, label %10

; <label>:10:                                     ; preds = %14, %4
  %11 = phi float [ 0.000000e+00, %4 ], [ %24, %14 ]
  %12 = add nsw i32 %9, %6
  %13 = getelementptr inbounds float, float addrspace(1)* %1, i32 %12
  store float %11, float addrspace(1)* %13, align 4, !tbaa !8
  ret void

; <label>:14:                                     ; preds = %4, %14
  %15 = phi i32 [ %25, %14 ], [ 0, %4 ]
  %16 = phi float [ %24, %14 ], [ 0.000000e+00, %4 ]
  %17 = mul nsw i32 %15, %7
  %18 = add nsw i32 %17, %6
  %19 = getelementptr inbounds float, float addrspace(1)* %2, i32 %18
  %20 = load float, float addrspace(1)* %19, align 4, !tbaa !8
  %21 = add nsw i32 %15, %9
  %22 = getelementptr inbounds float, float addrspace(1)* %3, i32 %21
  %23 = load float, float addrspace(1)* %22, align 4, !tbaa !8
  %24 = tail call float @llvm.fmuladd.f32(float %20, float %23, float %16)
  %25 = add nuw nsw i32 %15, 1
  %26 = icmp slt i32 %25, %7
  br i1 %26, label %14, label %10
}

; Function Attrs: nounwind readnone
declare spir_func i32 @_Z13get_global_idj(i32) local_unnamed_addr #1

; Function Attrs: nounwind readnone
declare spir_func i32 @_Z15get_global_sizej(i32) local_unnamed_addr #1

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
