#if __clang__
typedef float float16 __attribute__((ext_vector_type(16)));
typedef float float8 __attribute__((ext_vector_type(8)));
typedef float float4 __attribute__((ext_vector_type(4)));
typedef float float2 __attribute__((ext_vector_type(2)));
#if $H$ > 0
__attribute__((vec_type_hint($TV$)))
#endif
#endif

// #pragma omp simd, #pragma omp for simd, #pragma omp parallel for simd directives, extended set of atomic constructs, proc_bind clause for all parallel-based directives, depend clause for #pragma omp task directive (except for array sections), #pragma omp cancel and #pragma omp cancellation point directives, and #pragma omp taskgroup

#define NUM_THREADS 16
// N_LX_LY_WX_WY_G_TV H_TRANS
void k_gen_1048576_1_1_4_65536_4_float4_0_1_c_map_gmem_2d_copy (
    float4 * restrict out,
    const float4 * restrict in) {

	//a simple for loop for now, for all threads, G * WY * veclength floats
	#pragma omp parallel for simd schedule(static) num_threads(NUM_THREADS)
	for (int gid = 0; gid < 65536 * 4; gid++) {

		out[gid] = in[gid];

	}


}