/*
* @Author: Kamil Rocki
* @Date:   2017-05-11 12:03:51
* @Last Modified by:   Kamil Rocki
* @Last Modified time: 2017-05-11 12:24:33
*/
[[__kernel void 
kernel_name (float* restrict out, const float* restrict in) {
 
	const int id = get_group_id(0);
	
	function!$x=in[id],$y=out[id]

}]]