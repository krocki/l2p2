#if __clang__
typedef float float16 __attribute__((ext_vector_type(16)));
typedef float float8 __attribute__((ext_vector_type(8)));
typedef float float4 __attribute__((ext_vector_type(4)));
typedef float float2 __attribute__((ext_vector_type(2)));
#if $H$ > 0
__attribute__((vec_type_hint($TV$)))
#endif
#endif

// N_LX_LY_WX_WY_G_TV H_TRANS
void k_gen_1048576_1_1_4_65536_4_float4_0_1_c_map_gmem_2d_copy (
    float4 * restrict out,
    const float4 * restrict in) {

		//a simple for loop for now, for all threads, G * WY * veclength floats
		for (int gid = 0; gid < 65536 * 4; gid++) {

			out[gid] = in[gid];

		}

}