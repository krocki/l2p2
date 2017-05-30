/*
* @Author: kmrocki@us.ibm.com
* @Date:   2017-05-03 20:44:37
* @Last Modified by:   Kamil Rocki
* @Last Modified time: 2017-05-30 16:34:03
*/

#include <iostream>

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

	ocl.add_program("fold", "../include/cl/kernels/fold.cl");
	ocl.add_kernel ("max_coeff", "fold");

	ocl.list_loaded_kernels();

	return 0;

}

template<class T>
int run_example() {

	array_t<T> ref(25, 5);
	ref.setRandom();

	std::cout << "ref:" << std::endl;
	std::cout << ref << std::endl;

	T e_min = ref.minCoeff();
	T e_max = ref.maxCoeff();
	T e_sum = ref.sum();
	T e_mean = ref.mean();

	std::cout 	<< std::endl
	            << "min: " << e_min
	            << ", max: " << e_max
	            << ", sum: " << e_sum
	            << ", avg: " << e_mean
	            << std::endl;

	// make an opencl copy of the eigen array
	cl_array<T> x = cl_array<T> (&ocl, ref);
	cl_array<T> y = cl_array<T> (&ocl, 1, 1);

	// copy host_data to device
	x.sync_device();

	// find max in x and store in y
	exec_cl (y, x, "max_coeff");

	// copy device data to host
	y.sync_host();

	std::cout << "cl max_coeff = " << y.ref_host_data << std::endl;

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
