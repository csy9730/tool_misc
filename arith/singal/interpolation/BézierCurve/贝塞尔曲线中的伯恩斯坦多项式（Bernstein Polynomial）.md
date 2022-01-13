# 贝塞尔曲线中的伯恩斯坦多项式（Bernstein Polynomial）

[![王江荣](https://pic3.zhimg.com/v2-661edb21c44862d9d8c47b7b0f7cfabe_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/luckywjr)

[王江荣](https://www.zhihu.com/people/luckywjr)

学习是一个发现自己有多无知的过程



9 人赞同了该文章

在学习贝塞尔曲线的时候，大家一定都听过一个词叫伯恩斯坦多项式，我们先从一个简单的例子来看看它到底是什么。

[王江荣：贝塞尔曲线（Bezier Curve）83 赞同 · 8 评论文章![img](https://pic2.zhimg.com/v2-65d86056a72aed3ca94388ff0461dff5_180x120.jpg)](https://zhuanlan.zhihu.com/p/366678047)

本文主要参考清华大学胡事民教授的课件，也算当了回清华学生了，哈哈~

[清华大学-计算机图形学基础（国家级精品课）_哔哩哔哩 (゜-゜)つロ 干杯~-bilibiliwww.bilibili.com/video/BV13441127CH?t=2447&p=11![img](https://pic1.zhimg.com/v2-e8954f364f39ecf4bfc8c6d53bf22be4_180x120.jpg)](https://link.zhihu.com/?target=https%3A//www.bilibili.com/video/BV13441127CH%3Ft%3D2447%26p%3D11)



## 开礼包的概率

现在在各种游戏里，肯定都会充斥着开礼包的骗钱玩法。拿我玩的某刀举例，我们有0.1的概率开到高级物品，假设我们有3个这样的礼包，那么我们可以得到如下一些结果：

首先是拿命玩游戏的人，开到3个高级物品，这个概率想求很简单，自然是 ![[公式]](https://www.zhihu.com/equation?tex=0.1%5E3) 。

其次是还能活几天的人，开到2个高级物品，那么这个概率是多少呢？我们知道开到的概率是0.1，那么开不到的概率自然是 1-0.1=0.9。那么开到两个的概率是 ![[公式]](https://www.zhihu.com/equation?tex=0.1%5E2) ，一个没开到的概率是0.9，总的概率是 ![[公式]](https://www.zhihu.com/equation?tex=0.1%5E2%2A0.9) 嘛？错！在这里还存在着排列组合的关系，例如我前两个开到后一个没开到，它的概率是 ![[公式]](https://www.zhihu.com/equation?tex=0.1%5E2%2A0.9) ，而我第一个没开到后两个开到，它的概率是 ![[公式]](https://www.zhihu.com/equation?tex=0.9%2A0.1%5E2) ，当然还有中间没开到前后开到的情况，这些三种情况都属于开到2个高级物品，因此总概率应该为 ![[公式]](https://www.zhihu.com/equation?tex=3%2A0.1%5E2%2A0.9) 。

然后是欧皇，开到1个高级物品，一样存在排列组合的情况，概率应该为 ![[公式]](https://www.zhihu.com/equation?tex=3%2A0.1%2A0.9%5E2) 。

最后是正常人，一个都开不到，这个概率自然是 ![[公式]](https://www.zhihu.com/equation?tex=0.9%5E3) 。

题外话：非酋，我，连续二十几次没开到，概率为0！！！严重怀疑程序有bug。

而**这些概率相加得到的结果自然是1**。不存在200%这种概率啊。



## 伯恩斯坦多项式

通过上面的例子，我们可以假设有个礼包开到东西的概率为 t ，我们一共开 n 次，那么开到 i 次东西的概率应该怎么计算呢？

i=n 很好算，自然是 ![[公式]](https://www.zhihu.com/equation?tex=t%5En+) ，同样 i=0 也很好算，自然是 ![[公式]](https://www.zhihu.com/equation?tex=%281-t%29%5En) ，相对麻烦的是中间，因为我们前面说了，需要考虑到排列组合的情况，当然不管怎么排列组合，每个组合的概率应该都是 ![[公式]](https://www.zhihu.com/equation?tex=t%5Ei%281-t%29%5E%7Bn-i%7D) 。

接下来的问题就是算开到 i 次时，存在多少排列组合的情况了（假设值为k）。怎么算呢，其实[百度百科](https://link.zhihu.com/?target=https%3A//baike.baidu.com/item/%E6%8E%92%E5%88%97%E7%BB%84%E5%90%88/706498%3Ffr%3Daladdin)上有公式，如下：

> ![[公式]](https://www.zhihu.com/equation?tex=k%3D%5Cfrac%7Bn%21%7D%7Bi%21%28n-i%29%21%7D)

注：规定 ![[公式]](https://www.zhihu.com/equation?tex=0%21%3D1) ，因此即使 i=0，除数不会为0。

简单的理解下，我们可以把问题想成，我们有 i 个开到的礼包，要插入到这 n 个位置里，那么当我插入第一个礼包的时候，有 n 个空位给我放，插入第二个的时候，有 n-1 个空位，直到差到第 i 个，有 n-i+1 个空位，那么得到的结果就是：

![[公式]](https://www.zhihu.com/equation?tex=n%28n-1%29%28n-2%29...%28n-i%2B1%29%3D%5Cfrac%7Bn%21%7D%7B%28n-i%29%21%7D)

但是这里面还存在重复的情况，例如我第1个礼包放1号位，第2个礼包放2号位，和第1个礼包放2号位，第2个礼包放1号位是一样的，因此我们要去重。i 个礼包一共会有 i! 次情况，因此最终会得到上面的排列组合结果。

当然了，i=0或者i=n同样适用于这个公式，因此开到 i 次东西的概率应该为：

> ![[公式]](https://www.zhihu.com/equation?tex=%5Cfrac%7Bn%21%7D%7Bi%21%28n-i%29%21%7Dt%5Ei%281-t%29%5E%7Bn-i%7D)

这个其实就是我们要说的伯恩斯坦多项式！



我们常用 ![[公式]](https://www.zhihu.com/equation?tex=B_%7Bi%2Cn%7D%28t%29) 或者 ![[公式]](https://www.zhihu.com/equation?tex=B_i%5En%28t%29) 来代表伯恩斯坦多样式，其中 ![[公式]](https://www.zhihu.com/equation?tex=%5Cfrac%7Bn%21%7D%7Bi%21%28n-i%29%21%7D) 部分我们常用 ![[公式]](https://www.zhihu.com/equation?tex=C%5Ei_n) 或者 ![[公式]](https://www.zhihu.com/equation?tex=%5Cbinom%7Bn%7D%7Bi%7D) 来代替。

**因此伯恩斯坦多项式可以表示为：**

> ![[公式]](https://www.zhihu.com/equation?tex=B_i%5En%28t%29%3DC%5Ei_nt%5Ei%281-t%29%5E%7Bn-i%7D)

或者

> ![[公式]](https://www.zhihu.com/equation?tex=B_i%5En%28t%29%3D%5Cbinom%7Bn%7D%7Bi%7Dt%5Ei%281-t%29%5E%7Bn-i%7D)

**其中 n 为非0正整数，i 的取值范围为 0-n，t的取值范围为 0-1 。**

如图是n=10，i=3的伯恩斯坦多项式曲线图：

![img](https://pic2.zhimg.com/80/v2-2105fa6185a469c225b31e4996a31ae1_1440w.jpg)

从曲线可以看出，在 t=0.3 处会有一个极大值，并向两边衰减，并且所有的伯恩斯坦曲线都有类似的性质。这个情况用常识也很好理解，如果我们想要从10次开出3次，那么从统计学来说只有概率等0.3（i/n）时，开出3次的概率最高。后面会用导数来证明。

**贝塞尔曲线，就是使用伯恩斯坦多样式来定义。因此它的一些性质同样会影响到贝塞尔曲线的性质**，我们接下来看看伯恩斯坦多项式有哪些性质。



## 非负性（Non-negative）

当我们 t=0 时， ![[公式]](https://www.zhihu.com/equation?tex=t%5Ei%3D0) ，当 t=1 时， ![[公式]](https://www.zhihu.com/equation?tex=%281-t%29%5E%7Bn-i%7D%3D0) ，因此 ![[公式]](https://www.zhihu.com/equation?tex=B_i%5En%28t%29%3D0) 。而当 0<t<1 时， ![[公式]](https://www.zhihu.com/equation?tex=B_i%5En%28t%29%3E0) 。

因此具有非负性：

> ![[公式]](https://www.zhihu.com/equation?tex=B_i%5En%28t%29%5Cleft%5C%7B%5Cbegin%7Bmatrix%7D%3D0%26%26t%3D0%2C1+%5C%5C++%3E0%26%26t%5Cin%280%2C1%29+%5Cend%7Bmatrix%7D%5Cright.)



## 端点（End point）

当我们概率为0，即 t=0，那么开到 0 次（即 i=0）的概率肯定也为 1 ，而开到其他次数的概率肯定为 0，可得：

> ![[公式]](https://www.zhihu.com/equation?tex=B_i%5En%280%29%5Cleft%5C%7B%5Cbegin%7Bmatrix%7D%3D1%26%26i%3D0+%5C%5C++%3D0%26%26otherswise+%5Cend%7Bmatrix%7D%5Cright.)

当我们概率为1，即 t=1，那么开到 n 次（即 i=n）的概率肯定也为 1 ，而开到其他次数的概率肯定为 0，可得：

> ![[公式]](https://www.zhihu.com/equation?tex=B_i%5En%281%29%5Cleft%5C%7B%5Cbegin%7Bmatrix%7D%3D1%26%26i%3Dn+%5C%5C++%3D0%26%26otherswise+%5Cend%7Bmatrix%7D%5Cright.)

也就是说当 t=0 时，只有 i=0 这一项有意义（等于1），其他项都为 0。而当 t=1 时，也只有 i=n 这一项有意义（等于1），其他项也都为0 。



## 归一性（Unity）

伯恩斯坦多项式的**求和等于1**，在前面开礼包的例子里，我们已经提到了，所有概率加起来等于1。我们现在在代数的形式上证明一下：

首先 ![[公式]](https://www.zhihu.com/equation?tex=%5Csum_%7Bi%3D0%7D%5E%7Bn%7D%7BB_i%5En%28t%29%7D%3D%5Csum_%7Bi%3D0%7D%5E%7Bn%7D%7BC%5Ei_nt%5Ei%281-t%29%5E%7Bn-i%7D%7D) ，而 ![[公式]](https://www.zhihu.com/equation?tex=%5Csum_%7Bi%3D0%7D%5E%7Bn%7D%7BC%5Ei_nt%5Ei%281-t%29%5E%7Bn-i%7D%7D) 正好是一个**二项展开式**。

什么是[二项展开式](https://link.zhihu.com/?target=https%3A//baike.baidu.com/item/%E4%BA%8C%E9%A1%B9%E5%B1%95%E5%BC%80%E5%BC%8F/7078006%3Ffr%3Daladdin)？我们知道 ![[公式]](https://www.zhihu.com/equation?tex=%28a%2Bb%29%5E2%3Da%5E2%2B2ab%2Bb%5E2) ， ![[公式]](https://www.zhihu.com/equation?tex=%28a%2Bb%29%5E3%3Da%5E3%2B3a%5E2b%2B3ab%5E2%2Bb%5E3)（这个正好就是我们文章开头例子的算法）等等，这些就是我们的二项展开式。

那么 ![[公式]](https://www.zhihu.com/equation?tex=%28a%2Bb%29%5En) 是多少呢？正是上面的 ![[公式]](https://www.zhihu.com/equation?tex=%5Csum_%7Bi%3D0%7D%5E%7Bn%7D%7BC%5Ei_nt%5Ei%281-t%29%5E%7Bn-i%7D%7D) ，其中 a=t，b=1-t，因此：

> ![[公式]](https://www.zhihu.com/equation?tex=%5Csum_%7Bi%3D0%7D%5E%7Bn%7D%7BB_i%5En%28t%29%7D%3D%5Csum_%7Bi%3D0%7D%5E%7Bn%7D%7BC%5Ei_nt%5Ei%281-t%29%5E%7Bn-i%7D%7D%3D%28t%2B%281-t%29%29%5En%3D1)



## 对称性（Symmetry）

> ![[公式]](https://www.zhihu.com/equation?tex=B_i%5En%281-t%29%3DB_%7Bn-i%7D%5En%28t%29)

我们也可从下图曲线看出其对称性：

![img](https://pic2.zhimg.com/80/v2-ea6ce542838326cc625bba56b67753a1_1440w.jpg)

![[公式]](https://www.zhihu.com/equation?tex=B_0%5E3%28t%29) 和 ![[公式]](https://www.zhihu.com/equation?tex=B_3%5E3%28t%29) 对称， ![[公式]](https://www.zhihu.com/equation?tex=B_1%5E3%28t%29) 和 ![[公式]](https://www.zhihu.com/equation?tex=B_2%5E3%28t%29) 对称，即**第 i 个和倒数第 i 个是对称的**。

证明：

![[公式]](https://www.zhihu.com/equation?tex=B_i%5En%281-t%29%3DC%5Ei_n%281-t%29%5Ei%281-%281-t%29%29%5E%7Bn-i%7D%3DC%5Ei_n%28t%29%5E%7Bn-i%7D%281-t%29%5Ei)

![[公式]](https://www.zhihu.com/equation?tex=B_%7Bn-i%7D%5En%28t%29%3DC%5E%7Bn-i%7D_nt%5E%7Bn-i%7D%281-t%29%5E%7Bn-%28n-i%29%7D%3DC%5E%7Bn-i%7D_n%28t%29%5E%7Bn-i%7D%281-t%29%5Ei)

两者相等。



## 递归性（Recursive）

递归性是什么意思呢，就是说一个n阶的伯恩斯坦多项式 ![[公式]](https://www.zhihu.com/equation?tex=B_i%5En%28t%29) ，它可以写成两个n-1阶的伯恩斯坦多项式的组合，即：

> ![[公式]](https://www.zhihu.com/equation?tex=B_i%5En%28t%29%3D%281-t%29B_i%5E%7Bn-1%7D%28t%29%2BtB_%7Bi-1%7D%5E%7Bn-1%7D%28t%29)

很多贝塞尔曲线的定理和证明里都是做这个组合公式的应用。

证明：

首先： ![[公式]](https://www.zhihu.com/equation?tex=C%5Ei_n%3DC%5Ei_%7Bn-1%7D%2BC%5E%7Bi-1%7D_%7Bn-1%7D)

上面式子也是排列组合的基本性质，常用于杨辉三角。

![[公式]](https://www.zhihu.com/equation?tex=C%5Ei_%7Bn-1%7D%2BC%5E%7Bi-1%7D_%7Bn-1%7D%3D%5Cfrac%7B%28n-1%29%21%7D%7Bi%21%28n-1-i%29%21%7D%2B%5Cfrac%7B%28n-1%29%21%7D%7B%28i-1%29%21%28n-1-i%2B1%29%21%7D)

![[公式]](https://www.zhihu.com/equation?tex=%3D%5Cfrac%7B%28n-i%29%28n-1%29%21%7D%7Bi%21%28n-i%29%21%7D%2B%5Cfrac%7Bi%28n-1%29%21%7D%7Bi%21%28n-i%29%21%7D%3D%5Cfrac%7B%28n-i%2Bi%29%28n-1%29%21%7D%7Bi%21%28n-i%29%21%7D%3DC%5Ei_n)

有个很聪明的理解方法： ![[公式]](https://www.zhihu.com/equation?tex=C%5Ei_n) 即 n 里面取 i 个，那么我们可以拆分成：

- 从n-1个里面取 i 个并且从1个里面取0个，那么对应的就是 ![[公式]](https://www.zhihu.com/equation?tex=C%5Ei_%7Bn-1%7D)
- 从n-1个里面取 i-1 个并且从1个里面取1个，那么对应的就是 ![[公式]](https://www.zhihu.com/equation?tex=C%5E%7Bi-1%7D_%7Bn-1%7D)

这两个步骤合在一起不就是从 n 里面取 i 个嘛。

然后我们可以得到：

![[公式]](https://www.zhihu.com/equation?tex=B_i%5En%28t%29%3DC%5Ei_nt%5Ei%281-t%29%5E%7Bn-i%7D%3D%28C%5Ei_%7Bn-1%7D%2BC%5E%7Bi-1%7D_%7Bn-1%7D%29t%5Ei%281-t%29%5E%7Bn-i%7D)

然后就变成了 ![[公式]](https://www.zhihu.com/equation?tex=C%5Ei_%7Bn-1%7Dt%5Ei%281-t%29%5E%7Bn-i%7D%2BC%5E%7Bi-1%7D_%7Bn-1%7Dt%5Ei%281-t%29%5E%7Bn-i%7D)

左项提取 1-t，右项提取 t，即可得到我们最上面的式子。

这里还有个问题，即 i=0 怎么办？那 i-1 不就等于 -1 了。对于该情况，式子如下：

> ![[公式]](https://www.zhihu.com/equation?tex=B_0%5En%28t%29%3D%281-t%29B_0%5E%7Bn-1%7D%28t%29)

我们可以这么理解： ![[公式]](https://www.zhihu.com/equation?tex=B_0%5En%28t%29) 不就等于 ![[公式]](https://www.zhihu.com/equation?tex=%281-t%29%5En) ，不就等于 ![[公式]](https://www.zhihu.com/equation?tex=%281-t%29%281-t%29%5E%7Bn-1%7D) ，而 ![[公式]](https://www.zhihu.com/equation?tex=%281-t%29%5E%7Bn-1%7D) 正是 ![[公式]](https://www.zhihu.com/equation?tex=B_0%5E%7Bn-1%7D%28t%29) ，所以可以得到如上式子。

同样的 i=n 的时候会出现 ![[公式]](https://www.zhihu.com/equation?tex=B_n%5E%7Bn-1%7D) 的情况，和上面一样理解即可 ![[公式]](https://www.zhihu.com/equation?tex=B_n%5En%28t%29%3Dt%2At%5E%7Bn-1%7D) ，因此：

> ![[公式]](https://www.zhihu.com/equation?tex=B_n%5En%28t%29%3DtB_%7Bn-1%7D%5E%7Bn-1%7D%28t%29)



## 导数（Derivation）

> ![[公式]](https://www.zhihu.com/equation?tex=B_i%5E%7Bn%27%7D%28t%29%3Dn%28B_%7Bi-1%7D%5E%7Bn-1%7D%28t%29-B_i%5E%7Bn-1%7D%28t%29%29)

证明：

![[公式]](https://www.zhihu.com/equation?tex=B_i%5En%28t%29%3DC%5Ei_nt%5Ei%281-t%29%5E%7Bn-i%7D) ，我们可以设 ![[公式]](https://www.zhihu.com/equation?tex=f%28x%29%3Dt%5Ei) ， ![[公式]](https://www.zhihu.com/equation?tex=g%28x%29%3D%281-t%29%5E%7Bn-i%7D) ，由于 ![[公式]](https://www.zhihu.com/equation?tex=%28f%28x%29%2Ag%28x%29%29%5E%7B%27%7D%3Df%28x%29%5E%7B%27%7Dg%28x%29%2Bf%28x%29g%28x%29%5E%7B%27%7D)

因此 ![[公式]](https://www.zhihu.com/equation?tex=B_i%5E%7Bn%27%7D%28t%29%3DC%5Ei_n%28it%5E%7Bi-1%7D%281-t%29%5E%7Bn-i%7D-%28n-i%29t%5Ei%281-t%29%5E%7Bn-i-1%7D%29)

![[公式]](https://www.zhihu.com/equation?tex=%3D%5Cfrac%7Bn%21%7D%7Bi%21%28n-i%29%21%7Dit%5E%7Bi-1%7D%281-t%29%5E%7Bn-i%7D-%5Cfrac%7Bn%21%7D%7Bi%21%28n-i%29%21%7D%28n-i%29t%5Ei%281-t%29%5E%7Bn-i-1%7D)

![[公式]](https://www.zhihu.com/equation?tex=%3D%5Cfrac%7Bn%21%7D%7B%28i-1%29%21%28n-i%29%21%7Dt%5E%7Bi-1%7D%281-t%29%5E%7Bn-i%7D-%5Cfrac%7Bn%21%7D%7Bi%21%28n-1-i%29%21%7Dt%5Ei%281-t%29%5E%7Bn-i-1%7D)

左右项拆开看，分别提取n：

![[公式]](https://www.zhihu.com/equation?tex=%E5%B7%A6%E9%A1%B9%3Dn%5Cfrac%7B%28n-1%29%21%7D%7B%28i-1%29%21%28%28n-1%29-%28i-1%29%29%21%7Dt%5E%7Bi-1%7D%281-t%29%5E%7B%28n-1%29-%28i-1%29%7D%3DnB_%7Bi-1%7D%5E%7Bn-1%7D%28t%29)

![[公式]](https://www.zhihu.com/equation?tex=%E5%8F%B3%E9%A1%B9%3Dn%5Cfrac%7B%28n-1%29%21%7D%7Bi%21%28n-1-i%29%21%7Dt%5Ei%281-t%29%5E%7Bn-1-i%7D%3DnB_i%5E%7Bn-1%7D%28t%29)

因此最终可得： ![[公式]](https://www.zhihu.com/equation?tex=B_i%5E%7Bn%27%7D%28t%29%3Dn%28B_%7Bi-1%7D%5E%7Bn-1%7D%28t%29-B_i%5E%7Bn-1%7D%28t%29%29)

注：g(x)是复合函数，因此要对(1-t)再次求导，得到-1。



## 最大值（Maxium）

前面既然已经求出了导数，那么我们就可以求出伯恩斯坦多项式的峰值了，使导数的值等于0即可，我们来解一下：

![[公式]](https://www.zhihu.com/equation?tex=B_i%5E%7Bn%27%7D%28t%29%3Dn%28B_%7Bi-1%7D%5E%7Bn-1%7D%28t%29-B_i%5E%7Bn-1%7D%28t%29%29%3D0)

即：

![[公式]](https://www.zhihu.com/equation?tex=B_%7Bi-1%7D%5E%7Bn-1%7D%28t%29%3DB_i%5E%7Bn-1%7D%28t%29%5CRightarrow%5Cfrac%7B%28n-1%29%21%7D%7B%28i-1%29%21%28%28n-1%29-%28i-1%29%29%21%7Dt%5E%7Bi-1%7D%281-t%29%5E%7B%28n-1%29-%28i-1%29%7D%3D%5Cfrac%7B%28n-1%29%21%7D%7Bi%21%28n-1-i%29%21%7Dt%5Ei%281-t%29%5E%7Bn-1-i%7D)

![[公式]](https://www.zhihu.com/equation?tex=%5CRightarrow%5Cfrac%7B1%7D%7Bn-i%7Dt%5E%7Bi-1%7D%281-t%29%5E%7B%28n-1%29-%28i-1%29%7D%3D%5Cfrac%7B1%7D%7Bi%7Dt%5Ei%281-t%29%5E%7Bn-1-i%7D%5CRightarrow%5Cfrac%7B1%7D%7Bn-i%7D%281-t%29%3D%5Cfrac%7B1%7D%7Bi%7Dt)

![[公式]](https://www.zhihu.com/equation?tex=%5CRightarrow%281-t%29i%3Dt%28n-i%29%5CRightarrow+i%3Dtn%5CRightarrow+t%3D%5Cfrac%7Bi%7D%7Bn%7D)

这个解释唯一的，因此**伯恩斯坦多项式会在 t = i/n 处有唯一的局部最大值**。



## 升阶（Degree raising）公式

升阶的意思，即把n阶的伯恩斯坦多项式写成n+1阶。即把它乘以(1-t)或者t，如下：

> ![[公式]](https://www.zhihu.com/equation?tex=%281-t%29B_i%5En%28t%29%3D%281-%5Cfrac%7Bi%7D%7Bn%2B1%7D%29B_i%5E%7Bn%2B1%7D%28t%29)
> ![[公式]](https://www.zhihu.com/equation?tex=tB_i%5En%28t%29%3D%28%5Cfrac%7Bi%2B1%7D%7Bn%2B1%7D%29B_%7Bi%2B1%7D%5E%7Bn%2B1%7D%28t%29)

两者相加，即可得到：

> ![[公式]](https://www.zhihu.com/equation?tex=B_i%5En%28t%29%3D%281-%5Cfrac%7Bi%7D%7Bn%2B1%7D%29B_i%5E%7Bn%2B1%7D%28t%29%2B%28%5Cfrac%7Bi%2B1%7D%7Bn%2B1%7D%29B_%7Bi%2B1%7D%5E%7Bn%2B1%7D%28t%29)

我们不能把 ![[公式]](https://www.zhihu.com/equation?tex=3x%5E2%2B2x%2B1) 的二次多项式写成和 ![[公式]](https://www.zhihu.com/equation?tex=x%5E3) 相关的三次多项式，除非x=0，但是在伯恩斯坦多项式却可以。



## 积分（Integral）

> ![[公式]](https://www.zhihu.com/equation?tex=%5Cint_%7B1%7D%5E%7B0%7DB_i%5En%28t%29%3D%5Cfrac%7B1%7D%7Bn%2B1%7D)

因此伯恩斯坦多项式的总面积并不是1，曲线下的总面积为1/(n+1)，与i无关。



## 三角域的伯恩斯坦多项式

这个在三角域贝塞尔曲面里非常的重要！！！！！！

什么叫三角域的伯恩斯坦多项式呢，我们还是拿开礼包的例子来说明，如下：

假如我有一个礼包，可以开到A，B，C三种物体中的一个，并且不存在一个都开不到的情况。其中开到A的概率为u，开到B的概率为v，开到C的概率为w，且u+v+w=1。那么我问如果我开这个礼包n次，开到 i 个A，j 个B，k 个C的概率是多少？因为必出，所以 i+j+k=n。

首先不考虑排列组合的情况，那么概率自然是 ![[公式]](https://www.zhihu.com/equation?tex=u%5Eiv%5Ejw%5Ek) 了，接着我们把组合数怎么算，首先我们要在 n 里面放 i 个，那么就会得到![[公式]](https://www.zhihu.com/equation?tex=%5Cfrac%7Bn%21%7D%7B%28n-i%29%21%7D) （这个在前面解释过了，就不多说了），然后要在 n-i 个里放 j 个，那么就是![[公式]](https://www.zhihu.com/equation?tex=%5Cfrac%7B%28n-i%29%21%7D%7B%28n-i-j%29%21%7D) ，最后在 n-i-j 里放k个，那么就是![[公式]](https://www.zhihu.com/equation?tex=%5Cfrac%7B%28n-i-j%29%21%7D%7B%28n-i-j-k%29%21%7D) ，因为n-i-j-k=0，三者相乘得到的就是 n! 。然后算重复的情况分别会有 i!，j!，k! 次重复，所以最终的概率为 ![[公式]](https://www.zhihu.com/equation?tex=%5Cfrac%7Bn%21%7D%7Bi%21j%21k%21%7Du%5Eiv%5Ejw%5Ek) 。

那么我们就可以得到这样一个伯恩斯坦多项式：

> ![[公式]](https://www.zhihu.com/equation?tex=B_%7Bi%2Cj%2Ck%7D%5En%28u%2Cv%2Cw%29%3D%5Cfrac%7Bn%21%7D%7Bi%21j%21k%21%7Du%5Eiv%5Ejw%5Ek)

其中u，v，w不就是我们三角形的重心坐标的概念嘛，因此我们称之为三角域的伯恩斯坦多项式。

接着在问个问题， ![[公式]](https://www.zhihu.com/equation?tex=%5Csum+B_%7Bi%2Cj%2Ck%7D%5En%28u%2Cv%2Cw%29) 有多少项？我们知道 ![[公式]](https://www.zhihu.com/equation?tex=%5Csum+B_i%5En%28t%29) 中 i 的取值范围是 0到n ，因此 ![[公式]](https://www.zhihu.com/equation?tex=%5Csum+B_i%5En%28t%29) 一共会有 n+1 项，那么对于三角域的伯恩斯坦多项式有多少项呢？我们应该怎么算。

这里我们可以这么想，当我 i=0 时，j 的取值范围可以是 0到n ，而当我 j 确定了，k 也就确定了，例如 j=1 那么 k 必须等于 n-1，否则不能保证 i+j+k=1。因此 i=0 时一共有 n+1 项，那么 i=1 时有多少项呢？显然是 n 项，因为 j 的取值范围变为 0到n-1 。那么我 i 可以从 0到n，对应的项从 n+1 慢慢递减，即可得到 (n+1)+n+(n-1)+...+1，其中一共 n+1 项，头尾相加乘以项数除以2，即 ![[公式]](https://www.zhihu.com/equation?tex=%5Csum+B_%7Bi%2Cj%2Ck%7D%5En%28u%2Cv%2Cw%29) 一共有 ![[公式]](https://www.zhihu.com/equation?tex=%5Cfrac%7B%28n%2B1%29%28n%2B2%29%7D%7B2%7D) 项。

接下来再讲讲三角域的伯恩斯坦多项式的一些性质，大部分和正常的伯恩斯坦多项式没啥两样。



## 非负性

> ![[公式]](https://www.zhihu.com/equation?tex=B_%7Bi%2Cj%2Ck%7D%5En%28u%2Cv%2Cw%29%3E%3D0)



## 归一性

> ![[公式]](https://www.zhihu.com/equation?tex=%5Csum+B_%7Bi%2Cj%2Ck%7D%5En%28u%2Cv%2Cw%29%3D1)



## 递归性

递归性很重要，我们要用它来推导出de Casteljau算法。

我们用常理来理解，懒得写公式了，我们原本要开 n 个礼包，其中想要 i 个 A，j 个B，k 个C。但是现在我们发现，妈的钱不够，只买得起开 n-1 个礼包了，那么必然只能有下面三种情况：

情况1： i-1 个A，j 和 k不变，那么概率应该是 ![[公式]](https://www.zhihu.com/equation?tex=B_%7Bi-1%2Cj%2Ck%7D%5E%7Bn-1%7D%28u%2Cv%2Cw%29)

情况2： j-1 个B，i 和 k 不变，那么概率应该是 ![[公式]](https://www.zhihu.com/equation?tex=B_%7Bi%2Cj-1%2Ck%7D%5E%7Bn-1%7D%28u%2Cv%2Cw%29)

情况3： k-1 个C，i 和 j 不变，那么概率应该是 ![[公式]](https://www.zhihu.com/equation?tex=B_%7Bi%2Cj%2Ck-1%7D%5E%7Bn-1%7D%28u%2Cv%2Cw%29)

这个时候，突然有个大佬说他送你一个礼包，那么如果：

1：在情况1后，你用送的礼包在u的概率下开出了A，那种总概率就是 ![[公式]](https://www.zhihu.com/equation?tex=uB_%7Bi-1%2Cj%2Ck%7D%5E%7Bn-1%7D%28u%2Cv%2Cw%29)

2：在情况2后，你用送的礼包在v的概率下开出了B，那种总概率就是 ![[公式]](https://www.zhihu.com/equation?tex=vB_%7Bi%2Cj-1%2Ck%7D%5E%7Bn-1%7D%28u%2Cv%2Cw%29)

3：在情况3后，你用送的礼包在w的概率下开出了C，那种总概率就是 ![[公式]](https://www.zhihu.com/equation?tex=wB_%7Bi%2Cj%2Ck-1%7D%5E%7Bn-1%7D%28u%2Cv%2Cw%29)

上面三种的结果不都又变成了你 n 个礼包开到了 i 个 A，j 个B，k 个C么，因此：

> ![[公式]](https://www.zhihu.com/equation?tex=B_%7Bi%2Cj%2Ck%7D%5En%28u%2Cv%2Cw%29%3DuB_%7Bi-1%2Cj%2Ck%7D%5E%7Bn-1%7D%28u%2Cv%2Cw%29%2BvB_%7Bi%2Cj-1%2Ck%7D%5E%7Bn-1%7D%28u%2Cv%2Cw%29%2BwB_%7Bi%2Cj%2Ck-1%7D%5E%7Bn-1%7D%28u%2Cv%2Cw%29)

该公式就是我们的递归公式。

编辑于 2021-04-23 16:49

贝塞尔曲线

数学

计算机图形学