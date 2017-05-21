#if 0 > 0
__attribute__((vec_type_hint(float)))
#endif
// N_LX_LY_WX_WY_G_TV H_TRANS
__kernel void k_gen_1053696_128_1_168_49_21504_float_0_0_cl_permute_gmem_2d_copy (
    __global float * restrict out,
    __global const int * restrict idxs,
    __global const float * restrict in) {

	#if 0
		int gid = get_global_id(1) * get_global_size(0) + get_global_id(0);
	#else
		int gid = get_global_id(0) * get_global_size(1) + get_global_id(1);
	#endif

	// in - size M
	// idxs - size N
	// out - size N

//#if PULL
out[gid] = in[idxs[gid]];
//#endif
//#if PUSH
out[idxs[gid]] = in[gid];
//#endif
}