# Hermite Cubic Spline


### Hermite Basis Polynomials
Ferguson’s curves

给定两点P0 P1和两点处的切线P0t P1t，可以确定两点间的三次曲线。曲线的参数方程为：

$$
p(t) = at^3+bt^2+ct+d
$$

导数形式：
$$
p^`(t)=3at^2+2bt+c
$$

t=0,1

$$
p(0)=d\\
p(1)=a+b+c+d\\
p^`(0)=c\\
p^`(1)=3a+2b+c
$$

matrix form
$$
\begin{pmatrix} p(0)\\p(1)\\p^`(0)\\p^`(1) \end{pmatrix}=
\begin{pmatrix} 0&0&0&1 \\ 1&1&1&1 \\ 0&0&1&0\\ 3&2&1&0 \end{pmatrix}
\begin{pmatrix} a\\b\\c\\d \end{pmatrix}
$$

矩阵求逆：
$$
\begin{pmatrix} a\\b\\c\\d \end{pmatrix}
=
\begin{pmatrix} 2&-2&1&1 \\ -3&3&-2&-1 \\ 0&0&1&0\\ 1&0&0&0 \end{pmatrix}
\begin{pmatrix} p(0)\\p(1)\\p^`(0)\\p^`(1) \end{pmatrix}
$$


$$
p(t) = 
\begin{pmatrix} t^3 & t^2 & t & 1 \end{pmatrix}\begin{pmatrix} a\\b\\c\\d \end{pmatrix}
= \begin{pmatrix} t^3 & t^2 & t & 1 \end{pmatrix}
\begin{pmatrix} 2&-2&1&1 \\ -3&3&-2&-1 \\ 0&0&1&0\\ 1&0&0&0 \end{pmatrix}
\begin{pmatrix} p(0)\\p(1)\\p^`(0)\\p^`(1) \end{pmatrix}
$$



$$
p(t) = \begin{pmatrix} 2t^3-3t^2+1 & -2t^3+3t^2 & t^3-2t^2+t t^3-t^2 \end{pmatrix}
\begin{pmatrix} p(0)\\p(1)\\p^`(0)\\p^`(1) \end{pmatrix}
$$

> In essence, we have managed to find the unique cubic curve determined by two data points p(0) and p(1) and the slopes at these points p'(0) and p'(1).

### Piecewise Hermite
多个分段赫米特多项式，就构成了赫米特三次样条 hermite-cubic-spline。

## misc

### reference
[https://www.baeldung.com/cs/spline-differences](https://www.baeldung.com/cs/spline-differences)

