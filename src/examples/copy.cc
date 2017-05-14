/*
* @Author: kmrocki@us.ibm.com
* @Date:   2017-05-03 20:44:37
* @Last Modified by:   kmrocki@us.ibm.com
* @Last Modified time: 2017-05-04 14:16:18
*/

#include <iostream>
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

	ocl.add_program("copy", "../include/cl/kernels/copy.cl");
	ocl.add_kernel ("cl_copy_gmem", "copy");
	ocl.add_kernel ("cl_copy_gmem_v2", "copy");

	ocl.list_loaded_kernels();

	return 0;

}

template<class T>
int run_example() {

	array_t<T> ref(8, 8);
	ref.setRandom();

	std::cout << "ref:" << std::endl;
	std::cout << ref << std::endl;

	// make an opencl copy of the eigen array
	cl_array<T> x = cl_array<T> (&ocl, ref);
	cl_array<T> y = cl_array<T> (&ocl, ref.rows(), ref.cols());

	// copy host_data to device
	x.sync_device();

	std::string op = "cl_copy_gmem";

	// find max in x and store in y
	std::string cl_config_string = exec_cl (y, x, op);

	// copy device data to host
	y.sync_host();

	std::cout << op + " = \n" << y.ref_host_data << std::endl;

	T err = (y.ref_host_data - ref).cwiseAbs().maxCoeff();

	const std::string color = (err > 1e-3f) ? ANSI_COLOR_RED : err > 1e-7f ? ANSI_COLOR_YELLOW : "";
	const std::string keep = "\n"; //(err > 1e-7f) ? "\n" : "\r";

	const std::string message = color + "[ reduce test: op = '" + op + "', size = " + std::to_string(x.rows()) + " x " + std::to_string(x.cols()) + " ( " + std::to_string (x.rows() * x.cols()) + " ) " + " ] --->  ERR: " + std::to_string(err) + ANSI_COLOR_RESET + "; " + cl_config_string + keep;

	std::cout << message;

	return 0;

}

int main (int argc, char** argv) {

	try {

		int requested_device = 0;
		if (argc > 1) requested_device = atoi (argv[1]);
		init_cl(requested_device);

		run_example<float>();
		
	} catch (const std::runtime_error &e ) {

		std::string error_msg = std::string ( "main() - std::runtime_error: " ) + std::string ( e.what() );

		std::cerr << error_msg << std::endl;

		return -1;

	}

	return 0;

}
