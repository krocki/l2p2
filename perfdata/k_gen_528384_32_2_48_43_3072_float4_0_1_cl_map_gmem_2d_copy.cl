#if 0 > 0
__attribute__((vec_type_hint(float4)))
#endif
// N_LX_LY_WX_WY_G_TV H_TRANS
__kernel void k_gen_528384_32_2_48_43_3072_float4_0_1_cl_map_gmem_2d_copy (
    __global float4 * restrict out,
    __global const float4 * restrict in) {

#if 1
	int gid = get_global_id(1) * get_global_size(0) + get_global_id(0);
#else
	int gid = get_global_id(0) * get_global_size(1) + get_global_id(1);
#endif

	out[gid] = in[gid];

}
