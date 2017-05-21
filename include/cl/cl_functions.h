/*
* @Author: kmrocki@us.ibm.com
* @Date:   2017-05-04 10:56:35
* @Last Modified by:   Kamil M Rocki
* @Last Modified time: 2017-05-20 21:31:59
*/

#ifndef __CL_FUNCTIONS__
#define __CL_FUNCTIONS__

#include <cl/cl_array.h>
#include <utils/perf.h>
#include <cl/cl_c_kernel.h>

#define SMALLEST -1.0e37f

std::string exec_cl (cl_array<float>& y, cl_array<float>& x, std::string kernel_op, size_t lsize = 0, size_t ngroups = 0, size_t vecn = 1, bool profiling_enabled = false) {

	unsigned int n = x.device_data_size;

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
	int internal_iterations = x.device_data_size / global_work_size;

	CL_SAFE_CALL (clSetKernelArg (__ctx->cl_kernels[kernel_op], 0, sizeof (cl_mem), (void*) &y.ref_device_data) );
	CL_SAFE_CALL (clSetKernelArg (__ctx->cl_kernels[kernel_op], 1, sizeof (cl_mem), (void*) &x.ref_device_data) );
	//CL_SAFE_CALL (clSetKernelArg (__ctx->cl_kernels[kernel_op], 2, sizeof (int), (void*) &internal_iterations) );

	cl_config_string += " n=" + std::to_string(n) + " w=" + std::to_string(num_workgroups) + " g=" + std::to_string(global_work_size) + " l=" + std::to_string(local_work_size) + " i=" + std::to_string(internal_iterations) + " p=" + std::to_string(x.device_data_size);

	assert(is_multiple(x.device_data_size, global_work_size * vecn));
	assert(is_multiple(y.device_data_size, global_work_size * vecn));

	std::string func_string = "k_" + kernel_op + "_" + std::to_string(n);

	if (profiling_enabled) {
		clWaitForEvents (1, &__ctx->cl_events[func_string]);
	}

	// /* Execute the kernel */
	// std::cout << "1Running " << cl_config_string << std::endl;
	// std::cout << "2Running " << kernel_op << std::endl;
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

		pdata[kernel_op].key = kernel_op;
		pdata[kernel_op].time += total_time * 1e-9;
		// std::cout << time_start << "," << time_end << ", " << total_time << ", " << total_time * 1e-9 << std::endl;
		pdata[kernel_op].calls += 1;
		pdata[kernel_op].flops += __ctx->kernels[kernel_op].flops;
		// std::cout << __ctx->kernels[kernel_op].flops * x.length() << std::endl;
		pdata[kernel_op].bytes_in += __ctx->kernels[kernel_op].bytes_in;
		pdata[kernel_op].bytes_out += __ctx->kernels[kernel_op].bytes_out;

		// std::cout << __ctx->kernels[kernel_op].bytes_in << std::endl;
		// std::cout << __ctx->kernels[kernel_op].bytes_out << std::endl;
		// std::cout << __ctx->kernels[kernel_op].flops << std::endl;

	}

	return cl_config_string;
}

std::string exec_cl_2d (cl_array<float>& y, cl_array<float>& x, std::string kernel_op, size_t lsize_x, size_t lsize_y, size_t ngroups_x, size_t ngroups_y, size_t vecn = 1, bool profiling_enabled = false) {

	unsigned int n = x.device_data_size;

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

	assert(lsize_x > 0);
	assert(lsize_y > 0);
	assert(ngroups_x > 0);
	assert(ngroups_y > 0);

	CL_SAFE_CALL (clSetKernelArg (__ctx->cl_kernels[kernel_op], 0, sizeof (cl_mem), (void*) &y.ref_device_data) );
	CL_SAFE_CALL (clSetKernelArg (__ctx->cl_kernels[kernel_op], 1, sizeof (cl_mem), (void*) &x.ref_device_data) );

	size_t global_work_size[2];
	size_t local_work_size[2];

	global_work_size[0] = lsize_x * ngroups_x;
	global_work_size[1] = lsize_y * ngroups_y;

	local_work_size[0] = lsize_x;
	local_work_size[1] = lsize_y;

	size_t global_work_size_xy = global_work_size[0] * global_work_size[1];

	assert(is_multiple(x.device_data_size, global_work_size_xy * vecn));
	assert(is_multiple(y.device_data_size, global_work_size_xy * vecn));

	std::string func_string = "k_" + kernel_op + "_" + std::to_string(n);

	if (profiling_enabled) {
		clWaitForEvents (1, &__ctx->cl_events[func_string]);
	}

	// /* Execute the kernel */
	// std::cout << "1Running " << cl_config_string << std::endl;
	// std::cout << "2Running " << kernel_op << std::endl;
	CL_SAFE_CALL (clEnqueueNDRangeKernel (__ctx->queue(), __ctx->cl_kernels[kernel_op], 2, NULL, global_work_size, local_work_size, 0, NULL, &__ctx->cl_events[func_string]) );

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

		pdata[kernel_op].key = kernel_op;
		pdata[kernel_op].time += total_time * 1e-9;
		// std::cout << time_start << "," << time_end << ", " << total_time << ", " << total_time * 1e-9 << std::endl;
		pdata[kernel_op].calls += 1;
		pdata[kernel_op].flops += __ctx->kernels[kernel_op].flops;
		// std::cout << __ctx->kernels[kernel_op].flops * x.length() << std::endl;
		pdata[kernel_op].bytes_in += __ctx->kernels[kernel_op].bytes_in;
		pdata[kernel_op].bytes_out += __ctx->kernels[kernel_op].bytes_out;

		// std::cout << __ctx->kernels[kernel_op].bytes_in << std::endl;
		// std::cout << __ctx->kernels[kernel_op].bytes_out << std::endl;
		// std::cout << __ctx->kernels[kernel_op].flops << std::endl;

	}

	return cl_config_string;
}

// for permute
std::string exec_cl_2d (cl_array<float>& y, cl_array<int>& idxs, cl_array<float>& x, std::string kernel_op, size_t lsize_x, size_t lsize_y, size_t ngroups_x, size_t ngroups_y, size_t vecn = 1, bool profiling_enabled = false) {

	unsigned int n = x.device_data_size;

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

	assert(lsize_x > 0);
	assert(lsize_y > 0);
	assert(ngroups_x > 0);
	assert(ngroups_y > 0);

	CL_SAFE_CALL (clSetKernelArg (__ctx->cl_kernels[kernel_op], 0, sizeof (cl_mem), (void*) &y.ref_device_data) );
	CL_SAFE_CALL (clSetKernelArg (__ctx->cl_kernels[kernel_op], 1, sizeof (cl_mem), (void*) &idxs.ref_device_data) );
	CL_SAFE_CALL (clSetKernelArg (__ctx->cl_kernels[kernel_op], 2, sizeof (cl_mem), (void*) &x.ref_device_data) );

	size_t global_work_size[2];
	size_t local_work_size[2];

	global_work_size[0] = lsize_x * ngroups_x;
	global_work_size[1] = lsize_y * ngroups_y;

	local_work_size[0] = lsize_x;
	local_work_size[1] = lsize_y;

	size_t global_work_size_xy = global_work_size[0] * global_work_size[1];

	assert(is_multiple(x.device_data_size, global_work_size_xy * vecn));
	assert(is_multiple(y.device_data_size, global_work_size_xy * vecn));

	std::string func_string = "k_" + kernel_op + "_" + std::to_string(n);

	if (profiling_enabled) {
		clWaitForEvents (1, &__ctx->cl_events[func_string]);
	}

	// /* Execute the kernel */
	// std::cout << "1Running " << cl_config_string << std::endl;
	// std::cout << "2Running " << kernel_op << std::endl;
	CL_SAFE_CALL (clEnqueueNDRangeKernel (__ctx->queue(), __ctx->cl_kernels[kernel_op], 2, NULL, global_work_size, local_work_size, 0, NULL, &__ctx->cl_events[func_string]) );

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

		pdata[kernel_op].key = kernel_op;
		pdata[kernel_op].time += total_time * 1e-9;
		// std::cout << time_start << "," << time_end << ", " << total_time << ", " << total_time * 1e-9 << std::endl;
		pdata[kernel_op].calls += 1;
		pdata[kernel_op].flops += __ctx->kernels[kernel_op].flops;
		// std::cout << __ctx->kernels[kernel_op].flops * x.length() << std::endl;
		pdata[kernel_op].bytes_in += __ctx->kernels[kernel_op].bytes_in;
		pdata[kernel_op].bytes_out += __ctx->kernels[kernel_op].bytes_out;

		// std::cout << __ctx->kernels[kernel_op].bytes_in << std::endl;
		// std::cout << __ctx->kernels[kernel_op].bytes_out << std::endl;
		// std::cout << __ctx->kernels[kernel_op].flops << std::endl;

	}

	return cl_config_string;
}
#endif
