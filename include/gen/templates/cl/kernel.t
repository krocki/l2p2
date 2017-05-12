/*
* @Author: Kamil Rocki
* @Date:   2017-05-11 12:03:51
* @Last Modified by:   Kamil Rocki
* @Last Modified time: 2017-05-11 12:24:33
*/

<var out, var in, function f>
kernel {

	"__kernel void"
	$kernelname
	$args
	"{"
	@f ($out, $in)
	"}"

}
