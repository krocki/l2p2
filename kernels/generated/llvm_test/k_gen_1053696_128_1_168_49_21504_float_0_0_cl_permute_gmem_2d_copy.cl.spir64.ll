; ModuleID = 'k_gen_1053696_128_1_168_49_21504_float_0_0_cl_permute_gmem_2d_copy.cl'
source_filename = "k_gen_1053696_128_1_168_49_21504_float_0_0_cl_permute_gmem_2d_copy.cl"
target datalayout = "e-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "spir64-unknown-unknown"

; Function Attrs: nounwind
define spir_kernel void @k_gen_1053696_128_1_168_49_21504_float_0_0_cl_permute_gmem_2d_copy(float addrspace(1)* noalias nocapture, i32 addrspace(1)* noalias nocapture readonly, float addrspace(1)* noalias nocapture readonly) local_unnamed_addr #0 !kernel_arg_addr_space !4 !kernel_arg_access_qual !5 !kernel_arg_type !6 !kernel_arg_base_type !6 !kernel_arg_type_qual !7 {
  %4 = tail call spir_func i64 @_Z13get_global_idj(i32 0) #2
  %5 = tail call spir_func i64 @_Z15get_global_sizej(i32 1) #2
  %6 = mul i64 %5, %4
  %7 = tail call spir_func i64 @_Z13get_global_idj(i32 1) #2
  %8 = add i64 %6, %7
  %9 = shl i64 %8, 32
  %10 = ashr exact i64 %9, 32
  %11 = getelementptr inbounds i32, i32 addrspace(1)* %1, i64 %10
  %12 = load i32, i32 addrspace(1)* %11, align 4, !tbaa !8
  %13 = sext i32 %12 to i64
  %14 = getelementptr inbounds float, float addrspace(1)* %2, i64 %13
  %15 = load float, float addrspace(1)* %14, align 4, !tbaa !12
  %16 = getelementptr inbounds float, float addrspace(1)* %0, i64 %10
  store float %15, float addrspace(1)* %16, align 4, !tbaa !12
  %17 = getelementptr inbounds float, float addrspace(1)* %2, i64 %10
  %18 = load float, float addrspace(1)* %17, align 4, !tbaa !12
  %19 = getelementptr inbounds float, float addrspace(1)* %0, i64 %13
  store float %18, float addrspace(1)* %19, align 4, !tbaa !12
  ret void
}

; Function Attrs: nounwind readnone
declare spir_func i64 @_Z13get_global_idj(i32) local_unnamed_addr #1

; Function Attrs: nounwind readnone
declare spir_func i64 @_Z15get_global_sizej(i32) local_unnamed_addr #1

attributes #0 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}
!opencl.spir.version = !{!2, !2, !2}
!opencl.ocl.version = !{!3, !3, !3}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 5.0.0 (git@github.com:krocki/clang.git 088eaf5b7b121f70b2fe6b4328b7d8819c9f2aab) (git@github.com:krocki/llvm.git 7bfd7c00d76359356c3572222f33b03931972c9f)"}
!2 = !{i32 1, i32 2}
!3 = !{i32 1, i32 0}
!4 = !{i32 1, i32 1, i32 1}
!5 = !{!"none", !"none", !"none"}
!6 = !{!"float*", !"int*", !"float*"}
!7 = !{!"restrict", !"restrict const", !"restrict const"}
!8 = !{!9, !9, i64 0}
!9 = !{!"int", !10, i64 0}
!10 = !{!"omnipotent char", !11, i64 0}
!11 = !{!"Simple C/C++ TBAA"}
!12 = !{!13, !13, i64 0}
!13 = !{!"float", !10, i64 0}
