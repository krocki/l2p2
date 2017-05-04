# l2p2
**l**ow-**l**evel **p**arallel **p**rimitives

*This is a header-only library*

## Dependencies
* OpenCL headers

## Optional dependencies (tests/benchmarks/examples)
* [Eigen][1]
* [Arrayfire][2]

## Compiling tests/benchmarks/examples

Clone the repository and all dependencies (with `git clone --recursive`) or run:
```
git submodule update --init --recursive
```

Configure and build using CMake
```
mkdir build
cd build
cmake ..
make
```

## License
MIT License

[1]: http://eigen.tuxfamily.org
[2]: https://github.com/arrayfire/arrayfire
