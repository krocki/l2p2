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
#include <chrono> // timer

// misc functions

bool isNaNInf (float f) {
	return (std::isnan (f) || std::isinf (f) );
}

size_t round_up_multiple(size_t num, size_t multiple) {

	assert(multiple);
	return ((num + multiple - 1) / multiple) * multiple;

}

size_t is_multiple(size_t num, size_t multiple) {

	assert(multiple);
	return (num % multiple) == 0;

}

bool is_pow2(size_t num) {

	return (num & (num - 1)) == 0;
}

size_t round_up_multiple_pow2(size_t num, size_t multiple) {

	assert(multiple && is_pow2(multiple));
	return (num + multiple - 1) & ~(multiple - 1);

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
	auto duration = now.time_since_epoch();
	auto millis = std::chrono::duration_cast<std::chrono::milliseconds>(duration).count();
	ss << std::put_time (std::localtime (&in_time_t), format);
	return ss.str();
}

//formatting a table
template<typename charT, typename traits = std::char_traits<charT> >
class center_helper {
	std::basic_string<charT, traits> str_;
public:
	center_helper(std::basic_string<charT, traits> str) : str_(str) {}
	template<typename a, typename b>
	friend std::basic_ostream<a, b>& operator<<(std::basic_ostream<a, b>& s, const center_helper<a, b>& c);
};

template<typename charT, typename traits = std::char_traits<charT> >
center_helper<charT, traits> centered(std::basic_string<charT, traits> str) {
	return center_helper<charT, traits>(str);
}

// redeclare for std::string directly so we can support anything that implicitly converts to std::string
center_helper<std::string::value_type, std::string::traits_type> centered(const std::string& str) {
	return center_helper<std::string::value_type, std::string::traits_type>(str);
}

template<typename charT, typename traits>
std::basic_ostream<charT, traits>& operator<<(std::basic_ostream<charT, traits>& s, const center_helper<charT, traits>& c) {
	std::streamsize w = s.width();
	if (w > c.str_.length()) {
		std::streamsize left = (w + c.str_.length()) / 2;
		s.width(left);
		s << c.str_;
		s.width(w - left);
		s << "";
	} else {
		s << c.str_;
	}
	return s;
}


//for printing tuple contents
namespace aux {
template<std::size_t...> struct seq {};

template<std::size_t N, std::size_t... Is>
struct gen_seq : gen_seq < N - 1, N - 1, Is... > {};

template<std::size_t... Is>
struct gen_seq<0, Is...> : seq<Is...> {};

template<class Ch, class Tr, class Tuple, std::size_t... Is>
void print_tuple(std::basic_ostream<Ch, Tr>& os, Tuple const& t, seq<Is...>) {
	using swallow = int[];
	(void)swallow{0, (void(os << std::setw(8) << std::get<Is>(t) ), 0)...};
}
} // aux::

template<class Ch, class Tr, class... Args>
auto operator<<(std::basic_ostream<Ch, Tr>& os, std::tuple<Args...> const& t)
-> std::basic_ostream<Ch, Tr>& {

	os << "{";
	aux::print_tuple(os, t, aux::gen_seq<sizeof...(Args)>());
	return os << "}";
}


template<typename... Ts, size_t I = 1>
std::string pretty_print(std::tuple<Ts...> const& a) {

	std::ostringstream stream;
	stream << a;
	return stream.str();
}

template<typename... Ts, size_t I = 1>
std::string pretty_print(std::vector<std::tuple<Ts...>> const& res) {

	int count = 0;
	std::string out = "";

	for (auto& a : res) {

		out += pretty_print(a) + std::string("\n");
	}

	return out;
}

//cartesian product of n vectors
//http://stackoverflow.com/questions/13813007/tmp-how-to-generalize-a-cartesian-product-of-vectors
// cross_imp(f, v...) means "do `f` for each element of cartesian product of v..."
template<typename F>
inline void cross_imp(F f) {
	f();
}
template<typename F, typename H, typename... Ts>
inline void cross_imp(F f, std::vector<H> const& h,
                      std::vector<Ts> const&... t) {
	for (H const& he : h)
		cross_imp([&](Ts const & ... ts) {
		f(he, ts...);
	}, t...);
}

template<typename... Ts>
std::vector<std::tuple<Ts...>> cross(std::vector<Ts> const&... in) {
	std::vector<std::tuple<Ts...>> res;
	cross_imp([&](Ts const & ... ts) {
		res.emplace_back(ts...);
	}, in...);
	return res;
}

#endif
