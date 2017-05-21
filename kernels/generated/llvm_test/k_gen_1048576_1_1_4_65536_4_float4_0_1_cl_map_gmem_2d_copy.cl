#if 0 > 0
__attribute__((vec_type_hint(float4)))
#endif

// N_LX_LY_WX_WY_G_TV H_TRANS
__kernel void k_gen_1048576_1_1_4_65536_4_float4_0_1_cl_map_gmem_2d_copy (
    __global float4 * restrict out,
    __global const float4 * restrict in) {

	#if 1
		int gid = get_global_id(1) * get_global_size(0) + get_global_id(0);
	#else
		int gid = get_global_id(0) * get_global_size(1) + get_global_id(1);
	#endif

		out[gid] = in[gid];

}

// on NV, not reaching peak BW with copy, but about 70% (245GB/s on Titan X), it might be possible that:
// need at least 2 kernels, just read or just write, or something else
// CUDA bandwidth test reports similar numbers
 // Host to Device Bandwidth, 1 Device(s)
 // PINNED Memory Transfers
 //   Transfer Size (Bytes)	Bandwidth(MB/s)
 //   33554432			11819.8

 // Device to Host Bandwidth, 1 Device(s)
 // PINNED Memory Transfers
 //   Transfer Size (Bytes)	Bandwidth(MB/s)
 //   33554432			12041.5

 // Device to Device Bandwidth, 1 Device(s)
 // PINNED Memory Transfers
 //   Transfer Size (Bytes)	Bandwidth(MB/s)
 //   33554432			247884.3
// and p2pBandwidthLatencyTest shows around 252 (multiple streams)
