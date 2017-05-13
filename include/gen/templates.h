/*
* @Author: Kamil Rocki
* @Date:   2017-05-11 12:21:24
* @Last Modified by:   Kamil Rocki
* @Last Modified time: 2017-05-12 16:44:45
*/

#include <gen/defs.h>
#include <utils/string.h>
#include <utils/io.h>

template <class F, class M>
code_t k_fmap(F f, M m) {

	code_t body = "";
	code_t file = code_t(__FILE__);
	remove_prefix (file, code_t("/Users/kmrocki/git/l2p2/"));
	body += comment(code_t(__FUNCTION__) + " in " + file + ": " + std::to_string(__LINE__)) + "\n";

	std::string T = "../include/gen/templates/fmap.tt";
	body += comment(T);
	body += read_file(T);
	body += comment(T);

	body = subst(body, sanitize("@function(@out, @in)"), f("@out", "@in"));
	body = subst(body, sanitize("@out"), m("@out"));
	body = subst(body, sanitize("@in"), m("@in"));

	return indent(body);

}
code_t fmads(var_t out, var_t in) {

	code_t body = "";
	code_t file = code_t(__FILE__);
	remove_prefix (file, code_t("/Users/kmrocki/git/l2p2/"));
	body += comment(code_t(__FUNCTION__) + " in " + file + ": " + std::to_string(__LINE__)) + "\n";
	std::string T = "../include/gen/templates/fmads.tt";
	body += comment(T);
	body += read_file(T);
	body += comment(T);

	return indent(code_t(body));
}

template <class F>
code_t k_fold(F f) {

	code_t body = "";

	var_t in_mem = "in[@gid]";
	var_t out_mem = "out[0]";

	code_t func_body = f(out_mem, in_mem);

	body += indent(func_body);

	return body;

}

code_t mov(var_t out, var_t in) {
	return code_t(out + " = " + in + ";");
}

//c = c + a * b
code_t fmad(var_t a, var_t b, var_t c) {
	return code_t("mad(" + a + ", " + b + ", " + c + ")");
}

code_t add(var_t out, var_t in) {
	return code_t(out + " + " + in);
}

code_t mul(var_t out, var_t in) {
	return code_t(out + " * " + in);
}

code_t max(var_t out, var_t in) {
	return code_t("fmax(" + out + ", " + in + ")");
}

code_t f_max_flops(var_t out, var_t in) {

	code_t body = "";
	code_t funcname = __FUNCTION__;
	body += "\n{ // " + funcname + "\n";

	code_t inner_body = "";

	var_t r0 = "x";
	var_t r1 = "y";
	inner_body += "$dtype " + r0 + ", " + r1 + ";\n";

	inner_body += mov(r0, in) + ";\n";

	int flops_per_mad = 2;
	int flops_per_iter = flops_per_mad * 2;
	int iters = 32;
	int total_flops = iters * flops_per_iter;

	inner_body += "// " + std::to_string(total_flops) + " flops per thread\n";

	for (int i = 0; i < iters; i++) {
		// 4 float ops
		inner_body += fmad(r0, r1, r0) + "; " + fmad(r1, r0, r1) + ";\n";
	}

	inner_body += mov(out, r1) + ";\n";

	body += indent(inner_body);

	body += "\n} // " + funcname + "\n";

	return body;

}

code_t f_dummy(var_t out, var_t in) {

	code_t body = "";
	code_t funcname = __FUNCTION__;
	body += "\n{ // " + funcname + "\n";
	code_t inner_body = "// code goes here";
	body += indent(inner_body);
	body += "\n} // " + funcname + "\n";

	return body;

}
