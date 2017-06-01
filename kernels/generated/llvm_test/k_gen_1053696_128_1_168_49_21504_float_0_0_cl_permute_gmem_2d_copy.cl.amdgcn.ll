; ModuleID = 'k_gen_1053696_128_1_168_49_21504_float_0_0_cl_permute_gmem_2d_copy.cl'
target datalayout = "e-p:32:32-p1:64:64-p2:64:64-p3:32:32-p4:64:64-p5:32:32-p24:64:64-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64"
target triple = "amdgcn-amd-amdhsa-opencl"

; Function Attrs: nounwind
define void @k_gen_1053696_128_1_168_49_21504_float_0_0_cl_permute_gmem_2d_copy(float addrspace(1)* noalias nocapture %out, i32 addrspace(1)* noalias nocapture readonly %idxs, float addrspace(1)* noalias nocapture readonly %in) #0 {
  %1 = tail call i32 bitcast (i32 (...)* @get_global_id to i32 (i32)*)(i32 0) #2
  %2 = tail call i32 bitcast (i32 (...)* @get_global_size to i32 (i32)*)(i32 1) #2
  %3 = mul nsw i32 %2, %1
  %4 = tail call i32 bitcast (i32 (...)* @get_global_id to i32 (i32)*)(i32 1) #2
  %5 = add nsw i32 %3, %4
  %6 = sext i32 %5 to i64
  %7 = getelementptr inbounds i32 addrspace(1)* %idxs, i64 %6
  %8 = load i32 addrspace(1)* %7, align 4, !tbaa !7
  %9 = sext i32 %8 to i64
  %10 = getelementptr inbounds float addrspace(1)* %in, i64 %9
  %11 = bitcast float addrspace(1)* %10 to i32 addrspace(1)*
  %12 = load i32 addrspace(1)* %11, align 4, !tbaa !11
  %13 = getelementptr inbounds float addrspace(1)* %out, i64 %6
  %14 = bitcast float addrspace(1)* %13 to i32 addrspace(1)*
  store i32 %12, i32 addrspace(1)* %14, align 4, !tbaa !11
  %15 = getelementptr inbounds float addrspace(1)* %in, i64 %6
  %16 = bitcast float addrspace(1)* %15 to i32 addrspace(1)*
  %17 = load i32 addrspace(1)* %16, align 4, !tbaa !11
  %18 = getelementptr inbounds float addrspace(1)* %out, i64 %9
  %19 = bitcast float addrspace(1)* %18 to i32 addrspace(1)*
  store i32 %17, i32 addrspace(1)* %19, align 4, !tbaa !11
  ret void
}

declare i32 @get_global_id(...) #1

declare i32 @get_global_size(...) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!6}

!0 = !{void (float addrspace(1)*, i32 addrspace(1)*, float addrspace(1)*)* @k_gen_1053696_128_1_168_49_21504_float_0_0_cl_permute_gmem_2d_copy, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 1, i32 1, i32 1}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"float*", !"int*", !"float*"}
!4 = !{!"kernel_arg_base_type", !"float*", !"int*", !"float*"}
!5 = !{!"kernel_arg_type_qual", !"restrict", !"restrict const", !"restrict const"}
!6 = !{!"Apple LLVM version 7.0.2 (clang-700.1.81)"}
!7 = !{!8, !8, i64 0}
!8 = !{!"int", !9, i64 0}
!9 = !{!"omnipotent char", !10, i64 0}
!10 = !{!"Simple C/C++ TBAA"}
!11 = !{!12, !12, i64 0}
!12 = !{!"float", !9, i64 0}
