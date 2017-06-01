// blocked matmul
// based on https://github.com/HandsOnOpenCL/Exercises-Solutions/blob/master/Solutions/Exercise08/C_block_form.cl

typedef float float4 __attribute__((ext_vector_type(4)));

// #define LOAD4(s,i) vload4((size_t)(i), (__global const float*) (s))
// #define STORE4(s,i,v) vstore4((v), (size_t)(i), (__global float*) (s))

#define MAD(a,b,c) ((c) + (a) * (b))

// #define MAD(a,b,c) mad(a,b,c)

// k_gen_ORDER_BLKSIZE_cl_gemm
__kernel void k_gen_4_4_cl_gemm_v3_(__global float4* restrict Z, const __global float4* restrict X, const __global float4* restrict Y) {

	// const int gid = get_global_id(0);
	// const int lid = get_local_id(0);
	// const int wid = get_global_id(1);

	float4 x[4];
	float4 y[4];
	float4 z[4];

	x[0] = X[0];
	x[1] = X[1];
	x[2] = X[2];
	x[3] = X[3];

	y[0] = Y[0];
	y[1] = Y[1];
	y[2] = Y[2];
	y[3] = Y[3];

	z[0] = 0.0f;
	z[1] = 0.0f;
	z[2] = 0.0f;
	z[3] = 0.0f;

	z[0] = MAD(x[0],y[0].x,z[0]);
	z[1] += x[0] * y[1].x;
	z[2] += x[0] * y[2].x;
	z[3] += x[0] * y[3].x;

	z[0] += x[1] * y[0].y;
	z[1] += x[1] * y[1].y;
	z[2] += x[1] * y[2].y;
	z[3] += x[1] * y[3].y;

	z[0] += x[2] * y[0].z;
	z[1] += x[2] * y[1].z;
	z[2] += x[2] * y[2].z;
	z[3] += x[2] * y[3].z;

	z[0] += x[3] * y[0].w;
	z[1] += x[3] * y[1].w;
	z[2] += x[3] * y[2].w;
	z[3] += x[3] * y[3].w;

	Z[0] = z[0];
	Z[1] = z[1];
	Z[2] = z[2];
	Z[3] = z[3];

}