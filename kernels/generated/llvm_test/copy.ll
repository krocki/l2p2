; ModuleID = 'copy.cl'
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.10.0"

; Function Attrs: nounwind ssp uwtable
define void @k_gen_8_8_8192_1024_1_float_cl_copy_gmem(float* noalias nocapture %out, float* noalias nocapture readonly %in) #0 {
  %1 = tail call i32 (i32, ...)* bitcast (i32 (...)* @get_global_id to i32 (i32, ...)*)(i32 0) #2
  %2 = sext i32 %1 to i64
  %3 = getelementptr inbounds float* %in, i64 %2
  %4 = bitcast float* %3 to i32*
  %5 = load i32* %4, align 4, !tbaa !8
  %6 = getelementptr inbounds float* %out, i64 %2
  %7 = bitcast float* %6 to i32*
  store i32 %5, i32* %7, align 4, !tbaa !8
  ret void
}

declare i32 @get_global_id(...) #1

attributes #0 = { nounwind ssp uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+ssse3,+cx16,+sse,+sse2,+sse3" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+ssse3,+cx16,+sse,+sse2,+sse3" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0}
!llvm.module.flags = !{!6}
!llvm.ident = !{!7}

!0 = !{void (float*, float*)* @k_gen_8_8_8192_1024_1_float_cl_copy_gmem, !1, !2, !3, !4, !5}
!1 = !{!"kernel_arg_addr_space", i32 0, i32 0}
!2 = !{!"kernel_arg_access_qual", !"none", !"none"}
!3 = !{!"kernel_arg_type", !"float*", !"float*"}
!4 = !{!"kernel_arg_base_type", !"float*", !"float*"}
!5 = !{!"kernel_arg_type_qual", !"restrict", !"restrict const"}
!6 = !{i32 1, !"PIC Level", i32 2}
!7 = !{!"Apple LLVM version 7.0.2 (clang-700.1.81)"}
!8 = !{!9, !9, i64 0}
!9 = !{!"float", !10, i64 0}
!10 = !{!"omnipotent char", !11, i64 0}
!11 = !{!"Simple C/C++ TBAA"}
