/*
    @Author: kmrocki@us.ibm.com
    @Date:   2017-03-03 15:22:47
    @Last Modified by:   Kamil Rocki
    @Last Modified time: 2017-04-28 15:22:18
*/

#ifndef __UTIL_MAIN_H__
#define __UTIL_MAIN_H__

// to surpress warnings
#define UNUSED(...) [__VA_ARGS__](){};

// #include <cstring>
// #include <string>
// #include <cfloat>
// #include <chrono>
// #include <stdarg.h>  // For va_start, etc.
// #include <memory>    // For std::unique_ptr
// #include <iostream>

#include <sstream>
#include <iomanip> // put_time
#include <cmath> // isnan, isinf
#include <numeric> // iota
#include <algorithm> // sort
#include <vector>

// misc functions

bool isNaNInf (float f) {
	return (std::isnan (f) || std::isinf (f) );
}

// sort and keep track of indices
template <typename T, class F>
std::vector<size_t> sort_idxs (const std::vector<T>& v, F& f) {
	// initialize original index locations
	std::vector<size_t> idx (v.size() );
	std::iota (idx.begin(), idx.end(), 0);
	// sort indexes based on comparing values in v
	std::sort (idx.begin(), idx.end(), f);
	return idx;
}


// time/date functions

double get_time_diff (const struct timeval* s, const struct timeval* e) {
	// computes time difference between s and e
	struct timeval  diff_tv;
	diff_tv.tv_usec = e->tv_usec - s->tv_usec;
	diff_tv.tv_sec = e->tv_sec - s->tv_sec;

	if (s->tv_usec > e->tv_usec) {
		diff_tv.tv_usec += 1000000;
		diff_tv.tv_sec--;
	}

	return (double) diff_tv.tv_sec + ( (double) diff_tv.tv_usec / 1000000.0);
}

std::string return_current_time_and_date (const char* format = "%x %X") {
	auto now = std::chrono::system_clock::now();
	auto in_time_t = std::chrono::system_clock::to_time_t (now);
	std::stringstream ss;
	ss << std::put_time (std::localtime (&in_time_t), format);
	return ss.str();
}

#endif
