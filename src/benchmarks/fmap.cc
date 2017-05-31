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

	array_t<T> ref(rows, cols);
	ref.setRandom();

	// std::cout << "ref:" << std::endl;
	// std::cout << ref << std::endl;

	// make an opencl copy of the eigen array
	size_t padding = lsize_x * ngroups_x * lsize_y * ngroups_y * vecn;
	//std::cout << "padding: " << lsize << ", " << ngroups << ", " << vecn << ", = " << padding << std::endl;

	cl_array<T> x = cl_array<T> (&ocl, ref, padding);
	cl_array<T> y = cl_array<T> (&ocl, ref.rows(), ref.cols(), padding);

	_TIMED_CALL_(y = x,  "h_" + op + string_format ("_r%zu_c%zu", rows, cols));

	// copy host_data to device
	x.sync_device();

	// find max in x and store in y
	std::string cl_config_string;

	std::string perf_key = op;

	for (int i = 0; i < iters; i++) {

		_CL_TIMED_CALL_(cl_config_string = exec_cl_2d (((i % 2 == 0) ? y : x), ((i % 2 == 0) ? x : y), op, lsize_x, lsize_y, ngroups_x, ngroups_y, vecn, profile_cl), ocl, perf_key);

	}

	// copy device data to host
	y.sync_host();

	// std::cout << op + " = \n" << y.ref_host_data << std::endl;

	T err = (y.ref_host_data - ref).cwiseAbs().maxCoeff();

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

			printf("usage: %s <d> <t> <f> [outpath] [iters] [size]\nexamples:\n\t%s 1 \"cl_map_gmem_2d\" \"fmads\"\n\t%s 2 \"cl_map_gmem_2d\" \"copy\"\n\t%s 4 \"cl_map_gmem_2d\" \"fmads\" \"../kernels/generated/src/\" 20 24\n", argv[0], argv[0], argv[0], argv[0]);
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

		std::cout << "device = " << requested_device << "; ";
		std::cout << "generic name = " << generic_name << "; ";
		std::cout << "func name = " << func_name << "; ";
		std::cout << "kernel outpath = " << outpath << "; ";
		std::cout << "log = " << debug_fname << "; ";
		std::cout << "# of samples = " << bench_iters << "; ";
		std::cout << "size = " << "2^" << psize << "; ";
		init_cl(requested_device);

		std::vector<int> rs = {1 << (psize - 4), 1 << (psize - 3), 1 << (psize - 2), 1 << (psize - 1), 1 << psize};
		std::vector<int> cs = {1};
		std::vector<int> ls_x, ls_y;
		std::vector<int> ws_x, ws_y;
		std::vector<int> vs = {};
		std::vector<int> dims = {1, 2};
		std::vector<int> hs = {0, 1}; //__attribute__((vec_type_hint(T)))
		std::vector<int> us = {0, 1};
		int kk_iters;

		std::cout << ocl.current_device_properties.device_string + " ";

		if (is_cpu(ocl.current_device_properties)) {

			std::cout << "CPU" << std::endl;
			//std::generate_n(rs.begin(), rs.size(), [] { static int i {1 << 22}; return i <<= 2; });
			ws_x = {1, 2, 4, 6, 8, 12};
			ls_x = {1, 2, 4, 8, 16, 32};
			ws_y = {1};
			ls_y = {1};
			vs = {1, 2, 4, 8, 16};
			kk_iters = 512;

		} else {

			std::cout << "GPU" << std::endl;
			//std::generate_n(rs.begin(), rs.size(), [] { static int i {1 << 14}; return i <<= 2; });
			ws_x.resize(6);
			ws_y = {1};
			std::generate_n(ws_x.begin(), ws_x.size(), [] { static int i {static_cast<int>(ocl.current_device_properties.compute_units)}; return i += ocl.current_device_properties.compute_units; });
			ls_x = {8, 16, 32, 64, 128, 256};
			ls_y = {1};
			vs = {1, 2, 4, 8, 16};
			kk_iters = 512;

		}

		auto configurations = generate_configurations(RANDOM_SHUFFLE, rs, cs, ls_x, ls_y, ws_x, ws_y, vs, hs, us, dims);

		long double top_gb = 0;
		std::string conf_str_gb = "";
		long double top_gf = 0;
		std::string conf_str_gf = "";

		unsigned long long count = 0;

		std::string results = "";

		results += "OPENCL LOG:\n" + ocl.getlog() + "--- OPENCL LOG\n";

		for (auto& config : configurations) {

			std::string t = "float";
			int r = std::get<0>(config);
			int c = std::get<1>(config);
			int lx = std::get<2>(config);
			int ly = std::get<3>(config);
			int wx = std::get<4>(config);
			int wy = std::get<5>(config);
			int v = std::get<6>(config);
			int h = std::get<7>(config);
			int u = std::get<8>(config);
			int dim = std::get<9>(config);

			int g = lx * wx * ly * wy;
			int n = round_up_multiple(r * c, g * v); // round up to the nearest multiple of a block of threads
			assert (n % (g * v) == 0);

			int iters = n / (g * v); // need exactly iters iterations

			if (dim == 2) { // 2D

				wy = iters;

			} else {

				// 1D
				wx = iters * wx;
				wy = 1;
			}

			std::get<4>(config) = wx;
			std::get<5>(config) = wy;

			Dict<var_t> values, f_values;
			values["$N$"] = std::to_string(n);
			assert (n % v == 0);
			values["$S$"] = std::to_string(n / v);
			values["$H$"] = std::to_string(h);
			values["$LX$"] = std::to_string(lx);
			values["$LY$"] = std::to_string(ly);
			values["$G$"] = std::to_string(g);
			values["$WX$"] = std::to_string(wx);
			values["$WY$"] = std::to_string(wy);
			values["$TRANS$"] = std::to_string(u);
			values["$T$"] = t;

			values["$V$"] = std::to_string(v);
			values["$TV$"] = t + (v > 1 ? std::to_string(v) : "");
			f_values["$OUT$"] = "out[gid]";
			f_values["$IN$"] = "in[gid]";
			f_values["$TV$"] = values["$TV$"];
			f_values["$KK$"] = std::to_string(kk_iters);
			values["$FUNCNAME$"] = func_name;
			values["$FUNC$"] = make_tt ("functions/" + func_name, f_values);

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
				ocl.kernels[kname].bytes_in = (long double)(r * c * sizeof(float)) / (long double)(1 << 30);
				ocl.kernels[kname].bytes_out = (long double)(r * c * sizeof(float))  / (long double)(1 << 30);
				int FLOPS_PER_THREAD = 8 * kk_iters;
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

		}

		results += std::to_string(configurations.size()) + " configurations:\n";

		//results += pretty_print(configurations);

		results += std::string("loaded programs:\n") + ocl.loaded_programs() + "\n\n\n";
		results += std::string("loaded kernels:\n") + ocl.loaded_kernels() + "\n\n\n";

		results += "\n\nresults ( " + generic_name + "):\n";

		std::string prof_results = show_profiling_data(pdata, SORT_BY_BANDW, prof_enabled, true);
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
