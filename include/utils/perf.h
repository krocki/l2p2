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
			pdata[desc].time += func_time; \
			pdata[desc].calls += 1; \
			pdata[desc].description = desc; \
		} \
	} while (0)

typedef enum sort_method_type { NO_SORTING = 0, SORT_BY_TIME_DESC = 1, SORT_BY_FLOPS_DESC = 2, SORT_BY_NAME = 3, SORT_BY_NAME_DESC = 4, SORT_BY_CALLS_DESC = 5, SORT_BY_BANDW_DESC = 6} sort_method_type;
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
	unsigned long long errors = 0L;

	performance_counter (std::string _description = "") : description (_description) {
		reset();
	}

	void reset() {

		time = 0.0;
		flops = 0.0;
		bytes_in = 0.0;
		bytes_out = 0.0;
		calls = 0L;
		errors = 0L;
	}

	std::string show (const double global_time = 0.0, double total_cl_time = 0.0, unsigned long total_cl_flops_performed = 0L, unsigned long total_bytes_in = 0L,  unsigned long total_bytes_out = 0L, const int m = 7, const int n = 3) {

		double cl_time_perc = 0;
		double total_time_perc = 0;
		double total_flops_perc = 0;
		double total_bytes_in_perc = 0;
		double total_bytes_out_perc = 0;

		std::string results = "";

		if (!description.empty() ) results += description;
		if (total_cl_time > 0.0) cl_time_perc = (100.0 * time) / total_cl_time;
		if (global_time > 0.0) total_time_perc = (1e-7 * time) / global_time;
		if (total_cl_flops_performed > 0) total_flops_perc = ( (100.0 * (long double) flops) / (long double) total_cl_flops_performed);
		if (total_bytes_in > 0) total_bytes_in_perc = ( (100.0 * (long double) bytes_in) / (long double) total_bytes_in);
		if (total_bytes_out > 0) total_bytes_out_perc = ( (100.0 * (long double) bytes_out) / (long double) total_bytes_out);

		results += string_format (", err/total %06d/%06d", errors, calls);
		results += string_format (", T %3.3f s", time * 1e-9);
		results += string_format (", t/call %3.3f ms", (1e-6 * time) / ((double)calls));

		results += string_format (", GF/s %5.2f", ((double)(flops) / (double)(time * 1e-9)));
		results += string_format (", GB/s %5.2f", ((double)bytes_in + (double)bytes_out) / (double)time);
		results += string_format (", err %3.2f", ((double)errors / (double)calls));

		results += "\n";

		return results;
	}

};

std::string show_profiling_data (Dict<performance_counter>& pdata, sort_method_type sort_method = SORT_BY_TIME_DESC, profiling_type ptype = OFF, bool reset_counters = true, size_t show_top_k = 0) {

	unsigned long total_cl_flops_performed  = 0L;
	unsigned long total_bytes_in  = 0L;
	unsigned long total_bytes_out  = 0L;
	unsigned long total_calls  = 0L;

	std::string out = "";

	double total_cl_time = 0.0;
	end = std::chrono::system_clock::now();
	double difference = (double) std::chrono::duration_cast<std::chrono::microseconds> (end - start).count() / (double) 1e6;
	// out += std::string("T = ") + std::to_string(difference) + " s\n";

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
			auto f1 = pdata.entries[i1].flops / pdata.entries[i1].time;
			auto f2 = pdata.entries[i2].flops / pdata.entries[i2].time;
			if (!isNaNInf (f1) && !isNaNInf (f2))
				return f1 > f2;
			else return false;
		});
		break;

	case SORT_BY_BANDW_DESC:
		sorted_idxs = pdata.sorted_idxs ([&] (size_t i1, size_t i2) {
			double B1 = pdata.entries[i1].bytes_in + pdata.entries[i1].bytes_out;
			double B2 = pdata.entries[i2].bytes_in + pdata.entries[i2].bytes_out;
			auto b1 = B1 / pdata.entries[i1].time;
			auto b2 = B2 / pdata.entries[i2].time;
			if (!isNaNInf (b1) && !isNaNInf (b2))
				return b1 > b2;
			else return false;
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
	size_t entries_to_show = show_top_k == 0 ? pdata.entries.size() : show_top_k;

	for (size_t i = 0; i < entries_to_show; i ++) {
		if (ptype != OFF) {

			out += pdata.reverse_namemap[ sorted_idxs[i] ];
			if (show_top_k == 0) {

				out += pdata.entries[ sorted_idxs[i] ].show (difference, total_cl_time, total_cl_flops_performed, total_bytes_in, total_bytes_out);
			} else {

				out += " " + string_format ("%7.5f GB/s", (double)((pdata.entries[ sorted_idxs[i] ].bytes_in + pdata.entries[ sorted_idxs[i] ].bytes_out)) / (double)(pdata.entries[ sorted_idxs[i] ].time)) + "\t" + string_format ("%7.5f GF/s", (double)((pdata.entries[ sorted_idxs[i] ].flops)) / (double)(pdata.entries[ sorted_idxs[i] ].time * 1e-9));
			}
		}

		if (reset_counters)
			pdata.entries[ sorted_idxs[i] ].reset();
	}

	if (ptype != OFF && show_top_k == 0) {
		out += "\n";
		out +=  "Total profiled time: " + std::to_string(1e-9 * total_cl_time) + " s ( " + std::to_string ( (100.0 * (long double) (1e-9 * total_cl_time) / (long double) difference)) + " )\n";

		out += "Total compute: " + std::to_string(1e-9 * ( (long double) total_cl_flops_performed / (long double) difference)) + " GF\n";
		out += "Total in: " + std::to_string(1e-9 * ( (long double) total_bytes_in)) + " GB\n";
		out += "Total out: " + std::to_string(1e-9 * ( (long double) total_bytes_out)) + " GB\n";
		out += "Total kernel calls: " + std::to_string(total_calls) + "\n\n";
	}

	start = std::chrono::system_clock::now();

	return out;
}


Dict<performance_counter> pdata;
profiling_type prof_enabled = GPU_ONLY;

#endif /*__PERF_H__*/
