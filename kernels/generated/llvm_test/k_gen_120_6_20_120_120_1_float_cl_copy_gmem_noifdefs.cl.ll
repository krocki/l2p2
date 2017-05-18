; ModuleID = 'k_gen_120_6_20_120_120_1_float_cl_copy_gmem_noifdefs.cl'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nounwind uwtable
define void @k_gen_120_6_20_120_120_1_float_cl_copy_gmem(float* noalias nocapture %out, float* noalias nocapture readonly %in) #0 {
  %1 = tail call i32 (i32, ...) bitcast (i32 (...)* @get_global_id to i32 (i32, ...)*)(i32 0) #2
  %2 = icmp slt i32 %1, 120
  br i1 %2, label %.lr.ph.preheader, label %._crit_edge

.lr.ph.preheader:                                 ; preds = %0
  %3 = sext i32 %1 to i64
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %indvars.iv = phi i64 [ %3, %.lr.ph.preheader ], [ %indvars.iv.next, %.lr.ph ]
  %4 = getelementptr inbounds float, float* %in, i64 %indvars.iv
  %5 = bitcast float* %4 to i32*
  %6 = load i32, i32* %5, align 4, !tbaa !7
  %7 = getelementptr inbounds float, float* %out, i64 %indvars.iv
  %8 = bitcast float* %7 to i32*
  store i32 %6, i32* %8, align 4, !tbaa !7
  %indvars.iv.next = add nsw i64 %indvars.iv, 120
  %9 = icmp slt i64 %indvars.iv, 0
  br i1 %9, label %.lr.ph, label %._crit_edge.loopexit, !llvm.loop !11

._crit_edge.loopexit:                             ; preds = %.lr.ph
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %0
  ret void
}

declare i32 @get_global_id(...) #1

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!6}

!0 = !{void (float*, float*)* @k_gen_120_6_20_120_120_1_float_cl_copy_gmem, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 0, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"float*", !"float*"}
!4 = !{!"kernel_arg_base_type", !"float*", !"float*"}
!5 = !{!"kernel_arg_type_qual", !"restrict", !"restrict const"}
!6 = !{!"clang version 3.8.1-12ubuntu1 (tags/RELEASE_381/final)"}
!7 = !{!8, !8, i64 0}
!8 = !{!"float", !9, i64 0}
!9 = !{!"omnipotent char", !10, i64 0}
!10 = !{!"Simple C/C++ TBAA"}
!11 = distinct !{!11, !12}
!12 = !{!"llvm.loop.unroll.disable"}
