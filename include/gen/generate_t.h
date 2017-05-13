/*
* @Author: Kamil Rocki
* @Date:   2017-05-11 11:49:22
* @Last Modified by:   Kamil Rocki
* @Last Modified time: 2017-05-12 14:47:35
*/

#include <utils/io.h>
#include <utils/string.h>
#include <gen/defs.h>

std::vector<std::pair<code_t, code_t>> parse_args(code_t input) {

	std::vector<std::pair<code_t, code_t>> out;

	std::pair<code_t, code_t> s_args = split(input, "!");

	std::vector<code_t> tokens = words(s_args.first, ",");

	for (auto& tok : tokens) {

		std::vector<code_t> args = words(tok, "=");

		args[1] += s_args.second != "" ? ("!" + s_args.second) : "";

		out.push_back(std::make_pair(args[0], args[1]));
	}

	return out;

}
code_t generate_t (code_t T, std::vector<std::pair<code_t, code_t>> args = {}, std::string prefix = "../include/gen/templates/", std::string suffix = ".t") {

	std::cout << "generate_t: " + T << std::endl;

	code_t body = "";

	body += read_file(prefix + T + suffix );

	body = subst(body, R"(\n)", " #newline#");

	body = get_quoted_content(body);

	for (auto& a : args) {
		std::cout << "'" << a.first << "' = '" << a.second << "'" << std::endl;
		body = subst(body, sanitize(a.first), a.second);
	}

	std::cout << "body raw: " << std::endl;
	std::cout << body << std::endl;

	std::cout << "no comments: " << std::endl;
	std::cout << body << std::endl;

	// remove_comments(body)
	body = strip_comments(body);

	std::vector<std::string> tokens = words(body); // whitespace
	std::vector < std::pair<code_t, code_t>> Ts;

	body = "";

	for (auto& tok : tokens) {
		//find inner templates
		if (tok.compare(0, 1, "@") == 0) {
			std::pair<code_t, code_t> symbol = std::make_pair("#var" + std::to_string(Ts.size()), tok);
			body += symbol.first + " ";
			Ts.push_back(symbol);
		} else {
			body += tok + " ";
		}
	}

	std::cout << "templates" << std::endl;
	for (auto& t : Ts) {

		code_t varname = t.second;
		std::cout << varname << std::endl;
		varname.erase(0, 1); // remove prefix
		std::string args_raw = varname;
		varname = subst(varname, "!.*", "");
		args_raw = subst(args_raw, varname + "!", "");
		std::cout << T + " : " + varname + " is " + args_raw << std::endl;
		std::vector<std::pair<code_t, code_t>> args_p = parse_args(args_raw);
		code_t expansion = indent(generate_t(varname, args_p));
		body = subst(body, t.first, expansion);

	}

	body = subst(body, R"(#newline#)", "\n");
	return body;

}
