# [科学计算库（BLAS，LAPACK，MKL，EIGEN）](https://www.cnblogs.com/chest/p/11844129.html)



- ##### 函数库接口标准：BLAS (Basic Linear Algebra Subprograms)和LAPACK (Linear Algebra PACKage)

1979年，Netlib首先用Fortran实现基本的向量乘法、矩阵乘法的函数库（该库没有对运算做过多优化）。后来该代码库对应的接口规范被称为BLAS。

（注：NetLib是一个古老的代码社区，<https://en.wikipedia.org/wiki/Netlib>）

LAPACK也是Netlib用Fortan编写的代码库，实现了高级的线性运算功能，例如矩阵分解，求逆等，底层是调用的BLAS代码库。后来LAPACK也变成一套代码接口标准。

后来，Netlib还在BLAS/LAPACK的基础上，增加了C语言的调用方式，称为CBLAS/CLAPACK

**因此，BLAS/LAPACK都有两个含义，一个是Netlib通过Fortran或C实现的代码库，一个是这个两个代码库对应的接口标准**。

http://www.icl.utk.edu/~mgates3/docs/

<http://www.netlib.org/lapack>

 

现在大多数函数库都是基于BLAS/LAPACK接口标准实现

https://en.wikipedia.org/wiki/List_of_numerical_libraries

- ##### 开源函数库

开源社区对对BLAS/LAPACK的实现，比较著名是 ATLAS(Automatically Tuned Linear Algebra Software)和OpenBLAS。它们都实现了BLAS的全部功能，以及LAPACK的部分功能，并且他们都对计算过程进行了优化。

 

- ##### 商业函数库

商业公司对BLAS/LAPACK的实现，有Intel的MKL，AMD的ACML。他们对自己的cpu架构，进行了相关计算过程的优化，实现算法效率也很高。

NVIDIA针对其GPU，也推出了cuBLAS，用以在GPU上做矩阵运行。

 

------

Matlab用的是MKL库，可以用version –lapack来查看函数库的版本

Octave 默认用的是OpenBLAS库，  version -blas

------

附录：Lapack中的函数命名规则

============================================================================

lapack naming: x-yy-zzz, or x-yy-zz

 

x (data type)

\------------------------------ 

s float

d double

c float-complex

z double-complex

ds input data is double, internal use float

zc input data is double-complex, internal use float-complex

 

 

Matrix type (yy) | full | packed | RFP | banded | tridiag | generalized problem

================================================================================

general          | ge                    gb       gt        gg

symmetric        | sy     sp       sf    sb       st

Hermitian        | he     hp       hf    hb

positive definite| po     pp       pf    pb       pt

\--------------------------------------------------------------------------------

triangular       | tr     tp       tf    tb                 tg

upper Hessenberg | hs                                       hg

trapezoidal      | tz

\--------------------------------------------------------------------------------

orthogonal       | or    op

unitary          | un    up

\--------------------------------------------------------------------------------

diagonal         |                                di

bidiagonal       |                                bd

 

 

(zzz) algorithm

\------------------------------

\* Triangular factorization

-trf — factorize: General LU, Cholesky decomposition

-tri — calculate the inverse matrix

 

\* Orthogonal factorization

-qp3 — QR factorization, with pivoting

-qrf — QR factorization

 

\* Eigenvalue

-ev — all eigenvalues, [eigenvectors]

-evx — expert; also subset

-evd — divide-and-conquer; faster but more memory

-evr — relative robust; fastest and least memory

 

\* SVD singular value decomposition

-svd — singular values

 

\* Linear system, solve Ax = b

-sv — solve

-sdd — divide-and-conquer; faster but more memory

 

\* Linear least squares, minimize ||b?Ax||2

-ls — full rank, rank(A) = min(m,n), uses QR.

-lsy — rank deficient, uses complete orthogonal factorization.

-lsd — rank deficient, uses SVD.

 



分类: [计算机](https://www.cnblogs.com/chest/category/1641798.html)