/*
* @Author: kmrocki@us.ibm.com
* @Date:   2017-05-03 20:44:37
* @Last Modified by:   kmrocki@us.ibm.com
* @Last Modified time: 2017-05-04 09:52:59
*/

#include <iostream>

#include <cl/cl_ctx.h>

int init_cl(int dev) {

	cl_device_type dev_type = CL_DEVICE_TYPE_ALL;

	cl_ctx ocl (dev, dev_type);

	if (!ocl.initialized()) {
		std::cerr << "opencl init failed ! " << std::endl;
		return -1;
	}

	// add_program(std::string program_name, const char* fname, const char* build_flags = "")
	// add_kernel (std::string kernel_name, std::string program_name)

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
