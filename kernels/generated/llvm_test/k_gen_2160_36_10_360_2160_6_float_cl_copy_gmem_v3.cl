// ../include/gen/templates/cl_copy_gmem_v3.tt
//__attribute__((vec_type_hint(float)))
// N_L_W_G_S_I_TV
__kernel void k_gen_2160_36_10_360_2160_6_float_cl_copy_gmem_v3 (
    __global float * restrict out,
    __global const float * restrict in) {

	for (int i = 0; i < 6; i++) {
		out[get_global_id (0) + i * 360] = in[get_global_id (0) + i * 360];

	}

}
// EOF ../include/gen/templates/cl_copy_gmem_v3.tt
