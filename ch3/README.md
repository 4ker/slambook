## 如何在 CLion 里面配置库？

虽然你的 ubuntu 里面可以编译运行。CLion 里面不能跳转，IDE 就没有意义了。
所以我们要给 CLion 加上 library。

我还没有找到好的方法，现在只能通过把 eigen 头文件下载，然后给CMakeLists 加上
`include_directories(/Users/zxtang/dev/libs/eigen-eigen-5a0156e40feb)` 的方法来
实现。

Eigen 很多东西都是通过宏来拼出来的：

```cpp
#define EIGEN_MAKE_FIXED_TYPEDEFS(Type, TypeSuffix, Size)         \
/** \ingroup matrixtypedefs */                                    \
typedef Matrix<Type, Size, Dynamic> Matrix##Size##X##TypeSuffix;  \
/** \ingroup matrixtypedefs */                                    \
typedef Matrix<Type, Dynamic, Size> Matrix##X##Size##TypeSuffix;

#define EIGEN_MAKE_TYPEDEFS_ALL_SIZES(Type, TypeSuffix) \
EIGEN_MAKE_TYPEDEFS(Type, TypeSuffix, 2, 2) \
EIGEN_MAKE_TYPEDEFS(Type, TypeSuffix, 3, 3) \
EIGEN_MAKE_TYPEDEFS(Type, TypeSuffix, 4, 4) \
EIGEN_MAKE_TYPEDEFS(Type, TypeSuffix, Dynamic, X) \
EIGEN_MAKE_FIXED_TYPEDEFS(Type, TypeSuffix, 2) \
EIGEN_MAKE_FIXED_TYPEDEFS(Type, TypeSuffix, 3) \
EIGEN_MAKE_FIXED_TYPEDEFS(Type, TypeSuffix, 4)

EIGEN_MAKE_TYPEDEFS_ALL_SIZES(int,                  i)
EIGEN_MAKE_TYPEDEFS_ALL_SIZES(float,                f)
EIGEN_MAKE_TYPEDEFS_ALL_SIZES(double,               d)
EIGEN_MAKE_TYPEDEFS_ALL_SIZES(std::complex<float>,  cf)
EIGEN_MAKE_TYPEDEFS_ALL_SIZES(std::complex<double>, cd)
```

这就实现来很多常用的矩阵类型。

