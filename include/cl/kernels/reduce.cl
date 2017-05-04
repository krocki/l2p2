#define ZERO 0
#define ONE 1
#define SMALLEST -1.0e37f

#define FAST_MATH

#ifdef FAST_MATH
#define exp_function native_exp
#define log_function native_log
#define log2_function native_log2
#define sqrt_function native_sqrt
#define rsqrt_function native_rsqrt
#define powr_function native_powr
#define divide_function native_divide
#define fmad_function(a,b,c) (mad ((a), (b), (c)))
#define logistic_function(x) (native_recip ( 1.0f + native_exp ( -(x) ) ))
#else
#define exp_function exp
#define log_function log
#define log2_function log2
#define sqrt_function sqrt
#define rsqrt_function rsqrt
#define powr_function powr
#define divide_function divide
#define fmad_function(a,b,c) ((c) + (a) * (b))
#define logistic_function(x) (1.0f / ( 1.0f + exp ( -(x) ) ))
#endif

#ifndef REDUCTION_1_LOCAL_SIZE
#define REDUCTION_1_LOCAL_SIZE 64     // The local work-group size of the main kernel
#endif
#ifndef REDUCTION_2_LOCAL_SIZE
#define REDUCTION_2_LOCAL_SIZE 64     // The local work-group size of the epilogue kernel
#endif
#ifndef ELEMENTWISE_LOCAL_SIZE
#define ELEMENTWISE_LOCAL_SIZE 64
#endif

//TODO: test, try changing localsize1, localsize2
#define REDUCTION_BODY(initval, localsize1, localsize2, tempbuf, out) { \
						__local float maxlm[(localsize1)]; \
						__local float maxgm[(localsize2)]; \
						maxlm[lid] = xgm[id]; \
						barrier(CLK_LOCAL_MEM_FENCE); \
						for (unsigned int s = (localsize1) / 2; s > 0; s = s / 2) { \
							if (lid < s && (id+s) < n) { \
							maxlm[lid] = fmax(maxlm[lid + s], maxlm[lid]); \
							barrier(CLK_LOCAL_MEM_FENCE); \
							} \
						} \
						if (lid == 0) { \
							tempbuf[id] = maxlm[lid]; \
						} \
						barrier(CLK_GLOBAL_MEM_FENCE); \
						maxgm[0] = maxlm[0]; \
						if (n > (localsize1)) { \
							int iters = num_groups / (localsize2); \
							if (id < localsize2) { \
								for (int ii = 0; ii <= iters; ii++) { \
									unsigned int memloc = (lid + (ii * (localsize2))) * (localsize1); \
									if (memloc < n) { \
										float gval = tempbuf[memloc]; \
										maxgm[lid] = ii == 0 ? gval : fmax(maxgm[lid], gval); \
										barrier(CLK_LOCAL_MEM_FENCE); \
									} \
								} \
								for (int s = (localsize2) / 2; s > 0; s = s >> 1) { \
									if (lid < s && (id+s) < n) { \
										if (lid < num_groups && (id+s) < num_groups) { \
										maxgm[lid] = fmax(maxgm[lid + s], maxgm[lid]); \
										} \
										barrier(CLK_LOCAL_MEM_FENCE); \
									} \
								} \
							} \
						} \
						if (id == 0) { tempbuf[0] = maxgm[0]; } \
						barrier(CLK_GLOBAL_MEM_FENCE); \
						(out) = tempbuf[0]; \
		}


__kernel void max_coeff (__global float * restrict y, __global float * restrict xgm, const unsigned int n, __global float * restrict scratchbuf) {

	const unsigned int lid = get_local_id(0);
	const unsigned int id = get_global_id(0);
	const unsigned int wgid = get_group_id(0);
	const unsigned int num_groups = get_num_groups(0);

	float maxval = SMALLEST;

	if (id < n) {

		REDUCTION_BODY(maxval, REDUCTION_1_LOCAL_SIZE, REDUCTION_2_LOCAL_SIZE, scratchbuf, maxval)

	}

	if (id == 0) { y[0] = maxval; }

}