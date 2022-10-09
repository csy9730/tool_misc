# BLAS

BLAS (Basic Linear Algebra Subprograms)

[https://www.netlib.org/blas/](https://www.netlib.org/blas/)


blas 矩阵运算库

lapack 向量，矩阵的高级运算库（矩阵分解，最小二乘，方程求解）


# homepage

## Presentation:

The BLAS (Basic Linear Algebra Subprograms) are routines that provide standard building blocks for performing basic vector and matrix operations. The Level 1 BLAS perform scalar, vector and vector-vector operations, the Level 2 BLAS perform matrix-vector operations, and the Level 3 BLAS perform matrix-matrix operations. Because the BLAS are efficient, portable, and widely available, they are commonly used in the development of high quality linear algebra software, [LAPACK](http://www.netlib.org/lapack/) for example.

### Acknowledgments:

This material is based upon work supported by the National Science Foundation under Grant No. ASC-9313958 and DOE Grant No. DE-FG03-94ER25219. Any opinions, findings and conclusions or recommendations expressed in this material are those of the author(s) and do not necessarily reflect the views of the National Science Foundation (NSF) or the Department of Energy (DOE).

### History

Discover the great history behind BLAS. On April 2004 an oral history interview was conducted as part of the [SIAM project on the history of software for scientific computing and numerical analysis](http://history.siam.org/oralhistories.htm). This interview is being conducted with Professor Jack Dongarra in his office at the University of Tennessee. The interviewer is Thomas Haigh. [Download Interview](http://history.siam.org/pdfs2/Dongarra_%20returned_SIAM_copy.pdf) Enjoy!



#### BLAS Routines


- single   S
- double   D
- single complex  C
- double complex  Z


- LEVEL 1
	DOT
	SWAP
	COPY
	SCAL  y=x*k
	AXPY  y=x*a+b
	NRM2  
	CNRM2
	ASUM sum(abs(x))
	AMAX 
- LEVEL 2
	**MV 矩阵乘向量
	**SV 向量除矩阵
	** rank ?
- LEVEL 3
	MM  矩阵乘矩阵
	

#### lapacke

http://www.netlib.org/lapack/lapacke.html

- Linear Equations
- QR
- LQ
- Orthogonal
- GQR
- GRQ
- eigen
- SVD
