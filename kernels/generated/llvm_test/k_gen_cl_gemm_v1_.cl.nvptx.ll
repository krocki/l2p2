; ModuleID = 'k_gen_cl_gemm_v1_.cl'
source_filename = "k_gen_cl_gemm_v1_.cl"
target datalayout = "e-i64:64-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-unknown-unknown"

@k_gen_cl_gemm_v1_.Awrk = internal unnamed_addr addrspace(3) global [256 x float] undef, align 4
@k_gen_cl_gemm_v1_.Bwrk = internal unnamed_addr addrspace(3) global [256 x float] undef, align 4

; Function Attrs: noinline nounwind
define void @k_gen_cl_gemm_v1_(i32, float addrspace(1)* noalias nocapture, float addrspace(1)* noalias nocapture readonly, float addrspace(1)* noalias nocapture readonly) local_unnamed_addr #0 !kernel_arg_addr_space !3 !kernel_arg_access_qual !4 !kernel_arg_type !5 !kernel_arg_base_type !5 !kernel_arg_type_qual !6 {
  %5 = tail call i64 @_Z13get_global_idj(i32 0) #4
  %6 = tail call i64 @_Z13get_global_idj(i32 1) #4
  %7 = tail call i64 @_Z12get_group_idj(i32 0) #4
  %8 = trunc i64 %7 to i32
  %9 = tail call i64 @_Z12get_group_idj(i32 1) #4
  %10 = trunc i64 %9 to i32
  %11 = tail call i64 @_Z12get_local_idj(i32 0) #4
  %12 = trunc i64 %11 to i32
  %13 = tail call i64 @_Z12get_local_idj(i32 1) #4
  %14 = trunc i64 %13 to i32
  %15 = shl nsw i32 %10, 4
  %16 = shl nsw i32 %8, 13
  %17 = shl nsw i32 %12, 9
  %18 = add i32 %17, %14
  %19 = shl nsw i32 %12, 4
  %20 = add nsw i32 %19, %14
  %21 = sext i32 %20 to i64
  %22 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i64 0, i64 %21
  %23 = bitcast float addrspace(3)* %22 to i32 addrspace(3)*
  %24 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i64 0, i64 %21
  %25 = bitcast float addrspace(3)* %24 to i32 addrspace(3)*
  %26 = shl i64 %13, 32
  %27 = ashr exact i64 %26, 32
  %28 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i64 0, i64 %27
  %29 = sext i32 %19 to i64
  %30 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i64 0, i64 %29
  %31 = shl i64 %13, 32
  %32 = add i64 %31, 68719476736
  %33 = ashr exact i64 %32, 32
  %34 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i64 0, i64 %33
  %35 = or i32 %19, 1
  %36 = sext i32 %35 to i64
  %37 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i64 0, i64 %36
  %38 = shl i64 %13, 32
  %39 = add i64 %38, 137438953472
  %40 = ashr exact i64 %39, 32
  %41 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i64 0, i64 %40
  %42 = or i32 %19, 2
  %43 = sext i32 %42 to i64
  %44 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i64 0, i64 %43
  %45 = shl i64 %13, 32
  %46 = add i64 %45, 206158430208
  %47 = ashr exact i64 %46, 32
  %48 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i64 0, i64 %47
  %49 = or i32 %19, 3
  %50 = sext i32 %49 to i64
  %51 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i64 0, i64 %50
  %52 = shl i64 %13, 32
  %53 = add i64 %52, 274877906944
  %54 = ashr exact i64 %53, 32
  %55 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i64 0, i64 %54
  %56 = or i32 %19, 4
  %57 = sext i32 %56 to i64
  %58 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i64 0, i64 %57
  %59 = shl i64 %13, 32
  %60 = add i64 %59, 343597383680
  %61 = ashr exact i64 %60, 32
  %62 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i64 0, i64 %61
  %63 = or i32 %19, 5
  %64 = sext i32 %63 to i64
  %65 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i64 0, i64 %64
  %66 = shl i64 %13, 32
  %67 = add i64 %66, 412316860416
  %68 = ashr exact i64 %67, 32
  %69 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i64 0, i64 %68
  %70 = or i32 %19, 6
  %71 = sext i32 %70 to i64
  %72 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i64 0, i64 %71
  %73 = shl i64 %13, 32
  %74 = add i64 %73, 481036337152
  %75 = ashr exact i64 %74, 32
  %76 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i64 0, i64 %75
  %77 = or i32 %19, 7
  %78 = sext i32 %77 to i64
  %79 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i64 0, i64 %78
  %80 = shl i64 %13, 32
  %81 = add i64 %80, 549755813888
  %82 = ashr exact i64 %81, 32
  %83 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i64 0, i64 %82
  %84 = or i32 %19, 8
  %85 = sext i32 %84 to i64
  %86 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i64 0, i64 %85
  %87 = shl i64 %13, 32
  %88 = add i64 %87, 618475290624
  %89 = ashr exact i64 %88, 32
  %90 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i64 0, i64 %89
  %91 = or i32 %19, 9
  %92 = sext i32 %91 to i64
  %93 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i64 0, i64 %92
  %94 = shl i64 %13, 32
  %95 = add i64 %94, 687194767360
  %96 = ashr exact i64 %95, 32
  %97 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i64 0, i64 %96
  %98 = or i32 %19, 10
  %99 = sext i32 %98 to i64
  %100 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i64 0, i64 %99
  %101 = shl i64 %13, 32
  %102 = add i64 %101, 755914244096
  %103 = ashr exact i64 %102, 32
  %104 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i64 0, i64 %103
  %105 = or i32 %19, 11
  %106 = sext i32 %105 to i64
  %107 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i64 0, i64 %106
  %108 = shl i64 %13, 32
  %109 = add i64 %108, 824633720832
  %110 = ashr exact i64 %109, 32
  %111 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i64 0, i64 %110
  %112 = or i32 %19, 12
  %113 = sext i32 %112 to i64
  %114 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i64 0, i64 %113
  %115 = shl i64 %13, 32
  %116 = add i64 %115, 893353197568
  %117 = ashr exact i64 %116, 32
  %118 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i64 0, i64 %117
  %119 = or i32 %19, 13
  %120 = sext i32 %119 to i64
  %121 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i64 0, i64 %120
  %122 = shl i64 %13, 32
  %123 = add i64 %122, 962072674304
  %124 = ashr exact i64 %123, 32
  %125 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i64 0, i64 %124
  %126 = or i32 %19, 14
  %127 = sext i32 %126 to i64
  %128 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i64 0, i64 %127
  %129 = shl i64 %13, 32
  %130 = add i64 %129, 1030792151040
  %131 = ashr exact i64 %130, 32
  %132 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i64 0, i64 %131
  %133 = or i32 %19, 15
  %134 = sext i32 %133 to i64
  %135 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i64 0, i64 %134
  br label %136

; <label>:136:                                    ; preds = %136, %4
  %137 = phi float [ 0.000000e+00, %4 ], [ %198, %136 ]
  %138 = phi i32 [ %16, %4 ], [ %200, %136 ]
  %139 = phi i32 [ 0, %4 ], [ %201, %136 ]
  %140 = phi i32 [ %15, %4 ], [ %199, %136 ]
  %141 = add i32 %18, %140
  %142 = sext i32 %141 to i64
  %143 = getelementptr inbounds float, float addrspace(1)* %2, i64 %142
  %144 = bitcast float addrspace(1)* %143 to i32 addrspace(1)*
  %145 = load i32, i32 addrspace(1)* %144, align 4, !tbaa !7
  store i32 %145, i32 addrspace(3)* %23, align 4, !tbaa !7
  %146 = add i32 %18, %138
  %147 = sext i32 %146 to i64
  %148 = getelementptr inbounds float, float addrspace(1)* %3, i64 %147
  %149 = bitcast float addrspace(1)* %148 to i32 addrspace(1)*
  %150 = load i32, i32 addrspace(1)* %149, align 4, !tbaa !7
  store i32 %150, i32 addrspace(3)* %25, align 4, !tbaa !7
  tail call void @_Z7barrierj(i32 1) #5
  %151 = load float, float addrspace(3)* %28, align 4, !tbaa !7
  %152 = load float, float addrspace(3)* %30, align 4, !tbaa !7
  %153 = tail call float @llvm.fmuladd.f32(float %151, float %152, float %137)
  %154 = load float, float addrspace(3)* %34, align 4, !tbaa !7
  %155 = load float, float addrspace(3)* %37, align 4, !tbaa !7
  %156 = tail call float @llvm.fmuladd.f32(float %154, float %155, float %153)
  %157 = load float, float addrspace(3)* %41, align 4, !tbaa !7
  %158 = load float, float addrspace(3)* %44, align 4, !tbaa !7
  %159 = tail call float @llvm.fmuladd.f32(float %157, float %158, float %156)
  %160 = load float, float addrspace(3)* %48, align 4, !tbaa !7
  %161 = load float, float addrspace(3)* %51, align 4, !tbaa !7
  %162 = tail call float @llvm.fmuladd.f32(float %160, float %161, float %159)
  %163 = load float, float addrspace(3)* %55, align 4, !tbaa !7
  %164 = load float, float addrspace(3)* %58, align 4, !tbaa !7
  %165 = tail call float @llvm.fmuladd.f32(float %163, float %164, float %162)
  %166 = load float, float addrspace(3)* %62, align 4, !tbaa !7
  %167 = load float, float addrspace(3)* %65, align 4, !tbaa !7
  %168 = tail call float @llvm.fmuladd.f32(float %166, float %167, float %165)
  %169 = load float, float addrspace(3)* %69, align 4, !tbaa !7
  %170 = load float, float addrspace(3)* %72, align 4, !tbaa !7
  %171 = tail call float @llvm.fmuladd.f32(float %169, float %170, float %168)
  %172 = load float, float addrspace(3)* %76, align 4, !tbaa !7
  %173 = load float, float addrspace(3)* %79, align 4, !tbaa !7
  %174 = tail call float @llvm.fmuladd.f32(float %172, float %173, float %171)
  %175 = load float, float addrspace(3)* %83, align 4, !tbaa !7
  %176 = load float, float addrspace(3)* %86, align 4, !tbaa !7
  %177 = tail call float @llvm.fmuladd.f32(float %175, float %176, float %174)
  %178 = load float, float addrspace(3)* %90, align 4, !tbaa !7
  %179 = load float, float addrspace(3)* %93, align 4, !tbaa !7
  %180 = tail call float @llvm.fmuladd.f32(float %178, float %179, float %177)
  %181 = load float, float addrspace(3)* %97, align 4, !tbaa !7
  %182 = load float, float addrspace(3)* %100, align 4, !tbaa !7
  %183 = tail call float @llvm.fmuladd.f32(float %181, float %182, float %180)
  %184 = load float, float addrspace(3)* %104, align 4, !tbaa !7
  %185 = load float, float addrspace(3)* %107, align 4, !tbaa !7
  %186 = tail call float @llvm.fmuladd.f32(float %184, float %185, float %183)
  %187 = load float, float addrspace(3)* %111, align 4, !tbaa !7
  %188 = load float, float addrspace(3)* %114, align 4, !tbaa !7
  %189 = tail call float @llvm.fmuladd.f32(float %187, float %188, float %186)
  %190 = load float, float addrspace(3)* %118, align 4, !tbaa !7
  %191 = load float, float addrspace(3)* %121, align 4, !tbaa !7
  %192 = tail call float @llvm.fmuladd.f32(float %190, float %191, float %189)
  %193 = load float, float addrspace(3)* %125, align 4, !tbaa !7
  %194 = load float, float addrspace(3)* %128, align 4, !tbaa !7
  %195 = tail call float @llvm.fmuladd.f32(float %193, float %194, float %192)
  %196 = load float, float addrspace(3)* %132, align 4, !tbaa !7
  %197 = load float, float addrspace(3)* %135, align 4, !tbaa !7
  %198 = tail call float @llvm.fmuladd.f32(float %196, float %197, float %195)
  tail call void @_Z7barrierj(i32 1) #5
  %199 = add nsw i32 %140, 8192
  %200 = add nuw nsw i32 %138, 16
  %201 = add nuw nsw i32 %139, 1
  %202 = icmp eq i32 %201, 32
  br i1 %202, label %203, label %136

; <label>:203:                                    ; preds = %136
  %204 = trunc i64 %5 to i32
  %205 = trunc i64 %6 to i32
  %206 = shl i32 %204, 9
  %207 = add nsw i32 %206, %205
  %208 = sext i32 %207 to i64
  %209 = getelementptr inbounds float, float addrspace(1)* %1, i64 %208
  store float %198, float addrspace(1)* %209, align 4, !tbaa !7
  ret void
}

; Function Attrs: nounwind readnone
declare i64 @_Z13get_global_idj(i32) local_unnamed_addr #1

; Function Attrs: nounwind readnone
declare i64 @_Z12get_group_idj(i32) local_unnamed_addr #1

; Function Attrs: nounwind readnone
declare i64 @_Z12get_local_idj(i32) local_unnamed_addr #1

; Function Attrs: convergent
declare void @_Z7barrierj(i32) local_unnamed_addr #2

; Function Attrs: nounwind readnone speculatable
declare float @llvm.fmuladd.f32(float, float, float) #3

attributes #0 = { noinline nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-features"="-satom" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-features"="-satom" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { convergent "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-features"="-satom" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readnone speculatable }
attributes #4 = { nounwind readnone }
attributes #5 = { convergent nounwind }

!nvvm.annotations = !{!0}
!llvm.module.flags = !{!1}
!llvm.ident = !{!2}

!0 = !{void (i32, float addrspace(1)*, float addrspace(1)*, float addrspace(1)*)* @k_gen_cl_gemm_v1_, !"kernel", i32 1}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{!"clang version 5.0.0 (git@github.com:krocki/clang.git 088eaf5b7b121f70b2fe6b4328b7d8819c9f2aab) (git@github.com:krocki/llvm.git 7bfd7c00d76359356c3572222f33b03931972c9f)"}
!3 = !{i32 0, i32 1, i32 1, i32 1}
!4 = !{!"none", !"none", !"none", !"none"}
!5 = !{!"int", !"float*", !"float*", !"float*"}
!6 = !{!"", !"restrict", !"restrict const", !"restrict const"}
!7 = !{!8, !8, i64 0}
!8 = !{!"float", !9, i64 0}
!9 = !{!"omnipotent char", !10, i64 0}
!10 = !{!"Simple C/C++ TBAA"}
