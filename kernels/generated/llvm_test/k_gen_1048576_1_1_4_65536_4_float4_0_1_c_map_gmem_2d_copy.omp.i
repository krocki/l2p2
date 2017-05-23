# 1 "k_gen_1048576_1_1_4_65536_4_float4_0_1_c_map_gmem_2d_copy.omp.c"
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 331 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "k_gen_1048576_1_1_4_65536_4_float4_0_1_c_map_gmem_2d_copy.omp.c" 2

typedef float float16 __attribute__((ext_vector_type(16)));
typedef float float8 __attribute__((ext_vector_type(8)));
typedef float float4 __attribute__((ext_vector_type(4)));
typedef float float2 __attribute__((ext_vector_type(2)));
# 15 "k_gen_1048576_1_1_4_65536_4_float4_0_1_c_map_gmem_2d_copy.omp.c"
void k_gen_1048576_1_1_4_65536_4_float4_0_1_c_map_gmem_2d_copy (
    float4 * restrict out,
    const float4 * restrict in) {


#pragma omp parallel for simd schedule(static) num_threads(16)
 for (int gid = 0; gid < 65536 * 4; gid++) {

  out[gid] = in[gid];

 }


}
