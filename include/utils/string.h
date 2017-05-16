/*
* @Author: Kamil Rocki
* @Date:   2017-05-12 08:18:54
* @Last Modified by:   Kamil Rocki
* @Last Modified time: 2017-05-15 15:27:24
*/

#include <regex>
#include <string>
#include <vector>
#include <sstream>
#include <iomanip> // set_w

#ifndef _STRING_OPS_H_
#define _STRING_OPS_H_

std::string prefix_line (std::string in, std::string prefix = "") {

	std::string result = "";

	std::istringstream iss(in);

	for (std::string line; std::getline(iss, line); ) {
		result += prefix + line + "\n";
	}

	return result;
}

std::string comment(std::string in) {

	return prefix_line (in, "// ");
}

std::string indent(std::string in, int level = 1, bool spaces = false) {

	std::string prefix = "";
	for (int i = 0; i < level; i++) prefix += spaces ? " " : "\t";

	return prefix_line (in, prefix);
}

std::string subst_char(std::string& in, char x, char y) {

	std::string result = in;
	// replace all x with y
	std::replace( result.begin(), result.end(), x, y);
	return result;

}

std::string sanitize(const std::string& s) {
	std::regex re(R"([\s\S])");
	return std::regex_replace (s, re, "[$&]", std::regex_constants::format_default);
}

// http://en.cppreference.com/w/cpp/regex/regex_replace

std::string subst(std::string in, std::string regexp_in, std::string regexp_out) {

	std::string text = in;

	std::regex vowel_re(regexp_in);

	// construct a string holding the results
	text = std::regex_replace(text, vowel_re, regexp_out);

	return text;

}

std::string strip_comments(std::string& in) {

	std::string out = in;

	//out = subst(out, "//(.*?)#newline#", "");
	out = subst(out, "/\\*(.*?)\\*/", "");

	return out;

}

std::string find_regex(std::string& in, std::string regex_str) {

	std::smatch sm;
	std::regex reg1(regex_str);
	bool b = std::regex_search(in, sm, reg1);
	std::cout << "Match found at pos. " << sm.position() << std::endl;
	std::cout << "Pattern found was: " << sm.str() << std::endl;

	return b ? sm.str() : "not found!";
}

/*
#include <regex>
#include <string>
using std::regex;
using std::string;
using std::sregex_token_iterator;
. . .
// Delimiters are spaces (\s) and/or commas
regex re("[\\s,]+");
string s = "The White Rabbit,  is very,late.";
sregex_token_iterator it(s.begin(), s.end(), re, -1);
sregex_token_iterator reg_end;
for (; it != reg_end; ++it) {
     std::cout << it->str() << std::endl;
}
*/

template<typename T>
void remove_prefix (std::basic_string<T>& s, const std::basic_string<T>& p) {
	typename std::basic_string<T>::size_type n = p.length();

	for (typename std::basic_string<T>::size_type i = s.find (p);
	        i != std::basic_string<T>::npos;
	        i = s.find (p) )
		s.erase (i, n);
}


std::string getFirstWord (std::string & str) {
	return str.substr (0, str.find (' ') );
}

std::vector<std::string> split (std::string in) {
	std::vector<std::string> strings;
	std::istringstream f (in);
	std::string s;

	while (getline (f, s, ' ') ) {
		std::cout << s << std::endl;
		strings.push_back (s);
	}

	return strings;
}


template <typename T>
std::string to_string_with_precision (const T a_value, const int m = 12, const int n = 5) {
	std::ostringstream out;
	out << std::fixed << std::setw (m) << std::setprecision (n) << std::setfill ('_') << a_value;
	return out.str();
}

std::string string_format (const std::string fmt_str, ...) {
	int final_n, n = ( (int) fmt_str.size() ) * 2;   /* Reserve two times as much as the length of the fmt_str */
	std::string str;
	std::unique_ptr<char[]> formatted;
	va_list ap;

	while (1) {
		formatted.reset (new char[n]);   /* Wrap the plain char array into the unique_ptr */
		strcpy (&formatted[0], fmt_str.c_str() );
		va_start (ap, fmt_str);
		final_n = vsnprintf (&formatted[0], n, fmt_str.c_str(), ap);
		va_end (ap);

		if (final_n < 0 || final_n >= n)
			n += abs (final_n - n + 1);

		else
			break;
	}

	return std::string (formatted.get() );
}

std::vector<std::string> tokenize(const std::string& s, const std::string& regex) {

	std::string text = s;
	std::regex ws_re(regex);

	std::vector<std::string> out;

	std::sregex_token_iterator it ( s.begin(), s.end(), ws_re, -1 );
	std::sregex_token_iterator reg_end;

	for (; it != reg_end; ++it)  {
		out.push_back(it->str());
	}

	return out;
}

std::vector<std::string> words(const std::string& s, std::string delimiter = "\\s+") {

	return tokenize(s, delimiter); // whitespace

}

bool string_contains(const std::string& s1, const std::string s2) {

	return (s1.find(s2) != std::string::npos);
}

std::pair<std::string, std::string> split(const std::string s, std::string delimiter = "\\s+") {

	if (!string_contains(s, delimiter)) {

		return std::make_pair(s, "");
	}

	std::vector<std::string> pair;
	auto it = s.find(delimiter);
	std::string fst = s.substr(0, it);
	std::string snd = s;
	snd.erase(0, it + 1);
	return std::make_pair(fst, snd); // whitespace

}

// taken from
// http://stackoverflow.com/questions/83439/remove-spaces-from-stdstring-in-c
std::string delUnnecessary (std::string& str) {
	int size = str.length();

	for (int j = 0; j <= size; j++) {
		for (int i = 0; i <= j; i++) {
			if (str[i] == ' ' && str[i + 1] == ' ')
				str.erase (str.begin() + i);

			else if (str[0] == ' ')
				str.erase (str.begin() );

			else if (str[i] == '\0' && str[i - 1] == ' ')
				str.erase (str.end() - 1);
		}
	}

	return str;
}

#endif