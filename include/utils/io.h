/*
* @Author: Kamil Rocki
* @Date:   2017-05-12 08:20:12
* @Last Modified by:   Kamil M Rocki
* @Last Modified time: 2017-05-19 22:01:25
*/

#include <fstream>

#ifndef _UTILS_IO_
#define _UTILS_IO_

// c++ write
int write_to_file (const char* filename, std::string & content, bool append = false) {

	auto flags = std::ios::out;
	if (append) flags |= std::ios::app;

	std::ofstream file;
	file.open (filename);
	file << content;
	file.close();
	return 0;

}

// c++ read
std::string read_file(const char* filename) {

	std::ifstream file(filename);

	if (file.is_open()) {
		std::string prog( std::istreambuf_iterator<char>( file ), ( std::istreambuf_iterator<char>() ) );
		return prog;
	} else return (std::string("# could not read : ") + std::string(filename));
}

int write_to_file(std::string filename, std::string & content, bool append = false) {
	return write_to_file(filename.c_str(), content, append);
}

std::string read_file(std::string filename) {
	return read_file(filename.c_str());
}

// c read
char* readFile (const char* filename, size_t* length) {
	// locals
	FILE*           file = NULL;
	size_t          len;
	// open the  file
	file = fopen (filename, "rb");

	if (file == 0) {
		printf ("Can't open %s\n", filename);
		return NULL;
	}

	// get the length
	fseek (file, 0, SEEK_END);
	len = (size_t) ftell (file);
	fseek (file, 0, SEEK_SET);
	// allocate a buffer for the string and read it in
	char* buffer = (char*) malloc (len + 1);
	int ret = (int) fread ( (buffer), len, 1, file);

	if (ret == 0) {
		printf ("Can't read source %s\n", filename);
		return NULL;
	}

	// close the file and return the total length of the combined (preamble +
	// source) string
	fclose (file);

	if (length != 0)
		*length = len;

	buffer[len] = '\0';
	return buffer;
}

#endif