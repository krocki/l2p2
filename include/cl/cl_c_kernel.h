/*
* @Author: Kamil Rocki
* @Date:   2017-05-15 09:55:43
* @Last Modified by:   Kamil M Rocki
* @Last Modified time: 2017-05-17 22:09:17
*/

#include <string>
#include <vector>

#ifndef _COMPUTE_KERNEL_H_
#define _COMPUTE_KERNEL_H_

class compute_kernel {

public:

	std::vector<std::string> intermediate = {};

	std::string source = "";

	long double flops = 0.0;
	long double bytes_in = 0.0;
	long double bytes_out = 0.0;

};

#endif
