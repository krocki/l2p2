/*
* @Author: Kamil Rocki
* @Date:   2017-05-14 20:55:55
* @Last Modified by:   Kamil Rocki
* @Last Modified time: 2017-05-16 20:09:45
*/

#include <iostream>
#include <utils/ansi_colors.h>

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
	cl_array<T> x = cl_array<T> (&ocl, ref, padding);
	cl_array<T> y = cl_array<T> (&ocl, ref.rows(), ref.cols(), padding);

	_TIMED_CALL_(y = x,  "h_" + op + string_format ("_r%zu_c%zu", rows, cols));

	// copy host_data to device
	x.sync_device();

	// find max in x and store in y
	std::string cl_config_string;

	std::string perf_key = op;

	_CL_TIMED_CALL_(cl_config_string = exec_cl (y, x, op, lsize, ngroups, profile_cl), ocl, perf_key);

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

template <typename ...T>
auto generate_configurations(std::vector<T>& ...is) {

	return cross(is...);
}

int main (int argc, char** argv) {

	try {

		std::string generic_name = "fmads";//"cl_copy_gmem";
		std::vector<std::string> gen_list = {generic_name};
		std::string outpath = "../kernels/generated/src/";
		std::string debug_fname = "debug_" + generic_name + ".txt";
		std::string results_fname = "bench_" + generic_name + ".txt";

		int requested_device = 0;
		if (argc > 1) requested_device = atoi (argv[1]);
		init_cl(requested_device);

		// std::vector<int> rs = {1, 2, 4, 8, 16, 32, 64, 128, 256, 512};
		// std::vector<int> cs = {1, 2, 4, 8, 16, 32, 64, 128, 256, 512};
		// std::vector<int> ls = {4, 8, 16, 32, 64, 128, 256};
		// std::vector<int> ws = {32, 64, 128, 256, 512, 1024};
		// std::vector<int> vs = {1, 2, 4, 8, 16};

		std::vector<int> fls = {1, 2, 4, 8, 16, 32, 64};
		std::vector<int> rs = {256};
		std::vector<int> cs = {256};
		std::vector<int> ls = {1, 2, 4, 8, 16, 32, 64, 128, 256};
		std::vector<int> ws = {1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192};
		std::vector<int> vs = {1, 2, 4, 8, 16};

		auto configurations = generate_configurations(fls, rs, cs, ls, ws, vs);

		unsigned long long count = 0;

		std::string results = "";

		for (auto& config : configurations) {

			std::string t = "float";
			int k_iters = std::get<0>(config);
			int r = std::get<1>(config);
			int c = std::get<2>(config);
			int l = std::get<3>(config);
			int w = std::get<4>(config);
			int v = std::get<5>(config);
			int g = l * w;
			int n = r * c;
			int iters = (n - 1) / (g * v) + 1;

			Dict<var_t> values;
			values["$N$"] = std::to_string(n);
			values["$L$"] = std::to_string(l);
			values["$G$"] = std::to_string(g);
			values["$W$"] = std::to_string(w);
			values["$I$"] = std::to_string(iters);
			values["$K$"] = std::to_string(k_iters);
			values["$T$"] = t;
			values["$V$"] = std::to_string(v);
			values["$TV$"] = t + (v > 1 ? std::to_string(v) : "");

			for (auto& i : gen_list) {

				code_t k_code = make_tt (i, values, false);

				// find out kernel name:
				std::regex kname_re ("k_gen_.*?" + generic_name);
				std::vector<pair_str_int> matches = find_pattern(k_code, kname_re);
				std::string kname = matches.size() > 0 ? matches[0].first : i;
				std::string fname = outpath + kname + ".cl";

				write_to_file (fname, k_code, true);

				//std::cout << "generated \"" + i + "\" :\n>>>>>>>>>>>>>>>\n" + k_code + "\n<<<<<<<<<<<<<<<\nwritten to: " + fname + "\n";

				ocl.add_program(generic_name, fname);
				ocl.add_kernel (kname, generic_name);
				ocl.kernels[kname].flops = 8 * k_iters * n;

				run_benchmark<float>(r, c, kname, l, w, v);

				std::ostringstream os;

				os << ++count << "/"  << configurations.size() << ": " << config << "\t" + string_format ("%7.5f GB/s", (double)((pdata[kname].bytes_in + pdata[kname].bytes_out)) / (double)(pdata[kname].time)) + "\t" + string_format ("%7.5f GF/s", (double)((pdata[kname].flops)) / (double)(pdata[kname].time)) + "\terr: " + std::to_string(pdata[kname].errors) + "\n";
				results += os.str();
				std::cout << os.str();

			}

		}

		results += "OPENCL LOG:\n" + ocl.getlog() + "--- OPENCL LOG\n";
		results += std::to_string(configurations.size()) + " configurations:\n";

		results += pretty_print(configurations);

		results += std::string("loaded programs:\n") + ocl.loaded_programs() + "\n\n\n";
		results += std::string("loaded kernels:\n") + ocl.loaded_kernels() + "\n\n\n";

		results += "\n\n results ( " + generic_name + "):\n";

		// std::string prof_results = show_profiling_data(pdata, SORT_BY_BANDW_DESC, prof_enabled, true);
		std::string prof_results = show_profiling_data(pdata, SORT_BY_FLOPS_DESC, prof_enabled, true);
		std::cout << prof_results << std::endl;
		write_to_file (results_fname, prof_results, true);

		results += prof_results;
		results += "errors: " + std::to_string(total_errors) + "/" + std::to_string(total_runs);

		write_to_file (debug_fname, results, true);

	} catch (const std::runtime_error &e ) {

		std::string error_msg = std::string ( "main() - std::runtime_error: " ) + std::string ( e.what() );

		std::cerr << error_msg << std::endl;

		return -1;

	}

	return 0;

}
