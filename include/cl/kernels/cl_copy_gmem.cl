// ../include/gen/templates/cl_copy_gmem.tt
//__attribute__((vec_type_hint(float8)))
__kernel void k_gen_18144_18_324_18_7_float8_cl_copy_gmem (
    __global float8 * restrict out,
    __global const float8 * restrict in) {

#if 7>0
	int gid = get_global_id (0);
#endif

#if 7>1
#pragma unroll 7
#endif
#if 7>1
	for (; gid < 18144; gid += 324) {
#endif
#if 7>0
		printf("%d\n", gid);
		out[gid] = in[gid];
#endif
#if 7>1
	}
#endif

}
// EOF ../include/gen/templates/cl_copy_gmem.tt
