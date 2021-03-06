cmake_minimum_required (VERSION 2.8.12)

# project name
project(l2p2)

if (NOT IS_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/ext/eigen/Eigen")
  message(FATAL_ERROR "Dependency repositories are missing! "
    "You probably did not clone the project with --recursive. It is possible to recover "
    "by calling \"git submodule update --init --recursive\"")
endif()

set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")
find_package(OpenCL)

message(STATUS "OpenCL found: ${OPENCL_FOUND}")
message(STATUS "OpenCL includes: ${OPENCL_INCLUDE_DIRS}")
message(STATUS "OpenCL CXX includes: ${OPENCL_HAS_CPP_BINDINGS}")
message(STATUS "OpenCL libraries: ${OPENCL_LIBRARIES}")

option(L2P2_BUILD_EXAMPLE "Build l2p2 examples?" ON)
option(L2P2_BUILD_TESTS "Build l2p2 tests?" ON)
option(L2P2_BUILD_BENCHMARKS "Build l2p2 benchmarks?" ON)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wextra -Wfatal-errors -std=c++14")

if (CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Ofast")
else()
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O3")
endif()

set(L2P2_EXTRA_LIBS "")
set(L2P2_EXTRA_DEFS "")
set(L2P2_EXTRA_INCS "")

if (NOT L2P2_EIGEN_INCLUDE_DIR)
  set(L2P2_EIGEN_INCLUDE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/ext/eigen")
  list(APPEND L2P2_EXTRA_INCS "${L2P2_EIGEN_INCLUDE_DIR}")
endif()

set(TINYEXPR_PATH "${CMAKE_CURRENT_SOURCE_DIR}/ext/tinyexpr")
list(APPEND L2P2_EXTRA_INCS "${TINYEXPR_PATH}")

if (NOT L2P2_INCLUDE_DIR)
  set(L2P2_INCLUDE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/include")
  list(APPEND L2P2_EXTRA_INCS "${L2P2_INCLUDE_DIR}")
endif()

include_directories(${L2P2_EIGEN_INCLUDE_DIR} ${OPENCL_INCLUDE_DIRS} ${OPENCL_HAS_CPP_BINDINGS} include ${CMAKE_CURRENT_BINARY_DIR} ${L2P2_EXTRA_INCS})

add_definitions(${L2P2_EXTRA_DEFS})

if(L2P2_BUILD_EXAMPLE)
  #add_executable(example_generate src/examples/generate.cc ${TINYEXPR_PATH}/tinyexpr.c)
  #add_executable(example_copy src/examples/copy.cc)
  #add_executable(example_reduce src/examples/reduce.cc)
  #add_executable(example_initcl src/examples/initcl.cc)
  #target_link_libraries(example_reduce ${L2P2_EXTRA_LIBS} ${OPENCL_LIBRARIES})
  #target_link_libraries(example_initcl ${L2P2_EXTRA_LIBS} ${OPENCL_LIBRARIES})
  #target_link_libraries(example_generate ${L2P2_EXTRA_LIBS} ${OPENCL_LIBRARIES})
  #target_link_libraries(example_copy ${L2P2_EXTRA_LIBS} ${OPENCL_LIBRARIES})
endif()

if(L2P2_BUILD_TESTS)
	#add_executable(test_gemm src/tests/gemm.cc ${TINYEXPR_PATH}/tinyexpr.c)
	#target_link_libraries(test_gemm ${L2P2_EXTRA_LIBS} ${OPENCL_LIBRARIES})
endif()

if(L2P2_BUILD_BENCHMARKS)
  add_executable(fmap_bench src/benchmarks/fmap.cc ${TINYEXPR_PATH}/tinyexpr.c)
  add_executable(fold_bench src/benchmarks/fold.cc ${TINYEXPR_PATH}/tinyexpr.c)
  add_executable(scan_bench src/benchmarks/scan.cc ${TINYEXPR_PATH}/tinyexpr.c)
  add_executable(gemm_bench src/benchmarks/gemm.cc ${TINYEXPR_PATH}/tinyexpr.c)
  # add_executable(permute_bandwidth src/benchmarks/permute.cc ${TINYEXPR_PATH}/tinyexpr.c)
  target_link_libraries(fmap_bench ${L2P2_EXTRA_LIBS} ${OPENCL_LIBRARIES})
  target_link_libraries(fold_bench ${L2P2_EXTRA_LIBS} ${OPENCL_LIBRARIES})
  target_link_libraries(scan_bench ${L2P2_EXTRA_LIBS} ${OPENCL_LIBRARIES})
  target_link_libraries(gemm_bench ${L2P2_EXTRA_LIBS} ${OPENCL_LIBRARIES})
  # target_link_libraries(permute_bandwidth ${L2P2_EXTRA_LIBS} ${OPENCL_LIBRARIES})
endif()
