/*
* @Author: Kamil Rocki
* @Date:   2017-05-11 11:45:10
* @Last Modified by:   Kamil Rocki
* @Last Modified time: 2017-05-11 16:46:45
*/

#include <iostream>
#include <utils/common.h>
#include <gen/generate_cl.h>

int main() {

	// 2 kernels used to estimate peak performance

	code_t k_copy = make_kernel(k_fmap(mov));
	// code_t k_flops = make_kernel(k_fmap(f_max_flops));

	// // parallel reduce
	// code_t k_sum = make_kernel(k_fold(add));
	// code_t k_max = make_kernel(k_fold(max));

	write_to_file ("./debug/copy.cl", k_copy);
	// write_to_file ("./debug/flops.cl", k_flops);
	// write_to_file ("./debug/sum.cl", k_sum);
	// write_to_file ("./debug/maxcoeff.cl", k_max);

	return 1;

}