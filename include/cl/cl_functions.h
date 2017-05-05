/*
* @Author: kmrocki@us.ibm.com
* @Date:   2017-05-04 10:56:35
* @Last Modified by:   kmrocki@us.ibm.com
* @Last Modified time: 2017-05-05 14:50:28
*/

#ifndef __CL_FUNCTIONS__
#define __CL_FUNCTIONS__

#include <cl/cl_array.h>

/*__kernel void max_coeff (__global float * restrict y, __global float * restrict xgm, const unsigned int n, __global float * restrict scratchbuf) */

#define SMALLEST -1.0e37f

std::string cl_reduce (cl_array<float>& y, cl_array<float>& x, std::string reduce_op) {

	unsigned int n = x.rows() * x.cols();

	std::string cl_config_string = "";

	//which cl context to use
	cl_ctx* __ctx = x.matrix_ctx;

	if (__ctx == nullptr)
		std::cout << "cl_ctx* is null: " << __FILE__ << ", line: " << __LINE__ << std::endl;

	if (!x.prealloc_scratchpad) x.resize_scratchpad();

	float acc_val;
	if (reduce_op == "max_coeff") acc_val = SMALLEST;

	//reset the accumulator
	y.set(acc_val);

	CL_SAFE_CALL (clSetKernelArg (__ctx->cl_kernels[reduce_op], 0, sizeof (cl_mem), (void*) &y.ref_device_data) );
	CL_SAFE_CALL (clSetKernelArg (__ctx->cl_kernels[reduce_op], 1, sizeof (cl_mem), (void*) &x.ref_device_data) );
	CL_SAFE_CALL (clSetKernelArg (__ctx->cl_kernels[reduce_op], 2, sizeof (unsigned int), (void*) &n) );
	CL_SAFE_CALL (clSetKernelArg (__ctx->cl_kernels[reduce_op], 3, sizeof (cl_mem), (void*) &x.scratchBuf) );

	size_t local_work_size = __ctx->local_work_size;
	size_t num_workgroups = __ctx->num_workgroups;
	size_t global_work_size = local_work_size * num_workgroups;
	size_t internal_iterations = n / global_work_size + (((n % global_work_size) > 0) ? 1 : 0);

	// these might be used when using external tuning
	// bool fixed_global_work_size = false;
	// size_t fixed_workgroups = 64;
	// size_t fixed_local_size = 64;
	// /////////



	// if (fixed_global_work_size) { // fixed # of groups, # local_threads

	// 	// std::cout << "cl_reduce: fixed_global_work_size = true" << std::endl;
	// 	workgroups = fixed_workgroups;
	// 	local_work_size = fixed_local_size;
	// 	global_work_size = workgroups * local_work_size;
	// 	internal_iterations = n / global_work_size + 1;


	// } else { // set global_work_size = n + padding

	// 	workgroups =  (n / local_work_size) + ((n % local_work_size) > 0 ? 1 : 0);
	// 	global_work_size = workgroups * local_work_size;

	// }

	// std::cout << "cl_reduce: n = " << n << std::endl;
	// std::cout << "cl_reduce: workgroups = " << workgroups << std::endl;
	// std::cout << "cl_reduce: global work size = " << global_work_size << std::endl;
	// std::cout << "cl_reduce: local work size = " << local_work_size << std::endl;
	// std::cout << "cl_reduce: internal_iterations = " << internal_iterations << std::endl;

	cl_config_string += " n=" + std::to_string(n) + " w=" + std::to_string(num_workgroups) + " g=" + std::to_string(global_work_size) + " l=" + std::to_string(local_work_size) + " i=" + std::to_string(internal_iterations);

	std::string func_string = "cl_reduce_" + reduce_op + "_" + std::to_string(n) + "_" + std::to_string(x.rows()) + "x" + std::to_string(x.cols());

	/* Execute the kernel */
	CL_SAFE_CALL (clEnqueueNDRangeKernel (__ctx->queue(), __ctx->cl_kernels[reduce_op], 1, NULL, &global_work_size, &local_work_size, 0, NULL, &__ctx->cl_events[func_string]) );

	return cl_config_string;
}

#endif