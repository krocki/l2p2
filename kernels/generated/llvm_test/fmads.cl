__kernel void k_gen_float_fmads (
    __global float * restrict out,
    __global const float * restrict in) {

	int gid = get_global_id (0);
	float x, y, z, w;

	x = in[gid];
	y = in[gid] * 3.14f;
	w = out[gid];
	z = out[gid] * 6.1243f;

	// mad(a,b,c) = a * b + c
	x = mad(x, y, x); y = mad(y, x, y);
	w = mad(w, z, w); z = mad(z, w, z);
		
	out[gid] = y + z;

}