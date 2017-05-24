/*
* @Author: Kamil Rocki
* @Date:   2017-05-14 20:55:55
* @Last Modified by:   Kamil M Rocki
* @Last Modified time: 2017-05-22 21:06:59
*/

#include <iostream>
#include <utils/ansi_colors.h>

#include <random>

#include <array/eigen.h>
#include <cl/cl_ctx.h>
#include <cl/cl_array.h>
#include <cl/cl_functions.h>
#include <utils/perf.h>

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

template<class T>
int run_benchmark(size_t rows, size_t cols, std::string op, int lsize_x = 1, int lsize_y = 1, int ngroups_x = 1, int ngroups_y = 1, int vecn = 1, int iters = 1) {

	array_t<T> eA(rows, cols);
	array_t<T> eB(rows, cols);
	array_t<T> eC(rows, cols);

	eA.setRandom();
	eB.setRandom();

	// std::cout << "eA:" << std::endl;
	// std::cout << eA << std::endl;
	// std::cout << "eB:" << std::endl;
	// std::cout << eB << std::endl;
	// make an opencl copy of the eigen array
	size_t padding = lsize_x * ngroups_x * lsize_y * ngroups_y * vecn;
	//std::cout << "padding: " << lsize << ", " << ngroups << ", " << vecn << ", = " << padding << std::endl;

	cl_array<T> A = cl_array<T> (&ocl, eA, padding);
	cl_array<T> B = cl_array<T> (&ocl, eB, padding);
	cl_array<T> C = cl_array<T> (&ocl, eC, padding);

	_TIMED_CALL_(eC = eA * eB,  "h_gemm" + string_format ("_r%zu_c%zu", rows, cols));

	// std::cout << "eC:" << std::endl;
	// std::cout << eC << std::endl;

	// copy host_data to device
	A.sync_device();
	B.sync_device();

	// find max in x and store in y
	std::string cl_config_string;

	std::string perf_key = op;

	for (int i = 0; i < iters; i++) {

		_CL_TIMED_CALL_(cl_config_string = exec_cl_gemm (C, A, B, op, lsize_x, lsize_y, ngroups_x, ngroups_y, vecn, profile_cl), ocl, perf_key);

	}

	// copy device data to host
	C.sync_host();
	// std::cout << "C:" << std::endl;
	// std::cout << C.ref_host_data << std::endl;
	// std::cout << op + " = \n" << y.ref_host_data << std::endl;

	array_t<T> err = (C.ref_host_data - eC);
	//std::cout << "err:" << std::endl;
	//std::cout << err << std::endl;
	T errmax = err.cwiseAbs().maxCoeff();

	const std::string color = (errmax > 1e-3f) ? ANSI_COLOR_RED : errmax > 1e-7f ? ANSI_COLOR_YELLOW : "";
	const std::string keep = (errmax > 1e-7f) ? "\n" : "\r";

	total_runs++;
	pdata[perf_key].errmax = errmax > pdata[perf_key].errmax ? errmax : pdata[perf_key].errmax;

	if (errmax > 1e-4f) {
		total_errors++;
		pdata[perf_key].errors++;
	}

	return 0;

}

typedef enum {IN_ORDER = 0, RANDOM_SHUFFLE = 1} ITEM_ORDER;

template <typename ...T>
auto generate_configurations(ITEM_ORDER ord, std::vector<T>& ...is) {

	auto confs = cross(is...);
	if (ord == RANDOM_SHUFFLE) {
		std::cout << "ord = RANDOM_SHUFFLE" << std::endl;
		std::srand ( unsigned ( std::time(0) ) );
		std::shuffle ( confs.begin(), confs.end(), std::mt19937{std::random_device{}()});
	}
	return confs;
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

			printf("usage: %s <d> <t> <f> [outpath] [iters] [size]\nexamples:\n\t%s 1 \"cl_map_gmem_2d\" \"fmads\"\n\t%s 2 \"cl_map_gmem_2d\" \"copy\"\n\t%s 4 \"cl_map_gmem_2d\" \"fmads\" \"../kernels/generated/src/\" 20 24\n", argv[0], argv[0], argv[0], argv[0]);
			return -1;

		}

		std::vector<std::string> gen_list = {generic_name};
		std::string outpath = "../kernels/generated/src/";

		if (argc > 4) { outpath = std::string(argv[4]); }

		int bench_iters = 100;
		int psize = 5;

		if (argc > 5) { bench_iters = std::stoi(argv[5]); }
		if (argc > 6) { psize = std::stoi(argv[6]); }

		std::string debug_fname = "debug_" + generic_name + "_" + func_name + ".txt";
		std::string results_fname = "bench_" + generic_name + "_" + func_name + ".txt";

		std::cout << "device = " << requested_device << "; ";
		std::cout << "generic name = " << generic_name << "; ";
		std::cout << "func name = " << func_name << "; ";
		std::cout << "kernel outpath = " << outpath << "; ";
		std::cout << "log = " << debug_fname << "; ";
		std::cout << "# of samples = " << bench_iters << "; ";
		std::cout << "size = " << "2^" << psize << "; ";
		init_cl(requested_device);
		std::cout << ocl.getlog() << std::endl;

		std::vector<int> msizes = {1024};
		std::vector<int> blksizes = {2, 4, 8, 16, 32};

		int kk_iters;

		std::cout << ocl.current_device_properties.device_string + " : " + ocl.current_device_properties.vendor_str + " ";

		if (is_cpu(ocl.current_device_properties)) {

			std::cout << "CPU" << std::endl;

		} else {

			std::cout << "GPU" << std::endl;

		}

		auto configurations = generate_configurations(RANDOM_SHUFFLE, msizes, blksizes);

		long double top_gb = 0;
		std::string conf_str_gb = "";
		long double top_gf = 0;
		std::string conf_str_gf = "";

		unsigned long long count = 0;

		std::string results = "";

		results += "OPENCL LOG:\n" + ocl.getlog() + "--- OPENCL LOG\n";

		for (auto& config : configurations) {

			std::string t = "float";
			int msize = std::get<0>(config);
			int blksz = std::get<1>(config);
			int wx = msize / blksz;
			int lx = blksz;
			int wy = msize / blksz;
			int ly = blksz;
			int g = lx * wx * ly * wy;
			int v = 1;

			Dict<var_t> values;

			//gemm
			values["$ORDER$"] = std::to_string(msize);
			values["$BLKSZ$"] = std::to_string(blksz);
			values["$NUM_BLK$"] = std::to_string(msize/blksz);
			values["$A_INC$"] = std::to_string(msize*blksz);
			values["$B_INC$"] = std::to_string(blksz);

			for (auto& i : gen_list) {

				code_t k_code = make_tt (i, values, false);

				// find out kernel name:
				std::regex kname_re ("k_gen_.*?" + i);
				std::vector<pair_str_int> matches = find_pattern(k_code, kname_re);
				std::string kname = matches.size() > 0 ? matches[0].first : i;
				kname += "_" + func_name;
				std::string fname = outpath + kname + ".cl";

				write_to_file (fname, k_code, true);

				// std::cout << "generated \"" + i + "\" :\n>>>>>>>>>>>>>>>\n" + k_code + "\n<<<<<<<<<<<<<<<\nwritten to: " + fname + "\n";

				ocl.add_program(kname, fname);
				ocl.add_kernel (kname, kname);
				ocl.kernels[kname].bytes_in = (long double)(2 * msize * msize * sizeof(float)) / (long double)(1 << 30);
				ocl.kernels[kname].bytes_out = (long double)(msize * msize * sizeof(float))  / (long double)(1 << 30);
				int FLOPS_PER_THREAD = 2 * msize;
				ocl.kernels[kname].flops = (long double)(msize * msize * (long double)FLOPS_PER_THREAD)  / (long double)(1 << 30);

				ocl.err = 0;

				run_benchmark<float>(msize, msize, kname, lx, ly, wx, wy, v, bench_iters);

				std::ostringstream os;

				long double GBs = (pdata[kname].bytes_in + pdata[kname].bytes_out) / (pdata[kname].time);
				long double GFs = (pdata[kname].flops) / (pdata[kname].time);

				if (GBs > top_gb) { top_gb = GBs; conf_str_gb = i + std::string("  ") + pretty_print(config);}
				if (GFs > top_gf) { top_gf = GFs; conf_str_gf = i + std::string("  ") + pretty_print(config);}

				os << std::setw(5) << std::to_string(++count) << "/" + std::to_string(configurations.size() * gen_list.size()) << "   " << pretty_print(config) << std::setw(20) << centered(to_string_with_precision (GBs, 8, 2) + " GB/s ") << std::setw(10) << centered(to_string_with_precision (GFs, 8, 2) + " GF/s ") << " ERR " << std::setw(15) << centered(std::to_string(total_errors)) << " errmax: " << pdata[kname].errmax << " " << std::setw(20) << "#1 GB/s = " << std::setw(15) << to_string_with_precision (top_gb, 8, 2)  + " (" + conf_str_gb + ")" << std::setw(20) << "  #1 GF/s = "  << std::setw(10) << to_string_with_precision (top_gf, 8, 2) + " (" + conf_str_gf + ")" << "\n";

				results += os.str();
				std::cout << os.str();

			}

		}

		results += std::to_string(configurations.size()) + " configurations:\n";

		//results += pretty_print(configurations);

		results += std::string("loaded programs:\n") + ocl.loaded_programs() + "\n\n\n";
		results += std::string("loaded kernels:\n") + ocl.loaded_kernels() + "\n\n\n";

		results += "\n\nresults ( " + generic_name + "):\n";

		std::string prof_results = show_profiling_data(pdata, SORT_BY_BANDW_DESC, prof_enabled, true);
		std::cout << "\n" << prof_results << "\n";
		write_to_file (results_fname, prof_results, true);

		results += prof_results;
		results += "errors: " + std::to_string(total_errors) + "/" + std::to_string(total_runs);
		std::cout << "errors: " + std::to_string(total_errors) + "/" + std::to_string(total_runs) + "\n\n";

		write_to_file (debug_fname, results, true);

	} catch (const std::runtime_error &e ) {

		std::string error_msg = std::string ( "main() - std::runtime_error: " ) + std::string ( e.what() );

		std::cerr << error_msg << std::endl;

		return -1;

	}

	return 0;

}
