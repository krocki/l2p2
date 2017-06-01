; ModuleID = 'k_gen_1053696_128_1_168_49_21504_float_0_0_cl_permute_gmem_2d_copy.cl'
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.10.0"

; Function Attrs: nounwind ssp uwtable
define void @k_gen_1053696_128_1_168_49_21504_float_0_0_cl_permute_gmem_2d_copy(float* noalias nocapture %out, i32* noalias nocapture readonly %idxs, float* noalias nocapture readonly %in) #0 {
  %1 = tail call i32 (i32, ...)* bitcast (i32 (...)* @get_global_id to i32 (i32, ...)*)(i32 0) #2
  %2 = tail call i32 (i32, ...)* bitcast (i32 (...)* @get_global_size to i32 (i32, ...)*)(i32 1) #2
  %3 = mul nsw i32 %2, %1
  %4 = tail call i32 (i32, ...)* bitcast (i32 (...)* @get_global_id to i32 (i32, ...)*)(i32 1) #2
  %5 = add nsw i32 %3, %4
  %6 = sext i32 %5 to i64
  %7 = getelementptr inbounds i32* %idxs, i64 %6
  %8 = load i32* %7, align 4, !tbaa !8
  %9 = sext i32 %8 to i64
  %10 = getelementptr inbounds float* %in, i64 %9
  %11 = bitcast float* %10 to i32*
  %12 = load i32* %11, align 4, !tbaa !12
  %13 = getelementptr inbounds float* %out, i64 %6
  %14 = bitcast float* %13 to i32*
  store i32 %12, i32* %14, align 4, !tbaa !12
  %15 = getelementptr inbounds float* %in, i64 %6
  %16 = bitcast float* %15 to i32*
  %17 = load i32* %16, align 4, !tbaa !12
  %18 = getelementptr inbounds float* %out, i64 %9
  %19 = bitcast float* %18 to i32*
  store i32 %17, i32* %19, align 4, !tbaa !12
  ret void
}

declare i32 @get_global_id(...) #1

declare i32 @get_global_size(...) #1

attributes #0 = { nounwind ssp uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+ssse3,+cx16,+sse,+sse2,+sse3" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+ssse3,+cx16,+sse,+sse2,+sse3" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0}
!llvm.module.flags = !{!6}
!llvm.ident = !{!7}

!0 = !{void (float*, i32*, float*)* @k_gen_1053696_128_1_168_49_21504_float_0_0_cl_permute_gmem_2d_copy, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 0, i32 0, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"float*", !"int*", !"float*"}
!4 = !{!"kernel_arg_base_type", !"float*", !"int*", !"float*"}
!5 = !{!"kernel_arg_type_qual", !"restrict", !"restrict const", !"restrict const"}
!6 = !{i32 1, !"PIC Level", i32 2}
!7 = !{!"Apple LLVM version 7.0.2 (clang-700.1.81)"}
!8 = !{!9, !9, i64 0}
!9 = !{!"int", !10, i64 0}
!10 = !{!"omnipotent char", !11, i64 0}
!11 = !{!"Simple C/C++ TBAA"}
!12 = !{!13, !13, i64 0}
!13 = !{!"float", !10, i64 0}
