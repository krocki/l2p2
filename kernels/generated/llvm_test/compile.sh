FILES_CL=*.cl
FILES_C=*.c
FILES_C_OMP=*.omp.c

#WHICH_CLANG=/Users/kmrocki/git/build-clang/llvm/build/usr/local/bin/clang
#default
WHICH_CLANG=clang

CL_FLAGS="-Xclang -finclude-default-header -S -emit-llvm"
#-cl-std=CL2.0 -cl-single-precision-constant

# LLVM has two vectorizers: The Loop Vectorizer, which operates on Loops, and the SLP Vectorizer. These vectorizers focus on different optimization opportunities and use different techniques. The SLP vectorizer merges multiple scalars that are found in the code into vectors while the Loop Vectorizer widens instructions in loops to operate on multiple consecutive iterations.

C_FLAGS="-S -emit-llvm"
#-mllvm -force-vector-width=8 -loop-vectorize -force-vector-width=8 -fslp-vectorize-aggressive

OMP_FLAGS=-fopenmp


for f0 in $FILES_CL
do
	$WHICH_CLANG $CL_FLAGS -o $f0.ll $f0
	$WHICH_CLANG $CL_FLAGS -O3 -o $f0.o3.ll $f0
	$WHICH_CLANG $CL_FLAGS -target nvptx64-unknown-unknown -o $f0.nvptx.ll $f0
	$WHICH_CLANG $CL_FLAGS -target amdgcn-amd-amdhsa-opencl -o $f0.amdgcn.ll $f0
	$WHICH_CLANG $CL_FLAGS -target spir-unknown-unknown -o $f0.spir.ll $f0
	$WHICH_CLANG $CL_FLAGS -target spir64-unknown-unknown -o $f0.spir64.ll $f0
	$WHICH_CLANG $CL_FLAGS -target x86_64-unknown-MacOSX -o $f0.x86_64.osx.ll $f0
	$WHICH_CLANG $CL_FLAGS -target x86_64-unknown-Linux -o $f0.x86_64.linux.ll $f0

done

for f1 in $FILES_C
do
	$WHICH_CLANG $C_FLAGS -o $f1.ll $f1
	$WHICH_CLANG $C_FLAGS -O3 -o $f1.o3.ll $f1
	$WHICH_CLANG $C_FLAGS -Ofast -o $f1.ofast.ll $f1
	$WHICH_CLANG $C_FLAGS -mllvm -force-vector-width=4 -fslp-vectorize-aggressive -O3 -o $f1.o3_forcevec.ll $f1
	$WHICH_CLANG $C_FLAGS -mllvm -force-vector-width=4 -fslp-vectorize-aggressive -Ofast -o $f1.ofast_forcevec.ll $f1
done

for f2 in $FILES_C_OMP
do
	$WHICH_CLANG $C_FLAGS $OMP_FLAGS -fopenmp -o $f2.omp.ll $f2
	$WHICH_CLANG $C_FLAGS $OMP_FLAGS -fopenmp -O3 -o $f2.o3.omp.ll $f2
	$WHICH_CLANG $C_FLAGS $OMP_FLAGS -fopenmp -Ofast -o $f2.ofast.omp.ll $f2
done
