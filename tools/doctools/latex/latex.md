# latex



常见格式符号：上标，下标，分号，根号，

### 上标，下标
$$
x_{ij}^2
$$

### 分号
$$
y = \frac{a}{b+c}
$$

### 根号
$$
\sqrt[2]{x}
$$


### 求和
$$
\sum{x_{ij}^2}
$$


### 1换行(\\)

- \newline
- 另起一段是空一行
- \\

### 分段(\par)

- \par

### 换页(\newpage)

- \newpage


### 单边大括号

$$
\begin{cases} 选项1\\ 选项2 \\ \cdots \\ 选项n \end{cases} 
$$


## demo

###  方差

方差(variance)：是在概率论和统计方差衡量随机变量或一组数据时离散程度的度量
$$
\sigma^2=\frac{\sum{(X-\mu)^2}}{N}
$$
实际中使用样本方差
$$
S^2=\frac{\sum(X-\bar{X})^2}{n-1}
$$


标准差（Standard Deviation）又常称均方差

**极差**又称范围误差或[全距](https://baike.baidu.com/item/%E5%85%A8%E8%B7%9D/10424210)(Range)，以R表示，是用来表示统计资料中的[变异量数](https://baike.baidu.com/item/%E5%8F%98%E5%BC%82%E9%87%8F%E6%95%B0/10840782)(measures of variation)，其[最大值](https://baike.baidu.com/item/%E6%9C%80%E5%A4%A7%E5%80%BC/774514)与最小值之间的[差距](https://baike.baidu.com/item/%E5%B7%AE%E8%B7%9D/1855729)，即最大值减最小值后所得之数据。
$$
var(x)=\frac{\sum{(x_i-\bar{x})^2}}{n}
$$

$$
\overline{x} = \frac{\sum{x_i}}{n}
$$

$$
std(x)=\sqrt{\frac{(x_i-\overline{x})^2}{n}}
$$

推导可得：
$$
var(x)=\frac{\sum{(x_i-\bar{x})^2}}{n}
=\frac{\sum{x_i^2+\bar{x}^2-2x_i\bar{x}}}{n}
\\
\frac{\sum{x_i^2}-2\sum{x_i\bar{x}}+n\bar{x}^2}{n}
\\

\frac{\sum{x_i^2}}{n}-\bar{x}^2
$$

$$
\sum{x_i^2}=n(v+\bar{x}^2)
$$

分块计算方差均值v1和x1,v2和x2，然后合并计算方差均值v12,x12
$$
var(x)=

\frac{\sum{x^2}}{n}-\bar{x}^2\\
var(x_1,x_2)=
\frac{\sum{x_1^2}}{n}+\frac{\sum{x_2^2}}{n}-(\frac{n_1\bar{x_1}+n_2\bar{x_2}}{n_1+n_2})^2
\\
var(x_1,x_2)=\frac{n_1(v_1+\bar{x_1^2})+n_2(v_2+\bar{x_2^2})}{n_1+n_2}-(\frac{n_1\bar{x_1}+n_2\bar{x_2}}{n_1+n_2})^2
$$


