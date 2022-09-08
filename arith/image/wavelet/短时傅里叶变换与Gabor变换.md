# 短时傅里叶变换与Gabor变换

[![子一十](https://picx.zhimg.com/v2-1f0b9d9ce79d75c0a2a0f0b51f03d74a_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/zhe-shi-wo-xiao-hao-79)

[子一十](https://www.zhihu.com/people/zhe-shi-wo-xiao-hao-79)



30 人赞同了该文章

## **傅里叶变换:**

- ***定义**：*

FT(\omega)=\int_{-\infty}^{\infty}s(t)e^{-j\omega t}dt

*其中 s(t) 是一绝对可积时域信号*

- ***点积：***

我们将傅里叶变换后的频域空间的**点积定义**为

\langle f(x),g(x) \rangle = \int_{t1}^{t2}f(x) \cdot g^*(x)dx

- **基：**

傅里叶空间中的base为**orthogonal base**，且base为

\psi_{\omega} = e^{j \omega t }

- **系数：**

如果 \{\psi_i \} 是正交基，那么我们可以通过

c_i=\langle s,\psi_i \rangle

来得到每个正交基所对应的系数

因为为正交基，我们计算傅里叶系数时，可以直接用正交基点乘来得到系数，即

FT(\omega)=\langle s(t),\psi_\omega\rangle =\int_{-\infty}^{\infty}s(t)\cdot \psi^*_\omega dt=\int_{-\infty}^{\infty}s(t)\cdot e^{-j\omega t} dt

- **傅里叶变换的缺陷：**

由公式可知，傅里叶变换是把时域所有信息收集起来，转换到频域对应的基下的分量，每个频域基下对应的系数含有所有时域的信息。傅里叶变换直接把频域于时域割裂开来，因此，傅里叶变换对于时域分析有天然的劣势。

------

## 短时傅里叶变换：

短时傅里叶变换在傅里叶变换之前，先对信号进行窗函数截取。

短时傅里叶变换是在获取频域信息的同时，通过加窗来限制时域信号的展现，以此来获取时域信息。换句话说， 当我们在使用短时傅里叶变换时，是对加窗后的信号进行傅里叶变换，观察到的是特定时域的频域信息，相当于你透过窗户来观察原先的信号，管中窥豹，可见也只能见一”斑“。通过这种方法把时域的信息割裂开来，保留了原先的时域信息。



- **短时傅里叶变换的基方程：**

h(t,\omega)=\gamma(\tau-t)e^{j\omega \tau}

***!!!!!!!!***

**注意注意！！：这里的STFT的基方程和slide上不同，采用的是比较流行的定义，目的是为了整体文章逻辑推导清晰连贯，slide上的公式大家就记下来吧！！**

**!!!!!!!!**

**注意：他的基方程既含有时域信息又含有频域信息,由基方程可以看出，我们截取信号在某一时间短上的部分然后再取这部分上的频域分量。**



- **时频窗（Time-Frequency Window):**

一般的对于窗函数 \gamma(t)

我们定义他的一些在时域上的参数变量：

*中心(Center)*： \langle t\rangle_\gamma \equiv \frac{1}{||\gamma||^2}\int^{\infty}_{-\infty}t|\gamma(t)|^2dt

*半径(Radius):* \Delta_\gamma \equiv \frac{1}{||\gamma||}[\int^{\infty}_{-\infty}(t-\langle t\rangle)^2|\gamma(t)|^2]^{\frac12}

*宽度(Width):* W=2\Delta_\gamma

这里 ||\gamma|| 指代该向量的模



此时，顺理成章的，我们就有了我们的短时傅里叶变换

- **短时傅里叶变换：**

STFT(t,\omega)=\langle s(\tau),\gamma(\tau-t)e^{j\omega t} \rangle=\int^{\infty}_{-\infty}s(\tau)\gamma^*(\tau-t)e^{-j\omega \tau}d\tau

这是我们可以看到在我们进行每一项的STFT时，我们是在计算 t_n 时刻窗函数截取的信号在\omega_n 上的分量。

在短时傅里叶变换中，我们想要做的是把一个时域信号分解，他的基方程既含有时域信号也含有频域信号。

如果我们把 \gamma(\tau-t)e^{j\omega t} 记作 \gamma_{t,\omega}(\tau) ,那么STFT也可写作

STFT(t,\omega)=\int^{\infty}_{-\infty}s(\tau)\gamma_{t,\omega}^*(\tau)d\tau

STFT(t,\omega)对应的是每一个基方程 h(t,\omega) 的系数，每一个基方程在时频平面上的所占的位置为：

[\langle t\rangle+t-\frac{\Delta_t}{2},\langle t\rangle+t+\frac{\Delta_t}{2}]\times [\langle \omega\rangle+\omega-\frac{\Delta_\omega}{2},\langle \omega\rangle+\omega+\frac{\Delta_\omega}{2}]

每一个的面积都是 \Delta_t \times \Delta_\omega

**根据不确定性原理：**

\Delta_t \times \Delta_\omega \ge \frac12

**注意：因为此时** t **和** \omega **是连续的，所以每一个基在时频图上其实是彼此重叠的**



快速傅里叶**逆变换**定义为：
s(t)\gamma^*(\tau)=\frac{1}{2 \pi}\int_{-\infty}^{\infty}STFT_\gamma(\tau-t,\omega)e^{j\omega \tau}d\omega



------

## Gabor 变换



- **Gabor 展开：**

s(t)=\sum_{m=-\infty}^{\infty}\sum_{n=-\infty}^{\infty}c_{m,n}h_{m,n}(t)

其中 h_{m,n}(t)=h(t-mT)e^{jn\Omega t}

Gabor展开是**短时傅里叶变换的离散形式**同时**确定窗函数为Gaussian Window**

**在Gabor展开中，我们的基方程不再是连续的！**在时域上的基每个的间隔为 T ,在频域上的基每个的间隔为 \Omega 。





- **基方程的选取：**

**步长：**

在基方程选取时，我们需要注意到基方程之间的步长 T,\Omega 对于采样有影响

Oversampling : T\Omega <2\pi

Critical Sampling : T\Omega =2\pi

Undersampling: T\Omega>2\pi

理解： 在Gabor展开中，我们采样是同时对时域和频域采样，即是对时频图上进行二维采样，采样得到的是一个个 T\times\Omega sample cell，而时频图本身就是由一个个information cell构成的，information cell的大小是大于等于 2\pi 的（当无噪音是等于 2\pi ）。所以当sample cell的面积大于 2\pi 时，sample cell数量小于了information cell数量，那么就没有采样到足够的信息，属于Undersampling。当sample cell数量小于 2\pi 时，sample cell数量大于了information cell数量，我们采样到的样点比原来还多，属于Oversampling。

**一般来说我们要求 T\Omega \le 2\pi**



![img](data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='702' height='498'></svg>)Information cell

**基方程：**

**Gaussian function是最好的window。**

h(t)=g(t)=\sqrt[4]{\frac{\alpha}{\pi}}e^{-\frac{\alpha t^2}{2}}

原因：

1. 他的傅里叶变换就是他本身，这样的话在频域上能量也比较集中
2. Gaussian function 满足了不确定性原理的最下限 \Delta_t \Delta_\omega = \frac12 ，保证了时域和频域同时最集中，是使时频图分辨率最高的窗函数。



- 
  **补充知识：双正交：**

之前我们知道如果我们已经有正交基，那么我们可以直接通过点乘正交基来得到对应的系数（coefficient），以此来分解（decompose）任意向量，在分解之后我们可以通过系数乘以对应正交基来恢复向量。

但是当我们想要分解为的函数集 \{\gamma\} 不是正交基时,之前直接点乘基来得到系数的方法就无法使用了。

这时我们可以通过找到 \{\gamma\} 对应的对偶方程(dual function) \{h\} 来分解原向量。

方法:

若 \gamma^* = h 即

\begin{bmatrix} \gamma_1 \\ \gamma_2 \\ \vdots\\ \gamma_n \end{bmatrix} \cdot \begin{bmatrix} h_1h_2\cdots h_n \end{bmatrix}= \delta_{ij}

那么

\langle s,h_n\rangle=\langle c_n\gamma_n,h_n \rangle=c_n\langle\gamma_n,h_n \rangle=c_n

所以即使我们想分解的基不是正交基，只要有对应的对偶方程，那么我们也可以把一个向量分解为我们想要分解为的基 \{\gamma\} 的组合。



- **补充知识：Frame**

**Frame**是一个线性代数中的名词，当我们在讨论一个线性空间时,一般general的考虑是Hilbert空间，当**Hilbert空间中的一个函数集线性有关**时，我们把这个**函数集**叫做这个Hilbert空间中的**Frame。**

**在信号处理中，我们经常会使用Frame来解构信号，是因为线性有关的函数集会给我们带来信息的冗余，而信息的冗余我们可以利用他来降低噪音，提高鲁棒性等。**



- **Gabor 系数**

c_{m,n}=\int_{-\infty}^{\infty}s(t)\gamma_{m,n}^*(t)dt=STFT[mT,n\Omega]=\langle s, \gamma_{m,n}\rangle

注意：我们这里的基是 h_{m,n} ， \gamma_{m,n} 是 h_{m,n} 的对偶方程。

- **Gabor Frame**

A||s||^2 \le \sum^{\infty}_{m=-\infty}\sum^{\infty}_{n=-\infty}|\langle f,g_{m,n}\rangle |^2 \le B||s||^2 (0<A \le B < \infty)

而 c_{m,n}=\langle f,g_{m,n}\rangle 是其对应的系数。

**BTW：我们想方设法的想要解构一个向量再重构回去，正交基是一个信息熵最小的方法（用最少的系数来表示向量。而在信号处理或者一些应用场景中，增大信息熵却能为我们的解构重构提供鲁棒性（Robustness），因此Frame就派上用场了。**

为什么要把他限制成在两个有限量之间呢？

思考一下：

1. 如果 \sum^{\infty}_{m=-\infty}\sum^{\infty}_{n=-\infty}|\langle f,g_{m,n}\rangle |^2 =0而 ||s||^2\ne0 ,那么说明向量投影到框架上根本就没有分量！在框架中没有一个基可以撑起原向量，所以框架是在原向量的零空间中的，如果进行这样的变换是不可逆的！
2. 如果 \sum^{\infty}_{m=-\infty}\sum^{\infty}_{n=-\infty}|\langle f,g_{m,n}\rangle |^2 =\infty 而 ||s||^2\ne\infty ，那么说明向量投影到框架上的系数有无穷，那么这样的变换同样是不可逆的！

![img](data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='311' height='292'></svg>)V为零空间，W为向量

所以我们知道了原因，这是为了要这个变换可逆，保证了我们把一个向量解构了还有把他还原的可能性。





同样的那我们要用Frame来分解一个向量时我们该怎么做呢？

我们可以使用对偶框架(Dual Frame)

\{\gamma\} 和 \{ h\} 是对偶框架如果他们满足：

\begin{bmatrix} \gamma_1 \\ \gamma_2 \\ \vdots\\ \gamma_n \end{bmatrix} \cdot \begin{bmatrix} h_1h_2\cdots h_n \end{bmatrix}= \delta_{ij}





- **Gabor Frame的性质**

**Gabor 算子：**

S=\sum_{m=-\infty}^{\infty}\sum_{n=-\infty}^{\infty}\langle f, g_{m,n}\rangle g_{m,n}

通俗解释：把某一函数映射到框架上的过程，即把一个向量用框架 \{ g\} 来表示(表示的不一定等于原向量，可能没有复原）

**性质**(这里用英文名词是因为确实不知道怎么翻译比较合适)：

Commutes with Translation： S(t-mT)=S(t)-mT

Commutes with Modulation: S(te^{jn\Omega t})=S(t)e^{jn\Omega t}

所以Gabor算子和Translation，Modulation是可以互相交换顺序的。

**对偶框架：**

如果 \{\gamma\} 是 \{g\}的对偶框架，那么

\gamma = S^{-1}g

所以我们有 f=SS^{-1}f=\langle f,g\rangle\gamma

综上我们可以得到经过Translation 和Modulation后的 \{g_{m,n}\} 的对偶框架：

\gamma_{m,n}=S^{-1}g_{m,n}=S^{-1}g(t-mT)e^{jn\Omega t}=\gamma(t-mT)e^{jn\Omega t}

注意：框架中的向量普遍来讲是线性相关的，所以 c_{m,n} 可能有很多种映射方式，用对偶框架来映射是一种方便的做法。

编辑于 2021-10-30 15:01

数字信号处理

傅里叶变换（Fourier Transform）