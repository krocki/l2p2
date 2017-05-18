// ../include/gen/templates/cl_copy_gmem_v3.tt
//__attribute__((vec_type_hint(float)))
// N_L_W_G_S_I_TV
__kernel void k_gen_120_6_20_120_120_1_float_cl_copy_gmem_v3 (
    __global float * restrict out,
    __global const float * restrict in) {

	#if 1>1
	#pragma unroll 1
	#endif
	#if 1>1
	for (int i = 0; i < 1; i++) {
	#endif
	#if 1>1
		out[get_global_id (0)+i*120] = in[get_global_id (0)+i*120];
	#elif 1>0
		out[get_global_id (0)] = in[get_global_id (0)];
	#else
		//nothing
	#endif
	#if 1>1
	}
	#endif

}
// EOF ../include/gen/templates/cl_copy_gmem_v3.tt