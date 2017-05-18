; ModuleID = 'fmads.cl'
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.10.0"

; Function Attrs: nounwind ssp uwtable
define void @k_gen_float_fmads(float* noalias nocapture %out, float* noalias nocapture readonly %in) #0 {
  %1 = tail call i32 (i32, ...)* bitcast (i32 (...)* @get_global_id to i32 (i32, ...)*)(i32 0) #2
  %2 = sext i32 %1 to i64
  %3 = getelementptr inbounds float* %in, i64 %2
  %4 = load float* %3, align 4, !tbaa !8
  %5 = fmul float %4, 0x40091EB860000000
  %6 = getelementptr inbounds float* %out, i64 %2
  %7 = load float* %6, align 4, !tbaa !8
  %8 = fmul float %7, 0x40187F4880000000
  %9 = fpext float %4 to double
  %10 = fpext float %5 to double
  %11 = tail call i32 (double, double, double, ...)* bitcast (i32 (...)* @mad to i32 (double, double, double, ...)*)(double %9, double %10, double %9) #2
  %12 = sitofp i32 %11 to float
  %13 = fpext float %12 to double
  %14 = tail call i32 (double, double, double, ...)* bitcast (i32 (...)* @mad to i32 (double, double, double, ...)*)(double %10, double %13, double %10) #2
  %15 = sitofp i32 %14 to float
  %16 = fpext float %7 to double
  %17 = fpext float %8 to double
  %18 = tail call i32 (double, double, double, ...)* bitcast (i32 (...)* @mad to i32 (double, double, double, ...)*)(double %16, double %17, double %16) #2
  %19 = sitofp i32 %18 to float
  %20 = fpext float %19 to double
  %21 = tail call i32 (double, double, double, ...)* bitcast (i32 (...)* @mad to i32 (double, double, double, ...)*)(double %17, double %20, double %17) #2
  %22 = sitofp i32 %21 to float
  %23 = fadd float %15, %22
  store float %23, float* %6, align 4, !tbaa !8
  ret void
}

declare i32 @get_global_id(...) #1

declare i32 @mad(...) #1

attributes #0 = { nounwind ssp uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+ssse3,+cx16,+sse,+sse2,+sse3" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+ssse3,+cx16,+sse,+sse2,+sse3" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0}
!llvm.module.flags = !{!6}
!llvm.ident = !{!7}

!0 = !{void (float*, float*)* @k_gen_float_fmads, !1, !2, !3, !4, !5}
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
