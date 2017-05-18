__kernel void k_gen_8_8_8192_1024_1_float_cl_copy_gmem ( __global float * restrict out, __global const float * restrict in) {

    int gid = get_global_id (0);
	out[gid] = in[gid];

}