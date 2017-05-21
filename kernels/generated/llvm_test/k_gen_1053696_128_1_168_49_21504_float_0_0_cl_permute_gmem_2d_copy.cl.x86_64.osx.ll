; ModuleID = 'k_gen_1053696_128_1_168_49_21504_float_0_0_cl_permute_gmem_2d_copy.cl'
source_filename = "k_gen_1053696_128_1_168_49_21504_float_0_0_cl_permute_gmem_2d_copy.cl"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-MacOSX"

; Function Attrs: nounwind uwtable
define void @k_gen_1053696_128_1_168_49_21504_float_0_0_cl_permute_gmem_2d_copy(float* noalias nocapture, i32* noalias nocapture readonly, float* noalias nocapture readonly) local_unnamed_addr #0 !kernel_arg_addr_space !2 !kernel_arg_access_qual !3 !kernel_arg_type !4 !kernel_arg_base_type !4 !kernel_arg_type_qual !5 {
  %4 = tail call i64 @_Z13get_global_idj(i32 0) #2
  %5 = tail call i64 @_Z15get_global_sizej(i32 1) #2
  %6 = mul i64 %5, %4
  %7 = tail call i64 @_Z13get_global_idj(i32 1) #2
  %8 = add i64 %6, %7
  %9 = shl i64 %8, 32
  %10 = ashr exact i64 %9, 32
  %11 = getelementptr inbounds i32, i32* %1, i64 %10
  %12 = load i32, i32* %11, align 4, !tbaa !6
  %13 = sext i32 %12 to i64
  %14 = getelementptr inbounds float, float* %2, i64 %13
  %15 = bitcast float* %14 to i32*
  %16 = load i32, i32* %15, align 4, !tbaa !10
  %17 = getelementptr inbounds float, float* %0, i64 %10
  %18 = bitcast float* %17 to i32*
  store i32 %16, i32* %18, align 4, !tbaa !10
  %19 = getelementptr inbounds float, float* %2, i64 %10
  %20 = bitcast float* %19 to i32*
  %21 = load i32, i32* %20, align 4, !tbaa !10
  %22 = getelementptr inbounds float, float* %0, i64 %13
  %23 = bitcast float* %22 to i32*
  store i32 %21, i32* %23, align 4, !tbaa !10
  ret void
}

; Function Attrs: nounwind readnone
declare i64 @_Z13get_global_idj(i32) local_unnamed_addr #1

; Function Attrs: nounwind readnone
declare i64 @_Z15get_global_sizej(i32) local_unnamed_addr #1

attributes #0 = { nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 5.0.0 (git@github.com:krocki/clang.git 088eaf5b7b121f70b2fe6b4328b7d8819c9f2aab) (git@github.com:krocki/llvm.git 7bfd7c00d76359356c3572222f33b03931972c9f)"}
!2 = !{i32 1, i32 1, i32 1}
!3 = !{!"none", !"none", !"none"}
!4 = !{!"float*", !"int*", !"float*"}
!5 = !{!"restrict", !"restrict const", !"restrict const"}
!6 = !{!7, !7, i64 0}
!7 = !{!"int", !8, i64 0}
!8 = !{!"omnipotent char", !9, i64 0}
!9 = !{!"Simple C/C++ TBAA"}
!10 = !{!11, !11, i64 0}
!11 = !{!"float", !8, i64 0}
