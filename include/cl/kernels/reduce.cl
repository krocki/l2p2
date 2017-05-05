#pragma OPENCL EXTENSION cl_khr_global_int32_base_atomics : enable
#pragma OPENCL EXTENSION cl_khr_local_int32_base_atomics : enable

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

#ifndef REDUCTION_WORKGROUP_SIZE
#define REDUCTION_WORKGROUP_SIZE 64
#endif

#ifndef ELEMENTWISE_LOCAL_SIZE
#define ELEMENTWISE_LOCAL_SIZE 128
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
		newVal.floatVal = max(prevVal.floatVal, operand);
	} while (atomic_cmpxchg((volatile __global unsigned int *)source, prevVal.intVal, newVal.intVal) != prevVal.intVal);
}

//TODO: test, try changing localsize1, localsize2
//local reduction + atomic global reduction
//larger REDUCTION_WORKGROUP_SIZE means fewer atomic ops
#define REDUCTION_BODY(initval, localsize1, localsize2, out) { \
						__local float maxlm[(localsize1)]; \
						\
						while (id < n) { \
							float x = xgm[id]; \
							if (x >= maxval) { \
								maxval = x; \
							} \
							id += (localsize1) * num_groups; \
						} \
						maxlm[lid] = maxval; \
						barrier(CLK_LOCAL_MEM_FENCE); \
					  	for (int s=(localsize1)/2; s>0; s=s>>1) { \
					    	if (lid <= s) { \
					      		if (maxlm[lid + s] >= maxlm[lid]) { \
					        		maxlm[lid] = maxlm[lid + s]; \
					      		} \
					    	} \
					    	barrier(CLK_LOCAL_MEM_FENCE); \
					    	\
					  	} \
						if (lid == 0) { \
							AtomicMax(&out[0], maxlm[0]); \
						} \
			\
		}


__kernel void max_coeff (__global float * restrict y, __global float * restrict xgm, const unsigned int n, __global float * restrict scratchbuf) {

	const unsigned int lid = get_local_id(0);
	const unsigned int wgid = get_group_id(0);
	unsigned int id = wgid * REDUCTION_WORKGROUP_SIZE + lid; //get_global_id(0);
	const unsigned int num_groups = get_num_groups(0);

	float maxval = SMALLEST;

	REDUCTION_BODY(maxval, REDUCTION_WORKGROUP_SIZE, WGS2, y)


}