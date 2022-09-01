
## 基本概念


实际频率$f$, 实际周期$f_s$, 

角频率 $\Omega=2\pi f$, 实际周期$2\pi f_s$

圆周频率$\omega=2\pi f$，周期是$2\pi$

归一化频率 $f=f/f_s$, 周期是1

以上频率中，圆周频率和归一化频率都是归一化的相对频率，公式推导中基本不会使用。


### Fourier变换
$$
F(\omega)=\int_{-\infty}^{+\infty}{f(t)e^{-j\omega t}dt}
$$

### Laplace变换
Laplace变换, $s=\sigma+j\Omega$

$$
L(s)=\int_0^{\infty}{f(t)e^{-st}dt}
$$
### Z变换
Z变换（Z-transformation）是对离散序列进行的一种数学变换，常用于求线性时不变差分方程的解。它在离散系统中的地位如同拉普拉斯变换在连续系统中的地位。Z变换已成为分析线性时不变离散系统问题的重要工具，并且在数字信号处理、计算机控制系统等领域有着广泛的应用。

z变换，$z=re^{jw}$
#### 双边Z变换

$$
X(z)=\sum_{n=-\infty}^{+\infty}{x[n]Z^{-n}}
$$



#### 单边Z变换

$$
X(z)=\sum_{n=0}^{+\infty}{x[n]Z^{-n}},
$$

#### 收敛域
收敛域ROC。
