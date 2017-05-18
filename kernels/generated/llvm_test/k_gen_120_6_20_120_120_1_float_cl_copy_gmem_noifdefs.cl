// ../include/gen/templates/cl_copy_gmem.tt
//__attribute__((vec_type_hint(float)))
// N_L_W_G_S_I_TV
__kernel void k_gen_120_6_20_120_120_1_float_cl_copy_gmem (
    __global float * restrict out,
    __global const float * restrict in) {

	int gid = get_global_id (0);

#pragma unroll 1

	for (; gid < 120; gid += 120) {


		out[gid] = in[gid];

	}


}
// EOF ../include/gen/templates/cl_copy_gmem.tt
