# readme



BLAS， Netlib使用Fortran实现了BLAS的这些API接口, 最早Fortran版的blas是最慢的，不建议使用

LAPACK （linear algebra package），是著名的线性代数库，也是Netlib用fortran语言编写的

Netlib开发了CBLAS和(CLAPACK)[https://netlib.org/clapack/]。其本质是在BLAS和LAPACK的基础上，增加了c的调用方式。



Atlas （Automatically Tuned Linear Algebra Software）能根据硬件

Openblas



Intel的MKL在BLAS的基础上，针对自己特定的CPU平台进行针对性的优化加速。

AMD的ACML在BLAS的基础上，针对自己特定的CPU平台进行针对性的优化加速。

NVIDIA针对GPU开发的cuBLAS。

GotoBlas2

ScaLAPACK

### 上层库

Armadillo

Eigen

opencv

numpy