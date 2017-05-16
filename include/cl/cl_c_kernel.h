/*
* @Author: Kamil Rocki
* @Date:   2017-05-15 09:55:43
* @Last Modified by:   Kamil Rocki
* @Last Modified time: 2017-05-15 10:02:39
*/

#include <string>
#include <vector>

#ifndef _COMPUTE_KERNEL_H_
#define _COMPUTE_KERNEL_H_

class compute_kernel {

  public:

	std::vector<std::string> intermediate = {};

	std::string source = "";

	unsigned long long flops = 0ULL;

};

#endif