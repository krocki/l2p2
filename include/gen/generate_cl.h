/*
* @Author: Kamil Rocki
* @Date:   2017-05-11 11:49:22
* @Last Modified by:   Kamil Rocki
* @Last Modified time: 2017-05-11 16:28:24
*/

#include <iostream>
#include <gen/header.h>
#include <gen/templates.h>
#include <gen/defs_cl.h>
#include <gen/defs.h>

#define make_kernel(expr) _internal_make_kernel(#expr, expr);


template <class K>
code_t _internal_make_kernel(std::string kname_raw, K k_template) {

	code_t body = "";

	if (kname_raw == "") return " // kernel not generated, no name given";

	std::string kname = kname_raw;

	kname = "_" + subst(kname, "\\)|\\(", "_");
	//body += header;
	//body += "// defs_cl.h\n";
	//body += defs_cl;

	body += "// " + kname + "\n";

	code_t args = "$dtype$ptr restrict out, const $dtype$ptr restrict in";

	body += "__kernel void\n" + code_t(kname) + " (" + args + ") " + "{\n";

	//consts
	code_t consts = "\n // consts \n";
	consts += "const int id = get_group_id(0);\n";

	body += indent(consts);

	body += indent(k_template);

	body += code_t("} // " + kname + "\n");

	//apply data_type
	body = subst(body, "\\$dtype", "float");
	body = subst(body, "\\$ptr", "*");

	return body;

}