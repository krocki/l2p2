/*
* @Author: kmrocki@us.ibm.com
* @Date:   2017-05-03 20:44:37
* @Last Modified by:   kmrocki@us.ibm.com
* @Last Modified time: 2017-05-04 15:46:40
*/

#include <iostream>
#include <random>

#include <utils/ansi_colors.h>

#include <array/eigen.h>
#include <cl/cl_ctx.h>
#include <cl/cl_array.h>
#include <cl/cl_functions.h>

cl_ctx ocl;

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
T uniform(T x) {
	static std::mt19937 rng;
	static std::uniform_real_distribution<T> u(-1000000.0f, 1000000.0f);
	return u(rng);
}

template<class T>
int run_test(size_t rows, size_t cols, std::string op) {

	array_t<T> ref(rows, cols);

	ref = ref.unaryExpr(std::ptr_fun(uniform<T>));

	T e_max = ref.maxCoeff();

	// make an opencl copy of the eigen array
	cl_array<T> x = cl_array<T> (&ocl, ref);
	cl_array<T> y = cl_array<T> (&ocl, 1, 1);

	x.sync_device();

	std::string cl_config_string = cl_reduce (y, x, op);

	y.sync_host();

	T err = std::abs((y.ref_host_data(0) - e_max));

	const std::string color = (err > 1e-3f) ? ANSI_COLOR_RED : err > 1e-7f ? ANSI_COLOR_YELLOW : "";
	const std::string keep = (err > 1e-7f) ? "\n" : "\r";

	const std::string message = color + "[ reduce test: op = '" + op + "', size = " + std::to_string(rows) + " x " + std::to_string(cols) + " ( " + std::to_string (rows * cols) + " ) " + " ] ---> e_max: " + std::to_string(e_max) + ", cl max: " + std::to_string(y.ref_host_data(0)) + ", ERR: " + std::to_string(err) + ANSI_COLOR_RESET + "; " + cl_config_string + keep;

	std::cout << message;

	return 0;

}

int main (int argc, char** argv) {

	try {

		int requested_device = 0;
		if (argc > 1) requested_device = atoi (argv[1]);
		init_cl(requested_device);

		size_t full_range_min = 1;
		size_t full_range_inc = 32;
		size_t full_range_max = 2048;
		size_t rand_range_min = 1;
		size_t rand_range_max = 1024;
		size_t rand_iters = 10000;

		// run all sizes for a given range (full_range_min-full_range_max) x (full_range_min-full_range_max)
		// for (size_t r = full_range_min; r < full_range_max; r += full_range_inc)
		// 	for (size_t c = full_range_min; c < full_range_max; c += full_range_inc)
		// 		run_test<float> (r, c, "max_coeff");

		// rand tests
		for (size_t num = 0; num < rand_iters; num++) {
			run_test<float> (rand() % (rand_range_max - rand_range_min) + rand_range_min, rand() % (rand_range_max - rand_range_min) + rand_range_max, "max_coeff");
		}

	} catch (const std::runtime_error &e ) {

		std::string error_msg = std::string ( "main() - std::runtime_error: " ) + std::string ( e.what() );

		std::cerr << error_msg << std::endl;

		return -1;

	}

	return 0;

}
