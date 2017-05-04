/*
* @Author: kmrocki@us.ibm.com
* @Date:   2017-05-03 20:44:37
* @Last Modified by:   kmrocki@us.ibm.com
* @Last Modified time: 2017-05-03 21:24:50
*/

#include <iostream>

#include <array/eigen.h>

template<class T>
int run_example() {

	array_t<T> ref(25, 5);
	ref.setRandom();

	std::cout << "ref:" << std::endl;
	std::cout << ref << std::endl;

	T e_min = ref.minCoeff();
	T e_max = ref.maxCoeff();
	T e_sum = ref.sum();
	T e_mean = ref.mean();

	std::cout 	<< std::endl
	            << "min: " << e_min
	            << ", max: " << e_max
	            << ", sum: " << e_sum
	            << ", avg: " << e_mean
	            << std::endl;

	return 0;

}

int main (int argc, char** argv) {

	try {

		run_example<float>();

	} catch (const std::runtime_error &e ) {

		std::string error_msg = std::string ( "main() - std::runtime_error: " ) + std::string ( e.what() );

		std::cerr << error_msg << std::endl;

		return -1;

	}

	return 0;

}
