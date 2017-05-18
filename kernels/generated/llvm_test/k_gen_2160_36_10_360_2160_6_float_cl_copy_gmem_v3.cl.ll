; ModuleID = 'k_gen_2160_36_10_360_2160_6_float_cl_copy_gmem_v3.cl'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nounwind uwtable
define void @k_gen_2160_36_10_360_2160_6_float_cl_copy_gmem_v3(float* noalias nocapture %out, float* noalias nocapture readonly %in) #0 {
  %1 = tail call i32 (i32, ...) bitcast (i32 (...)* @get_global_id to i32 (i32, ...)*)(i32 0) #2
  %2 = sext i32 %1 to i64
  %3 = getelementptr inbounds float, float* %in, i64 %2
  %4 = bitcast float* %3 to i32*
  %5 = load i32, i32* %4, align 4, !tbaa !7
  %6 = tail call i32 (i32, ...) bitcast (i32 (...)* @get_global_id to i32 (i32, ...)*)(i32 0) #2
  %7 = sext i32 %6 to i64
  %8 = getelementptr inbounds float, float* %out, i64 %7
  %9 = bitcast float* %8 to i32*
  store i32 %5, i32* %9, align 4, !tbaa !7
  %10 = tail call i32 (i32, ...) bitcast (i32 (...)* @get_global_id to i32 (i32, ...)*)(i32 0) #2
  %11 = add nsw i32 %10, 360
  %12 = sext i32 %11 to i64
  %13 = getelementptr inbounds float, float* %in, i64 %12
  %14 = bitcast float* %13 to i32*
  %15 = load i32, i32* %14, align 4, !tbaa !7
  %16 = tail call i32 (i32, ...) bitcast (i32 (...)* @get_global_id to i32 (i32, ...)*)(i32 0) #2
  %17 = add nsw i32 %16, 360
  %18 = sext i32 %17 to i64
  %19 = getelementptr inbounds float, float* %out, i64 %18
  %20 = bitcast float* %19 to i32*
  store i32 %15, i32* %20, align 4, !tbaa !7
  %21 = tail call i32 (i32, ...) bitcast (i32 (...)* @get_global_id to i32 (i32, ...)*)(i32 0) #2
  %22 = add nsw i32 %21, 720
  %23 = sext i32 %22 to i64
  %24 = getelementptr inbounds float, float* %in, i64 %23
  %25 = bitcast float* %24 to i32*
  %26 = load i32, i32* %25, align 4, !tbaa !7
  %27 = tail call i32 (i32, ...) bitcast (i32 (...)* @get_global_id to i32 (i32, ...)*)(i32 0) #2
  %28 = add nsw i32 %27, 720
  %29 = sext i32 %28 to i64
  %30 = getelementptr inbounds float, float* %out, i64 %29
  %31 = bitcast float* %30 to i32*
  store i32 %26, i32* %31, align 4, !tbaa !7
  %32 = tail call i32 (i32, ...) bitcast (i32 (...)* @get_global_id to i32 (i32, ...)*)(i32 0) #2
  %33 = add nsw i32 %32, 1080
  %34 = sext i32 %33 to i64
  %35 = getelementptr inbounds float, float* %in, i64 %34
  %36 = bitcast float* %35 to i32*
  %37 = load i32, i32* %36, align 4, !tbaa !7
  %38 = tail call i32 (i32, ...) bitcast (i32 (...)* @get_global_id to i32 (i32, ...)*)(i32 0) #2
  %39 = add nsw i32 %38, 1080
  %40 = sext i32 %39 to i64
  %41 = getelementptr inbounds float, float* %out, i64 %40
  %42 = bitcast float* %41 to i32*
  store i32 %37, i32* %42, align 4, !tbaa !7
  %43 = tail call i32 (i32, ...) bitcast (i32 (...)* @get_global_id to i32 (i32, ...)*)(i32 0) #2
  %44 = add nsw i32 %43, 1440
  %45 = sext i32 %44 to i64
  %46 = getelementptr inbounds float, float* %in, i64 %45
  %47 = bitcast float* %46 to i32*
  %48 = load i32, i32* %47, align 4, !tbaa !7
  %49 = tail call i32 (i32, ...) bitcast (i32 (...)* @get_global_id to i32 (i32, ...)*)(i32 0) #2
  %50 = add nsw i32 %49, 1440
  %51 = sext i32 %50 to i64
  %52 = getelementptr inbounds float, float* %out, i64 %51
  %53 = bitcast float* %52 to i32*
  store i32 %48, i32* %53, align 4, !tbaa !7
  %54 = tail call i32 (i32, ...) bitcast (i32 (...)* @get_global_id to i32 (i32, ...)*)(i32 0) #2
  %55 = add nsw i32 %54, 1800
  %56 = sext i32 %55 to i64
  %57 = getelementptr inbounds float, float* %in, i64 %56
  %58 = bitcast float* %57 to i32*
  %59 = load i32, i32* %58, align 4, !tbaa !7
  %60 = tail call i32 (i32, ...) bitcast (i32 (...)* @get_global_id to i32 (i32, ...)*)(i32 0) #2
  %61 = add nsw i32 %60, 1800
  %62 = sext i32 %61 to i64
  %63 = getelementptr inbounds float, float* %out, i64 %62
  %64 = bitcast float* %63 to i32*
  store i32 %59, i32* %64, align 4, !tbaa !7
  ret void
}

declare i32 @get_global_id(...) #1

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!6}

!0 = !{void (float*, float*)* @k_gen_2160_36_10_360_2160_6_float_cl_copy_gmem_v3, !1, !2, !3, !4, !5}
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
