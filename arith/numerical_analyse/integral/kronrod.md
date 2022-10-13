# kronrod

[kronrod](https://people.sc.fsu.edu/~jburkardt/py_src/kronrod/kronrod.html)


kronrod, a Python code which computes both a Gauss quadrature rule of order N, and the Gauss-Kronrod rule of order 2*N+1.

A pair of Gauss and Gauss-Kronrod quadrature rules are typically used to provide an error estimate for an integral. The integral is estimated using the Gauss rule, and then the Gauss-Kronrod rule provides a higher precision estimate. The difference between the two estimates is taken as an approximation to the level of error.

The advantage of using a Gauss and Gauss-Kronrod pair is that the second rule, which uses 2*N+1 points, actually includes the N points in the previous Gauss rule. This means that the function values from that computation can be reused. This efficiency comes at the cost of a mild reduction in the degree of polynomial precision of the Gauss-Kronrod rule.

## misc
Virginia Tech 的 John Burkardt 老师在2016年给出了 Gauss–Kronrod 积分的 Python 3实现