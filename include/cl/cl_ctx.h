/*
    @Author: kmrocki@us.ibm.com
    @Date:   2017-04-25 03:59:24
    @Last Modified by:   kmrocki@us.ibm.com
    @Last Modified time: 2017-04-29 11:36:43
*/


#include <cl/cl_utils.h>
#include <cl/cl_c_kernel.h>
#include <utils/dict.h>

#ifndef __CL_CTX_H__
#define __CL_CTX_H__

class cl_ctx {

private:

	cl_platform_id platform = 0;

	// cl_context_properties props[3] = { CL_CONTEXT_PLATFORM, 0, 0 };
	cl_context _ctx = 0;
	cl_command_queue _queue = 0;

	// there can be multiple programs/kernels per ctx
	Dict<cl_program> cl_programs;

	bool _initialized = false;

	std::string log = "";

public:

	Dict<cl_event> cl_events;
	Dict<cl_kernel> cl_kernels;
	Dict<compute_kernel> kernels;

	std::vector <compute_device_info> available_devices;

	unsigned selected_device = 0; // 0, 1, ....
	cl_device_id device_in_use = 0; // cl_int identifier
	cl_dev_info current_device_properties;

	// various performance options
	bool asynchronous = true;
	bool profiling_enabled = true;
	bool ooo_exec_enabled = false;
	bool zero_copy_mem = false;

	cl_mem_flags device_mem_alloc_flags = CL_MEM_READ_WRITE;

	bool get_workgroup_size_from_device = false;
	bool get_num_workgroups_from_device = false;

	size_t local_work_size = 8;
	size_t num_workgroups = 4;

	cl_int err;

	cl_ctx () {};

	cl_ctx (int requested_device, cl_device_type dev_type = CL_DEVICE_TYPE_ALL) { init(requested_device, dev_type); }

	// TODO: requested_device_type = GPU/CPU, ...
	int init (int requested_device = 0, cl_device_type dev_type = CL_DEVICE_TYPE_ALL) {

		log += "Querying OpenCL...\n";

		available_devices.clear();
		std::vector <compute_device_info> clDevices = clUtils::listDevices (dev_type);
		available_devices.insert (available_devices.end(), clDevices.begin(), clDevices.end() );

		for (unsigned int i = 0; i < available_devices.size(); i++) {
			log += string_format ("[%2d]: %s [%s, local id = %ld]\n", i, available_devices[i].name.c_str(), available_devices[i].type.c_str(), available_devices[i].localNum);
		}

		int requestedDevice = requested_device;

		if (requestedDevice >= 0 && requestedDevice < (int) available_devices.size() )
			selected_device = (unsigned) requestedDevice;

		else
			log += string_format ("Device %d is not available!\n", requestedDevice);

		log += string_format ("Selected Device: %u (%s) \n", selected_device, available_devices[selected_device].name.c_str() );
		/* Setup OpenCL environment. */
		CL_SAFE_CALL (clGetPlatformIDs (1, &platform, NULL) );
		device_in_use = (cl_device_id) available_devices[selected_device].localNum;
		current_device_properties = clUtils::getDevice (device_in_use);

		log += string_format ("device_string: %s\n", current_device_properties.device_string.c_str() );
		log += string_format ("compute_units: %u\n", current_device_properties.compute_units);
		log += string_format ("workgroup_size: %zu\n", current_device_properties.workgroup_size);
		log += string_format ("workitem_size: %zu x %zu x %zu\n",
		                      current_device_properties.workitem_size[0],
		                      current_device_properties.workitem_size[1],
		                      current_device_properties.workitem_size[2]);

		log += string_format ("global_mem_size: %llu\n", (long long unsigned int) current_device_properties.global_mem_size);
		log += string_format ("local_mem_size: %llu\n", (long long unsigned int) current_device_properties.local_mem_size);
		log += string_format ("preferred_vector: %u\n", current_device_properties.preferred_vector);


		if (zero_copy_mem) {
			device_mem_alloc_flags = CL_MEM_ALLOC_HOST_PTR;
		}

		if (get_workgroup_size_from_device) {
			local_work_size = current_device_properties.workgroup_size;
		}

		if (get_num_workgroups_from_device) {
			num_workgroups = current_device_properties.compute_units * 4;
		}

		const std::string color_message = "\x1b[33m[ workgroup_size = " + std::to_string (local_work_size) + " ]\x1b[0m\n" + "\x1b[33m[ num_workgroups = " + std::to_string (num_workgroups) + " ]\x1b[0m\n";
		log += "\n" + color_message + "\n";

		//props[1] = (cl_context_properties)platform;
		cl_int err;
		_ctx = clCreateContext (NULL, 1, &device_in_use, NULL, NULL, &err);

		if (clUtils::checkError(err, "cl_ctx: clCreateContext()") != 0) return err;

		/* create command queue */
		cl_command_queue_properties queue_properties = 0;

		if (profiling_enabled) queue_properties |= CL_QUEUE_PROFILING_ENABLE;
		if (ooo_exec_enabled) queue_properties |= CL_QUEUE_OUT_OF_ORDER_EXEC_MODE_ENABLE;

		_queue = clCreateCommandQueue (_ctx, device_in_use, queue_properties, &err);

		if (clUtils::checkError(err, "cl_ctx: clCreateCommandQueue()") != 0) return err;

		init_cl_libs();

		_initialized = true;
		return 0;
	}

	int add_program(std::string program_name, const char* fname, const char* build_flags = "") {

		log += string_format ("building program '%s' from file '%s'\n", program_name.c_str(), fname);

		std::string all_flags = std::string(build_flags);

		//platform dependent flags
		if (!is_intel(current_device_properties)) {
			all_flags += "-cl-strict-aliasing"; //intel doesn't recognize this
		}

		cl_programs[program_name] = clUtils::compileProgram (fname, _ctx, device_in_use, all_flags.c_str());

		if (!cl_programs[program_name]) {
			log += string_format ("'%s' ('%s') compilation failed\n", program_name.c_str(), fname);
			return -1;
		}

		return 0;

	}

	int add_program(std::string program_name, std::string fname, const char* build_flags = "") {

		return add_program(program_name, fname.c_str(), build_flags);

	}

	int add_kernel (std::string kernel_name, std::string program_name) {

		log += string_format ("compiling kernel '%s' from program '%s'\n", kernel_name.c_str(), program_name.c_str());

		if (!cl_programs[program_name]) {
			log += string_format ("program '%s' does not exist\n", program_name.c_str());
			return -1;
		}

		cl_int err;
		cl_kernels[kernel_name] = clCreateKernel (cl_programs[program_name], kernel_name.c_str(), &err);

		if (err != CL_SUCCESS) {
			log += string_format ("clCreateKernel failed with %d, program: '%s', kernel '%s'\n", err, program_name.c_str(), kernel_name.c_str());
			return -1;
		}

		return 0;

	}

	void init_cl_libs() {

		/* Setup clblas. */
		// CL_SAFE_CALL (CL_BLAS_INIT() );
		// CL_BLAS_SHOW_VERSION();

		// /* Setup clRNG. */
		// init_clrng (_ctx, local_work_size);
	}

	void deinit_cl_libs() {

		// destroy_clrng();
		//  Finalize work with clblas.
		// CL_BLAS_TEARDOWN();

	}

	std::string loaded_programs() {

		std::string list = "";
		for (size_t i = 0; i < cl_programs.entries.size(); i++)
			list += std::to_string(i) + " " + cl_programs.reverse_namemap[i] + " ";

		return list;
	}

	std::string loaded_kernels() {

		std::string list = "";
		for (size_t i = 0; i < cl_kernels.entries.size(); i++)
			list += std::to_string(i) + " " + cl_kernels.reverse_namemap[i] + " ";

		return list;

	}

	void barrier() {

		clFinish (_queue );

	}

	~cl_ctx() {

		deinit_cl_libs();

		for (size_t i = 0; i < cl_kernels.entries.size(); i++)
			clReleaseKernel (cl_kernels.entries[i]);

		for (size_t i = 0; i < cl_programs.entries.size(); i++)
			clReleaseProgram (cl_programs.entries[i]);

		clReleaseCommandQueue (_queue);
		clReleaseContext (_ctx);
	}

	cl_context& ctx() {
		return _ctx;
	}

	cl_command_queue& queue() {
		return _queue;
	}

	bool& initialized() {
		return _initialized;
	}

	std::string& getlog() {
		return log;
	}

};

#endif
