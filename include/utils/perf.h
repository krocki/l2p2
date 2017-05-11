/*
    @Author: kmrocki@us.ibm.com
    @Date:   2017-04-28 12:49:03
    @Last Modified by:   kmrocki@us.ibm.com
    @Last Modified time: 2017-04-29 11:21:31
*/

#ifndef __PERF_H__
#define __PERF_H__

#include <utils/dict.h>
#include <chrono>

typedef enum profiling_type {OFF = 0, CPU_ONLY = 1, GPU_ONLY = 2, CPU_GPU = 3} profiling_type;

#define CL_PROF_ENABLED (((prof_enabled == GPU_ONLY) || (prof_enabled == CPU_GPU)) ? true : false)
#define CPU_PROF_ENABLED (((prof_enabled == CPU_ONLY) || (prof_enabled == CPU_GPU)) ? true : false)

#define _TIMED_CALL_(func, ...)  \
	do { \
		std::chrono::time_point<std::chrono::system_clock> func_start, func_end; \
		if (CPU_PROF_ENABLED) { \
			func_start = std::chrono::system_clock::now(); \
		} \
		func; \
		if (CPU_PROF_ENABLED) { \
			func_end = std::chrono::system_clock::now(); \
			double func_time = ( double ) std::chrono::duration_cast<std::chrono::nanoseconds> ( func_end - func_start ).count(); \
			std::string key = std::string(__VA_ARGS__); \
			std::string desc = std::string(#func); desc = ""; \
			if (key.empty()) { key = std::string(#func); desc = std::string(__VA_ARGS__); } \
			pdata[key].time += func_time; \
			pdata[key].calls += 1; \
			pdata[key].description = desc; \
		} \
	} while (0)

#define _CL_TIMED_CALL_(func, ocl, ...)  \
	do { \
		ocl.barrier(); \
		std::chrono::time_point<std::chrono::system_clock> func_start, func_end; \
		if (CPU_PROF_ENABLED) { \
			func_start = std::chrono::system_clock::now(); \
		} \
		func; \
		ocl.barrier(); \
		if (CPU_PROF_ENABLED) { \
			func_end = std::chrono::system_clock::now(); \
			double func_time = ( double ) std::chrono::duration_cast<std::chrono::nanoseconds> ( func_end - func_start ).count(); \
			std::string key = std::string(__VA_ARGS__); \
			std::string desc = std::string(#func); desc = "";\
			if (key.empty()) { key = std::string(#func); desc = std::string(__VA_ARGS__); } \
			pdata[key].time += func_time; \
			pdata[key].calls += 1; \
			pdata[key].description = desc; \
		} \
	} while (0)

typedef enum sort_method_type { NO_SORTING = 0, SORT_BY_TIME_DESC = 1, SORT_BY_FLOPS_DESC = 2, SORT_BY_NAME = 3, SORT_BY_NAME_DESC = 4, SORT_BY_CALLS_DESC = 5} sort_method_type;
std::chrono::time_point<std::chrono::system_clock> start, end;

class performance_counter {

  public:

	std::string key = "";
	std::string description = "";

	long double time = 0.0;
	long double flops = 0.0;
	long double bytes_in = 0.0;
	long double bytes_out = 0.0;
	unsigned long long calls = 0L;

	performance_counter (std::string _description = "") : description (_description) {
		reset();
	}

	void reset() {

		time = 0.0;
		flops = 0.0;
		bytes_in = 0.0;
		bytes_out = 0.0;
		calls = 0L;
	}

	void show (const double global_time = 0.0, double total_cl_time = 0.0, unsigned long total_cl_flops_performed = 0L, unsigned long total_bytes_in = 0L,  unsigned long total_bytes_out = 0L, const int m = 7, const int n = 3) {

		double cl_time_perc = 0;
		double total_time_perc = 0;
		double total_flops_perc = 0;
		double total_bytes_in_perc = 0;
		double total_bytes_out_perc = 0;

		if (!description.empty() ) std::cout << ", descr: " << description;
		if (total_cl_time > 0.0) cl_time_perc = (100.0 * time) / total_cl_time;
		if (global_time > 0.0) total_time_perc = (1e-7 * time) / global_time;
		if (total_cl_flops_performed > 0) total_flops_perc = ( (100.0 * (long double) flops) / (long double) total_cl_flops_performed);
		if (total_bytes_in > 0) total_bytes_in_perc = ( (100.0 * (long double) bytes_in) / (long double) total_bytes_in);
		if (total_bytes_out > 0) total_bytes_out_perc = ( (100.0 * (long double) bytes_out) / (long double) total_bytes_out);

		std::cout << " #";
		std::cout << to_string_with_precision ((double)calls * 1e-3, 5, 3) << "k";
		std::cout << ", time: " << to_string_with_precision (time * 1e-9, m, n) << " s ";
		std::cout << ", avg: " << to_string_with_precision ((1e-6 * time) / ((double)calls), m, n) << " ms ";
		// std::cout << " / ( " << to_string_with_precision (cl_time_perc, 6, 2) << "% / ";
		// std::cout << to_string_with_precision (total_time_perc, 6, 2) << "% )";
		// std::cout << ", GFlOPs " << to_string_with_precision (flops * 1e-9, m, n) << ", ";
		// std::cout << " ( " << to_string_with_precision (total_flops_perc, 6, 2) << "% )";
		std::cout << ", GF/s: " << to_string_with_precision (flops / time, m, n) << "/s ";
		// std::cout << ", GB in " << to_string_with_precision (bytes_in * 1e-9, m, n) << ", ";
		// std::cout << "( " << to_string_with_precision (total_bytes_in_perc, 6, 2) << "% )";
		// std::cout << ", GB/s: " << to_string_with_precision (bytes_in / time, m, n) << " ";
		// std::cout << ", GB out " << to_string_with_precision (bytes_out * 1e-9, m, n) << ", ";
		// std::cout << " ( " << to_string_with_precision (total_bytes_out_perc, 6, 2) << "% )";
		// std::cout << ", GB/s: " << to_string_with_precision (bytes_out / time, m, n) << " ";
		std::cout << ", GB/s: " << to_string_with_precision ((bytes_in + bytes_out) / time, m, n) << " ";
		std::cout << std::endl;
	}
};

void show_profiling_data (Dict<performance_counter>& pdata, sort_method_type sort_method = SORT_BY_TIME_DESC, profiling_type ptype = OFF, bool reset_counters = true) {

	unsigned long total_cl_flops_performed  = 0L;
	unsigned long total_bytes_in  = 0L;
	unsigned long total_bytes_out  = 0L;
	unsigned long total_calls  = 0L;

	double total_cl_time = 0.0;
	end = std::chrono::system_clock::now();
	double difference = (double) std::chrono::duration_cast<std::chrono::microseconds> (end - start).count() / (double) 1e6;
	std::cout << "T = " << difference << " s" << std::endl;

	//first pass
	for (size_t i = 0; i < pdata.entries.size(); i ++) {
		if (ptype != OFF) {
			total_cl_flops_performed += pdata.entries[ i ].flops;
			total_cl_time += pdata.entries[ i ].time;
			total_bytes_in += pdata.entries[ i ].bytes_in;
			total_bytes_out += pdata.entries[ i ].bytes_out;
			total_calls += pdata.entries[ i ].calls;
		}
	}

	std::vector<size_t> sorted_idxs;

	switch (sort_method) {
	case NO_SORTING:
		sorted_idxs.resize (pdata.entries.size() );
		std::iota (sorted_idxs.begin(), sorted_idxs.end(), 0);
		break;

	case SORT_BY_TIME_DESC:
		sorted_idxs = pdata.sorted_idxs ([&] (size_t i1, size_t i2) {
			return pdata.entries[i1].time > pdata.entries[i2].time;
		});
		break;

	case SORT_BY_CALLS_DESC:
		sorted_idxs = pdata.sorted_idxs ([&] (size_t i1, size_t i2) {
			return pdata.entries[i1].calls > pdata.entries[i2].calls;
		});
		break;

	case SORT_BY_FLOPS_DESC:
		sorted_idxs = pdata.sorted_idxs ([&] (size_t i1, size_t i2) {
			return pdata.entries[i1].flops / pdata.entries[i1].time > pdata.entries[i2].flops / pdata.entries[i2].time;
		});
		break;

	case SORT_BY_NAME:
		sorted_idxs = pdata.sorted_idxs ([&] (size_t i1, size_t i2) {
			return pdata.entries[i1].key < pdata.entries[i2].key;
		});
		break;

	case SORT_BY_NAME_DESC:
		sorted_idxs = pdata.sorted_idxs ([&] (size_t i1, size_t i2) {
			return pdata.entries[i1].key > pdata.entries[i2].key;
		});
		break;
	}

	//second pass
	for (size_t i = 0; i < pdata.entries.size(); i ++) {
		if (ptype != OFF) {
			std::cout << std::setw (50) << pdata.reverse_namemap[ sorted_idxs[i] ];
			pdata.entries[ sorted_idxs[i] ].show (difference, total_cl_time, total_cl_flops_performed, total_bytes_in, total_bytes_out);
		}

		if (reset_counters)
			pdata.entries[ sorted_idxs[i] ].reset();
	}

	if (ptype != OFF) {
		std::cout << std::endl;
		std::cout << "Total profiled time: " << 1e-9 * total_cl_time << " s " << "( " << to_string_with_precision ( (100.0 * (long double) (1e-9 * total_cl_time) / (long double) difference), 7, 3) << "% ) " << std::endl;
		std::cout << "Total compute: " << 1e-9 * ( (long double) total_cl_flops_performed / (long double) difference) << " GF/s" << std::endl;
		std::cout << "Total in: " << 1e-9 * ( (long double) total_bytes_in) << " GB" << std::endl;
		std::cout << "Total out: " << 1e-9 * ( (long double) total_bytes_out) << " GB" << std::endl;
		std::cout << "Total kernel calls: " << total_calls << std::endl;
		std::cout << std::endl;
	}

	start = std::chrono::system_clock::now();
}


Dict<performance_counter> pdata;
profiling_type prof_enabled = CPU_GPU;

#endif /*__PERF_H__*/
