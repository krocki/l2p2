; ModuleID = 'k_gen_cl_gemm_v0_.cl'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-Linux"

; Function Attrs: nounwind uwtable
define void @k_gen_cl_gemm_v0_(i32 %N, float* nocapture %C, float* nocapture readonly %A, float* nocapture readonly %B) #0 {
  %1 = tail call i32 (i32, ...)* bitcast (i32 (...)* @get_global_id to i32 (i32, ...)*)(i32 0) #2
  %2 = tail call i32 (i32, ...)* bitcast (i32 (...)* @get_global_id to i32 (i32, ...)*)(i32 1) #2
  %3 = tail call i32 (i32, ...)* bitcast (i32 (...)* @get_global_size to i32 (i32, ...)*)(i32 0) #2
  %4 = icmp sgt i32 %3, 0
  %5 = mul nsw i32 %3, %1
  br i1 %4, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %0
  %6 = sext i32 %5 to i64
  %7 = sext i32 %3 to i64
  %8 = sext i32 %2 to i64
  %9 = add i32 %3, -1
  %xtraiter = and i32 %3, 1
  %lcmp.mod = icmp ne i32 %xtraiter, 0
  br i1 %lcmp.mod, label %10, label %.lr.ph.split

; <label>:10                                      ; preds = %.lr.ph
  %11 = mul nsw i64 0, %7
  %12 = add nsw i64 %11, %8
  %13 = getelementptr inbounds float* %A, i64 %12
  %14 = load float* %13, align 4, !tbaa !7
  %15 = add nsw i64 0, %6
  %16 = getelementptr inbounds float* %B, i64 %15
  %17 = load float* %16, align 4, !tbaa !7
  %18 = fmul float %14, %17
  %19 = fadd float 0.000000e+00, %18
  %indvars.iv.next.prol = add nuw nsw i64 0, 1
  %lftr.wideiv.prol = trunc i64 0 to i32
  %exitcond.prol = icmp eq i32 %lftr.wideiv.prol, %9
  br label %.lr.ph.split

.lr.ph.split:                                     ; preds = %10, %.lr.ph
  %.lcssa.unr = phi float [ undef, %.lr.ph ], [ %19, %10 ]
  %indvars.iv.unr = phi i64 [ 0, %.lr.ph ], [ %indvars.iv.next.prol, %10 ]
  %tmp.01.unr = phi float [ 0.000000e+00, %.lr.ph ], [ %19, %10 ]
  %20 = icmp ult i32 %9, 1
  br i1 %20, label %._crit_edge.loopexit, label %.lr.ph.split.split

.lr.ph.split.split:                               ; preds = %.lr.ph.split
  br label %21

; <label>:21                                      ; preds = %21, %.lr.ph.split.split
  %indvars.iv = phi i64 [ %indvars.iv.unr, %.lr.ph.split.split ], [ %indvars.iv.next.1, %21 ]
  %tmp.01 = phi float [ %tmp.01.unr, %.lr.ph.split.split ], [ %39, %21 ]
  %22 = mul nsw i64 %indvars.iv, %7
  %23 = add nsw i64 %22, %8
  %24 = getelementptr inbounds float* %A, i64 %23
  %25 = load float* %24, align 4, !tbaa !7
  %26 = add nsw i64 %indvars.iv, %6
  %27 = getelementptr inbounds float* %B, i64 %26
  %28 = load float* %27, align 4, !tbaa !7
  %29 = fmul float %25, %28
  %30 = fadd float %tmp.01, %29
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv to i32
  %31 = mul nsw i64 %indvars.iv.next, %7
  %32 = add nsw i64 %31, %8
  %33 = getelementptr inbounds float* %A, i64 %32
  %34 = load float* %33, align 4, !tbaa !7
  %35 = add nsw i64 %indvars.iv.next, %6
  %36 = getelementptr inbounds float* %B, i64 %35
  %37 = load float* %36, align 4, !tbaa !7
  %38 = fmul float %34, %37
  %39 = fadd float %30, %38
  %indvars.iv.next.1 = add nuw nsw i64 %indvars.iv.next, 1
  %lftr.wideiv.1 = trunc i64 %indvars.iv.next to i32
  %exitcond.1 = icmp eq i32 %lftr.wideiv.1, %9
  br i1 %exitcond.1, label %._crit_edge.loopexit.unr-lcssa, label %21

._crit_edge.loopexit.unr-lcssa:                   ; preds = %21
  %.lcssa.ph = phi float [ %39, %21 ]
  br label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %.lr.ph.split, %._crit_edge.loopexit.unr-lcssa
  %.lcssa = phi float [ %.lcssa.unr, %.lr.ph.split ], [ %.lcssa.ph, %._crit_edge.loopexit.unr-lcssa ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %0
  %tmp.0.lcssa = phi float [ 0.000000e+00, %0 ], [ %.lcssa, %._crit_edge.loopexit ]
  %40 = add nsw i32 %5, %2
  %41 = sext i32 %40 to i64
  %42 = getelementptr inbounds float* %C, i64 %41
  store float %tmp.0.lcssa, float* %42, align 4, !tbaa !7
  ret void
}

declare i32 @get_global_id(...) #1

declare i32 @get_global_size(...) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!6}

!0 = !{void (i32, float*, float*, float*)* @k_gen_cl_gemm_v0_, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 0, i32 0, i32 0, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"int", !"float*", !"float*", !"float*"}
!4 = !{!"kernel_arg_base_type", !"int", !"float*", !"float*", !"float*"}
!5 = !{!"kernel_arg_type_qual", !"const", !"", !"", !""}
!6 = !{!"Apple LLVM version 7.0.2 (clang-700.1.81)"}
!7 = !{!8, !8, i64 0}
!8 = !{!"float", !9, i64 0}
!9 = !{!"omnipotent char", !10, i64 0}
!10 = !{!"Simple C/C++ TBAA"}
