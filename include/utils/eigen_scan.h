#ifndef __EIGEN_SCAN__
#define __EIGEN_SCAN__

template <class T>
void scan(array_t<T>& dst, array_t<T>& src) {
  //inclusive
  dst(0) = src(0);
  for (int i = 1; i < src.size(); i++) {
    dst(i) = dst(i-1) + src(i);
  }
}
#endif
