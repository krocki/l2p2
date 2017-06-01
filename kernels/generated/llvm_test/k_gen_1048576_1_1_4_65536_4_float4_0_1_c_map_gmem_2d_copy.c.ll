; ModuleID = 'k_gen_1048576_1_1_4_65536_4_float4_0_1_c_map_gmem_2d_copy.c'
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.10.0"

; Function Attrs: nounwind ssp uwtable
define void @k_gen_1048576_1_1_4_65536_4_float4_0_1_c_map_gmem_2d_copy(<4 x float>* noalias %out, <4 x float>* noalias %in) #0 {
  %1 = alloca <4 x float>*, align 8
  %2 = alloca <4 x float>*, align 8
  %gid = alloca i32, align 4
  store <4 x float>* %out, <4 x float>** %1, align 8
  store <4 x float>* %in, <4 x float>** %2, align 8
  store i32 0, i32* %gid, align 4
  br label %3

; <label>:3                                       ; preds = %16, %0
  %4 = load i32* %gid, align 4
  %5 = icmp slt i32 %4, 262144
  br i1 %5, label %6, label %19

; <label>:6                                       ; preds = %3
  %7 = load i32* %gid, align 4
  %8 = sext i32 %7 to i64
  %9 = load <4 x float>** %2, align 8
  %10 = getelementptr inbounds <4 x float>* %9, i64 %8
  %11 = load <4 x float>* %10, align 16
  %12 = load i32* %gid, align 4
  %13 = sext i32 %12 to i64
  %14 = load <4 x float>** %1, align 8
  %15 = getelementptr inbounds <4 x float>* %14, i64 %13
  store <4 x float> %11, <4 x float>* %15, align 16
  br label %16

; <label>:16                                      ; preds = %6
  %17 = load i32* %gid, align 4
  %18 = add nsw i32 %17, 1
  store i32 %18, i32* %gid, align 4
  br label %3

; <label>:19                                      ; preds = %3
  ret void
}

attributes #0 = { nounwind ssp uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+ssse3,+cx16,+sse,+sse2,+sse3" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"PIC Level", i32 2}
!1 = !{!"Apple LLVM version 7.0.2 (clang-700.1.81)"}
