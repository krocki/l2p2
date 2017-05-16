// ../include/gen/templates/fmads.tt
__kernel void cl_flops (
    __global float * restrict out,
    __global const float * restrict in,
    const int iters) {

	const int _STRIDE_ = get_global_size(0);
	const int _ITERS_ = iters;

	int _GID_ = get_global_id (0);

	for (int i = 0; i < _ITERS_; i++) {

		float x, y, z, w;

		x = in[_GID_];
		y = _GID_;
		w = out[_GID_];
		z = _GID_;

#define K_ITERS 512
		//fmads, K_ITERS * 4 flops
#pragma unroll K_ITERS
		for (int k = 0; k < K_ITERS; k++) {
			// mad(a,b,c) = a * b + c
			x = mad(x, y, x); y = mad(y, x, y);
			w = mad(w, z, w); z = mad(z, w, z);
			x = mad(x, y, x); y = mad(y, x, y);
			w = mad(w, z, w); z = mad(z, w, z);
			x = mad(x, y, x); y = mad(y, x, y);
			w = mad(w, z, w); z = mad(z, w, z);
			x = mad(x, y, x); y = mad(y, x, y);
			w = mad(w, z, w); z = mad(z, w, z);

		}

		out[_GID_] = y + z;
		_GID_ += _STRIDE_;
	}
}
// EOF ../include/gen/templates/fmads.tt

// ../include/gen/templates/fmads.tt
__kernel void cl_flops4 (
    __global float4 * restrict out,
    __global const float4 * restrict in,
    const int iters) {

	const int _STRIDE_ = get_global_size(0);
	const int _ITERS_ = iters / 4;

	int _GID_ = get_global_id (0);

	for (int i = 0; i < _ITERS_; i++) {

		float4 x, y, w, z;

		x = in[_GID_];
		y = _GID_;
		w = out[_GID_];
		z = _GID_;

#define K_ITERS 512
		//fmads, K_ITERS * 16 flops
#pragma unroll K_ITERS
		for (int k = 0; k < K_ITERS; k++) {
			// mad(a,b,c) = a * b + c
			x = mad(x, y, x); y = mad(y, x, y);
			w = mad(w, z, w); z = mad(z, w, z);
			x = mad(x, y, x); y = mad(y, x, y);
			w = mad(w, z, w); z = mad(z, w, z);
			x = mad(x, y, x); y = mad(y, x, y);
			w = mad(w, z, w); z = mad(z, w, z);
			x = mad(x, y, x); y = mad(y, x, y);
			w = mad(w, z, w); z = mad(z, w, z);
		}

		out[_GID_] = y + z;
		_GID_ += _STRIDE_;
	}
}
// EOF ../include/gen/templates/fmads.tt

// ../include/gen/templates/fmads.tt
__kernel void cl_flops2 (
    __global float2 * restrict out,
    __global const float2 * restrict in,
    const int iters) {

	const int _STRIDE_ = get_global_size(0);
	const int _ITERS_ = iters / 2;

	int _GID_ = get_global_id (0);

	for (int i = 0; i < _ITERS_; i++) {

		float2 x, y, w, z;

		x = in[_GID_];
		y = _GID_;
		w = out[_GID_];
		z = _GID_;

#define K_ITERS 512
		//fmads, K_ITERS * 16 flops
#pragma unroll K_ITERS
		for (int k = 0; k < K_ITERS; k++) {
			// mad(a,b,c) = a * b + c
			x = mad(x, y, x); y = mad(y, x, y);
			w = mad(w, z, w); z = mad(z, w, z);
			x = mad(x, y, x); y = mad(y, x, y);
			w = mad(w, z, w); z = mad(z, w, z);
			x = mad(x, y, x); y = mad(y, x, y);
			w = mad(w, z, w); z = mad(z, w, z);
			x = mad(x, y, x); y = mad(y, x, y);
			w = mad(w, z, w); z = mad(z, w, z);
		}

		out[_GID_] = y + z;
		_GID_ += _STRIDE_;
	}
}
// EOF ../include/gen/templates/fmads.tt