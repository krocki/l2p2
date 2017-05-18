/*
* @Author: Kamil Rocki
* @Date:   2017-05-16 15:22:30
* @Last Modified by:   Kamil M Rocki
* @Last Modified time: 2017-05-18 08:19:26
*/

#include <gen/defs.h>
#include <utils/string.h>
#include <tinyexpr.h>

// compiler might be able to do this (or might not, need to check)
#ifndef _OPT_H_
#define _OPT_H_

//take care of i = 0 i < 1 and i < 0
code_t remove_non_loops(code_t& input) {

	const code_t out = input;

	//std::string t = find_regex(input, "for.*?\\(.*?;.*?;.*?\\)");
	std::regex loop_header("for(.*?)\\((.*?);(.*?);(.*?)\\)");
	std::regex entire_loop("((#pragma(.*?)unroll(.*?)).*?)for(.*?)\\((.*?);(.*?);(.*?)\\)(.*?)\\{?(.*?)\\}?");
	std::smatch match;
	if (std::regex_search(out.begin(), out.end(), match, loop_header)) {
		std::cout << "space: " << match[1] << '\n';
		std::cout << "init: " << match[2] << '\n';
		const std::string condition = match[3];
		std::smatch match_inner;
		if (std::regex_search(condition.begin(), condition.end(), match_inner, re_digits)) {

			std::cout << "cond val: " << match_inner[0] << '\n';

			std::string strval = match_inner[0];
			int val = atoi(strval.c_str());

			if (val <= 0) input = std::regex_replace (out, entire_loop, "", std::regex_constants::format_default);
			else if (val == 1) input = std::regex_replace (out, loop_header, "", std::regex_constants::format_default);

			std::cout << input;
		}

		std::cout << "increment: " << match[4] << '\n';
	}
	// std::regex re(R"([\s\S])");
	// return std::regex_replace (s, re, "[$&]", std::regex_constants::format_default);

	return input;
}

//remove all the dirty stuff
code_t prune_ifdefs() {


}

#endif
