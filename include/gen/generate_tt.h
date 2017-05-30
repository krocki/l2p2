/*
* @Author: krocki
* @Date:   2017-05-13 18:35:21
* @Last Modified by:   Kamil Rocki
* @Last Modified time: 2017-05-30 16:37:46
*/

#include <utils/io.h>
#include <utils/string.h>
#include <utils/dict.h>
#include <gen/parse.h>
#include <gen/defs.h>

code_t make_tt(std::string T, Dict<var_t> vars, bool debug = false, std::string indent = "") {

	code_t body = "";

	std::string resource_name = "../include/gen/templates/" + T + ".tt";

	code_t tt_body = read_file(resource_name);

	//TODO: change to all possible
	tt_body = subst(tt_body, "\n", std::string(NEWLINE_STR + indent));

	// process tt_body
	code_t tt_body_processed = process_tt(tt_body, vars, debug);

	//body += " // " + resource_name + NEWLINE_STR;

	if (debug) {

		body += NEWLINE_STR + "/* raw */" + std::string(NEWLINE_STR);
		body += "/* " + tt_body + "*/" + std::string(NEWLINE_STR);
		body += NEWLINE_STR + "/* final */" + std::string(NEWLINE_STR);
	}

	body += tt_body_processed;
	//body += "// EOF " + resource_name;

	body = subst(body, std::string(NEWLINE_STR + indent) , "\n");

	return body;

}
