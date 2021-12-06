# LAPACK

[http://performance.netlib.org/lapack/](http://performance.netlib.org/lapack/)

[https://github.com/Reference-LAPACK/lapack](https://github.com/Reference-LAPACK/lapack)


## homepage

[Related older Projects](http://performance.netlib.org/lapack/#_related_older_projects)

| ![LAPACK](http://performance.netlib.org/lapack/images/lapack1.jpg) | **Version 3.10.0** [**LAPACK on GitHub**](https://github.com/Reference-LAPACK/lapack) [**Browse the LAPACK User Forum**](http://icl.cs.utk.edu/lapack-forum) [**Browse the LAPACK User Forum**](http://icl.cs.utk.edu/lapack-forum) [**Contact the LAPACK team**](mailto:lapack@icl.utk.edu)  [**Get the latest LAPACK News**](mailto:lapack-announce-subscribe@eecs.utk.edu)  [# access](http://www.netlib.org/master_counts2.html#lapack) | ![LAPACK](http://performance.netlib.org/lapack/images/lapack2.jpg) |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
|                                                              |                                                              |                                                              |

LAPACK is a software package provided by Univ. of Tennessee; Univ. of California, Berkeley; Univ. of Colorado Denver; and NAG Ltd..

## Presentation

LAPACK is written in Fortran 90 and provides routines for solving systems of simultaneous linear equations, least-squares solutions of linear systems of equations, eigenvalue problems, and singular value problems. The associated matrix factorizations (LU, Cholesky, QR, SVD, Schur, generalized Schur) are also provided, as are related computations such as reordering of the Schur factorizations and estimating condition numbers. Dense and banded matrices are handled, but not general sparse matrices. In all areas, similar functionality is provided for real and complex matrices, in both single and double precision.

The original goal of the LAPACK project was to make the widely used EISPACK and LINPACK libraries run efficiently on shared-memory vector and parallel processors. On these machines, LINPACK and EISPACK are inefficient because their memory access patterns disregard the multi-layered memory hierarchies of the machines, thereby spending too much time moving data instead of doing useful floating-point operations. LAPACK addresses this problem by reorganizing the algorithms to use block matrix operations, such as matrix multiplication, in the innermost loops. These block operations can be optimized for each architecture to account for the memory hierarchy, and so provide a transportable way to achieve high efficiency on diverse modern machines. We use the term "transportable" instead of "portable" because, for fastest possible performance, LAPACK requires that highly optimized block matrix operations be already implemented on each machine.

LAPACK routines are written so that as much as possible of the computation is performed by calls to the Basic Linear Algebra Subprograms (BLAS). LAPACK is designed at the outset to exploit the Level 3 BLAS — a set of specifications for Fortran subprograms that do various types of matrix multiplication and the solution of triangular systems with multiple right-hand sides. Because of the coarse granularity of the Level 3 BLAS operations, their use promotes high efficiency on many high-performance computers, particularly if specially coded implementations are provided by the manufacturer.

Highly efficient machine-specific implementations of the BLAS are available for many modern high-performance computers. For details of known vendor- or ISV-provided BLAS, consult the BLAS FAQ. Alternatively, the user can download ATLAS to automatically generate an optimized BLAS library for the architecture. A Fortran 77 reference implementation of the BLAS is available from netlib; however, its use is discouraged as it will not perform as well as a specifically tuned implementation.

Acknowledgments:

This material is based upon work supported by the National Science Foundation and the Department of Energy (DOE). Any opinions, findings and conclusions or recommendations expressed in this material are those of the author(s) and do not necessarily reflect the views of the National Science Foundation (NSF) or the Department of Energy (DOE).

The LAPACK project is also sponsored in part by [MathWorks](http://www.mathworks.com/) and [Intel](https://software.intel.com/en-us/intel-mkl) since many years.

## Software

### Licensing

LAPACK is a freely-available software package. It is available from netlib via anonymous ftp and the World Wide Web at <http://www.netlib.org/lapack> . Thus, it can be included in commercial software packages (and has been). We only ask that proper credit be given to the authors.

The license used for the software is the modified BSD license, see:

- [LICENSE](http://performance.netlib.org/lapack/LICENSE.txt)

Like all software, it is copyrighted. It is not trademarked, but we do ask the following:

- If you modify the source for these routines we ask that you change the name of the routine and comment the changes made to the original.
- We will gladly answer any questions regarding the software. If a modification is done, however, it is the responsibility of the person who modified the routine to provide support.

### LAPACK, version 3.10.0

- Download: [lapack-3.10.0.tar.gz](https://github.com/Reference-LAPACK/lapack/archive/refs/tags/v3.10.0.tar.gz)
- [LAPACK 3.10.0 Release Notes](http://performance.netlib.org/lapack/lapack-3.10.0.html)
- Updated: June 28 2021
- [LAPACK GitHub Open Bug](https://github.com/Reference-LAPACK/lapack/issues?q=is%3Aissue+is%3Aopen+label%3A%22Type%3A+Bug%22) (Current known bugs)

### Standard C language APIs for LAPACK

collaboration LAPACK and INTEL Math Kernel Library Team

- LAPACK C INTERFACE is now included in the LAPACK package (in the lapacke directory)
- [LAPACKE User Guide](http://performance.netlib.org/lapack/lapacke.html)
- Updated: November 16, 2013
- header files: [lapacke.h](http://performance.netlib.org/lapack/lapacke.h), [lapacke_config.h](http://performance.netlib.org/lapack/lapacke_config.h), [lapacke_mangling.h](http://performance.netlib.org/lapack/lapacke_mangling.h), [lapacke_utils.h](http://performance.netlib.org/lapack/lapacke_utils.h)