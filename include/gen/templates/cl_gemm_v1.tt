// blocked matmul
// based on https://github.com/HandsOnOpenCL/Exercises-Solutions/blob/master/Solutions/Exercise08/C_block_form.cl

#define blksz 16
#define O 512

__kernel void k_gen_cl_gemm_v1_(const int N, __global float* restrict C, const __global float* restrict A, const __global float* restrict B) {

	int kloc, Kblk;

	__local float Awrk[blksz * blksz];
	__local float Bwrk[blksz * blksz];

	// The number of blocks are the same in each dimension
	const int Num_BLK = O / blksz;

	const int i = get_global_id(0);
	const int j = get_global_id(1);
	
	// Element C(i,j) is in block C(Iblk,Jblk)
	const int Iblk = get_group_id(0);
	const int Jblk = get_group_id(1);

	// C(i,j) is element C(iloc, jloc) of block C(Iblk, Jblk)
	const int iloc = get_local_id(0);
	const int jloc = get_local_id(1);

	// Setup the upper-left-corner (base address) for the A and
	// B blocks plus the increments to advance base addresses as
	// we loop over blocks
	int Abase = Jblk * blksz;
	const int Ainc  = blksz * O;

	int Bbase = Iblk * O * blksz;
	const int Binc  = blksz;

	float Ctmp = 0.0f;

	// C(Iblk,Jblk) = (sum over Kblk) A(Iblk,Kblk)*B(Kblk,Jblk)
	for (Kblk = 0;  Kblk < Num_BLK;  Kblk++) {

		// Load A(Iblk,Kblk) and B(Kblk,Jblk) into local memory.
		// Each work-item loads a single element of the two blocks
		// which are shared with the entire work-group.

		Awrk[iloc * blksz + jloc] = A[Abase + iloc * O + jloc];
		Bwrk[iloc * blksz + jloc] = B[Bbase + iloc * O + jloc];

		barrier(CLK_LOCAL_MEM_FENCE);

		// Compute dot products over local blocks to find
		// the contribution to C(i,j) from this block
		#pragma unroll
		for (kloc = 0; kloc < blksz; kloc++)
			Ctmp += Awrk[kloc * blksz + jloc] * Bwrk[iloc * blksz + kloc];

		barrier(CLK_LOCAL_MEM_FENCE);
		Abase += Ainc;
		Bbase += Binc;
	}

	// update global C matrix
	C[i * O + j] = Ctmp;

}

// __kernel void mmul(
//  const int N,
//  __global float* A,
//  __global float* B,
//  __global float* C)
// {
//  int k, j;
//  int i = get_global_id(0);
//  float tmp;
//  if (i < N) {
//      for (j = 0; j < N; j++) {
//          tmp = 0.0;
//          for (k = 0; k < N; k++)
//              tmp += A[i*N+k] * B[k*N+j];
//          C[i*N+j] = tmp;
//      }
//  }
// }
