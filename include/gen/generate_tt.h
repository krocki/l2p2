/*
* @Author: krocki
* @Date:   2017-05-13 18:35:21
* @Last Modified by:   krocki
* @Last Modified time: 2017-05-13 18:47:28
*/

#include <utils/io.h>
#include <gen/defs.h>

code_t make_tt(std::string T) {

	code_t body = "";

	std::string resource_name = "../include/gen/templates/" + T + ".tt";

	code_t tt_body = read_file(resource_name);

	body += "// " + resource_name + "\n";
	body += tt_body;
	body += "// EOF " + resource_name;

	return body;

}
