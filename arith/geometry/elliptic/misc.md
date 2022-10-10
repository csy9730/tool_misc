# misc


### inverse function 
If g takes on both negative and positive values, or is zero on some interval, then f is not invertible, as mentioned in comments.

Assume g is strictly positive (or strictly negative), hence f−1 exists and is differentiable by inverse function theorem.

Then $f(f^{−1}(x))=x$, so by differentiating, we get that $f^′(f^{−1}(x))(f^{−1})^′(x)=1$, i.e, $g(f^{−1}(x))(f^{−1})^′(x)=1$.

Thus we see that f−1 satisfies the differential equation
$$
y^′=\frac{1}{g(y)}
$$
For some functions g this can be solved exactly (for example, $g(y)=e^y$ or $g(y)=y^2+1$), while for others it cannot be solved exactly (for example $g(y)=e^{y^2}$). Hence, you can get this differential formula but no explicit solution in general.


### 3
在密码学的分支“椭圆曲线密码学”中使用的椭圆曲线和“费马大定理”的证明中使用的椭圆曲线


###  AGM

$$
AGM(ka,kb)= k*AGM(a,b) \\

AGM(a,b)=(a+b)/2 * AGM(2a/(a+b), 2b/(a+b))\\
= \frac{(a+b)}{2} AGM(1+h, 1-h)\\
h= \frac{a-b}{a+b}
$$

