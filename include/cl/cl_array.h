/*
    @Author: kmrocki@us.ibm.com
    @Date:   2017-04-24 16:58:15
    @Last Modified by:   kmrocki@us.ibm.com
    @Last Modified time: 2017-04-29 11:35:06
*/

/* An OpenCL array providing easy trasfers between host-device mem */

#ifndef __cl_array__
#define __cl_array__

int cl_copy_device_to_device (cl_ctx* clctx, cl_mem& src, cl_mem& dst, size_t offset_src, size_t offset_dst, size_t bytes);

template <typename T>
int cl_alloc_from_matrix (cl_ctx* ctx, cl_mem& buffer, array_t<T>& h, cl_mem_flags flags = CL_MEM_READ_WRITE);

template <typename T>
int cl_copy_matrix_to_host (cl_ctx* ctx, array_t<T>& dst, cl_mem device_data);

template <typename T>
int cl_copy_matrix_to_device (cl_ctx* ctx, cl_mem device_data, array_t<T>& src);

unsigned long cl_mem_allocated = 0L;

template <typename T = float>
class cl_array {

  public:

	cl_mem device_data;
	cl_mem& ref_device_data;

	//temp buffers
	cl_mem scratchBuf;

	cl_mem iMax; // index of max value (updated through cl_max_coeff(cl_array& m)) - device mem
	cl_uint indexMax = 0; // index of max value (updated through cl_max_coeff(cl_array& m))

	cl_mem d_sum; // sum of elements
	T h_sum; // host copy of the sum

	bool prealloc_scratchpad = false;
	unsigned int lenScratchBuf = 0;
	size_t padding = 1;

	size_t device_data_size;

	array_t<T> host_data;
	array_t<T>& ref_host_data;

	cl_ctx* matrix_ctx;

	cl_array (cl_ctx* ctx = nullptr) : ref_device_data (device_data), ref_host_data (host_data), matrix_ctx (ctx) {
		device_data = nullptr;
		scratchBuf = nullptr;
		iMax = nullptr;
	}

	explicit
	cl_array (cl_ctx* ctx, size_t rows, size_t cols, size_t _pad = 1, bool _prealloc_scratchpad = false) : cl_array (ctx) {
		host_data = array_t<T> (rows, cols);
		host_data.setZero();
		ref_host_data = host_data;
		prealloc_scratchpad = _prealloc_scratchpad;
		padding = _pad;
		alloc_device_mem();

	};

	explicit
	cl_array (cl_ctx* ctx, array_t<T>& m, size_t _pad = 1, bool _prealloc_scratchpad = false) : cl_array (ctx) {
		host_data = m;
		ref_host_data = host_data;
		prealloc_scratchpad = _prealloc_scratchpad;
		padding = _pad;
		alloc_device_mem();
	};

	cl_array& operator= (const cl_array& other) {
		host_data = other.host_data;
		ref_host_data = host_data;
		matrix_ctx = other.matrix_ctx;
		prealloc_scratchpad = other.prealloc_scratchpad;
		padding = other.padding;
		free_device_mem();
		alloc_device_mem();
		return *this;
	};

	void resize (size_t rows, size_t cols) {
		host_data.resize (rows, cols);
		free_device_mem();
		alloc_device_mem();
	}

	T sum() { cl_sum(*this, false, true); return h_sum; }

	size_t rows() const {
		return ref_host_data.rows();
	}
	size_t cols() const {
		return ref_host_data.cols();
	}
	size_t length() const {
		return device_data_size;
	}

	cl_array (const cl_array& other) : cl_array (other.matrix_ctx, other.rows(), other.cols(), other.padding ) {}

	int set(T _val) {

		T val = T (_val);

		CL_SAFE_CALL (clEnqueueFillBuffer (matrix_ctx->queue(), device_data, &val, sizeof (T), 0, length() * sizeof (T), 0, nullptr, &matrix_ctx->cl_events["cl_set_val"]) );

		return matrix_ctx->err;


	}
	int setZero () {

		return set(T(0));

	}

	int setOnes () {

		return set(T(1));

	}

	int resize_scratchpad() {

		unsigned int N = rows() * cols();

		if (lenScratchBuf < N) {
			lenScratchBuf = N;

			if (scratchBuf) clReleaseMemObject ( (cl_mem) scratchBuf);

			scratchBuf = clCreateBuffer (matrix_ctx->ctx(), matrix_ctx->device_mem_alloc_flags, (N * sizeof (cl_float)), NULL, &matrix_ctx->err);

			if (clUtils::checkError(matrix_ctx->err, "resize_scratchpad : scratchBuf = clCreateBuffer()") != 0) return matrix_ctx->err;
		}

		return 0;
	}

	~cl_array() {
		free_device_mem();
	};

	void alloc_device_mem() {

		//std::cout << ref_host_data.rows() * ref_host_data.cols() << std::endl;
		device_data_size = cl_alloc_from_matrix (matrix_ctx, device_data, ref_host_data, padding, matrix_ctx->device_mem_alloc_flags);
		//std::cout << device_data_size << std::endl;
		ref_device_data = device_data;
		if (prealloc_scratchpad) resize_scratchpad();

	}

	void free_device_mem() {
		if (device_data) clReleaseMemObject ( (cl_mem) device_data);
		if (scratchBuf) clReleaseMemObject ( (cl_mem) scratchBuf);
		if (iMax) clReleaseMemObject ( (cl_mem) iMax);
	}

	void sync_device() {
		cl_copy_matrix_to_device (matrix_ctx, device_data, ref_host_data);
	}

	void sync_host() {
		cl_copy_matrix_to_host (matrix_ctx, ref_host_data, device_data);
	}

};

int cl_copy_device_to_device (cl_ctx* ctx, cl_mem& src, cl_mem& dst, size_t offset_src, size_t offset_dst, size_t bytes) {

	if (ctx == nullptr) {
		printf ("cl_copy_device_to_device: ctx== null!\n");
		return 1;
	}

	std::string event_string = "cl_copy_device_to_device";

	//if (ctx->profiling_enabled) clFinish (ctx->queue() );

	CL_SAFE_CALL (clEnqueueCopyBuffer (ctx->queue(), src, dst, offset_src, offset_dst, bytes, 0, NULL, &ctx->cl_events[event_string]) );

	// if ( (!ctx->asynchronous || wait) || ctx->profiling_enabled) ctx->get_profiling_data (event_string);

	return 0;
}

template <typename T = float>
int cl_alloc_from_matrix (cl_ctx* clctx, cl_mem& buffer, array_t<T>& h, size_t padding, cl_mem_flags flags) {

	size_t host_size = h.rows() * h.cols();
	size_t device_data_size = host_size > 0 ? ((((host_size + padding - 1)) / padding) * padding) : padding;

	size_t alloc_size = sizeof (T) * device_data_size;

	if (clctx == nullptr) {
		printf ("cl_alloc_from_matrix: clctx == null!\n");
		return -1;
	}

	if (alloc_size > 0) {

		cl_int err;
		buffer = clCreateBuffer (clctx->ctx(), flags, alloc_size, NULL, &err);
		if (clUtils::checkError(err, "cl_alloc_from_matrix: clCreateBuffer") != 0) return err;

	} else fprintf (stderr, "alloc_matrix: alloc_size <= 0!\n");

	cl_mem_allocated += alloc_size;
	return device_data_size;
}

template <typename T = float>
void cl_free_matrix (cl_array<T>& m) {
	clReleaseMemObject ( (cl_mem) m.device_data);
	cl_mem_allocated -= m.cols() * m.rows() * sizeof (T);
}

template <typename T = float>
int cl_copy_matrix_to_device (cl_ctx* ctx, cl_mem device_data, array_t<T>& src) {
	if (ctx == nullptr) {
		printf ("cl_alloc_from_matrix: clctx == null!\n");
		return 1;
	}

	size_t bytes = src.rows() * src.cols() * sizeof (T);
	std::string event_string = "cl_copy_matrix_to_device";

	//if (ctx->profiling_enabled) clFinish (ctx->queue() );

	//if (ctx->zero_copy_mem) {

	//CL_SAFE_CALL (clEnqueueUnMapBuffer());, flags: CL_MAP_READ

	//} else {
	CL_SAFE_CALL (clEnqueueWriteBuffer (ctx->queue(), device_data, CL_TRUE, 0, bytes, src.data(), 0, NULL, &ctx->cl_events[event_string]) );
	//}
	// if ( (!ctx->asynchronous || wait) || ctx->profiling_enabled) ctx->get_profiling_data (event_string);

	return 0;
}

template <typename T = float>
int cl_copy_matrix_to_host (cl_ctx* ctx, array_t<T>& dst, cl_mem device_data) {
	if (ctx == nullptr) {
		printf ("cl_alloc_from_matrix: clctx == null!\n");
		return 1;
	}

	size_t bytes = dst.rows() * dst.cols() * sizeof (T);

	//if (ctx->zero_copy_mem) {

	//CL_SAFE_CALL (clEnqueueMapBuffer());, flags: CL_MAP_READ

	//} else {
	CL_SAFE_CALL (clEnqueueReadBuffer (ctx->queue(), device_data, CL_TRUE, 0, bytes, dst.data(), 0, NULL, NULL) );
	//}
	//if (ctx->profiling_enabled) clFinish (ctx->queue() );

	return 0;
}

#endif
