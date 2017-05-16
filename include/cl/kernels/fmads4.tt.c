// ../include/gen/templates/fmads.tt
__kernel void cl_flops (
    __global float4 * restrict out,
    __global const float4 * restrict in,
    const int iters) {

	const int _STRIDE_ = get_global_size(0);
	const int _ITERS_ = iters / 4;

	int _GID_ = get_global_id (0);

	for (int i = 0; i < _ITERS_; i++) {

		float4 x, y;

		x = in[_GID_];
		y = _GID_;

#define K_ITERS 128
		//fmads, K_ITERS * 4 flops
#pragma unroll K_ITERS
		for (int k = 0; k < K_ITERS; k++) {
			mad(y, x, x); mad(x, y, y);

		}

		out[_GID_] = y;
		_GID_ += _STRIDE_;
	}
}
// EOF ../include/gen/templates/fmads.tt