# 牛顿迭代算法

## Newton-Raphson
Newton迭代法也称为切线法

求解方程$f(x)= 0$

对函数f(x)做一阶泰勒展开
$$
f(x) =f(x_k)+ f^`(x_k)(x-x_k) + \frac{f^{``}(x_k)}{2}(x-x_k)^2\\
\approx f(x_k)+ f^`(x_k)(x-x_k) 
$$

代入方程
$$
f(x) = 0 \\
f(x_k)+ f^`(x_k)(x-x_k) = 0\\
x = x_k - \frac{f(x_k)}{f^`(x_k)}
$$


牛顿法在靠近最优点处是二次收敛的。

推导牛顿法时，我们就舍弃了高阶项，舍弃这一部分产生的误差在迭代跨度稍微大一点的时候是不好忽略的。

我们将以上的性质称为牛顿法的局部收敛性。



牛顿迭代法可能出现的问题
- 超出定义域
- 导数为0
- 振荡或发散
- 收敛过慢
#### 1

$$				
\phi(x) = x-f(x)/f^`(x)\\
\phi^`(x) = \frac{f(x)f^{``}(x))}{ |f^`(x)|^2}\\

$$


假定$x^*$ 是$f(x)=0$的一个单根，即$f( x^∗ ) = 0$ , $f^`(x^*)\neq 0$, 则有 $\varphi'(x^*)=0$ , 当x充分靠近$x^*$ 
时，可使 $|\varphi'(x)|\leq L<1∣$ 成立，从而根据迭代法的局部收敛性定理可知，Newton迭代法在单根 $x^*$的邻近是收敛的。即有下面的Newton法局部收敛性定理。
#### 2

设f(x)在区间[a,b]上二阶导数存在，且满足：

- $f(a)f(b)<0$
- $f^`(x)\neq 0,x\in(a,b)$
- $f{``}(x) \neq 0, x\in(a,b)$ , f(x)不变号
- $f''(x_0)f(x_0)>0, x\in(a,b)$ 

则Newton迭代公式收敛于$f(x)=0$在(a,b)内的惟一根$x^*$。
#### 3

$$
f(x) =f(x_k)+ f^`(x_k)(x-x_k) + \frac{f^{``}(x_k)}{2}(x-x_k)^2\\
f(x_k)+ B(x-x_k) + A(x-x_k)^2=0\\
C+ Bu + Au^2=0\\
\Delta= B^2-4AC\\
u=\frac{-B+-\sqrt{B^2-4AC}}{2A}\\
u=\frac{4AC}{2A(-B-+\sqrt{B^2-4AC})}\\
u=\frac{-2C}{B+-\sqrt{B^2-4AC}}\approx -C/B\\
x = u+x_k
$$
#### 4
选取初值，使$B^2>>4AC$，此时，牛顿法收敛较快

#### 使用牛顿法计算开平方
$$
f(x) = x^2- C 
$$
2
$$
f^`(x) = 2x
$$

3
$$
x_{k+1}= x_k-\frac{f(x_k)}{f^`(x_k)}\\
 = x_k-\frac{x_k^2-C}{2x_k}\\
 = \frac{x_k+C/x_k}{2}\\
$$

#### 使用牛顿法计算开平方2
$$
f(x) = x^2/C-1\\
f(x) = C/x^2-1\\
f^`(x) = 1\\
x_{k+1}= \frac{(3C-x_k^2)x_k}{2C}
$$

迭代函数导数可能超过1，导致发散？





## 牛顿最优化算法
对函数做二阶泰勒展开
$$
f(x) \approx f_k+\nabla f(x_k)(x-x_k) + (x-x_k)^T\nabla^2f(x_k)(x-x_k)/2
$$

两边求导
$$
\nabla f(x) \approx \nabla f(x_k)+ \nabla^2f(x_k)(x-x_k) \\
$$


极点方程
$$
\nabla f(x)=0 \\
$$
求解
$$
\Delta f(x_k)+ \Delta^2f(x_k)(x-x_k) = 0\\
 x = x_k-\Delta^2f^{-1}(x_k)* \Delta f(x_k)
$$

对于多元函数（向量），导数是Jacobi(雅克比)矩阵；二阶微分是Hessian（海森）矩阵。

### 阻尼牛顿法

牛顿下山法？

### LM法
牛顿法中 海森矩阵​可能是奇异、非正定等情况，为了解决这个情况，我们可以为Hessian矩阵加上一个 单位矩阵。

### ​拟牛顿法(Quasi-Newton Method)