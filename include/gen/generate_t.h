/*
* @Author: Kamil Rocki
* @Date:   2017-05-11 11:49:22
* @Last Modified by:   krocki
* @Last Modified time: 2017-05-11 21:52:39
*/

#include <utils/common.h>
#include <gen/defs.h>

code_t generate_t (code_t T, std::string prefix = "../include/gen/templates/", std::string suffix = ".t") {

	std::cout << "generate_t: " + T << std::endl;
	code_t body = "";

	body += read_file(prefix + T + suffix );

	std::cout << body << std::endl;

	// remove_comments(body)
	// regex -> "// * newline " -> ""
	// regex -> /* * */ -> ""

	std::cout << body << std::endl;

	std::vector<std::string> tokens = tokenize(body, " ");

	for (auto& tok : tokens) {
		std::cout << tok << std::endl;
	}

	return body;

}
