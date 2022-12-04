# interpolation

> Interpolation is a method of constructing new data points within the range of a discrete set of known data points. Image interpolation refers to the "guess" of intensity values at missing locations.

插值分为内插值和外插值。



- 时域插值
  - 多项式插值法
    - 范德蒙德矩阵法
    - 拉格朗日（多项式）插值法
    - 牛顿（多项式）插值法
    - hermit插值法
  - 分段插值法
    - 最近邻插值法（0阶保持器）
    - 线性插值（一阶保持器）
    - 多项式插值 hermit
    - 三次多项式插值 样条插值
  - 三角函数拟合（傅里叶拟合）
  - 特殊函数拟合（指数，对数）
- 频域插值，等价于频域插值0，加窗反变换
  - 频域加矩形窗对应 时域的sinc函数
  - 其他窗函数

- 一维信号
  - 线性插值
  - 三次插值
- 二维信号
  - 最近邻插值法
  - 双线性插值
  - 双三次插值


## 多项式拟合

给定n+1个点，
$$
y_i=f(x_i), i=0,1,\dots,n
$$
可以得到关于系数的n+1元线性方程组。
$$
\begin{cases} a_0+a_1x_0+...+a_nx_0^n=y_0\\
a_0+a_1x_1+...+a_nx_1^n=y_1 \\ \dots 

\\ a_0+a_1x_n+...+a_nx_n^n=y_n

\end{cases}
$$


### 范德蒙德矩阵
$$
A=\begin{bmatrix} 1 & x_0 & \cdots & x_0^n \\
1 & x_1 & \cdots & x_1^n \\
\vdots & \vdots & & \vdots\\
1 & x_n & \cdots & x_n^n \\
\end{bmatrix}
$$




### 拉格朗日拟合

拉格朗日插值属于多项式插值的一种。

### 牛顿插值

### 艾尔米特插值

艾尔米特插值可以保证一阶导数连续

## 分段插值

### 分段线性插值

### 分段三次艾尔米特插值

一阶导数连续

### 三次样条插值

N+1个点，共有N个区间[x_j,x_j+1], 一个区间对应一个三次多项式，四个待定系数。共有N个区间，需要确定4N 个系数。每个区间有两个端点确定，提供了2N个条件。一阶连续和二阶连续，提供了2N-2 个条件，合计4N-2个条件，距离4N还差两个条件。
$$
f(x_j-0)=f(x_j+0) \\
f(x_j-0)=f(x_j+0)
$$


这两个边界条件可以自行确定。

1. 两端的一阶导数
2. 两端的二阶导数。
   1. 二阶导数为0
3. periodic，周期函数，左端点的微分等于右端点的微分，左端点的二次微分等于右端点的二次微分
 


### 三角多项式
span{cos(it),sin(it)}

### C 曲线
span{1,t,cost,sint}

span{1,t,t^{n-2}, cost,sint}

### H-Bezier

span{1,t,t^{n-4}, cosht,sinht, tsinht,tcosht}