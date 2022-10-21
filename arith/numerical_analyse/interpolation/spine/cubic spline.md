# 三次样条拟合求解



已知n+1个数据节点$x_0,...x_n$，分成n个区间$[x_0,x_1],[x_1,x_2],...[x_{n-1},x_n]$.

在每个区间构造一个三次函数，共n段函数（S0~Sn-1）

$$
S_i(x)=a_i+b_i(x-x_i)+c_i(x-x_i)^2+d_i(x-x_i)^3
$$

n个三次函数：

$$
S_0(x)=a_0+b_0(x-x_0)+c_0(x-x_0)^2+d_0(x-x_0)^3\\
S_1(x)=a_1+b_1(x-x_1)+c_1(x-x_1)^2+d_1(x-x_1)^3\\
S_i(x)=a_i+b_i(x-x_i)+c_i(x-x_i)^2+d_i(x-x_i)^3\\
S_{n-1}(x)=a_{n-1}+b_{n-1}(x-x_{n-1})+c_{n-1}(x-x_{n-1})^2+d_{n-1}(x-x_{n-1})^3\\
$$

每段三次函数S(x)都有a,b,c,d四个系数，上述n个分段函数，共有4*n个系数（未知数）。因此，要想求解这4n个未知数，共需要4n个方程。

### 约束条件

#### 左端点条件
已知左端点约束条件, 共有n个。
$$
S_i(x_i)=y_i, i=0,1,n-1\\
$$

#### 右端点条件
已知右端点约束条件, 共有n个。
$$
S_i(x_{i+1})=y_{i+1},i=0,1,2,n-1\\
$$
#### 导数连续条件
已知导数连续条件, 共有n-1个。
$$
S_i^`(x_{i+1})=S_{i+1}^`(x_{i+1}),i=0,1,n-2\\
$$
#### 二阶导数连续条件
已知二阶导数连续条件, 共有n-1个。
$$
S_i^{``}(x_{i+1})=S_{i+1}^{``}(x_{i+1}),i=0,1,n-2\\
$$
#### 合计
总共有$n+n+(n-1)+(n-1)=4n-2$个方程，还需要两个方程。
这两个方程通过边界条件给出。 

### 边界条件

有多种边界条件：自然边界，固定边界，非节点边界
#### 自然边界
$$
S_0^{``}(x_0)=0\\
S_{n-1}^{``}(x_n)=0
$$

#### 固定边界

#### 非节点边界

### solve


$$
\begin{cases}
S_i(x)=a_i+b_i(x-x_i)+c_i(x-x_i)^2+d_i(x-x_i)^3\\
S_i^`(x)=b_i+2c_i(x-x_i)+3d_i(x-x_i)^2\\
S_i^{``}(x)=2c_i+6d_i(x-x_i)\\
\end{cases}
$$

引入h参数。
y
$$
h_i=x_{i+1}-x_i\\
$$

#### 左端点条件
$$
S_i(x_i)=a_i+b_i(x-x_i)+c_i(x-x_i)^2+d_i(x-x_i)^3=y_i \\
a_i = y_i
$$

#### 右端点条件
$$
S_i(x_{i+1})=y_{i+1}\\
a_i+h_ib_i+h_i^2c_i+h_i^3d_i=y_{i+1}\\
$$

#### 一阶导数连续条件

$$
S_i^`(x_{i+1}) =b_i+2c_i(x_{i+1}-x_i)+3d_i(x_{i+1}-x_i)^2=b_i+2c_ih_i+3d_ih_i^2\\

S_{i+1}^`(x_{i+1}) =b_{i+1}+2c_{i+1}(x_{i+1}-x_{i+1})+3d_{i+1}(x_{i+1}-x_{i+1})^2=b_{i+1}\\
b_i+2c_ih_i+3d_ih_i^2=b_{i+1}
$$


#### 二阶导数连续条件
$$
S_i^{``}(x_{i+1})=S_{i+1}^{``}(x_{i+1})\\
2c_i+6d_ih_i=2c_{i+1}
$$

引入m参数。
$$
m_i=2c_i\\
d_i=\frac{m_{i+1}-m_i}{6h_i}
$$

注意， c是n维，而m是n+1维。

#### 联立方程

左端点条件，二阶导数连续条件代入到右端点条件。

$$
b_i=\frac{y_{i+1}-y_i}{h_i}-\frac{h_i}{2}m_i-\frac{h_i}{6}(m_{i+1}-m_i)
$$

#### 联立方程2
代入到一阶导数连续条件。

$$

h_im_i+2(h_i+h_{i+1})m_{i+1}+h_{i+1}m_{i+2}=6(\frac{y_{i+2}-y_{i+1}}{h_{i+1}}-\frac{y_{i+1}-y_i}{h_i})
$$


#### 自然边界条件 
$$
m_0=0, m_n=0
$$

矩阵方程形式：
$$
\begin{pmatrix} 1 & 0 & 0 & ... & 0 & 0\\ 
h_0 & 2(h_0+h_1) & h_1 & ... & 0 & 0\\
0 & h_1 & 2(h_1+h_2) & h_2 & 0 & 0 \\
...\\
0 & 0 & ... & h_{n-2} & 2(h_{n-2}+h_{n-1}) & h_{n-1}\\
0 & 0  & ... & 0 & 0 & 1\\\end{pmatrix}
\begin{pmatrix} m_0\\m_1\\m_2\\...\\m_{n-1}\\m_{n}\end{pmatrix}
=6\begin{pmatrix} m_0/6\\ \frac{y_{2}-y_{1}}{h_{1}}-\frac{y_{1}-y_0}{h_0}\\\frac{y_{3}-y_{2}}{h_{2}}-\frac{y_{2}-y_1}{h_1}\\...\\ \frac{y_{n}-y_{n-1}}{h_{n-1}}-\frac{y_{n-1}-y_{n-2}}{h_{n-2}}\\m_{n}/6\end{pmatrix}
$$


H是三对角矩阵，对应的三向量是：
$$
B = \begin{pmatrix} 1 & 2(h_0+h_1) & 2(h_1+h_2) & ... & 2(h_{n-2}+h_{n-1}) & 1\end{pmatrix}\\
A = \begin{pmatrix} 0 & h_1 & h_2 & ... & h_{n-2} & h_{n-1}\end{pmatrix}\\
C = \begin{pmatrix} h_0 & h_1 & h_2 & ... & h_{n-2} & 0\end{pmatrix}\\
$$
#### 夹持边界条件

紧压样条(Clamped), 也叫做完全三次样条，一阶导数条件.

$$
S^{`}_0(x_0)=A\\
S^{`}_{n-1}(x_n)=B\\
$$
##### 左夹持边界条件
化简
$$
S^{`}_0(x_0)=b_0=A\\
$$
带入联立方程

$$
b_0=\frac{y_{1}-y_0}{h_0}-\frac{h_0}{2}m_0-\frac{h_0}{6}(m_{1}-m_0)=A
$$

化简
$$
2h_0m_0+h_0m_1=6(\frac{y_1-y_0}{h_0}-A)
$$
##### 右夹持边界条件

化简
$$
S^{`}_{n-1}(x_n)=B\\
$$
带入联立方程


化简
$$
h_{n-1}m_{n-1}+2h_{n-1}m_n=6(B-\frac{y_n-y_{n-1}}{h_{n-1}})
$$

##### matrix
矩阵方程简写：
$$
HM=Y\\
$$

矩阵详细表达：
$$
H=\begin{pmatrix} 2h_0 & h_0 & 0 & ... & 0 & 0\\ 
h_0 & 2(h_0+h_1) & h_1 & ... & 0 & 0\\
0 & h_1 & 2(h_1+h_2) & h_2 & 0 & 0\\
...\\
0 & 0 & ... & h_{n-2} & 2(h_{n-2}+h_{n-1}) & h_{n-1}\\
0 & 0  & ... & 0 & h_{n-1} & 2h_{n-1}\\\end{pmatrix}\\
M=\begin{pmatrix} m_0\\m_1\\m_2\\...\\m_{n-1}\\m_{n}\end{pmatrix}\\
Y=6\begin{pmatrix} \frac{y_1-y_0}{h_0}-A\\ \frac{y_{2}-y_{1}}{h_{1}}-\frac{y_{1}-y_0}{h_0}\\\frac{y_{3}-y_{2}}{h_{2}}-\frac{y_{2}-y_1}{h_1}\\...\\ \frac{y_{n}-y_{n-1}}{h_{n-1}}-\frac{y_{n-1}-y_{n-2}}{h_{n-2}}\\B-\frac{y_n-y_{n-1}}{h_{n-1}}\end{pmatrix}\\
$$

H是三对角矩阵，对应的三向量是：
$$
B = \begin{pmatrix} 2h_0 & 2(h_0+h_1) & 2(h_1+h_2) & ... & 2(h_{n-2}+h_{n-1}) & 2h_{n-1}\end{pmatrix}\\
A = \begin{pmatrix} h_0 & h_1 & h_2 & ... & h_{n-2} & h_{n-1}\end{pmatrix}\\
C = \begin{pmatrix} h_0 & h_1 & h_2 & ... & h_{n-2} & h_{n-1}\end{pmatrix}\\
$$

#### 在非扭结边界条件
无结三次样条(not a knot).

$$
S^{```}_0(x_1)=S^{```}_1(x_1)\\
S^{```}_{n-2}(x_{n-1})=S^{```}_{n-1}(x_{n-1})\\
$$

$$
S_i^{```}(x)=6d_i\\
$$

带入可得
$$

d_0=d_1\\
d_{n-2}=d_{n-1}\\
$$

又有
$$
d_i = \frac{m_{i+1}-m_i}{6h_i}
$$

联立可得
$$
h_1(m_1-m_0)=h_0(m_2-m_1)\\
h_{n-1}(m_{n-1}-m_{n-2})=h_{n-2}(m_n-m_{n-1})\\
$$

$$
-h_1m_0 + (h_1+ h_0)m_1 - h_0m_2 = 0\\
-h_{n-1}m_{n-2}+(h_{n-1}+h_{n-2})m_{n-1}-h_{n-2}m_n=0\\
$$

3
$$

H=\begin{pmatrix} -h_1 & h_0+h_1 & -h_0 & ... & 0 & 0\\ 
h_0 & 2(h_0+h_1) & h_1 & ... & 0 & 0\\
0 & h_1 & 2(h_1+h_2) & h_2 & 0 & 0\\
...\\
0 & 0 & ... & h_{n-2} & 2(h_{n-2}+h_{n-1}) & h_{n-1}\\
0 & 0  & ... & -h_{n-1} & h_{n-1}+h_{n-2} & -h_{n-2}\\\end{pmatrix}\\

Y=6\begin{pmatrix} 0\\ \frac{y_{2}-y_{1}}{h_{1}}-\frac{y_{1}-y_0}{h_0}\\\frac{y_{3}-y_{2}}{h_{2}}-\frac{y_{2}-y_1}{h_1}\\...\\ \frac{y_{n}-y_{n-1}}{h_{n-1}}-\frac{y_{n-1}-y_{n-2}}{h_{n-2}}\\0\end{pmatrix}
$$

H是5对角矩阵。

#### 周期边界条件
略

#### equation solve
thomas 
#### rebuild
$$
\begin{cases}
a_i=y_i\\
b_i=\frac{y_{i+1}-y_i}{h_i}-\frac{h_i}{2}m_i-\frac{h_i}{6}(m_{i+1}-m_i)\\
c_i=m_i/2\\
d_i=\frac{m_{i+1}-m_i}{6h_i}\\
\end{cases}
$$

2
$$
S_i(x)=a_i+b_i(x-x_i)+c_i(x-x_i)^2+d_i(x-x_i)^3
$$

### reference
[https://zhuanlan.zhihu.com/p/62860859](https://zhuanlan.zhihu.com/p/62860859)

### 3

> from Bernstein basis to the canonical monomial basis
$$
\begin{pmatrix}
B_1(t)\\
B_2(t)\\
B_3(t)\\
B_4(t)\\
\end{pmatrix}
= \begin{pmatrix}
1 & -3 & 3 & -1\\
0 & 3 & -6 & 3\\
0 & 0 & 3 & -3\\
0 & 0 & 0 & 1\\
\end{pmatrix}
\begin{pmatrix}
1\\
t\\
t^2\\
t^3\\
\end{pmatrix}
$$



$$
\begin{pmatrix}
1\\
t\\
t^2\\
t^3\\
\end{pmatrix}
= \begin{pmatrix}
1 & 1 & 1 & 1\\
0 & 1/3 & 2/3 & 1\\
0 & 0 & 1/3 & 1\\
0 & 0 & 0 & 1\\
\end{pmatrix}

\begin{pmatrix}
B_1(t)\\
B_2(t)\\
B_3(t)\\
B_4(t)\\
\end{pmatrix}
$$


$$
P(t) = \begin{pmatrix}
P_1 & P_2 & P_3 & P_4 
\end{pmatrix}

\begin{pmatrix}
B_1(t)\\
B_2(t)\\
B_3(t)\\
B_4(t)\\
\end{pmatrix}
$$

