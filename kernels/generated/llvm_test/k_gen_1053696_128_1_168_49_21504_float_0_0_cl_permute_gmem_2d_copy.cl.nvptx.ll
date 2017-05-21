; ModuleID = 'k_gen_1053696_128_1_168_49_21504_float_0_0_cl_permute_gmem_2d_copy.cl'
source_filename = "k_gen_1053696_128_1_168_49_21504_float_0_0_cl_permute_gmem_2d_copy.cl"
target datalayout = "e-i64:64-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-unknown-unknown"

; Function Attrs: noinline nounwind
define void @k_gen_1053696_128_1_168_49_21504_float_0_0_cl_permute_gmem_2d_copy(float addrspace(1)* noalias nocapture, i32 addrspace(1)* noalias nocapture readonly, float addrspace(1)* noalias nocapture readonly) local_unnamed_addr #0 !kernel_arg_addr_space !3 !kernel_arg_access_qual !4 !kernel_arg_type !5 !kernel_arg_base_type !5 !kernel_arg_type_qual !6 {
  %4 = tail call i64 @_Z13get_global_idj(i32 0) #2
  %5 = tail call i64 @_Z15get_global_sizej(i32 1) #2
  %6 = mul i64 %5, %4
  %7 = tail call i64 @_Z13get_global_idj(i32 1) #2
  %8 = add i64 %6, %7
  %9 = shl i64 %8, 32
  %10 = ashr exact i64 %9, 32
  %11 = getelementptr inbounds i32, i32 addrspace(1)* %1, i64 %10
  %12 = load i32, i32 addrspace(1)* %11, align 4, !tbaa !7
  %13 = sext i32 %12 to i64
  %14 = getelementptr inbounds float, float addrspace(1)* %2, i64 %13
  %15 = bitcast float addrspace(1)* %14 to i32 addrspace(1)*
  %16 = load i32, i32 addrspace(1)* %15, align 4, !tbaa !11
  %17 = getelementptr inbounds float, float addrspace(1)* %0, i64 %10
  %18 = bitcast float addrspace(1)* %17 to i32 addrspace(1)*
  store i32 %16, i32 addrspace(1)* %18, align 4, !tbaa !11
  %19 = getelementptr inbounds float, float addrspace(1)* %2, i64 %10
  %20 = bitcast float addrspace(1)* %19 to i32 addrspace(1)*
  %21 = load i32, i32 addrspace(1)* %20, align 4, !tbaa !11
  %22 = getelementptr inbounds float, float addrspace(1)* %0, i64 %13
  %23 = bitcast float addrspace(1)* %22 to i32 addrspace(1)*
  store i32 %21, i32 addrspace(1)* %23, align 4, !tbaa !11
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

!0 = !{void (float addrspace(1)*, i32 addrspace(1)*, float addrspace(1)*)* @k_gen_1053696_128_1_168_49_21504_float_0_0_cl_permute_gmem_2d_copy, !"kernel", i32 1}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{!"clang version 5.0.0 (git@github.com:krocki/clang.git 088eaf5b7b121f70b2fe6b4328b7d8819c9f2aab) (git@github.com:krocki/llvm.git 7bfd7c00d76359356c3572222f33b03931972c9f)"}
!3 = !{i32 1, i32 1, i32 1}
!4 = !{!"none", !"none", !"none"}
!5 = !{!"float*", !"int*", !"float*"}
!6 = !{!"restrict", !"restrict const", !"restrict const"}
!7 = !{!8, !8, i64 0}
!8 = !{!"int", !9, i64 0}
!9 = !{!"omnipotent char", !10, i64 0}
!10 = !{!"Simple C/C++ TBAA"}
!11 = !{!12, !12, i64 0}
!12 = !{!"float", !9, i64 0}
