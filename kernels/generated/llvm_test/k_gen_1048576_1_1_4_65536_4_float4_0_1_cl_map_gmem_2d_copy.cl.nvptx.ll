; ModuleID = 'k_gen_1048576_1_1_4_65536_4_float4_0_1_cl_map_gmem_2d_copy.cl'
source_filename = "k_gen_1048576_1_1_4_65536_4_float4_0_1_cl_map_gmem_2d_copy.cl"
target datalayout = "e-i64:64-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-unknown-unknown"

; Function Attrs: noinline nounwind
define void @k_gen_1048576_1_1_4_65536_4_float4_0_1_cl_map_gmem_2d_copy(<4 x float> addrspace(1)* noalias nocapture, <4 x float> addrspace(1)* noalias nocapture readonly) local_unnamed_addr #0 !kernel_arg_addr_space !3 !kernel_arg_access_qual !4 !kernel_arg_type !5 !kernel_arg_base_type !6 !kernel_arg_type_qual !7 {
  %3 = tail call i64 @_Z13get_global_idj(i32 1) #2
  %4 = tail call i64 @_Z15get_global_sizej(i32 0) #2
  %5 = mul i64 %4, %3
  %6 = tail call i64 @_Z13get_global_idj(i32 0) #2
  %7 = add i64 %5, %6
  %8 = shl i64 %7, 32
  %9 = ashr exact i64 %8, 32
  %10 = getelementptr inbounds <4 x float>, <4 x float> addrspace(1)* %1, i64 %9
  %11 = load <4 x float>, <4 x float> addrspace(1)* %10, align 16, !tbaa !8
  %12 = getelementptr inbounds <4 x float>, <4 x float> addrspace(1)* %0, i64 %9
  store <4 x float> %11, <4 x float> addrspace(1)* %12, align 16, !tbaa !8
  ret void
}

; Function Attrs: nounwind readnone
declare i64 @_Z13get_global_idj(i32) local_unnamed_addr #1

; Function Attrs: nounwind readnone
declare i64 @_Z15get_global_sizej(i32) local_unnamed_addr #1

attributes #0 = { noinline nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-features"="-satom" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-features"="-satom" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }

!nvvm.annotations = !{!0}
!llvm.module.flags = !{!1}
!llvm.ident = !{!2}

!0 = !{void (<4 x float> addrspace(1)*, <4 x float> addrspace(1)*)* @k_gen_1048576_1_1_4_65536_4_float4_0_1_cl_map_gmem_2d_copy, !"kernel", i32 1}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{!"clang version 5.0.0 (git@github.com:krocki/clang.git 088eaf5b7b121f70b2fe6b4328b7d8819c9f2aab) (git@github.com:krocki/llvm.git 7bfd7c00d76359356c3572222f33b03931972c9f)"}
!3 = !{i32 1, i32 1}
!4 = !{!"none", !"none"}
!5 = !{!"float4*", !"float4*"}
!6 = !{!"float __attribute__((ext_vector_type(4)))*", !"float __attribute__((ext_vector_type(4)))*"}
!7 = !{!"restrict", !"restrict const"}
!8 = !{!9, !9, i64 0}
!9 = !{!"omnipotent char", !10, i64 0}
!10 = !{!"Simple C/C++ TBAA"}
