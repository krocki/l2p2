/*
* @Author: Kamil Rocki
* @Date:   2017-05-11 11:45:10
* @Last Modified by:   Kamil Rocki
* @Last Modified time: 2017-05-15 12:10:12
*/

#include <iostream>
#include <utils/io.h>
#include <vector>
#include <gen/generate_tt.h>

int main() {
	// std::vector<std::string> gen_list = {"cl_copy_gmem", "cl_copy_gmem_v2", "fmads"};
	std::vector<std::string> gen_list = {"cl_copy_gmem"};
	std::string outpath = "./debug/";

	for (auto& i : gen_list) {

		code_t k_code = make_tt (i);
		std::string fname = outpath + i + ".cl";
		write_to_file (fname, k_code);
		std::cout << "generated \"" + i + "\" :\n>>>>>>>>>>>>>>>\n" + k_code + "\n<<<<<<<<<<<<<<<\nwritten to: " + fname + "\n";

	}

	return 1;
}
