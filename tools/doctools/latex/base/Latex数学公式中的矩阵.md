## [Latex数学公式中的矩阵](https://www.cnblogs.com/solvit/p/11345482.html)



目录

- [矩阵的括号形式](https://www.cnblogs.com/solvit/p/11345482.html#矩阵的括号形式)
- [array环境](https://www.cnblogs.com/solvit/p/11345482.html#array环境)
- [上三角矩阵](https://www.cnblogs.com/solvit/p/11345482.html#上三角矩阵)
- [分块矩阵](https://www.cnblogs.com/solvit/p/11345482.html#分块矩阵)
- [行内矩阵](https://www.cnblogs.com/solvit/p/11345482.html#行内矩阵)



## 矩阵的括号形式

使用`matrix`、`pmatrix`、`bmatrix`、`Bmatrix`、`vmatrix`或者`Vmatrix`环境：

- matrix 裸矩阵
- pmatrix (矩阵)
- bmatrix [矩阵]
- Bmatrix {矩阵}
- vmatrix 行列式： |矩阵|
- Vmatrix ||矩阵||


```
$$
\begin{gathered}
\begin{matrix} 0 & 1 \\ 1 & 0 \end{matrix}
\quad
\begin{pmatrix} 0 & -i \\ i & 0 \end{pmatrix}
\quad
\begin{bmatrix} 0 & -1 \\ 1 & 0 \end{bmatrix}
\quad
\begin{Bmatrix} 1 & 0 \\ 0 & -1 \end{Bmatrix}
\quad
\begin{vmatrix} a & b \\ c & d \end{vmatrix}
\quad
\begin{Vmatrix} i & 0 \\ 0 & -i \end{Vmatrix}
\end{gathered}
$$
```





0110(0i−i0)[01−10]{100−1}∣∣∣acbd∣∣∣∥∥∥i00−i∥∥∥0110(0−ii0)[0−110]{100−1}|abcd|‖i00−i‖

### dots

– \ldots for horizontal dots on the line
– \cdots for horizontal dots above the line
– \vdots for vertical dots
– \ddots for diagonal dots



## array环境

使用`array`环境来输入矩阵：

```
$$      %开始数学环境
\left(                 %左括号
  \begin{array}{ccc}   %该矩阵一共3列，每一列都居中放置
    a11 & a12 & a13\\  %第一行元素
    a21 & a22 & a23\\  %第二行元素
  \end{array}
\right)                 %右括号
$$
```





(a11a21a12a22a13a23)(a11a12a13a21a22a23)



## 上三角矩阵

上三角矩阵

```
$$
A=\begin{bmatrix}
a_{11} & \dots & a_{1n}\\
  & \ddots & \vdots\\
0 & & a_{nn}
\end{bmatrix}_{n \times n}
$$
```





A=⎡⎣⎢⎢a110…⋱a1n⋮ann⎤⎦⎥⎥n×nA=[a11…a1n⋱⋮0ann]n×n



## 分块矩阵

分块矩阵

```
$$
\begin{pmatrix}
\begin{matrix} 1&0\\0&1 \end{matrix} & \text{0}\\
\text{0} & \begin{matrix} 1&0\\0&1 \end{matrix}
\end{pmatrix}
$$
```





⎛⎝⎜⎜⎜1001001001⎞⎠⎟⎟⎟(1001001001)



## 行内矩阵

行内矩阵

```
$
\left(
\begin{smallmatrix}
x & \frac{x}{y} \\
\frac{y}{x} & x
\end{smallmatrix}
\right)
$
```

这是一个(xyxxyx)(xxyyxx)行内矩阵



分类: [数学基础](https://www.cnblogs.com/solvit/category/1525119.html)