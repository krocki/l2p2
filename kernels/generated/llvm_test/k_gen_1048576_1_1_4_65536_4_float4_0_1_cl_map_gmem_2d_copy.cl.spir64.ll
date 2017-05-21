; ModuleID = 'k_gen_1048576_1_1_4_65536_4_float4_0_1_cl_map_gmem_2d_copy.cl'
source_filename = "k_gen_1048576_1_1_4_65536_4_float4_0_1_cl_map_gmem_2d_copy.cl"
target datalayout = "e-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "spir64-unknown-unknown"

; Function Attrs: nounwind
define spir_kernel void @k_gen_1048576_1_1_4_65536_4_float4_0_1_cl_map_gmem_2d_copy(<4 x float> addrspace(1)* noalias nocapture, <4 x float> addrspace(1)* noalias nocapture readonly) local_unnamed_addr #0 !kernel_arg_addr_space !4 !kernel_arg_access_qual !5 !kernel_arg_type !6 !kernel_arg_base_type !7 !kernel_arg_type_qual !8 {
  %3 = tail call spir_func i64 @_Z13get_global_idj(i32 1) #2
  %4 = tail call spir_func i64 @_Z15get_global_sizej(i32 0) #2
  %5 = mul i64 %4, %3
  %6 = tail call spir_func i64 @_Z13get_global_idj(i32 0) #2
  %7 = add i64 %5, %6
  %8 = shl i64 %7, 32
  %9 = ashr exact i64 %8, 32
  %10 = getelementptr inbounds <4 x float>, <4 x float> addrspace(1)* %1, i64 %9
  %11 = load <4 x float>, <4 x float> addrspace(1)* %10, align 16, !tbaa !9
  %12 = getelementptr inbounds <4 x float>, <4 x float> addrspace(1)* %0, i64 %9
  store <4 x float> %11, <4 x float> addrspace(1)* %12, align 16, !tbaa !9
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
!4 = !{i32 1, i32 1}
!5 = !{!"none", !"none"}
!6 = !{!"float4*", !"float4*"}
!7 = !{!"float __attribute__((ext_vector_type(4)))*", !"float __attribute__((ext_vector_type(4)))*"}
!8 = !{!"restrict", !"restrict const"}
!9 = !{!10, !10, i64 0}
!10 = !{!"omnipotent char", !11, i64 0}
!11 = !{!"Simple C/C++ TBAA"}
