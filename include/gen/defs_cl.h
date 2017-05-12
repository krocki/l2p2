/*
* @Author: Kamil Rocki
* @Date:   2017-05-11 11:50:15
* @Last Modified by:   Kamil Rocki
* @Last Modified time: 2017-05-11 12:24:13
*/

#include <gen/defs.h>

code_t defs_cl =
    R"(
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
)";