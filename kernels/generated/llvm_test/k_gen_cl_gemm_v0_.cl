__kernel void k_gen_cl_gemm_v0_(const int N, __global float* C, __global float* A, __global float* B) {

	const int i = get_global_id(0);
	const int j = get_global_id(1);
	const int n = get_global_size(0);

	float tmp = 0.0f;

	for (int k = 0; k < n; k++)
		tmp += A[k * n + j] * B[i * n + k];

	C[i * n + j] = tmp;

}