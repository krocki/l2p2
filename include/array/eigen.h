/*
* @Author: kmrocki@us.ibm.com
* @Date:   2017-05-03 21:03:27
* @Last Modified by:   kmrocki@us.ibm.com
* @Last Modified time: 2017-05-03 21:11:35
*/

#include <Eigen/Dense>

#ifndef _EIGEN_ARRAY_H_
#define _EIGEN_ARRAY_H_

template<class T = float>
using array_t = Eigen::Matrix<T, Eigen::Dynamic, Eigen::Dynamic>;

#endif
