# cblas

[https://people.math.sc.edu/Burkardt/cpp_src/cblas/cblas.html](https://people.math.sc.edu/Burkardt/cpp_src/cblas/cblas.html)

# homepage

**CBLAS** is a C++ program which illustrates the use of the CBLAS, a C translation of the FORTRAN77 Basic Linear Algebra Subprograms (BLAS) which are used by the C translation of the FORTRAN77 LAPACK linear algebra library.

The translation of the BLAS source code from FORTRAN77 to C was done using the automatic F2C translator. As a consequence, the resulting C source code is unreadable by the user, but should execute precisely as the FORTRAN77 code did.

A user calling program must have the necessary "include" statements. Usually, this means adding the statements:

```
        # include "blaswrap.h"
        # include "f2c.h"
        # include "clapack.h"
      
```



Secondly, all variables that will be passed to a CBLAS function must be declared using types that can be handled by the FORTRAN package. In general, this only affects integer variables; as a rule this means that if N is an integer scalar, vector or array that will be passed to CBLAS, its type must be either "integer" (a type defined by f2c.h), or else as "long int" (a standard C type). Declaring such a variable as "int" will not work!

Each user accessible routine in the FORTRAN version of the BLAS has a corresponding CBLAS version. However, to access the CLAPACK version, the user must specify the name of the routine in lower case letters only, and must append an underscore to the name. Thus, to access a BLAS function such as DNRM2(), the user's C code must look something like this:

```
        norm = dnrm2_ ( list of arguments );
      
```



Because all FORTRAN subroutine arguments can be modified during the execution of the subroutine, the CBLAS interface requires that every argument in the argument list must be modifiable. In cases where a vector or array is being passed, this happens automatically. However, when passing a scalar variable, such as "N", the size of the linear system, or "LDA", the leading dimension of array A, or "INFO", an error return flag, it is necessary to prefix the name with an ampersand. Thus, a call to DGESV() might look like:

```
        dgesv_ ( &n, &nrhs, a, &lda, ipiv, b, &ldb, &info );
      
```

because 

n

, 

nrhs

, 

lda

, 

ldb

 and 

info

 are scalar variables.



The vector and matrix arguments to the CBLAS routine don't require the ampersand. Moreover, vectors (singly indexed lists of numbers) essentially work the same in C and FORTRAN, so it's not difficult to correctly set up vector arguments for CBLAS. However, matrices (doubly indexed sets of data) are handled differently, and the user's C code must either set up the data in a FORTRAN way immediately, or else set it up in a way natural to C and then convert the data to make a FORTRAN copy.

Let's assume that we have an M by N set of data, and to be concrete, let's consider an example where M = 3 and N = 2. In C, it would be natural to declare this data as follows:

```
        double a[3][2] = {
          { 11, 12 },
          { 21, 22 },
          { 31, 32 } };
      
```

In this case, the (I,J) entry (using 0-based indexing) can be retrieved as 

a[i][j]

.



However, FORTRAN essentially stores a matrix as a vector, in which the data is stored on column at a time. Thus, if we wished to pass the example data to CBLAS as an array, we might instead use the following declaration:

```
        double b[3*2] = {
          11, 21, 31,
          12, 22, 32 };
      
```

In this case, the (I,J) entry (using 0-based indexing) can be retrieved as 

b[i+j*3]

 where the number 3 is the "leading dimension" of the array, that is, the length of one column.



But suppose we need to build the array using the double indexed version, although we know we have to pass a single indexed copy to CBLAS? Then we can start with the following declarations:

```
        double a[3][2];
        double b[3*2];
      
```

and calculate the entries of 

a

 using double indexing, and then copy the information into 

b

 using code like the following:

```
        for ( j = 0; j < 2; j++ )
        {
          for ( i = 0; i < 3; i++ )
          {
            b[i+j*3] = a[i][j];
          }
        }
      
```

after which, the vector 

b

 will contain a copy of the data that is in 

a

, suitable for use by CBLAS.



The source code for the CBLAS library is available as part of the distribution of the CLAPACK library, at [http://www.netlib.org/clapack ](http://www.netlib.org/clapack).

### Licensing:

The computer code and data files described and made available on this web page are distributed under [the GNU LGPL license.](https://people.math.sc.edu/Burkardt/txt/gnu_lgpl.txt)

This refers to the EXAMPLES presented here. The CBLAS library itself is licensed under a different arrangement.

### Languages:

The examples for **CBLAS** are available in [a C version](https://people.math.sc.edu/Burkardt/c_src/cblas/cblas.html) and [a C++ version](https://people.math.sc.edu/Burkardt/cpp_src/cblas/cblas.html).

### Related Data and Programs:

[BLAS1_C](https://people.math.sc.edu/Burkardt/cpp_src/blas1_c/blas1_c.html), a C++ library which contains basic linear algebra subprograms (BLAS) for vector-vector operations, using single precision complex arithmetic, by Charles Lawson, Richard Hanson, David Kincaid, Fred Krogh.

[BLAS1_D](https://people.math.sc.edu/Burkardt/cpp_src/blas1_d/blas1_d.html), a C++ library which contains basic linear algebra subprograms (BLAS) for vector-vector operations, using double precision real arithmetic, by Charles Lawson, Richard Hanson, David Kincaid, Fred Krogh.

[BLAS1_S](https://people.math.sc.edu/Burkardt/cpp_src/blas1_s/blas1_s.html), a C++ library which contains basic linear algebra subprograms (BLAS) for vector-vector operations, using single precision real arithmetic, by Charles Lawson, Richard Hanson, David Kincaid, Fred Krogh.

[BLAS1_Z](https://people.math.sc.edu/Burkardt/cpp_src/blas1_z/blas1_z.html), a C++ library which contains basic linear algebra subprograms (BLAS) for vector-vector operations, using double precision complex arithmetic, by Charles Lawson, Richard Hanson, David Kincaid, Fred Krogh.

### Reference:



1. Edward Anderson, Zhaojun Bai, Christian Bischof, Susan Blackford, James Demmel, Jack Dongarra, Jeremy DuCroz, Anne Greenbaum, Sven Hammarling, Alan McKenney, Danny Sorensen,
   LAPACK User's Guide,
   Third Edition,
   SIAM, 1999,
   ISBN: 0898714478,
   LC: QA76.73.F25L36



### Examples and Tests:



- [cblas_test.cpp](https://people.math.sc.edu/Burkardt/cpp_src/cblas/cblas_test.cpp), a sample calling program.
- [cblas_test.sh](https://people.math.sc.edu/Burkardt/cpp_src/cblas/cblas_test.sh), commands to compile, load and run the example.
- [cblas_test.txt](https://people.math.sc.edu/Burkardt/cpp_src/cblas/cblas_test.txt), the output file.



You can go up one level to [the C++ source codes](https://people.math.sc.edu/Burkardt/cpp_src/cpp_src.html).

------

Last revised on 05 October 2018.