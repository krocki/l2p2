; ModuleID = 'k_gen_1048576_1_1_4_65536_4_float4_0_1_c_map_gmem_2d_copy.c'
source_filename = "k_gen_1048576_1_1_4_65536_4_float4_0_1_c_map_gmem_2d_copy.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.10.0"

; Function Attrs: noinline nounwind ssp uwtable
define void @k_gen_1048576_1_1_4_65536_4_float4_0_1_c_map_gmem_2d_copy(<4 x float>* noalias, <4 x float>* noalias) #0 {
  %3 = alloca <4 x float>*, align 8
  %4 = alloca <4 x float>*, align 8
  %5 = alloca i32, align 4
  store <4 x float>* %0, <4 x float>** %3, align 8
  store <4 x float>* %1, <4 x float>** %4, align 8
  store i32 0, i32* %5, align 4
  br label %6

; <label>:6:                                      ; preds = %19, %2
  %7 = load i32, i32* %5, align 4
  %8 = icmp slt i32 %7, 262144
  br i1 %8, label %9, label %22

; <label>:9:                                      ; preds = %6
  %10 = load <4 x float>*, <4 x float>** %4, align 8
  %11 = load i32, i32* %5, align 4
  %12 = sext i32 %11 to i64
  %13 = getelementptr inbounds <4 x float>, <4 x float>* %10, i64 %12
  %14 = load <4 x float>, <4 x float>* %13, align 16
  %15 = load <4 x float>*, <4 x float>** %3, align 8
  %16 = load i32, i32* %5, align 4
  %17 = sext i32 %16 to i64
  %18 = getelementptr inbounds <4 x float>, <4 x float>* %15, i64 %17
  store <4 x float> %14, <4 x float>* %18, align 16
  br label %19

; <label>:19:                                     ; preds = %9
  %20 = load i32, i32* %5, align 4
  %21 = add nsw i32 %20, 1
  store i32 %21, i32* %5, align 4
  br label %6

; <label>:22:                                     ; preds = %6
  ret void
}

attributes #0 = { noinline nounwind ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 1, !"PIC Level", i32 2}
!2 = !{!"clang version 5.0.0 (git@github.com:krocki/clang.git 088eaf5b7b121f70b2fe6b4328b7d8819c9f2aab) (git@github.com:krocki/llvm.git 7bfd7c00d76359356c3572222f33b03931972c9f)"}
