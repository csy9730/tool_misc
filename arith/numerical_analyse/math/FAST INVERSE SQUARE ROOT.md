# FAST INVERSE SQUARE ROOT

原始函数形式
$$
y = \frac{1}{\sqrt{x}},
$$

转变成隐函数方程形式
$$
f(y)=\frac{1}{y^2}-X=0
$$


引入牛顿迭代法
$$
y_{n+1}=y_n-\frac{f(y_n)}{f^`(y_n)}\\

$$

带入可得
$$
f(y)=\frac{1}{y^2}-X \\
f^`(y_n)=\frac{-2}{y^3}\\
y_{n+1}=y_n-\frac{f(y_n)}{f^`(y_n)}=\frac{y_n(3-Xy_n^2)}{2}
$$

其他的迭代形式
$$
y-\frac{1}{\sqrt(X)} = 0\\
y^2-\frac{1}{X} = 0\\
y^2-\frac{1}{X} = 0\\
\frac{1}{y}-\sqrt X = 0\\
Xy^2-1 = 0\\
$$
