# y=x^2抛物线长度计算

对于方程为 ![[公式]](https://www.zhihu.com/equation?tex=y+%3D+x%5E2) 的抛物线，其在区间 ![[公式]](https://www.zhihu.com/equation?tex=%5B0%2C+a%5D) ， ![[公式]](https://www.zhihu.com/equation?tex=a+%3E+0) ，内的弧长为

![[公式]](https://www.zhihu.com/equation?tex=%5Cbegin%7Balign%7D+++++L_1+%5Cleft%28+a+%5Cright%29+%26%3D+%5Cint_0%5Ea+%5Csqrt%7B1+%2B+%5Cleft%28+y%5E%5Cprime+%5Cright%29%5E2%7D+%5C%2C+%7B%5Crm%7Bd%7D%7D+x+%5C%5C+++++%26%3D+%5Cint_0%5Ea+%5Csqrt%7B1+%2B+4+x%5E2%7D+%5C%2C+%7B%5Crm%7Bd%7D%7D+x+%5C%5C+++++%26%5Cxlongequal%5B%7B%5Crm%7Bd%7D%7Dx+%3D+%5Cfrac%7B1%7D%7B2%7D%7B%5Crm%7Bsec%7D%7D%5E2+u%5D%7Bx+%3D+%5Cfrac%7B1%7D%7B2%7D%7B%5Crm%7Btan%7D%7D+u%7D+%5Cint_0%5E%7B%7B%5Crm%7Barctan%7D%7D+2a%7D+%5Cdfrac%7B%7B%5Crm%7Bd%7D%7D+u%7D%7B%7B%5Crm%7Bcos%7D%7D%5E3+u%7D+%5C%5C+++++%26%3D+%5Cdfrac%7B1%7D%7B4%7D+%7B%5Crm%7Bln%7D%7D+%5Cleft%28+2+a+%2B+%5Csqrt%7B1+%2B+4+a%5E2%7D+%5Cright%29+%2B+%5Cdfrac%7B1%7D%7B2%7D+a+%5Csqrt%7B1+%2B+4+a%5E2%7D+%5Cend%7Balign%7D)
$$
L_1(a)=\int_0^a{\sqrt(1+y^{'2})dx}\\
= \frac{1}{4}ln(2a+\sqrt({1+4a^2}))+\frac{1}{2}a\sqrt{1+4a^2}
$$




对于方程为 ![[公式]](https://www.zhihu.com/equation?tex=y+%3D+k+x%5E2)， ![[公式]](https://www.zhihu.com/equation?tex=k+%5Cneq+0)，的抛物线，其在区间 ![[公式]](https://www.zhihu.com/equation?tex=%5B0%2C+a%5D) ， ![[公式]](https://www.zhihu.com/equation?tex=a+%3E+0) ，内的弧长为

![[公式]](https://www.zhihu.com/equation?tex=%5Cbegin%7Balign%7D+++++L_k+%5Cleft%28+a+%5Cright%29+%26%3D+%5Cint_0%5Ea+%5Csqrt%7B1+%2B+%5Cleft%28+y%5E%5Cprime+%5Cright%29%5E2%7D+%5C%2C+%7B%5Crm%7Bd%7D%7D+x+%5C%5C+++++%26%3D+%5Cint_0%5Ea+%5Csqrt%7B1+%2B+4+k%5E2+x%5E2%7D+%5C%2C+%7B%5Crm%7Bd%7D%7D+x+%5C%5C+++++%26%3D+%5Cdfrac%7B1%7D%7Bk%7D+%5Cint_0%5Ea+%5Csqrt%7B1+%2B+4+k%5E2+x%5E2%7D+%5C%2C+%7B%5Crm%7Bd%7D%7D+%5Cleft%28+k+x+%5Cright%29+%5C%5C+++++%26%3D+%5Cdfrac%7B1%7D%7Bk%7D+%5Cint_0%5E%7Ba+k%7D+%5Csqrt%7B1+%2B+4+u%5E2%7D+%5C%2C+%7B%5Crm%7Bd%7D%7D+u+%5C%5C+++++%26%3D+%5Cdfrac%7B1%7D%7Bk%7D+L_1+%5Cleft%28+a+k+%5Cright%29+%5Cend%7Balign%7D)


$$
L_k(a)=\int_0^a{\sqrt{1+y^{'2}}dx}\\
=\frac{1}{k}L_1(ak)
$$




对于区间 ![[公式]](https://www.zhihu.com/equation?tex=%5Ba%2C+b%5D) ，剩下的就是加加减减的工作了。



## 圆计算

$$
L=\int_0^1\sqrt{x^{`2}+\sqrt{1-x^2}^{`2}}dx\\
= \int_0^1\sqrt{1+\frac{x^{2}}{1-x^2}}dx\\
$$



使用sin/cos形式


$$
L=\int_0^{\pi/2}\sqrt{Rcos(t)^{`2}+Rsin(t)^{`2}}dt\\
= \int_0^{\pi/2}Rdx=\pi R/2\\
$$
