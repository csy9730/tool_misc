# eigen



[eigen](https://eigen.tuxfamily.org/index.php)



>  Eigen is a C++ template library for linear algebra: matrices, vectors, numerical solvers, and related algorithms.





## Overview

- [Eigen is versatile](https://eigen.tuxfamily.org/index.php?title=Versatility).
  - It supports all matrix sizes, from small fixed-size matrices to arbitrarily large dense matrices, and even sparse matrices.
  - It supports all standard numeric types, including std::complex, integers, and is easily extensible to [custom numeric types](https://eigen.tuxfamily.org/dox/TopicCustomizingEigen.html#CustomScalarType).
  - It supports various [matrix decompositions](https://eigen.tuxfamily.org/dox/group__TopicLinearAlgebraDecompositions.html) and [geometry features](https://eigen.tuxfamily.org/dox/group__TutorialGeometry.html).
  - Its ecosystem of [unsupported modules](https://eigen.tuxfamily.org/dox/unsupported/index.html) provides many specialized features such as non-linear optimization, matrix functions, a polynomial solver, FFT, and much more.
- [Eigen is fast](https://eigen.tuxfamily.org/index.php?title=Benchmark).
  - Expression templates allow intelligently removing temporaries and enable [lazy evaluation](https://eigen.tuxfamily.org/dox/TopicLazyEvaluation.html), when that is appropriate.
  - [Explicit vectorization](https://eigen.tuxfamily.org/index.php?title=FAQ#Vectorization) is performed for SSE 2/3/4, AVX, AVX2, FMA, AVX512, ARM NEON (32-bit and 64-bit), PowerPC AltiVec/VSX (32-bit and 64-bit), ZVector (s390x/zEC13) SIMD instruction sets, and since 3.4 MIPS MSA with graceful fallback to non-vectorized code.
  - Fixed-size matrices are fully optimized: dynamic memory allocation is avoided, and the loops are unrolled when that makes sense.
  - For large matrices, special attention is paid to cache-friendliness.
- [Eigen is reliable](https://eigen.tuxfamily.org/index.php?title=Reliability).
  - Algorithms are carefully selected for reliability. Reliability trade-offs are [clearly documented](https://eigen.tuxfamily.org/dox/group__TopicLinearAlgebraDecompositions.html) and [extremely](https://eigen.tuxfamily.org/dox/classEigen_1_1JacobiSVD.html) [safe](https://eigen.tuxfamily.org/dox/classEigen_1_1FullPivHouseholderQR.html) [decompositions](https://eigen.tuxfamily.org/dox/classEigen_1_1FullPivLU.html) are available.
  - Eigen is thoroughly tested through its own [test suite](https://eigen.tuxfamily.org/index.php?title=Tests) (over 500 executables), the standard BLAS test suite, and parts of the LAPACK test suite.
- [Eigen is elegant](https://eigen.tuxfamily.org/index.php?title=API_Showcase).
  - The API is extremely [clean and expressive](https://eigen.tuxfamily.org/index.php?title=API_Showcase) while feeling natural to C++ programmers, thanks to expression templates.
  - Implementing an algorithm on top of Eigen feels like just copying pseudocode.
- **Eigen has good compiler support** as we run our test suite against many compilers to guarantee reliability and work around any compiler bugs. Eigen up to version 3.4 is standard C++03 and maintains reasonable compilation times. Versions following 3.4 will be C++14.

## 