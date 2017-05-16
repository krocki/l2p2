/*
* @Author: Kamil Rocki
* @Date:   2017-05-14 20:55:55
* @Last Modified by:   Kamil Rocki
* @Last Modified time: 2017-05-15 11:59:13
*/

#include <iostream>
#include <utils/ansi_colors.h>

#include <array/eigen.h>
#include <cl/cl_ctx.h>
#include <cl/cl_array.h>
#include <cl/cl_functions.h>
#include <utils/perf.h>

cl_ctx ocl;
unsigned long total_runs = 0L;
unsigned long total_errors = 0L;
bool profile_cl = true;

int init_cl(int dev) {

	cl_device_type dev_type = CL_DEVICE_TYPE_ALL;

	ocl.init (dev, dev_type);

	if (!ocl.initialized()) {
		std::cerr << "opencl init failed ! " << std::endl;
		return -1;
	}

	ocl.add_program("flops", "../include/cl/kernels/fmads.cl");
	ocl.add_kernel ("cl_flops", "flops");
	ocl.add_kernel ("cl_flops2", "flops");
	ocl.add_kernel ("cl_flops4", "flops");
	ocl.kernels["cl_flops"].flops = 512 * 32;
	ocl.kernels["cl_flops2"].flops = 512 * 32;
	ocl.kernels["cl_flops4"].flops = 512 * 32;
	ocl.list_loaded_kernels();

	return 0;

}

template<class T>
int run_benchmark(size_t rows, size_t cols, std::string op, int lsize = 1, int ngroups = 1) {

	array_t<T> ref(rows, cols);

	// make an opencl copy of the eigen array
	cl_array<T> x = cl_array<T> (&ocl, ref);
	x.ref_host_data.setRandom();
	cl_array<T> y = cl_array<T> (&ocl, ref);
	y.ref_host_data.setRandom();

	// copy host_data to device
	x.sync_device();
	y.sync_device();

	auto f = [&]() {

		// for (int k = 0; k < 128; k++) {
		// 	x.ref_host_data.array() += y.ref_host_data.array() * y.ref_host_data.array();
		// 	y.ref_host_data.array() += x.ref_host_data.array() * x.ref_host_data.array();
		// }

	};

	//_TIMED_CALL_(f(),  "h_" + op + string_format ("_r%zu_c%zu", rows, cols));

	std::string cl_config_string;

	_CL_TIMED_CALL_(cl_config_string = exec_cl (y, x, op, lsize, ngroups, profile_cl), ocl, "d_" + op + string_format ("_r%zu_c%zu", rows, cols));

	// copy device data to host
	y.sync_host();

	// std::cout << op + " = \n" << y.ref_host_data << std::endl;

	T err = (y.ref_host_data - ref).cwiseAbs().maxCoeff();

	const std::string color = (err > 1e-3f) ? ANSI_COLOR_RED : err > 1e-7f ? ANSI_COLOR_YELLOW : "";
	const std::string keep = (err > 1e-7f) ? "\n" : "\r";

	const std::string message = color + "[ bench: op = '" + op + "', size = " + std::to_string(x.rows()) + " x " + std::to_string(x.cols()) + " ( " + std::to_string (x.rows() * x.cols()) + " ) " + " ] --->  ERR: " + std::to_string(err) + ANSI_COLOR_RESET + "; " + cl_config_string + keep;

	std::cout << message;
	total_runs++;
	total_errors += err > 1e-6f ? 1 : 0;

	show_profiling_data(pdata, SORT_BY_TIME_DESC, prof_enabled, true);
	std::cout << "errors: " << total_errors << "/" << total_runs << std::endl;

	return 0;

}

int main (int argc, char** argv) {

	try {

		int requested_device = 0;
		if (argc > 1) requested_device = atoi (argv[1]);
		init_cl(requested_device);

		run_benchmark<float>(1024, 1024, "cl_flops", 8, 32);
		run_benchmark<float>(1024, 1024, "cl_flops2", 8, 32);
		run_benchmark<float>(1024, 1024, "cl_flops4", 8, 32);

		run_benchmark<float>(4096, 4096, "cl_flops", 8, 32);
		run_benchmark<float>(4096, 4096, "cl_flops2", 8, 32);
		run_benchmark<float>(4096, 4096, "cl_flops4", 8, 32);

		run_benchmark<float>(2 * 8192, 2 * 8192, "cl_flops", 256, 128);
		run_benchmark<float>(2 * 8192, 2 * 8192, "cl_flops2", 256, 128);
		run_benchmark<float>(2 * 8192, 2 * 8192, "cl_flops4", 256, 128);

	} catch (const std::runtime_error &e ) {

		std::string error_msg = std::string ( "main() - std::runtime_error: " ) + std::string ( e.what() );

		std::cerr << error_msg << std::endl;

		return -1;

	}

	return 0;

}
