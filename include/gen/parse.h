/*
* @Author: Kamil Rocki
* @Date:   2017-05-11 11:49:22
* @Last Modified by:   Kamil Rocki
* @Last Modified time: 2017-05-15 17:09:03
*/

#include <utils/string.h>
#include <gen/defs.h>

#ifndef _PARSE_OPS_H_
#define _PARSE_OPS_H_

code_t process_template(code_t tt) {

	return "[" + tt + "]";
}

code_t get_var(code_t tt) {

	if (tt == "$STRIDE$") return "get_global_size(0)";
	if (tt == "$ITERS$") return "iters";
	if (tt == "$T$") return "float";
	if (tt == "$V$") return "4";

	return tt;

}

code_t eval_expr(code_t tt) {

	return "eval " + tt;

}


typedef std::pair<std::string, int> pair_str_int;

std::vector<pair_str_int> find_pattern(std::string input, std::regex re) {

	std::smatch m;
	std::regex_search ( input, m, re );
	std::vector<pair_str_int> results;

	auto it_begin = std::sregex_iterator(input.begin(), input.end(), re);

	auto it_end = std::sregex_iterator();

	for (std::sregex_iterator i = it_begin; i != it_end; ++i) {

		std::smatch match = *i;
		std::string match_str = match.str();

		int m_idx = match.position(0);

		pair_str_int entry = {match_str, m_idx};

		results.push_back(entry);
	}

	return results;

}

template<class F>
std::string process_vars(std::string& original_input, std::vector<pair_str_int> vars, F func) {

	std::string matches = "";
	std::string out = "";
	out = original_input;

	matches += std::string("Found ") + std::to_string(vars.size()) + std::string(" matches:\n");

	for (int i = vars.size() - 1; i >= 0; --i) {

		std::string match_str = vars[i].first;
		int m_idx = vars[i].second;
		int m_length = match_str.length();

		matches +=  std::string("pos: ") + std::to_string(m_idx) + std::string(" - ") + std::to_string(m_idx + m_length - 1) +  std::string(" = ") + match_str + "   ";

		std::string t = match_str;
		std::string replacement = func(t);

		matches += ": " + t + "| ";

		// remove old
		out.erase(out.begin() + m_idx, out.begin() + m_idx + m_length);

		// insert new
		out.insert(out.begin() + m_idx, replacement.begin(), replacement.end());

	}

	return std::string( " matches" + matches + "\n\n\n" + out);

}

code_t process_tt(code_t& input) {

	code_t output = "\n\n/* process_tt in:\n";
	output += input + "\n*/";

	code_t newline_string = "####newline!!!!";
	std::string sanitized_input = subst(input, "\n", newline_string);
	output += "/* sanitized:\n" + sanitized_input + "\n*/";

	//find vars for substitution
	std::regex t_regex("\\$.*?\\$");
	std::regex e_regex("`.*?`");
	std::regex h_regex("``.*?``");

	std::string processed_input = sanitized_input;

	//find vars
	code_t final_str = process_vars(sanitized_input, find_pattern(sanitized_input, t_regex), get_var);

	//eval
	final_str = process_vars(final_str, find_pattern(final_str, e_regex), eval_expr);

	std::string host_str = process_vars(final_str, find_pattern(final_str, h_regex), host_expr);

	output += "/* processed pre:\n" + processed_input + "\n*/";
	processed_input = subst(processed_input, newline_string, "\n");
	output += "/* processed post:\n" + processed_input + "\n*/\n";
	output += "/* final pre:\n" + final_str + "\n*/";
	final_str = subst(final_str, newline_string, "\n");
	output += "\n\n\n/* final post:\n/*" + final_str + "\n";
	return output;
}

std::vector<code_t> process_tokens(code_t& input, std::string delimiter = "\\s+") {

	std::vector<code_t> tokens = words(input, delimiter); // whitespace
	return tokens;
}

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