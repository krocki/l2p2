/*
* @Author: Kamil Rocki
* @Date:   2017-05-11 11:49:22
* @Last Modified by:   Kamil Rocki
* @Last Modified time: 2017-05-12 16:37:53
*/

#include <iostream>
#include <gen/header.h>
#include <gen/templates.h>
#include <gen/defs_cl.h>
#include <gen/defs.h>

#define make_kernel(expr) _internal_make_kernel(#expr, expr);

code_t local(var_t addr) {
	return code_t(addr + "[@gid]");
}

code_t direct(var_t addr) {
	return code_t(addr + "[@gid]");
}

template <class K>
code_t _internal_make_kernel(std::string kname_raw, K k_template) {

	code_t body = "";

	if (kname_raw == "") return " // kernel not generated, no name given";

	std::string kname = kname_raw;

	kname = "_" + subst(kname, "\\)|\\(|,\\s+", "_");
	//body += header;
	//body += "// defs_cl.h\n";
	//body += defs_cl;

	body += "// " + kname + "\n";

	var_t var_in = "in";
	var_t var_out = "out";
	var_t var_gid = "gid";

	code_t args = "@var_t@ptr_t restrict " + var_out + ", const @var_t@ptr_t restrict " + var_in;

	body += "__kernel void\n" + code_t(kname) + " (" + args + ") " + "{\n";

	//consts
	code_t consts = "\n // consts \n";
	consts += "const int " + var_gid + " = get_group_id(0);\n";

	body += indent(consts);

	body += indent(k_template);

	body += code_t("} // " + kname + "\n");

	//apply data_type
	body = subst(body, "\\@var_t", "float");
	body = subst(body, "\\@ptr_t", "*");

	//plugin inputs and outputs
	body = subst(body, sanitize("@out"), var_out);
	body = subst(body, sanitize("@in"), var_in);
	body = subst(body, sanitize("@gid"), var_gid);

	return body;

}
