// ../include/gen/templates/cl_copy_gmem_v2.tt
//__attribute__((vec_type_hint(float)))
// N_L_W_G_S_I_TV
__kernel void k_gen_728_26_28_728_728_1_float_cl_copy_gmem_v2 (
    __global float * restrict out,
    __global const float * restrict in) {

    #if 1>0
    int gid = get_global_id (0);
    #endif

	#if 1>1
	#pragma unroll 1
	#endif
	#if 1>1
	for (int i = 0; i < 1; i++) {
	#endif
	#if 1>0
		out[gid] = in[gid];
	#endif
	#if 1>1
		gid += 728;
	}
	#endif

}
// EOF ../include/gen/templates/cl_copy_gmem_v2.tt