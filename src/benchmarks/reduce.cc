/*
* @Author: kmrocki@us.ibm.com
* @Date:   2017-05-03 20:44:37
* @Last Modified by:   kmrocki@us.ibm.com
* @Last Modified time: 2017-05-04 22:01:03
*/

#include <iostream>
#include <random>

#include <utils/ansi_colors.h>

#include <array/eigen.h>
#include <cl/cl_ctx.h>
#include <cl/cl_array.h>
#include <cl/cl_functions.h>

#include <utils/perf.h>

cl_ctx ocl;
profiling_type prof_enabled = CPU_ONLY;
unsigned long total_runs = 0L;
unsigned long total_errors = 0L;

int init_cl(int dev) {

	cl_device_type dev_type = CL_DEVICE_TYPE_ALL;

	ocl.init (dev, dev_type);

	if (!ocl.initialized()) {
		std::cerr << "opencl init failed ! " << std::endl;
		return -1;
	}

	ocl.add_program("reduce", "../include/cl/kernels/reduce.cl");
	ocl.add_kernel ("max_coeff", "reduce");

	ocl.list_loaded_kernels();

	return 0;

}

template<class T>
T randn(T _mean, T _std) {
	static std::mt19937 rng;
	static std::normal_distribution<T> n(_mean, _std);
	return n(rng);
}

template<class T>
T randi(T _min, T _max) {
	static std::mt19937 rng;
	static std::uniform_int_distribution<T> u(_min, _max);
	return u(rng);
}

template<class T, size_t iters>
int run_benchmarks(size_t rows, size_t cols, std::string op) {

	array_t<T> ref(rows, cols);
	ref = ref.unaryExpr( [](T) { return randn<T>(0, 1000); });
	T e_max;

	//do this for a fair comparison
	bool prealloc_cl_scratchpad = true;

	// make an opencl copy of the eigen array
	cl_array<T> x = cl_array<T> (&ocl, ref, prealloc_cl_scratchpad);
	cl_array<T> y = cl_array<T> (&ocl, 1, 1);

	x.sync_device();

	for (size_t k = 0; k < iters; k++) {

		_TIMED_CALL_(e_max = ref.maxCoeff(), "reduce_" + op + string_format ("_r%zu_c%zu", rows, cols));

		std::string cl_config_string;
		_CL_TIMED_CALL_(cl_config_string = cl_reduce (y, x, op), ocl, "cl_reduce_" + op + string_format ("_r%zu_c%zu", rows, cols));

		y.sync_host();

		T err = std::abs((y.ref_host_data(0) - e_max));

		const std::string color = (err > 1e-3f) ? ANSI_COLOR_RED : err > 1e-7f ? ANSI_COLOR_YELLOW : "";
		const std::string keep = (err > 1e-7f) ? "\n" : "\r";

		const std::string message = (err > 1e-3f) ? (color + "[ reduce test: op = '" + op + "', size = " + std::to_string(rows) + " x " + std::to_string(cols) + " ( " + std::to_string (rows * cols) + " ) " + " ] ---> e_max: " + std::to_string(e_max) + ", cl max: " + std::to_string(y.ref_host_data(0)) + ", ERR: " + std::to_string(err) + ANSI_COLOR_RESET + "; " + cl_config_string + keep) : "";

		total_runs++;
		total_errors += err > 1e-6f ? 1 : 0;

		std::cout << message;

	}

	show_profiling_data(pdata, SORT_BY_TIME_DESC, prof_enabled, false);
	std::cout << "errors: " << total_errors << "/" << total_runs << std::endl;

	return 0;

}

int main (int argc, char** argv) {

	try {

		int requested_device = 0;
		if (argc > 1) requested_device = atoi (argv[1]);
		init_cl(requested_device);

		size_t full_range_min = 256;
		size_t full_range_inc = 256;
		size_t full_range_max = 2048;
		size_t rand_range_min = 1;
		size_t rand_range_max = 2048;
		size_t rand_iters = 10000;

		//run all sizes for a given range (full_range_min-full_range_max) x (full_range_min-full_range_max)
		for (size_t r = full_range_min; r <= full_range_max; r += full_range_inc)
			for (size_t c = full_range_min; c <= full_range_max; c += full_range_inc) {

				std::cout << r << ", " << c << std::endl;
				run_benchmarks<float, 10000> (r, c, "max_coeff");
			}

		// rand tests
		// for (size_t num = 0; num < rand_iters; num++) {
		// 	run_benchmarks<float, 1000> (randi<size_t>(rand_range_min, rand_range_max),
		// 	                             randi<size_t>(rand_range_min, rand_range_max),
		// 	                             "max_coeff");
		//}

	} catch (const std::runtime_error &e ) {

		std::string error_msg = std::string ( "main() - std::runtime_error: " ) + std::string ( e.what() );

		std::cerr << error_msg << std::endl;

		return -1;

	}

	return 0;

}
