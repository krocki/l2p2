// ../include/gen/templates/cl_copy_gmem.tt
__kernel void cl_copy_gmem (
    __global float4 * restrict out,
    __global const float4 * restrict in,
    const int iters) {

	int gid = get_global_id (0);
	const int it = iters / 4;

	for (int i = 0; i < it; i++) {
		out[gid] = in[gid];
		gid += get_global_size(0);
	}
}
// EOF ../include/gen/templates/cl_copy_gmem.tt

// ../include/gen/templates/cl_copy_gmem_v2.tt
__kernel void cl_copy_gmem_v2 (
    __global float * restrict out,
    __global const float * restrict in,
    const int iters) {

	const int _STRIDE_ = get_global_size(0);
	const int _GID_ = get_global_id (0);
	const int _ITERS_ = iters;

	for (int i = 0; i < _ITERS_; i++) {
		out[i * _STRIDE_ + _GID_] = in[i * _STRIDE_ + _GID_];
	}
}
// EOF ../include/gen/templates/cl_copy_gmem_v2.tt