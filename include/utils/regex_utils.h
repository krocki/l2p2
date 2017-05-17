/*
* @Author: Kamil Rocki
* @Date:   2017-05-16 13:48:55
* @Last Modified by:   Kamil Rocki
* @Last Modified time: 2017-05-16 14:03:21
*/

#include <regex>

#ifndef _REGEX_UTILS_H_
#define _REGEX_UTILS_H_

// https://solarianprogrammer.com/2011/10/20/cpp-11-regex-tutorial-part-2/
std::regex re_integer("(\\+|-)?[[:digit:]]+");
std::regex re_digit("[[:digit:]]");
std::regex re_digits("[[:digit:]]+");
std::regex re_float("((\\+|-)?[[:digit:]]+)(\\.(([[:digit:]]+)?))?");
std::regex re_scientific("((\\+|-)?[[:digit:]]+)(\\.(([[:digit:]]+)?))?((e|E)((\\+|-)?)[[:digit:]]+)?");
std::regex leading_spaces("[[:space:]]*(.+)");
std::regex word("[[:alpha:]]+");

std::regex alphanum("[a-z_][a-z_0-9]*\\.[a-z0-9]+", std::regex_constants::icase);

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

#endif