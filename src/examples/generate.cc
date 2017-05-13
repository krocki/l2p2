/*
* @Author: Kamil Rocki
* @Date:   2017-05-11 11:45:10
* @Last Modified by:   Kamil Rocki
* @Last Modified time: 2017-05-12 16:34:47
*/

#include <iostream>
#include <utils/common.h>
#include <gen/generate_cl.h>
//#include <gen/generate_t.h>

int main() {

	// 2 kernels used to estimate peak performance
	// code_t k_bandwidth = generate_t ("bandwidth");
	// write_to_file ("./debug/bandwidth.cl", k_bandwidth);

	// code_t k_flops = generate_t ("compute");
	// write_to_file ("./debug/compute.cl", k_flops);

	code_t k_copy = make_kernel(k_fmap(mov, direct));
	code_t k_flops = make_kernel(k_fmap(f_max_flops, direct));
	code_t k_flops2 = make_kernel(k_fmap(fmads, direct));

	// // parallel reduce
	// code_t k_sum = make_kernel(k_fold(add));
	// code_t k_max = make_kernel(k_fold(max));

	write_to_file ("./debug/copy.cl", k_copy);
	write_to_file ("./debug/compute.cl", k_flops);
	write_to_file ("./debug/compute2.cl", k_flops2);
	// write_to_file ("./debug/flops.cl", k_flops);
	// write_to_file ("./debug/sum.cl", k_sum);
	// write_to_file ("./debug/maxcoeff.cl", k_max);

	return 1;

}
