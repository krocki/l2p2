; ModuleID = 'k_gen_cl_gemm_v1_.cl'
source_filename = "k_gen_cl_gemm_v1_.cl"
target datalayout = "e-p:32:32-p1:64:64-p2:64:64-p3:32:32-p4:64:64-p5:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64"
target triple = "amdgcn-amd-amdhsa-opencl"

@k_gen_cl_gemm_v1_.Awrk = internal unnamed_addr addrspace(3) global [256 x float] undef, align 4
@k_gen_cl_gemm_v1_.Bwrk = internal unnamed_addr addrspace(3) global [256 x float] undef, align 4

; Function Attrs: nounwind
define amdgpu_kernel void @k_gen_cl_gemm_v1_(i32, float addrspace(1)* noalias nocapture, float addrspace(1)* noalias nocapture readonly, float addrspace(1)* noalias nocapture readonly) local_unnamed_addr #0 !kernel_arg_addr_space !3 !kernel_arg_access_qual !4 !kernel_arg_type !5 !kernel_arg_base_type !5 !kernel_arg_type_qual !6 {
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
  %21 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i32 0, i32 %20
  %22 = bitcast float addrspace(3)* %21 to i32 addrspace(3)*
  %23 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i32 0, i32 %20
  %24 = bitcast float addrspace(3)* %23 to i32 addrspace(3)*
  %25 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i32 0, i32 %14
  %26 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i32 0, i32 %19
  %27 = add nsw i32 %14, 16
  %28 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i32 0, i32 %27
  %29 = or i32 %19, 1
  %30 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i32 0, i32 %29
  %31 = add nsw i32 %14, 32
  %32 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i32 0, i32 %31
  %33 = or i32 %19, 2
  %34 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i32 0, i32 %33
  %35 = add nsw i32 %14, 48
  %36 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i32 0, i32 %35
  %37 = or i32 %19, 3
  %38 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i32 0, i32 %37
  %39 = add nsw i32 %14, 64
  %40 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i32 0, i32 %39
  %41 = or i32 %19, 4
  %42 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i32 0, i32 %41
  %43 = add nsw i32 %14, 80
  %44 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i32 0, i32 %43
  %45 = or i32 %19, 5
  %46 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i32 0, i32 %45
  %47 = add nsw i32 %14, 96
  %48 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i32 0, i32 %47
  %49 = or i32 %19, 6
  %50 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i32 0, i32 %49
  %51 = add nsw i32 %14, 112
  %52 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i32 0, i32 %51
  %53 = or i32 %19, 7
  %54 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i32 0, i32 %53
  %55 = add nsw i32 %14, 128
  %56 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i32 0, i32 %55
  %57 = or i32 %19, 8
  %58 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i32 0, i32 %57
  %59 = add nsw i32 %14, 144
  %60 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i32 0, i32 %59
  %61 = or i32 %19, 9
  %62 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i32 0, i32 %61
  %63 = add nsw i32 %14, 160
  %64 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i32 0, i32 %63
  %65 = or i32 %19, 10
  %66 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i32 0, i32 %65
  %67 = add nsw i32 %14, 176
  %68 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i32 0, i32 %67
  %69 = or i32 %19, 11
  %70 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i32 0, i32 %69
  %71 = add nsw i32 %14, 192
  %72 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i32 0, i32 %71
  %73 = or i32 %19, 12
  %74 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i32 0, i32 %73
  %75 = add nsw i32 %14, 208
  %76 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i32 0, i32 %75
  %77 = or i32 %19, 13
  %78 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i32 0, i32 %77
  %79 = add nsw i32 %14, 224
  %80 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i32 0, i32 %79
  %81 = or i32 %19, 14
  %82 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i32 0, i32 %81
  %83 = add nsw i32 %14, 240
  %84 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Awrk, i32 0, i32 %83
  %85 = or i32 %19, 15
  %86 = getelementptr inbounds [256 x float], [256 x float] addrspace(3)* @k_gen_cl_gemm_v1_.Bwrk, i32 0, i32 %85
  br label %87

; <label>:87:                                     ; preds = %87, %4
  %88 = phi float [ 0.000000e+00, %4 ], [ %209, %87 ]
  %89 = phi i32 [ %16, %4 ], [ %211, %87 ]
  %90 = phi i32 [ 0, %4 ], [ %212, %87 ]
  %91 = phi i32 [ %15, %4 ], [ %210, %87 ]
  %92 = add i32 %18, %91
  %93 = sext i32 %92 to i64
  %94 = getelementptr inbounds float, float addrspace(1)* %2, i64 %93
  %95 = bitcast float addrspace(1)* %94 to i32 addrspace(1)*
  %96 = load i32, i32 addrspace(1)* %95, align 4, !tbaa !7
  store i32 %96, i32 addrspace(3)* %22, align 4, !tbaa !7
  %97 = add i32 %18, %89
  %98 = sext i32 %97 to i64
  %99 = getelementptr inbounds float, float addrspace(1)* %3, i64 %98
  %100 = bitcast float addrspace(1)* %99 to i32 addrspace(1)*
  %101 = load i32, i32 addrspace(1)* %100, align 4, !tbaa !7
  store i32 %101, i32 addrspace(3)* %24, align 4, !tbaa !7
  tail call void @_Z7barrierj(i32 1) #5
  %102 = load float, float addrspace(3)* %25, align 4, !tbaa !7
  %103 = load float, float addrspace(3)* %26, align 4, !tbaa !7
  %104 = tail call float @llvm.fmuladd.f32(float %102, float %103, float %88)
  %105 = load float, float addrspace(3)* %28, align 4, !tbaa !7
  %106 = load float, float addrspace(3)* %30, align 4, !tbaa !7
  %107 = tail call float @llvm.fmuladd.f32(float %105, float %106, float %104)
  %108 = load float, float addrspace(3)* %32, align 4, !tbaa !7
  %109 = load float, float addrspace(3)* %34, align 4, !tbaa !7
  %110 = tail call float @llvm.fmuladd.f32(float %108, float %109, float %107)
  %111 = load float, float addrspace(3)* %36, align 4, !tbaa !7
  %112 = load float, float addrspace(3)* %38, align 4, !tbaa !7
  %113 = tail call float @llvm.fmuladd.f32(float %111, float %112, float %110)
  %114 = load float, float addrspace(3)* %40, align 4, !tbaa !7
  %115 = load float, float addrspace(3)* %42, align 4, !tbaa !7
  %116 = tail call float @llvm.fmuladd.f32(float %114, float %115, float %113)
  %117 = load float, float addrspace(3)* %44, align 4, !tbaa !7
  %118 = load float, float addrspace(3)* %46, align 4, !tbaa !7
  %119 = tail call float @llvm.fmuladd.f32(float %117, float %118, float %116)
  %120 = load float, float addrspace(3)* %48, align 4, !tbaa !7
  %121 = load float, float addrspace(3)* %50, align 4, !tbaa !7
  %122 = tail call float @llvm.fmuladd.f32(float %120, float %121, float %119)
  %123 = load float, float addrspace(3)* %52, align 4, !tbaa !7
  %124 = load float, float addrspace(3)* %54, align 4, !tbaa !7
  %125 = tail call float @llvm.fmuladd.f32(float %123, float %124, float %122)
  %126 = load float, float addrspace(3)* %56, align 4, !tbaa !7
  %127 = load float, float addrspace(3)* %58, align 4, !tbaa !7
  %128 = tail call float @llvm.fmuladd.f32(float %126, float %127, float %125)
  %129 = load float, float addrspace(3)* %60, align 4, !tbaa !7
  %130 = load float, float addrspace(3)* %62, align 4, !tbaa !7
  %131 = tail call float @llvm.fmuladd.f32(float %129, float %130, float %128)
  %132 = load float, float addrspace(3)* %64, align 4, !tbaa !7
  %133 = load float, float addrspace(3)* %66, align 4, !tbaa !7
  %134 = tail call float @llvm.fmuladd.f32(float %132, float %133, float %131)
  %135 = load float, float addrspace(3)* %68, align 4, !tbaa !7
  %136 = load float, float addrspace(3)* %70, align 4, !tbaa !7
  %137 = tail call float @llvm.fmuladd.f32(float %135, float %136, float %134)
  %138 = load float, float addrspace(3)* %72, align 4, !tbaa !7
  %139 = load float, float addrspace(3)* %74, align 4, !tbaa !7
  %140 = tail call float @llvm.fmuladd.f32(float %138, float %139, float %137)
  %141 = load float, float addrspace(3)* %76, align 4, !tbaa !7
  %142 = load float, float addrspace(3)* %78, align 4, !tbaa !7
  %143 = tail call float @llvm.fmuladd.f32(float %141, float %142, float %140)
  %144 = load float, float addrspace(3)* %80, align 4, !tbaa !7
  %145 = load float, float addrspace(3)* %82, align 4, !tbaa !7
  %146 = tail call float @llvm.fmuladd.f32(float %144, float %145, float %143)
  %147 = load float, float addrspace(3)* %84, align 4, !tbaa !7
  %148 = load float, float addrspace(3)* %86, align 4, !tbaa !7
  %149 = tail call float @llvm.fmuladd.f32(float %147, float %148, float %146)
  tail call void @_Z7barrierj(i32 1) #5
  %150 = add nsw i32 %91, 8192
  %151 = or i32 %89, 16
  %152 = add i32 %18, %150
  %153 = sext i32 %152 to i64
  %154 = getelementptr inbounds float, float addrspace(1)* %2, i64 %153
  %155 = bitcast float addrspace(1)* %154 to i32 addrspace(1)*
  %156 = load i32, i32 addrspace(1)* %155, align 4, !tbaa !7
  store i32 %156, i32 addrspace(3)* %22, align 4, !tbaa !7
  %157 = add i32 %18, %151
  %158 = sext i32 %157 to i64
  %159 = getelementptr inbounds float, float addrspace(1)* %3, i64 %158
  %160 = bitcast float addrspace(1)* %159 to i32 addrspace(1)*
  %161 = load i32, i32 addrspace(1)* %160, align 4, !tbaa !7
  store i32 %161, i32 addrspace(3)* %24, align 4, !tbaa !7
  tail call void @_Z7barrierj(i32 1) #5
  %162 = load float, float addrspace(3)* %25, align 4, !tbaa !7
  %163 = load float, float addrspace(3)* %26, align 4, !tbaa !7
  %164 = tail call float @llvm.fmuladd.f32(float %162, float %163, float %149)
  %165 = load float, float addrspace(3)* %28, align 4, !tbaa !7
  %166 = load float, float addrspace(3)* %30, align 4, !tbaa !7
  %167 = tail call float @llvm.fmuladd.f32(float %165, float %166, float %164)
  %168 = load float, float addrspace(3)* %32, align 4, !tbaa !7
  %169 = load float, float addrspace(3)* %34, align 4, !tbaa !7
  %170 = tail call float @llvm.fmuladd.f32(float %168, float %169, float %167)
  %171 = load float, float addrspace(3)* %36, align 4, !tbaa !7
  %172 = load float, float addrspace(3)* %38, align 4, !tbaa !7
  %173 = tail call float @llvm.fmuladd.f32(float %171, float %172, float %170)
  %174 = load float, float addrspace(3)* %40, align 4, !tbaa !7
  %175 = load float, float addrspace(3)* %42, align 4, !tbaa !7
  %176 = tail call float @llvm.fmuladd.f32(float %174, float %175, float %173)
  %177 = load float, float addrspace(3)* %44, align 4, !tbaa !7
  %178 = load float, float addrspace(3)* %46, align 4, !tbaa !7
  %179 = tail call float @llvm.fmuladd.f32(float %177, float %178, float %176)
  %180 = load float, float addrspace(3)* %48, align 4, !tbaa !7
  %181 = load float, float addrspace(3)* %50, align 4, !tbaa !7
  %182 = tail call float @llvm.fmuladd.f32(float %180, float %181, float %179)
  %183 = load float, float addrspace(3)* %52, align 4, !tbaa !7
  %184 = load float, float addrspace(3)* %54, align 4, !tbaa !7
  %185 = tail call float @llvm.fmuladd.f32(float %183, float %184, float %182)
  %186 = load float, float addrspace(3)* %56, align 4, !tbaa !7
  %187 = load float, float addrspace(3)* %58, align 4, !tbaa !7
  %188 = tail call float @llvm.fmuladd.f32(float %186, float %187, float %185)
  %189 = load float, float addrspace(3)* %60, align 4, !tbaa !7
  %190 = load float, float addrspace(3)* %62, align 4, !tbaa !7
  %191 = tail call float @llvm.fmuladd.f32(float %189, float %190, float %188)
  %192 = load float, float addrspace(3)* %64, align 4, !tbaa !7
  %193 = load float, float addrspace(3)* %66, align 4, !tbaa !7
  %194 = tail call float @llvm.fmuladd.f32(float %192, float %193, float %191)
  %195 = load float, float addrspace(3)* %68, align 4, !tbaa !7
  %196 = load float, float addrspace(3)* %70, align 4, !tbaa !7
  %197 = tail call float @llvm.fmuladd.f32(float %195, float %196, float %194)
  %198 = load float, float addrspace(3)* %72, align 4, !tbaa !7
  %199 = load float, float addrspace(3)* %74, align 4, !tbaa !7
  %200 = tail call float @llvm.fmuladd.f32(float %198, float %199, float %197)
  %201 = load float, float addrspace(3)* %76, align 4, !tbaa !7
  %202 = load float, float addrspace(3)* %78, align 4, !tbaa !7
  %203 = tail call float @llvm.fmuladd.f32(float %201, float %202, float %200)
  %204 = load float, float addrspace(3)* %80, align 4, !tbaa !7
  %205 = load float, float addrspace(3)* %82, align 4, !tbaa !7
  %206 = tail call float @llvm.fmuladd.f32(float %204, float %205, float %203)
  %207 = load float, float addrspace(3)* %84, align 4, !tbaa !7
  %208 = load float, float addrspace(3)* %86, align 4, !tbaa !7
  %209 = tail call float @llvm.fmuladd.f32(float %207, float %208, float %206)
  tail call void @_Z7barrierj(i32 1) #5
  %210 = add nsw i32 %91, 16384
  %211 = add nsw i32 %89, 32
  %212 = add nsw i32 %90, 2
  %213 = icmp eq i32 %212, 32
  br i1 %213, label %214, label %87

; <label>:214:                                    ; preds = %87
  %215 = trunc i64 %5 to i32
  %216 = trunc i64 %6 to i32
  %217 = shl i32 %215, 9
  %218 = add nsw i32 %217, %216
  %219 = sext i32 %218 to i64
  %220 = getelementptr inbounds float, float addrspace(1)* %1, i64 %219
  store float %209, float addrspace(1)* %220, align 4, !tbaa !7
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

attributes #0 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-features"="+fp64-fp16-denormals,-fp32-denormals" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-features"="+fp64-fp16-denormals,-fp32-denormals" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { convergent "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-features"="+fp64-fp16-denormals,-fp32-denormals" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readnone speculatable }
attributes #4 = { nounwind readnone }
attributes #5 = { convergent nounwind }

!opencl.ocl.version = !{!0}
!llvm.module.flags = !{!1}
!llvm.ident = !{!2}

!0 = !{i32 1, i32 0}
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
