; ModuleID = 'k_gen_cl_gemm_v0_.cl'
target datalayout = "e-p:32:32-p1:64:64-p2:64:64-p3:32:32-p4:64:64-p5:32:32-p24:64:64-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64"
target triple = "amdgcn-amd-amdhsa-opencl"

; Function Attrs: nounwind
define void @k_gen_cl_gemm_v0_(i32 %N, float addrspace(1)* nocapture %C, float addrspace(1)* nocapture readonly %A, float addrspace(1)* nocapture readonly %B) #0 {
  %1 = tail call i32 bitcast (i32 (...)* @get_global_id to i32 (i32)*)(i32 0) #2
  %2 = tail call i32 bitcast (i32 (...)* @get_global_id to i32 (i32)*)(i32 1) #2
  %3 = tail call i32 bitcast (i32 (...)* @get_global_size to i32 (i32)*)(i32 0) #2
  %4 = icmp sgt i32 %3, 0
  %5 = mul nsw i32 %3, %1
  br i1 %4, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %0
  %6 = sext i32 %5 to i64
  %7 = sext i32 %3 to i64
  %8 = sext i32 %2 to i64
  %9 = add i32 %3, -1
  br label %10

; <label>:10                                      ; preds = %10, %.lr.ph
  %indvars.iv = phi i64 [ 0, %.lr.ph ], [ %indvars.iv.next, %10 ]
  %tmp.01 = phi float [ 0.000000e+00, %.lr.ph ], [ %19, %10 ]
  %11 = mul nsw i64 %indvars.iv, %7
  %12 = add nsw i64 %11, %8
  %13 = getelementptr inbounds float addrspace(1)* %A, i64 %12
  %14 = load float addrspace(1)* %13, align 4, !tbaa !7
  %15 = add nsw i64 %indvars.iv, %6
  %16 = getelementptr inbounds float addrspace(1)* %B, i64 %15
  %17 = load float addrspace(1)* %16, align 4, !tbaa !7
  %18 = fmul float %14, %17
  %19 = fadd float %tmp.01, %18
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %9
  br i1 %exitcond, label %._crit_edge.loopexit, label %10

._crit_edge.loopexit:                             ; preds = %10
  %.lcssa = phi float [ %19, %10 ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %0
  %tmp.0.lcssa = phi float [ 0.000000e+00, %0 ], [ %.lcssa, %._crit_edge.loopexit ]
  %20 = add nsw i32 %5, %2
  %21 = sext i32 %20 to i64
  %22 = getelementptr inbounds float addrspace(1)* %C, i64 %21
  store float %tmp.0.lcssa, float addrspace(1)* %22, align 4, !tbaa !7
  ret void
}

declare i32 @get_global_id(...) #1

declare i32 @get_global_size(...) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!6}

!0 = !{void (i32, float addrspace(1)*, float addrspace(1)*, float addrspace(1)*)* @k_gen_cl_gemm_v0_, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 0, i32 1, i32 1, i32 1}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"int", !"float*", !"float*", !"float*"}
!4 = !{!"kernel_arg_base_type", !"int", !"float*", !"float*", !"float*"}
!5 = !{!"kernel_arg_type_qual", !"const", !"", !"", !""}
!6 = !{!"Apple LLVM version 7.0.2 (clang-700.1.81)"}
!7 = !{!8, !8, i64 0}
!8 = !{!"float", !9, i64 0}
!9 = !{!"omnipotent char", !10, i64 0}
!10 = !{!"Simple C/C++ TBAA"}
