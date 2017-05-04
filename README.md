# l2p2
**l**ow-**l**evel **p**arallel **p**rimitives

## Dependencies
* [Eigen][1]
* OpenCL

*This is a header-only library*
## Compiling tests/benchmarks
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
