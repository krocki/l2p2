/*
* @Author: Kamil Rocki
* @Date:   2017-05-15 09:55:43
* @Last Modified by:   Kamil Rocki
* @Last Modified time: 2017-05-25 14:13:17
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

	std::string device_name = "";
	size_t max_wsize; // max number of workgroup for this kernel & device
	size_t lmem; // required lmem size

};

#endif
