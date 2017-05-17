// ../include/gen/templates/cl_copy_gmem.tt

/* raw */
/* __kernel void cl_copy_gmem (
    __global $T$$V$ * restrict out,
    __global const $T$$V$ * restrict in,
    const int iters) {

	int gid = get_global_id (0);
	const int it = $ITERS$ / $V$;

	for (int i = 0; i < it; i++) {
		out[gid] = in[gid];
		gid += $STRIDE$;
	}
}*/

/* final */


 process_tt in:
__kernel void cl_copy_gmem (
    __global $T$$V$ * restrict out,
    __global const $T$$V$ * restrict in,
    const int iters) {

	int gid = get_global_id (0);
	const int it = $ITERS$ / $V$;

	for (int i = 0; i < it; i++) {
		out[gid] = in[gid];
		gid += $STRIDE$;
	}
}
 sanitized:
__kernel void cl_copy_gmem (####newline!!!!    __global $T$$V$ * restrict out,####newline!!!!    __global const $T$$V$ * restrict in,####newline!!!!    const int iters) {####newline!!!!####newline!!!!	int gid = get_global_id (0);####newline!!!!	const int it = $ITERS$ / $V$;####newline!!!!####newline!!!!	for (int i = 0; i < it; i++) {####newline!!!!		out[gid] = in[gid];####newline!!!!		gid += $STRIDE$;####newline!!!!	}####newline!!!!}
 processed pre:
__kernel void cl_copy_gmem (####newline!!!!    __global $T$$V$ * restrict out,####newline!!!!    __global const $T$$V$ * restrict in,####newline!!!!    const int iters) {####newline!!!!####newline!!!!	int gid = get_global_id (0);####newline!!!!	const int it = $ITERS$ / $V$;####newline!!!!####newline!!!!	for (int i = 0; i < it; i++) {####newline!!!!		out[gid] = in[gid];####newline!!!!		gid += $STRIDE$;####newline!!!!	}####newline!!!!}
 processed post:
__kernel void cl_copy_gmem (
    __global $T$$V$ * restrict out,
    __global const $T$$V$ * restrict in,
    const int iters) {

	int gid = get_global_id (0);
	const int it = $ITERS$ / $V$;

	for (int i = 0; i < it; i++) {
		out[gid] = in[gid];
		gid += $STRIDE$;
	}
}

final pre:
 matchesFound 0 matches:



 matchesFound 7 matches:
pos: 395 - 402 = $STRIDE$   : $STRIDE$| pos: 270 - 272 = $V$   : $V$| pos: 260 - 266 = $ITERS$   : $ITERS$| pos: 115 - 117 = $V$   : $V$| pos: 112 - 114 = $T$   : $T$| pos: 59 - 61 = $V$   : $V$| pos: 56 - 58 = $T$   : $T$| 


__kernel void cl_copy_gmem (####newline!!!!    __global float4 * restrict out,####newline!!!!    __global const float4 * restrict in,####newline!!!!    const int iters) {####newline!!!!####newline!!!!	int gid = get_global_id (0);####newline!!!!	const int it =  / 4;####newline!!!!####newline!!!!	for (int i = 0; i < it; i++) {####newline!!!!		out[gid] = in[gid];####newline!!!!		gid += ;####newline!!!!	}####newline!!!!}



/* final post:
/* matchesFound 0 matches:



 matchesFound 7 matches:
pos: 395 - 402 = $STRIDE$   : $STRIDE$| pos: 270 - 272 = $V$   : $V$| pos: 260 - 266 = $ITERS$   : $ITERS$| pos: 115 - 117 = $V$   : $V$| pos: 112 - 114 = $T$   : $T$| pos: 59 - 61 = $V$   : $V$| pos: 56 - 58 = $T$   : $T$| 


__kernel void cl_copy_gmem (
    __global float4 * restrict out,
    __global const float4 * restrict in,
    const int iters) {

	int gid = get_global_id (0);
	const int it =  / 4;

	for (int i = 0; i < it; i++) {
		out[gid] = in[gid];
		gid += ;
	}
}
// EOF ../include/gen/templates/cl_copy_gmem.tt