/*
* @Author: Kamil Rocki
* @Date:   2017-05-14 20:55:55
* @Last Modified by:   Kamil M Rocki
* @Last Modified time: 2017-05-18 12:50:08
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
int run_benchmark(size_t rows, size_t cols, std::string op, int lsize = 1, int ngroups = 1, int vecn = 1) {

	array_t<T> ref(rows, cols);
	ref.setRandom();

	// std::cout << "ref:" << std::endl;
	// std::cout << ref << std::endl;

	// make an opencl copy of the eigen array
	size_t padding = lsize * ngroups * vecn;
	//std::cout << "padding: " << lsize << ", " << ngroups << ", " << vecn << ", = " << padding << std::endl;

	cl_array<T> x = cl_array<T> (&ocl, ref, padding);
	cl_array<T> y = cl_array<T> (&ocl, ref.rows(), ref.cols(), padding);

	_TIMED_CALL_(y = x,  "h_" + op + string_format ("_r%zu_c%zu", rows, cols));

	// copy host_data to device
	x.sync_device();

	// find max in x and store in y
	std::string cl_config_string;

	std::string perf_key = op;

	_CL_TIMED_CALL_(cl_config_string = exec_cl (y, x, op, lsize, ngroups, vecn, profile_cl), ocl, perf_key);

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

		std::string generic_name = "cl_copy_gmem";
		std::string generic_name2 = "cl_copy_gmem_v2";
		std::string generic_name3 = "cl_copy_gmem_v3";
		std::vector<std::string> gen_list = {generic_name, generic_name2, generic_name3};

		std::string outpath = "../kernels/generated/src/";
		std::string debug_fname = "debug_" + generic_name + ".txt";
		std::string results_fname = "bench_" + generic_name + ".txt";

		int requested_device = 0;
		if (argc > 1) requested_device = atoi (argv[1]);
		init_cl(requested_device);

		std::vector<int> rs(3);
		std::vector<int> cs = {1};
		std::vector<int> ls = {};
		std::vector<int> ws;
		std::vector<int> vs = {};
		std::vector<int> hs = {0, 1}; //__attribute__((vec_type_hint(T)))

		std::cout << ocl.current_device_properties.device_string + "\n";

		if (is_cpu(ocl.current_device_properties)) {

			std::cout << "CPU" << std::endl;
			std::generate_n(rs.begin(), rs.size(), [] { static int i {1 << 12}; return i <<= 4; });
			ls = {1, 2, 4, 8, 16, 18, 32, 36, 72};
			ws = {1, 2, 4, 8, 16, 18, 32, 36, 72};
			vs = {1, 2, 4, 8, 16};

		} else {

			std::cout << "GPU" << std::endl;
			std::generate_n(rs.begin(), rs.size(), [] { static int i {1 << 12}; return i <<= 4; });
			ws.resize(10);
			std::generate_n(ws.begin(), ws.size(), [] { static int i {ocl.current_device_properties.compute_units}; return i += ocl.current_device_properties.compute_units; });
			ls = {16, 32, 64, 128, 256, 512, 1024};
			vs = {1, 2, 4, 8, 16};

		}

		auto configurations = generate_configurations(RANDOM_SHUFFLE, rs, cs, ls, ws, vs, hs);

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
			int l = std::get<2>(config);
			int w = std::get<3>(config);
			int v = std::get<4>(config);
			int h = std::get<5>(config);
			int g = l * w;
			int n = round_up_multiple(r * c, g * v); // round up to the nearest multiple of a block of threads
			assert (n % (g * v) == 0);

			int iters = n / (g * v); // need exactly iters iterations

			Dict<var_t> values;
			values["$N$"] = std::to_string(n);
			assert (n % v == 0);
			values["$S$"] = std::to_string(n / v);
			values["$H$"] = std::to_string(h);
			values["$L$"] = std::to_string(l);
			values["$G$"] = std::to_string(g);
			values["$W$"] = std::to_string(w);
			values["$I$"] = std::to_string(iters);
			values["$T$"] = t;
			values["$V$"] = std::to_string(v);
			values["$TV$"] = t + (v > 1 ? std::to_string(v) : "");

			// std::cout << "N " << n << std::endl;
			// std::cout << "L " << l << std::endl;
			// std::cout << "G " << g << std::endl;
			// std::cout << "W " << w << std::endl;
			// std::cout << "I " << iters << std::endl;

			for (auto& i : gen_list) {

				code_t k_code = make_tt (i, values, false);

				// find out kernel name:
				std::regex kname_re ("k_gen_.*?" + i);
				std::vector<pair_str_int> matches = find_pattern(k_code, kname_re);
				std::string kname = matches.size() > 0 ? matches[0].first : i;
				std::string fname = outpath + kname + ".cl";

				write_to_file (fname, k_code, true);

				//std::cout << "generated \"" + i + "\" :\n>>>>>>>>>>>>>>>\n" + k_code + "\n<<<<<<<<<<<<<<<\nwritten to: " + fname + "\n";

				ocl.add_program(i, fname);
				ocl.add_kernel (kname, i);
				ocl.kernels[kname].bytes_in = (long double)(r * c * sizeof(float)) / (long double)(1 << 30);
				ocl.kernels[kname].bytes_out = (long double)(r * c * sizeof(float))  / (long double)(1 << 30);
				ocl.kernels[kname].flops = 0;

				ocl.err = 0;

				run_benchmark<float>(r, c, kname, l, w, v);

				std::ostringstream os;

				long double GBs = (pdata[kname].bytes_in + pdata[kname].bytes_out) / (pdata[kname].time);
				long double GFs = (pdata[kname].flops) / (pdata[kname].time);

				if (GBs > top_gb) { top_gb = GBs; conf_str_gb = "r " + std::to_string(r) + " c " + std::to_string(c) + " r*c " + std::to_string(r * c) + " n " + std::to_string(n) + " l " + std::to_string(l) + " c " + std::to_string(c) + " v " + std::to_string(v ) + " w " + std::to_string(w)  + " h " + std::to_string(h) + " " + i;}
				if (GFs > top_gf) { top_gf = GFs; conf_str_gf = " r " + std::to_string(r) + " c " + std::to_string(c) + " r*c " + std::to_string(r * c) + " n " + std::to_string(n) + " l " + std::to_string(l) + " c " + std::to_string(c) + " v " + std::to_string(v) + " w " + std::to_string(w) + " h " + std::to_string(h) + " " + i;}
				os << std::setw(10) << ++count << "/"  << configurations.size() * gen_list.size() << ": " << std::setw(25) << config << "\t" << std::setw(20) << std::to_string(GBs) << " GB/s";
				//os << std::to_string(GFs) + " GF/s" + "\t";
				os << std::setw(20) << "\terr: " + std::to_string(pdata[kname].errors) + "\t#1 GB/s = " + std::to_string(top_gb) + "\t" + conf_str_gb + "\n";

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
