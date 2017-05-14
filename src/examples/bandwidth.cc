/*
* @Author: kmrocki@us.ibm.com
* @Date:   2017-05-03 20:44:37
* @Last Modified by:   kmrocki@us.ibm.com
* @Last Modified time: 2017-05-04 14:16:18
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

	ocl.add_program("copy", "../include/cl/kernels/copy.cl");
	ocl.add_kernel ("cl_copy_gmem", "copy");
	ocl.add_kernel ("cl_copy_gmem_v2", "copy");

	ocl.list_loaded_kernels();

	return 0;

}

int main (int argc, char** argv) {

	try {

		int requested_device = 0;
		if (argc > 1) requested_device = atoi (argv[1]);
		init_cl(requested_device);

	} catch (const std::runtime_error &e ) {

		std::string error_msg = std::string ( "main() - std::runtime_error: " ) + std::string ( e.what() );

		std::cerr << error_msg << std::endl;

		return -1;

	}

	return 0;

}
