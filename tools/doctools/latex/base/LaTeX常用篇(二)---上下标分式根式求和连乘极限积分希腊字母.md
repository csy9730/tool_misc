# [LaTeX常用篇(二)---上下标/分式/根式/求和/连乘/极限/积分/希腊字母](https://www.cnblogs.com/liangjianli/p/11616847.html)



**更新时间：2019.10.27**
**增加补充项中的内容**



目录

- [1. 序言](https://www.cnblogs.com/liangjianli/p/11616847.html#1-序言)
- [2. 上下标](https://www.cnblogs.com/liangjianli/p/11616847.html#2-上下标)
- [3. 分式](https://www.cnblogs.com/liangjianli/p/11616847.html#3-分式)
- [4. 根式](https://www.cnblogs.com/liangjianli/p/11616847.html#4-根式)
- [5. 求和和连乘](https://www.cnblogs.com/liangjianli/p/11616847.html#5-求和和连乘)
- [6. 极限](https://www.cnblogs.com/liangjianli/p/11616847.html#6-极限)
- [7. 积分](https://www.cnblogs.com/liangjianli/p/11616847.html#7-积分)
- [8. 常用的希腊字母](https://www.cnblogs.com/liangjianli/p/11616847.html#8-常用的希腊字母)
- \9. 补充项
  - [9.1 波浪线的表示](https://www.cnblogs.com/liangjianli/p/11616847.html#91-波浪线的表示)
  - [9.2 求导](https://www.cnblogs.com/liangjianli/p/11616847.html#92-求导)
  - [9.3 垂直和平行符号](https://www.cnblogs.com/liangjianli/p/11616847.html#93-垂直和平行符号)
  - [9.4 把符号放在正下方](https://www.cnblogs.com/liangjianli/p/11616847.html#94-把符号放在正下方)
  - [9.5 集合](https://www.cnblogs.com/liangjianli/p/11616847.html#95-集合)
  - [9.6 成正比](https://www.cnblogs.com/liangjianli/p/11616847.html#96-成正比)
  - [9.7 梯度](https://www.cnblogs.com/liangjianli/p/11616847.html#97-梯度)



### 1. 序言

  之前总结了一下latex的[公式输入](https://www.cnblogs.com/liangjianli/p/11616067.html)。但是俗话说得好，巧妇难为无米之炊![流汗](https://img2018.cnblogs.com/blog/1684731/201910/1684731-20191002083614896-1439798913.png)。如果想要输入复杂的数学公式，光知道公式输入的方式是远远不够的，我们还需要了解公式中常用的组成部分。

### 2. 上下标

  数学公式中的字母经常是带上标（幂/转置/导数等）和下标（矩阵元素位置/参数个数等）的，而用latex解决这个问题十分简单。可以使用`^`表示上标，使用`_`表示下标。当然要值得注意的是，当上下标的有多个（2个及以上）字符时，要用`{}`括起来。


$$
Y = \beta_0 + \beta_1X_1 + \beta_2X_2^2
$$

$$
a_{11} + a_{12}^2 + a_{13}^3 = 0
$$


**显示效果：**



- **tip1：**有时我们想使用的标记在字母的正上方，例如X¯X¯。这种无法直接用上下标来表示，需要使用其他的方法。

- tip2：

  在这里列举一些常用的用法：

  - X¯X¯(X拔)的表示方法是：`$\bar X$`，这个通常是用来表示变量的均值
  - Y^Y^(Y帽)的表示方法是：`$\hat Y$`，这个通常是用来表示变量的预测值
  - X––X_的表示方式是：`$\underline X$`，可以用来表示下限
  - 还有其他像X˜X~的表示方式是：`$\widetilde X$`

- **tip3：**例子中使用了一些希腊字母，可以直接跳转到下面进行查看[常用的希腊字母](https://www.cnblogs.com/liangjianli/p/11616847.html#常用的希腊字母)

### 3. 分式

  直接使用`\frac{}{}`来表示分式，其中第一个`{}`表示分子，第二个`{}`表示分母

```
$$f(x, y) = \frac{x + y}{x - y}$$
```

**显示效果：**





f(x,y)=x+yx−yf(x,y)=x+yx−y



### 4. 根式

  直接使用`sqrt[]{}`来表示分式，其中`[]`用来放开方的次数，`{}`用来放要被开方的公式

```
$$f(x, y) = \sqrt[n]{\frac{x^2 + y^2}{x^2 - y^2}}$$
```

**显示效果：**





f(x,y)=x2+y2x2−y2−−−−−−−√nf(x,y)=x2+y2x2−y2n



### 5. 求和和连乘

  对于连加的情况，我们通常使用∑∑来表示。它的使用用法也很简单，但是通常都要添加上下标，像`$\sum_{}^{}$`形式。除了连加，我们有时也使用连乘，虽然没有连加使用得多（连乘都能通过对数写成连加），它只要以`$\prod_{}^{}$`的形式表示。

```
<!--连加-->
$$\sum_{i = 1}^{n}x_i$$

<!--连乘-->
$$\prod_{i = 1}^{n}x_i$$
```

**显示效果：**





∑i=1nxi∑i=1nxi







∏i=1nxi∏i=1nxi



- **tip1：**在latex中，默认情况下行内公式都是显示像∑ni=1aij∑i=1naij的效果，如果想要这样的效果∑i=1naij∑i=1naij，就需要在前面加上`\displaystyle`，来重新看一下下面的例子：

```
<!--连加-->
$\sum_{i = 1}^{n}x_i$
$\displaystyle\sum_{i = 1}^{n}x_i$

<!--连乘-->
$\prod_{i = 1}^{n}x_i$
$\displaystyle\prod_{i = 1}^{n}x_i$
```

**显示效果：**

∑ni=1xi∑i=1nxi
∑i=1nxi∑i=1nxi

∏ni=1xi∏i=1nxi
∏i=1nxi∏i=1nxi

### 6. 极限

  还记得高数里极限的符号吗![皱眉](https://img2018.cnblogs.com/blog/1684731/201910/1684731-20191002102657884-1615601426.png)。在latex中的极限表示，也直接使用`\lim`这个我们时常看到的符号。当然极限通常都是带下标的，所以更多的是使用`lim_{}`的形式。

```
<!--来看看两个重要极限-->
$$\displaystyle\lim_{x \rightarrow 0}\frac{\sin x}{x} = 1$$

$$\displaystyle\lim_{x \rightarrow + \infty}(1 + \frac{1}{x})^x = e$$
```

**显示效果：**


$$\displaystyle\lim_{x \rightarrow 0}\frac{\sin x}{x} = 1$$

$$\displaystyle\lim_{x \rightarrow + \infty}(1 + \frac{1}{x})^x = e$$


- **tip1：**右箭头→→的表示方式为`$\rightarrow$`，左箭头←←的表示方式是`$\leftarrow$`
- **tip2：**正无穷+∞+∞的表示方式为`$+ \infty$`，负无穷−∞−∞的表示方式是`$- \infty$`

### 7. 积分

  如果想要输入积分，则需要使用`\int_{}^{}`来表示

```
$$\int_0^1 x^2 dx$$
<!--来看一个更加复杂的例子-->
<!--正态分布的分布函数-->
$$F(x) = \int_{- \infty}^{+ \infty} \frac{1}{\sqrt{2\pi}\sigma}e^{-(\frac{x-\mu}{\sigma})^2} dx$$
```

**显示效果：**



$$\int_0^1 x^2 dx$$

$$F(x) = \int_{- \infty}^{+ \infty} \frac{1}{\sqrt{2\pi}\sigma}e^{-(\frac{x-\mu}{\sigma})^2} dx$$




### 8. 常用的希腊字母

  有时我们的公式里会包含一些希腊字母，而在latex中，其实只要会读希腊字母基本就会写出来。下面总结一些常用的希腊字母：

| 希腊字母 | 对应的代码 | 希腊字母 |   对应的代码    |
| :------: | :--------: | :------: | :-------------: |
|    αα    | `$\alpha$` |    μμ    |     `$\mu$`     |
|    ββ    | `$\beta$`  |    σσ    |   `$\sigma$`    |
|    γγ    | `$\gamma$` |    εε    | `$\varepsilon$` |
|    θθ    | `$theta$`  |    χχ    |    `$\chi$`     |
|    ζζ    | `$\zeta$`  |    ττ    |    `$\tau$`     |
|    ηη    |  `$\eta$`  |    ρρ    |    `$\rho$`     |
|    ξξ    |  `$\xi$`   |    ψψ    |    `$\psi$`     |
|    ππ    |  `$\pi$`   |    ϕϕ    |    `$\phi$`     |

### 9. 补充项

#### 9.1 波浪线的表示

可以使用`$\sim$`来表示波浪线

```
$\varepsilon \sim N(0, \sigma^2I_n)$
```

显示效果：
ε∼N(0,σ2In)ε∼N(0,σ2In)
$$\varepsilon \sim N(0, \sigma^2I_n)$$

#### 9.2 求导

使用`$\mathrm{d}$`来表示求导符号，`$\partial$`来表示求偏导

```
$\frac {\mathrm{d}L(\beta)}{\beta}$

<!--直接用d来表示求导符的效果-->
$\frac {dL(\beta)}{\beta}$

<!--偏导-->
$\frac {\partial L(\beta_0, \beta_1)}{\partial \beta_0}$
```

显示效果：
$$\frac {\mathrm{d}L(\beta)}{\beta}$$


$$\frac {dL(\beta)}{\beta}$$


$$\frac {\partial L(\beta_0, \beta_1)}{\partial \beta_0}$$

#### 9.3 垂直和平行符号

- 垂直：使用`\$perp$`，效果为⊥⊥
- 平行：可以直接用`//`或`$//$`，也可以使用`$\parallel$`，不过这个是显示竖直的形式`||`

```
$//$
$\parallel$
```

显示效果：
////
∥∥

#### 9.4 把符号放在正下方

有时我们需要把文本放在正下方，这是我们就可以使用`$\underset$`，有时也可以使用`$\limits$`

```
$$\hat \beta = \underset{\beta}{\arg \min} L(\beta)$$
$$\hat \beta = \arg \min \limits_{\beta} L(\beta)$$
```

显示效果：



$$\hat \beta = \underset{\beta}{\arg \min} L(\beta)$$

$$\hat \beta = \arg \min \limits_{\beta} L(\beta)$$

β^=argminβL(β)β^=arg⁡minβL(β)







β^=argminβL(β)β^=arg⁡minβL(β)



#### 9.5 集合

```
<!--真包含-->
$$\subset$$

<!--包含-->
$$\subseteq$$

<!--属于和不属于-->
$$\in$$
$$\notin$$

<!--交集和并集-->
$$\cap$$
$$\cup$$

<!--其他-->
$$\mid$$
$$\supset$$
```

显示效果：





⊂⊂







⊆⊆







∈∈







∉∉







∩∩







∪∪







∣∣







⊃⊃



#### 9.6 成正比

使用`$\propto$`来表示

```
$f(\beta|X) \propto f(\beta) f(X|\beta)$
```

显示效果：
f(β|X)∝f(β)f(X|β)f(β|X)∝f(β)f(X|β)

#### 9.7 梯度

使用`$nabla$`来表示

```
$\nabla f(x) = [\frac{\partial f(x)}{\partial x_1}, \frac{\partial f(x)}{\partial x_2}, ..., \frac{\partial f(x)}{\partial x_d}]^T$
```

显示效果：
∇f(x)=[∂f(x)∂x1,∂f(x)∂x2,...,∂f(x)∂xd]T∇f(x)=[∂f(x)∂x1,∂f(x)∂x2,...,∂f(x)∂xd]T

$\nabla f(x) = [\frac{\partial f(x)}{\partial x_1}, \frac{\partial f(x)}{\partial x_2}, ..., \frac{\partial f(x)}{\partial x_d}]^T$

标签: [Markdown](https://www.cnblogs.com/liangjianli/tag/Markdown/), [latex](https://www.cnblogs.com/liangjianli/tag/latex/)

