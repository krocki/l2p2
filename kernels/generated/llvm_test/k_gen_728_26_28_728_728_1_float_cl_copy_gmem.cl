// ../include/gen/templates/cl_copy_gmem.tt
//__attribute__((vec_type_hint(float)))
// N_L_W_G_S_I_TV
__kernel void k_gen_728_26_28_728_728_1_float_cl_copy_gmem (
    __global float * restrict out,
    __global const float * restrict in) {

    #if 1>0
    int gid = get_global_id (0);
    #endif

	#if 1>1
	#pragma unroll 1
	#endif
	#if 1>1
	for (; gid < 728; gid += 728) {
	#endif
	#if 1>0
		out[gid] = in[gid];
	#endif
	#if 1>1
	}
	#endif

}
// EOF ../include/gen/templates/cl_copy_gmem.tt