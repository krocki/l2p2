#pragma OPENCL EXTENSION cl_khr_global_int32_base_atomics : enable
#pragma OPENCL EXTENSION cl_khr_local_int32_base_atomics : enable

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

//Function to perform the atomic max
inline void AtomicMax(volatile __global float *source, const float operand) {
	union {
		unsigned int intVal;
		float floatVal;
	} newVal;
	union {
		unsigned int intVal;
		float floatVal;
	} prevVal;
	do {
		prevVal.floatVal = *source;
		newVal.floatVal = fmax(prevVal.floatVal, operand);
	} while (atomic_cmpxchg((volatile __global unsigned int *)source, prevVal.intVal, newVal.intVal) != prevVal.intVal);
}

//fixed 128 for now
//#define GROUP_SIZE 128
// manual unroll
#define REDUCTION_BODY_v3(out) { \
						\
						float maxval = out[0]; \
						\
						while (id < n) { \
							float x = xgm[id]; \
							if (x >= maxval) { \
								maxval = x; \
							} \
							id += wsize * num_groups; \
						} \
						maxlm[lid] = maxval; \
						barrier(CLK_LOCAL_MEM_FENCE); \
						if (lid < 64) { maxlm[lid] = fmax(maxlm[lid], maxlm[lid + 64]); } \
						barrier(CLK_LOCAL_MEM_FENCE); \
						if (lid < 32) { maxlm[lid] = fmax(maxlm[lid], maxlm[lid + 32]); } \
						barrier(CLK_LOCAL_MEM_FENCE); \
						if (lid < 16) { maxlm[lid] = fmax(maxlm[lid], maxlm[lid + 16]); } \
						barrier(CLK_LOCAL_MEM_FENCE); \
						if (lid < 8) { maxlm[lid] = fmax(maxlm[lid], maxlm[lid + 8]); } \
						barrier(CLK_LOCAL_MEM_FENCE); \
						if (lid < 4) { maxlm[lid] = fmax(maxlm[lid], maxlm[lid + 4]); } \
						barrier(CLK_LOCAL_MEM_FENCE); \
						if (lid < 2) { maxlm[lid] = fmax(maxlm[lid], maxlm[lid + 2]); } \
						barrier(CLK_LOCAL_MEM_FENCE); \
						if (lid < 1) { maxlm[lid] = fmax(maxlm[lid], maxlm[lid + 1]); } \
						barrier(CLK_LOCAL_MEM_FENCE); \
						\
						if (lid == 0) { \
							AtomicMax(&out[0], maxlm[0]); \
						} \
			\
		}

//TODO: there's something wrong when size is 3 x 17

//TODO: test, try changing localsize1, localsize2
//local reduction + atomic global reduction
//larger REDUCTION_WORKGROUP_SIZE means fewer atomic ops
#define REDUCTION_BODY_v1(out) { \
						\
						float maxval = out[0]; \
						\
						for (int i = 0; i < iters; i++) { \
							float x = id < n ? xgm[id] : out[0]; \
							maxval = fmax(maxval, x); \
							id += gsize; \
						} \
						maxlm[lid] = maxval; \
						barrier(CLK_LOCAL_MEM_FENCE); \
					  	for (int s=wsize/2; s>0; s=s>>1) { \
					    	if (lid < s) { \
								maxlm[lid] = fmax(maxlm[lid + s], maxlm[lid]); \
					    	} \
					    	barrier(CLK_LOCAL_MEM_FENCE); \
					    	\
					  	} \
						if (lid == 0) { \
							AtomicMax(&out[0], maxlm[0]); \
						} \
			\
		}

__kernel void max_coeff (__global float * restrict y, __global float * restrict xgm, const unsigned int n, __local float *maxlm) {

	const unsigned int lid = get_local_id(0);
	const unsigned int wgid = get_group_id(0);
	const unsigned int wsize = get_local_size (0);
	const unsigned int gsize = get_global_size (0);
	unsigned int id = wgid * wsize + lid; //get_global_id(0);
	const unsigned int num_groups = get_num_groups(0);
	const unsigned int iters = ((n - 1) / gsize) + 1;

	REDUCTION_BODY_v1(y)

}
