/*
* @Author: Kamil Rocki
* @Date:   2017-05-11 11:49:22
* @Last Modified by:   Kamil Rocki
* @Last Modified time: 2017-05-12 14:47:35
*/

#include <utils/string.h>

#ifndef _PARSE_OPS_H_
#define _PARSE_OPS_H_

std::string get_args(std::string in, std::string in_symbol = "\\(", std::string out_symbol = "\\)", int in_trim = 1, int out_trim = 1) {

	std::string regexp = in_symbol + "(.*?)" + out_symbol;
	std::cout << in << std::endl;
	std::string content = find_regex(in, regexp);
	if (content != "")
		return content.substr(in_trim, content.size() - out_trim - in_trim);
	else return "";
}

std::vector<code_t> get_vars(code_t input, std::string symbol = "$", std::string delim = "\\s+") {

	std::vector<code_t> tokens = words(input, delim);
	std::vector<code_t> vars;

	for (auto& tok : tokens) {

		auto it = tok.find(symbol);
		if (it != std::string::npos) {
			vars.push_back(tok);
		}

	}

	return vars;

}

std::vector<std::string> process_tokens(std::string input) {

	std::vector<std::string> tokens = words(input); // whitespace
	return tokens;
}

#endif

/*code_t generate_t (code_t T, std::vector<std::pair<code_t, code_t>> args = {}, std::string prefix = "../include/gen/templates/", std::string suffix = ".t") {

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

*/