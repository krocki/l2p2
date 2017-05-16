/*
* @Author: krocki
* @Date:   2017-05-13 18:35:21
* @Last Modified by:   Kamil Rocki
* @Last Modified time: 2017-05-15 12:44:35
*/

#include <utils/io.h>
#include <gen/parse.h>
#include <gen/defs.h>

code_t make_tt(std::string T) {

	code_t body = "";

	std::string resource_name = "../include/gen/templates/" + T + ".tt";

	code_t tt_body = read_file(resource_name);

	// process tt_body
	code_t tt_body_processed = process_tt(tt_body);

	body += "// " + resource_name + "\n";

	body += "\n/* raw */\n";
	body += "/* " + tt_body + "*/\n";
	body += "\n/* final */\n";
	body += tt_body_processed;
	body += "// EOF " + resource_name;

	return body;

}
