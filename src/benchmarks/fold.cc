/*
* @Author: Kamil Rocki
* @Date:   2017-05-14 20:55:55
* @Last Modified by:   Kamil Rocki
* @Last Modified time: 2017-05-30 16:34:48
*/

#include <iostream>
#include <utils/ansi_colors.h>

#include <random>

#include <array/eigen.h>
#include <cl/cl_ctx.h>
#include <cl/cl_array.h>
#include <cl/cl_functions.h>
#include <utils/perf.h>
#include <utils/configs.h>

#include <gen/generate_tt.h>
#include <gen/parse.h>

cl_ctx ocl;
unsigned long total_runs = 0L;
unsigned long total_errors = 0L;
bool profile_cl = true;
profiling_type prof_enabled = CPU_GPU;

int init_cl(int dev) {

	cl_device_type dev_type = CL_DEVICE_TYPE_ALL;

	ocl.init (dev, dev_type);

	if (!ocl.initialized()) {
		std::cerr << "opencl init failed ! " << std::endl;
		return -1;
	}

	return 0;

}

int main (int argc, char** argv) {

	try {

		start = std::chrono::system_clock::now();
		std::string generic_name, func_name;
		int requested_device;

		if (argc > 3) {

			requested_device = atoi (argv[1]);
			generic_name = std::string(argv[2]);
			func_name = std::string(argv[3]);

		} else {

			printf("usage: %s <d> <t> <f> [outpath] [iters] [size]\nexamples:\n\t%s 1 \"cl_fold\" \"fmax\"\n\t%s 2 \"cl_fold\" \"fmin\"\n\t%s 4 \"cl_fold\" \"add\" \"../kernels/generated/src/\" 20 24\n", argv[0], argv[0], argv[0], argv[0]);
			return -1;

		}

		std::vector<std::string> gen_list = {generic_name};
		std::string outpath = "../kernels/generated/src/";

		if (argc > 4) { outpath = std::string(argv[4]); }

		int bench_iters = 200;
		int psize = 23;

		if (argc > 5) { bench_iters = std::stoi(argv[5]); }
		if (argc > 6) { psize = std::stoi(argv[6]); }

		std::string debug_fname = "debug_" + generic_name + "_" + func_name + ".txt";
		std::string results_fname = "bench_" + generic_name + "_" + func_name + ".txt";

		init_cl(requested_device);
		std::string out = "";

		out += "\n" + return_current_time_and_date() + "\n";
		out += "device = " + std::to_string(requested_device) + ": " + ocl.current_device_properties.device_string + "\n";
		out += "tt generic name = " + generic_name + "; ";
		out += "subfunc name = " + func_name + ";\n";
		out += "kernel outpath = " + outpath + "; ";
		out += "log = " + debug_fname + ";\n";
		out += "# of samples = " + std::to_string(bench_iters) + "; ";
		out += "size = 2^" + std::to_string(psize) + ";\n";
		out += "\nOPENCL LOG:\n" + ocl.getlog() + "--- OPENCL LOG\n";
		out += "\n" + return_current_time_and_date() + "\n";

		std::vector<int> array_sizes = {512, 1024, 4096};
		std::vector<int> local_mem = {0, 1};

		auto configurations = generate_configurations(RANDOM_SHUFFLE, array_sizes, local_mem);
		
		out += std::to_string(configurations.size()) + " configurations:\n";

		//////////////////
		for (auto& config : configurations) {

			out += pretty_print(config);
		}
		//////////////////
		
		out += "\n" + return_current_time_and_date() + "\n";
		std::cout << out;

		write_to_file (debug_fname, out, true);

	} catch (const std::runtime_error &e ) {

		std::string error_msg = std::string ( "main() - std::runtime_error: " ) + std::string ( e.what() );

		std::cerr << error_msg << std::endl;

		return -1;

	}

	return 0;

}