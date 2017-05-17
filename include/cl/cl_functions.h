/*
* @Author: kmrocki@us.ibm.com
* @Date:   2017-05-04 10:56:35
* @Last Modified by:   Kamil Rocki
* @Last Modified time: 2017-05-16 21:57:38
*/

#ifndef __CL_FUNCTIONS__
#define __CL_FUNCTIONS__

#include <cl/cl_array.h>
#include <utils/perf.h>
#include <cl/cl_c_kernel.h>

#define SMALLEST -1.0e37f

std::string exec_cl (cl_array<float>& y, cl_array<float>& x, std::string kernel_op, size_t lsize = 0, size_t ngroups = 0, bool profiling_enabled = false) {

	unsigned int n = x.length();

	std::string cl_config_string = "";

	//which cl context to use
	cl_ctx* __ctx = x.matrix_ctx;

	if (__ctx == nullptr)
		std::cout << "cl_ctx* is null: " << __FILE__ << ", line: " << __LINE__ << std::endl;

	float acc_val = 0.0f;
	if (kernel_op == "max_coeff") {
		acc_val = SMALLEST;
		//reset the accumulator
		y.set(acc_val);
	}

	size_t local_work_size = lsize > 0 ? lsize : __ctx->local_work_size;
	size_t num_workgroups = ngroups > 0 ? ngroups : __ctx->num_workgroups;
	size_t global_work_size = local_work_size * num_workgroups;
	int internal_iterations = ((n - 1) / global_work_size) + 1;

	CL_SAFE_CALL (clSetKernelArg (__ctx->cl_kernels[kernel_op], 0, sizeof (cl_mem), (void*) &y.ref_device_data) );
	CL_SAFE_CALL (clSetKernelArg (__ctx->cl_kernels[kernel_op], 1, sizeof (cl_mem), (void*) &x.ref_device_data) );
	//CL_SAFE_CALL (clSetKernelArg (__ctx->cl_kernels[kernel_op], 2, sizeof (int), (void*) &internal_iterations) );

	cl_config_string += " n=" + std::to_string(n) + " w=" + std::to_string(num_workgroups) + " g=" + std::to_string(global_work_size) + " l=" + std::to_string(local_work_size) + " i=" + std::to_string(internal_iterations);

	std::string func_string = "cl_kernel_" + kernel_op + "_" + std::to_string(n) + "_" + std::to_string(x.rows()) + "x" + std::to_string(x.cols());

	if (profiling_enabled) {
		clWaitForEvents (1, &__ctx->cl_events[func_string]);
	}

	// /* Execute the kernel */
	CL_SAFE_CALL (clEnqueueNDRangeKernel (__ctx->queue(), __ctx->cl_kernels[kernel_op], 1, NULL, &global_work_size, &local_work_size, 0, NULL, &__ctx->cl_events[func_string]) );

	if (profiling_enabled) {

		clWaitForEvents (1, &__ctx->cl_events[func_string]);
		__ctx->barrier();

		cl_ulong time_start, time_end;
		double total_time;

		//- CL_PROFILING_COMMAND_QUEUED
		//- CL_PROFILING_COMMAND_SUBMIT
		//- CL_PROFILING_COMMAND_START
		//- CL_PROFILING_COMMAND_END

		clGetEventProfilingInfo (__ctx->cl_events[func_string], CL_PROFILING_COMMAND_START, sizeof (time_start), &time_start, NULL);
		clGetEventProfilingInfo (__ctx->cl_events[func_string], CL_PROFILING_COMMAND_END, sizeof (time_end), &time_end, NULL);
		total_time = time_end - time_start;

		// std::cout << kernel_op << std::endl;
		// std::cout << x.length() * sizeof(float) << std::endl;
		// std::cout << y.length() * sizeof(float) << std::endl;

		// std::cout << kernel_op << std::endl;

		pdata[kernel_op].key = kernel_op;
		pdata[kernel_op].time += total_time;
		pdata[kernel_op].calls += 1;
		pdata[kernel_op].flops += __ctx->kernels[kernel_op].flops * (double(x.length()) * 1e-9);
		// std::cout << __ctx->kernels[kernel_op].flops * x.length() << std::endl;
		pdata[kernel_op].bytes_in += x.length() * sizeof(float);
		pdata[kernel_op].bytes_out += y.length() * sizeof(float);

	}

	return cl_config_string;
}

#endif