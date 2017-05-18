// ../include/gen/templates/cl_copy_gmem.tt
//__attribute__((vec_type_hint(float)))
// N_L_W_G_S_I_TV
__kernel void k_gen_2160_36_10_360_2160_6_float_cl_copy_gmem (
    __global float * restrict out,
    __global const float * restrict in) {


	for (int gid = get_global_id (0); gid < 2160; gid += 360) {

		out[gid] = in[gid];

	}


}
// EOF ../include/gen/templates/cl_copy_gmem.tt
