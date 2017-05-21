; ModuleID = 'k_gen_1048576_1_1_4_65536_4_float4_0_1_c_map_gmem_2d_copy.omp.c'
source_filename = "k_gen_1048576_1_1_4_65536_4_float4_0_1_c_map_gmem_2d_copy.omp.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.10.0"

%ident_t = type { i32, i32, i32, i32, i8* }

@.str = private unnamed_addr constant [23 x i8] c";unknown;unknown;0;0;;\00", align 1
@0 = private unnamed_addr constant %ident_t { i32 0, i32 2, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str, i32 0, i32 0) }, align 8
@1 = private unnamed_addr constant %ident_t { i32 0, i32 66, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str, i32 0, i32 0) }, align 8

; Function Attrs: nounwind ssp uwtable
define void @k_gen_1048576_1_1_4_65536_4_float4_0_1_c_map_gmem_2d_copy(<4 x float>* noalias, <4 x float>* noalias) local_unnamed_addr #0 {
  %3 = alloca <4 x float>*, align 8
  %4 = alloca <4 x float>*, align 8
  store <4 x float>* %0, <4 x float>** %3, align 8, !tbaa !3
  store <4 x float>* %1, <4 x float>** %4, align 8, !tbaa !3
  call void (%ident_t*, i32, void (i32*, i32*, ...)*, ...) @__kmpc_fork_call(%ident_t* nonnull @0, i32 2, void (i32*, i32*, ...)* bitcast (void (i32*, i32*, <4 x float>**, <4 x float>**)* @.omp_outlined. to void (i32*, i32*, ...)*), <4 x float>** nonnull %3, <4 x float>** nonnull %4) #2
  ret void
}

; Function Attrs: nounwind ssp uwtable
define internal void @.omp_outlined.(i32* noalias nocapture readonly, i32* noalias nocapture readnone, <4 x float>** nocapture readonly dereferenceable(8), <4 x float>** nocapture readonly dereferenceable(8)) #0 {
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = bitcast i32* %5 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %9) #2
  store i32 0, i32* %5, align 4, !tbaa !7
  %10 = bitcast i32* %6 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %10) #2
  store i32 262143, i32* %6, align 4, !tbaa !7
  %11 = bitcast i32* %7 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %11) #2
  store i32 1, i32* %7, align 4, !tbaa !7
  %12 = bitcast i32* %8 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %12) #2
  store i32 0, i32* %8, align 4, !tbaa !7
  %13 = load i32, i32* %0, align 4, !tbaa !7
  call void @__kmpc_for_static_init_4(%ident_t* nonnull @0, i32 %13, i32 34, i32* nonnull %8, i32* nonnull %5, i32* nonnull %6, i32* nonnull %7, i32 1, i32 1) #2
  %14 = load i32, i32* %6, align 4, !tbaa !7
  %15 = icmp slt i32 %14, 262143
  %16 = select i1 %15, i32 %14, i32 262143
  store i32 %16, i32* %6, align 4, !tbaa !7
  %17 = load i32, i32* %5, align 4, !tbaa !7
  %18 = icmp sgt i32 %17, %16
  br i1 %18, label %31, label %19

; <label>:19:                                     ; preds = %4
  %20 = sext i32 %17 to i64
  %21 = sext i32 %16 to i64
  br label %22

; <label>:22:                                     ; preds = %22, %19
  %23 = phi i64 [ %29, %22 ], [ %20, %19 ]
  %24 = load <4 x float>*, <4 x float>** %3, align 8, !tbaa !3
  %25 = getelementptr inbounds <4 x float>, <4 x float>* %24, i64 %23
  %26 = load <4 x float>, <4 x float>* %25, align 16, !tbaa !9
  %27 = load <4 x float>*, <4 x float>** %2, align 8, !tbaa !3
  %28 = getelementptr inbounds <4 x float>, <4 x float>* %27, i64 %23
  store <4 x float> %26, <4 x float>* %28, align 16, !tbaa !9
  %29 = add nsw i64 %23, 1
  %30 = icmp slt i64 %23, %21
  br i1 %30, label %22, label %31

; <label>:31:                                     ; preds = %22, %4
  call void @__kmpc_for_static_fini(%ident_t* nonnull @0, i32 %13) #2
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %12) #2
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %11) #2
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %10) #2
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %9) #2
  call void @__kmpc_barrier(%ident_t* nonnull @1, i32 %13) #2
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start.p0i8(i64, i8* nocapture) #1

declare void @__kmpc_for_static_init_4(%ident_t*, i32, i32, i32*, i32*, i32*, i32*, i32, i32) local_unnamed_addr

declare void @__kmpc_for_static_fini(%ident_t*, i32) local_unnamed_addr

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end.p0i8(i64, i8* nocapture) #1

declare void @__kmpc_barrier(%ident_t*, i32) local_unnamed_addr

declare void @__kmpc_fork_call(%ident_t*, i32, void (i32*, i32*, ...)*, ...) local_unnamed_addr

attributes #0 = { nounwind ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }
attributes #2 = { nounwind }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 1, !"PIC Level", i32 2}
!2 = !{!"clang version 5.0.0 (git@github.com:krocki/clang.git 088eaf5b7b121f70b2fe6b4328b7d8819c9f2aab) (git@github.com:krocki/llvm.git 7bfd7c00d76359356c3572222f33b03931972c9f)"}
!3 = !{!4, !4, i64 0}
!4 = !{!"any pointer", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C/C++ TBAA"}
!7 = !{!8, !8, i64 0}
!8 = !{!"int", !5, i64 0}
!9 = !{!5, !5, i64 0}
