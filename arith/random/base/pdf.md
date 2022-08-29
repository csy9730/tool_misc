# pdf


## 名词介绍

### pdf
pdf(probability density function)
在数学中，连续型随机变量的概率密度函数（在不至于混淆时可以简称为密度函数）是一个描述这个随机变量的输出值，在某个确定的取值点附近的可能性的函数。而随机变量的取值落在某个区域之内的概率则为概率密度函数在这个区域上的积分。当概率密度函数存在的时候，累积分布函数是概率密度函数的积分。概率密度函数一般以小写标记。

随机数据的概率密度函数：表示瞬时幅值落在某指定范围内的概率，因此是幅值的函数。它随所取范围的幅值而变化。
密度函数f(x) 具有下列性质：
$$
f(x)>=0\\
\int_{-\infin}^{+\infin}{f(x)dx}=1\\
P(a<x<=b) = \int_a^b{f(x)dx}
$$

### PMF
PMF : 是英文单词 probability mass function 的缩写， 翻译过来是指概率质量函数
### cdf
CDF (cumulative distribution function)

PDF：是英文单词 probability density function 的缩写，翻译过来是指概率密度函数，是用来描述连续型随机变量的输出值，在某个确定的取值点附近的可能性的大小的函数。

PMF : 是英文单词 probability mass function 的缩写， 翻译过来是指概率质量函数，是用来描述离散型随机变量在各特定取值上的概率。

CDF : 是英文单词 cumulative distribution function 的缩写，翻译过来是指累积分布函数，又叫分布函数，是概率密度函数的积分，用来表示离散型随机变量x的概率分布。

PDF函数得到的是概率吗？并不是，因为它的值域已经不是，而概率的定义是要求的。我们是将概率密度函数和概率质量函数(Probability Mass Function, PMF)弄混了，PMF是用于离散随机变量，而PDF用于连续随机变量。而概率质量函数PMF是等于概率的，但是概率密度函数PDF  概率。

连续随机变量某一点的概率为0
### 期望
$$
E[X]=\int_{-\infin}^{+\infin}{xf_X(x)dx}
$$
### 方差
$$
D[X]=E[X-E(x)]^2=\int_{-\infin}^{+\infin}{(x-E(x))^2f_X(x)dx}
$$
### 期望
$$
E[X^n]=\int_{-\infin}^{+\infin}{x^nf_X(x)dx}
$$
## 均匀分布
最简单的概率密度函数是均匀分布的密度函数
$$
f(x) = \frac{1}{b-a}
$$
### 正态分布
$$
f(x)=\frac{1}{\sigma\sqrt{2\pi}}e^{-\frac{(x-\mu)^2}{2\sigma^2}}
$$

### 两点分布
### 指数分布
### 拉普拉斯分布
### 泊松分布

### 狄利克雷分布

### Beta分布

### 特征函数
对概率密度函数作傅里叶变换可得特征函数。

特征函数与概率密度函数有一对一的关系。因此知道一个分布的特征函数就等同于知道一个分布的概率密度函数

$$
F(jw) = \int_{-\infin}^{+\infin}{f(x)e^{jwx}dx}
$$

## misc

#### 基于均匀分布生成任意分布 
如何通过一个均匀分布生成指定的pmf, pdf？

首先根据pdf计算cdf。
cdf的值域是0～1，和均匀分布一样 ，可以互相映射。

#### 实现一次方分布 
$$
f(t) = 2t\\
F(x)=cdf(x) = \int_0^x{2tdt}=x^2\\
F(x)=u\\
x= F^{-1}(u)
x = \sqrt{u}\\
$$

``` matlab
tt = 0:0.001:1
% pdf(xx) == 2*tt
xx = sqrt(tt)
hist(x)
```


f(x)=2*x
F(x)=x^2
F^-1=sqrt(x)

#### 实现二次方分布 
$$
f(t) = 3t^2\\
cdf(x) = \int_0^x{3t^2dt}=x^3\\
x = \sqrt[3]{u}\\
$$

``` matlab
tt = 0:0.001:1
xx = sqrt(tt)
hist(x)
```
#### 实现正弦分布 
``` matlab
tt = 0:0.001:1
% pdf(xx) == 2*tt
xx = acos(1-tt)/pi*2;
hist(x)
```


### 给定函数，计算概率分布 
