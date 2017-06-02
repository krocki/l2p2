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

template<class T>
int run_benchmark(size_t rows, size_t cols, std::string op, int lsize_x = 1, int lsize_y = 1, int ngroups_x = 1, int ngroups_y = 1, int vecn = 1, int iters = 1) {

	array_t<T> eX(rows, cols);
	eX.setRandom();
	array_t<T> eY(1, 1);
	
	// std::cout << "ref:" << std::endl;
	// std::cout << ref << std::endl;

	// make an opencl copy of the eigen array
	size_t padding = lsize_x * ngroups_x * lsize_y * ngroups_y * vecn;
	//std::cout << "padding: " << lsize << ", " << ngroups << ", " << vecn << ", = " << padding << std::endl;

	cl_array<T> x = cl_array<T> (&ocl, eX, padding);
	cl_array<T> y = cl_array<T> (&ocl, eY, padding);

	_TIMED_CALL_(eY((0,0)) = x.ref_host_data.sum(),  "h_" + op + string_format ("_r%zu_c%zu", rows, cols));

	// _TIMED_CALL_(eY((0,0)) = x.ref_host_data.maxCoeff(),  "h_" + op + string_format ("_r%zu_c%zu", rows, cols));

	// copy host_data to device
	x.sync_device();
	y.ref_host_data(0,0) = 0.0f;
	y.sync_device();

	// find max in x and store in y
	std::string cl_config_string;

	std::string perf_key = op;

	for (int i = 0; i < iters; i++) {

		_CL_TIMED_CALL_(cl_config_string = exec_cl_2d (y, x, op, lsize_x, lsize_y, ngroups_x, ngroups_y, vecn, profile_cl), ocl, perf_key);

	}

	// copy device data to host
	y.sync_host();

	// std::cout << op + " = \n" << y.ref_host_data << std::endl;

	T err = (y.ref_host_data - eY).cwiseAbs().maxCoeff();

	// std::cout << "in\n" << x.ref_host_data << std::endl;
	std::cout << "ref res\n" << eY << std::endl;
	std::cout << "cl y\n" << y.ref_host_data << std::endl;

	const std::string color = (err > 1e-3f) ? ANSI_COLOR_RED : err > 1e-7f ? ANSI_COLOR_YELLOW : "";
	const std::string keep = (err > 1e-7f) ? "\n" : "\r";

	// const std::string message = color + "[ reduce test: op = '" + op + "', size = " + std::to_string(x.rows()) + " x " + std::to_string(x.cols()) + " ( " + std::to_string (x.rows() * x.cols()) + " ) " + " ] --->  ERR: " + std::to_string(err) + ANSI_COLOR_RESET + "; " + cl_config_string + keep;

	// std::cout << message;
	total_runs++;

	if (err > 1e-6f) {
		total_errors++;
		pdata[perf_key].errors++;
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

		int bench_iters = 1;
		int psize = 10;

		int asize = 32;
		int lsize = 32;
		int niters = 1;
		
		if (argc > 5) { bench_iters = std::stoi(argv[5]); }
		if (argc > 6) { psize = std::stoi(argv[6]); }
		if (argc > 7) { asize = std::stoi(argv[7]); }
		if (argc > 8) { lsize = std::stoi(argv[8]); }
		if (argc > 9) { niters = std::stoi(argv[9]); }

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

		std::vector<int> array_sizes = {asize};
		std::vector<int> lxs = {lsize};
		std::vector<int> local_mem = {1};
		std::vector<int> atomics = {1};
		std::vector<int> is = {niters};

		auto configurations = generate_configurations(RANDOM_SHUFFLE, array_sizes, lxs, local_mem, atomics, is);

		long double top_gb = 0; std::string conf_str_gb = "";
		long double top_gf = 0; std::string conf_str_gf = "";
		unsigned long long count = 0;

		out += std::to_string(configurations.size()) + " configurations:\n";

		//////////////////
		for (auto& config : configurations) {

			int r = std::get<0>(config);
			int c = 1;
			int lx = std::get<1>(config);
			int ly = 1;
			int wx = r/lx;
			int wy = 1;
			int v = 1;
			int use_lmem = std::get<2>(config);
			int use_atomic_ops = std::get<3>(config);
			int iters = std::get<4>(config);
			wx /= iters;
			int gx = lx * wx;
			
			Dict<var_t> values;
			values["$N$"] = std::to_string(r * c);
			values["$LX$"] = std::to_string(lx);
			values["$LY$"] = std::to_string(ly);
			values["$WX$"] = std::to_string(wx);
			values["$WY$"] = std::to_string(wy);
			values["$GX$"] = std::to_string(gx);
			values["$USE_LOCAL$"] = std::to_string(use_lmem);
			values["$USE_ATOMICS$"] = std::to_string(use_atomic_ops);
			values["$ITERS$"] = std::to_string(iters);

			std::string results = "";
			results += pretty_print(config);
			out += pretty_print(config);

			for (auto& i : gen_list) {

				code_t k_code = make_tt (i, values, false);

				// find out kernel name:
				std::regex kname_re ("k_gen_.*?" + i);
				std::vector<pair_str_int> matches = find_pattern(k_code, kname_re);
				std::string kname = matches.size() > 0 ? matches[0].first : i;
				kname += "_" + func_name;
				std::string fname = outpath + kname + ".cl";

				write_to_file (fname, k_code, true);

				std::cout << "generated \"" + i + "\" :\n>>>>>>>>>>>>>>>\n" + k_code + "\n<<<<<<<<<<<<<<<\nwritten to: " + fname + "\n";

				ocl.add_program(kname, fname);
				ocl.add_kernel (kname, kname);
				ocl.kernels[kname].bytes_in = (long double)(r * c * sizeof(float)) / (long double)(1 << 30);
				ocl.kernels[kname].bytes_out = (long double)(1 * sizeof(float))  / (long double)(1 << 30);
				int FLOPS_PER_THREAD = 1;
				ocl.kernels[kname].flops = (long double)(r * c * (long double)FLOPS_PER_THREAD)  / (long double)(1 << 30);

				ocl.err = 0;

				run_benchmark<float>(r, c, kname, lx, ly, wx, wy, v, bench_iters);

				std::ostringstream os;

				long double GBs = (pdata[kname].bytes_in + pdata[kname].bytes_out) / (pdata[kname].time);
				long double GFs = (pdata[kname].flops) / (pdata[kname].time);

				if (GBs > top_gb) { top_gb = GBs; conf_str_gb = i + std::string("  ") + pretty_print(config);}
				if (GFs > top_gf) { top_gf = GFs; conf_str_gf = i + std::string("  ") + pretty_print(config);}

				os << std::setw(5) << std::to_string(++count) << "/" + std::to_string(configurations.size() * gen_list.size()) << "   " << pretty_print(config) << std::setw(20) << centered(to_string_with_precision (GBs, 8, 2) + " GB/s ") << std::setw(10) << centered(to_string_with_precision (GFs, 8, 2) + " GF/s ") << " ERR " << std::setw(15) << centered(std::to_string(total_errors)) << " " << std::setw(20) << "#1 GB/s = " << std::setw(15) << to_string_with_precision (top_gb, 8, 2)  + " (" + conf_str_gb + ")" << std::setw(20) << "  #1 GF/s = "  << std::setw(10) << to_string_with_precision (top_gf, 8, 2) + " (" + conf_str_gf + ")" << "\n";

				results += os.str();
				std::cout << os.str();

			}

			out += results;
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