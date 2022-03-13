# 4-4 最大后验估计（MAP）和贝叶斯估计（BE）

[![AK小孩](https://pica.zhimg.com/v2-0bb0542fe98c1ee63c9d22a1d17cc0f2_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/akxiaohai)

[AK小孩](https://www.zhihu.com/people/akxiaohai)

不要怪别人太严厉，自己的错自己永远发现不了

8 人赞同了该文章

## 1，频率统计与贝叶斯统计

频率统计认为事件服从特定的分布，分布的参数虽然未知但是固定。如果进行大量独立重复实验，那么事件发生的概率一定会趋向事件的真实概率。比如抛硬币实验，如果重复无数次的话，出面证明的概率会非常接近0.5. 换句话说，频率统计以大数据为基础。

贝叶斯统计认为事件的发生不是随机的，他受到知识的影响。贝叶斯统计概率来描述知识。比如在抛硬币实验中，只进行了三次实验，而这三次实验都是正面。如果根据频率统计的观点，那么正面出现的概率应该是1.但是事实上，如果硬币没有问题的话，正面出现的概率应该是0.5.所以说此时（实验次数少）的情况下，频率统计的结果并不合理。贝叶斯统计解决这种基于已知的知识，比如说，我们可以假设正面出现的概率位于 ![[公式]](https://www.zhihu.com/equation?tex=%5Cleft%5B+0.4%2C~0.6+%5Cright%5D) 的区间内。然后基于这个假设，去估计正面出现的概率。

## 2，贝叶斯统计

### 2.1 贝叶斯公式：

![[公式]](https://www.zhihu.com/equation?tex=p%28%5Ctheta%7Cx%29%3D%5Cfrac%7Bp%28x%7C%5Ctheta%29p%28%5Ctheta%29%7D%7Bp%28x%29%7D+%5C%5C)

![[公式]](https://www.zhihu.com/equation?tex=p%28%5Ctheta%7Cx%29) 称为后验概率，他表示以采样数据为条件求得的参数概率。他就是要求的量。

![[公式]](https://www.zhihu.com/equation?tex=p%28x%7C%5Ctheta%29) 称为似然函数，他表示以参数 ![[公式]](https://www.zhihu.com/equation?tex=%5Ctheta) 为条件，观察到采样数据的概率。

![[公式]](https://www.zhihu.com/equation?tex=p%28%5Ctheta%29) 为先验概率，表示人们已知的知识。他描述了参数![[公式]](https://www.zhihu.com/equation?tex=%5Ctheta)各种取值的概率，是概率分布函数（PDF）。

![[公式]](https://www.zhihu.com/equation?tex=p%28x%29) 为边缘分布。边缘分布也是一个归一化因子，把 ![[公式]](https://www.zhihu.com/equation?tex=p%28%5Ctheta%7Cx%29) 归一化 ![[公式]](https://www.zhihu.com/equation?tex=%5Cleft%5B+0%2C~1+%5Cright%5D) .

![[公式]](https://www.zhihu.com/equation?tex=p%28x%29%3D%5Cint+p%28x%7C%5Ctheta%29p%28%5Ctheta%29%5Cmbox%7Bd%7D%5Ctheta) . 确定了先验概率之后，边缘分布是个常数，所以有：

![[公式]](https://www.zhihu.com/equation?tex=p%28%5Ctheta%7Cx%29~~%5Cpropto~~%7Bp%28x%7C%5Ctheta%29p%28%5Ctheta%29%7D+%5C%5C)

在抛硬币的例子中，抛硬币事件可以看成是以![[公式]](https://www.zhihu.com/equation?tex=%5Ctheta)为参数的二项分布，所以似然函数![[公式]](https://www.zhihu.com/equation?tex=p%28x%7C%5Ctheta%29)可以表示为：

![[公式]](https://www.zhihu.com/equation?tex=%5Cbegin%7Balign%7D+p%28x_1%3D1%7C%5Ctheta%29%26%3D%5Ctheta+%5C%5C+p%28x_2%3D1%7C%5Ctheta%29%26%3D%5Ctheta%5C%5C+p%28x_3%3D1%7C%5Ctheta%29%26%3D%5Ctheta%5C%5C+p%28%5Cmathbb%7Bx%7D%7C%5Ctheta%29%26%3D%5Ctheta%5E3%5C%5C+%5Cend%7Balign%7D+%5C%5C)

### 2.2 Beta分布：

通常会使用 ![[公式]](https://www.zhihu.com/equation?tex=%5Cmbox%7BBeta%7D%28a%2Cb%29) 分布来描述![[公式]](https://www.zhihu.com/equation?tex=p%28%5Ctheta%29)。

![[公式]](https://www.zhihu.com/equation?tex=%5Cmbox%7BBeta%7D%28a%2Cb%29+%3D+%5Cfrac%7B%5Ctheta%5E%7Ba-1%7D%281-%5Ctheta%29%5E%7Bb-1%7D%7D%7BB%28a%2Cb%29%7D%5C%5C)

因为![[公式]](https://www.zhihu.com/equation?tex=%5Cmbox%7BBeta%7D%28a%2Cb%29)描述概率，所以 ![[公式]](https://www.zhihu.com/equation?tex=%5Ctheta) 的定义域为 ![[公式]](https://www.zhihu.com/equation?tex=%5Cleft%5B+0%2C~1+%5Cright%5D) .给定a，b的值之后， ![[公式]](https://www.zhihu.com/equation?tex=B%28a%2Cb%29) 为常数。

![[公式]](https://www.zhihu.com/equation?tex=B%28a%2Cb%29%3D%5Cint_%7B0%7D%5E%7B1%7D%5Cmu%5E%7Ba-1%7D%281-%5Cmu%29%5E%7Bb-1%7D%5Cmbox%7Bd%7D%5Cmu+%5C%5C)

只有 ![[公式]](https://www.zhihu.com/equation?tex=B%28a%2Cb%29) 为上述表达形式时， 才满足概率分布的积分为 ![[公式]](https://www.zhihu.com/equation?tex=1) .![[公式]](https://www.zhihu.com/equation?tex=%5Cint_%7B0%7D%5E%7B1%7D%5Cmbox%7BBeta%7D%28a%2Cb%29%5Cmbox%7Bd%7D%5Ctheta+%3D+%5Cint_%7B0%7D%5E%7B1%7D%5Cfrac%7B%5Ctheta%5E%7Ba-1%7D%281-%5Ctheta%29%5E%7Bb-1%7D%7D%7BB%28a%2Cb%29%7D%5Cmbox%7Bd%7D%5Ctheta+%3D+%5Cfrac%7B%5Cint_%7B0%7D%5E%7B1%7D%5Ctheta%5E%7Ba-1%7D%281-%5Ctheta%29%5E%7Bb-1%7D%5Cmbox%7Bd%7D%5Ctheta%7D%7BB%28a%2Cb%29%7D%3D1%5C%5C+)

![[公式]](https://www.zhihu.com/equation?tex=a%2Cb) 取不同值是，![[公式]](https://www.zhihu.com/equation?tex=%5Cmbox%7BBeta%7D%28a%2Cb%29)的曲线如下图所示。当 ![[公式]](https://www.zhihu.com/equation?tex=a%3D1%EF%BC%8Cb%3D1) 时， ![[公式]](https://www.zhihu.com/equation?tex=%5Cmbox%7BBeta%7D%28a%2Cb%29) 为均匀分布。

![img](https://pic3.zhimg.com/80/v2-f1304d019ae8ba55f35462cccf20e642_1440w.jpg)

![[公式]](https://www.zhihu.com/equation?tex=%5Cmbox%7BBeta%7D%28a%2Cb%29)的均值为：

![[公式]](https://www.zhihu.com/equation?tex=%5Cmathbb%7BE%7D%28%5Cmbox%7BBeta%7D%28a%2Cb%29%29%3D%5Cint_%7B0%7D%5E%7B1%7D%5Ctheta%5Cfrac%7B%5Ctheta%5E%7Ba-1%7D%281-%5Ctheta%29%5E%7Bb-1%7D%7D%7BB%28a%2Cb%29%7D%5Cmbox%7Bd%7D%5Ctheta+%3D+%5Cfrac%7Ba%7D%7Ba%2Bb%7D%5C%5C)

### 2.3 Beta分布与二项式分布是共轭先验的：

在使用贝叶斯方法进行参数估计时，如果先验概率和后验概率有相同的形式，那么就称为先验概率和后验概率是共轭先验的。共轭先验可以大幅简化计算过程。

举个例子，以Beta分布为先验概率，用二项式分布构造似然函数时，参数的后验概率也符合Beta分布。

证明Beta分布与二项式分布是共轭先验，先设事件为![[公式]](https://www.zhihu.com/equation?tex=%5Cmathbb%7BX%7D%3D%5Cleft%5C%7B+x_1%2Cx_2%2C%5Ccdots%2Cx_n+%5Cright%5C%7D) ,其中发生的次数为 ![[公式]](https://www.zhihu.com/equation?tex=p) ，不发生的次数为 ![[公式]](https://www.zhihu.com/equation?tex=q) （ ![[公式]](https://www.zhihu.com/equation?tex=p%2Bq%3Dn) ）。则似然函数，先验概率，和事件的边缘分布可以表示为：

![[公式]](https://www.zhihu.com/equation?tex=p%28%5Cmathbb%7BX%7D%7C%5Ctheta%29+%3D+%5Ctheta%5Ep%281-%5Ctheta%29%5E%7Bq%7D+%5C%5C+p%28%5Ctheta%29+%3D+%5Cmbox%7BBeta%7D%28a%2Cb%29+%3D+%5Cfrac%7B%5Ctheta%5E%7Ba-1%7D%281-%5Ctheta%29%5E%7Bb-1%7D%7D%7BB%28a%2Cb%29%7D%5C%5C+p%28%5Cmathbb%7BX%7D%29%3D%5Cint+p%28%5Cmathbb%7BX%7D%7C%5Ctheta%29p%28%5Ctheta%29%5Cmbox%7Bd%7D%5Ctheta+%3D+%5Cint++%5Ctheta%5Ep%281-%5Ctheta%29%5E%7Bq%7D++%5Cmbox%7BBeta%7D%28a%2Cb%29%5Cmbox%7Bd%7D%5Ctheta+%3D%5Cint++%5Ctheta%5Ep%281-%5Ctheta%29%5E%7Bq%7D++%5Cfrac%7B%5Ctheta%5E%7Ba-1%7D%281-%5Ctheta%29%5E%7Bb-1%7D%7D%7BB%28a%2Cb%29%7D%5Cmbox%7Bd%7D%5Ctheta+%5C%5C)

则根据贝叶斯公司可以得参数的后验概率为：

![[公式]](https://www.zhihu.com/equation?tex=%5Cbegin%7Balign%7D+p%28%5Ctheta%7C%5Cmathbb%7BX%7D%29%26%3D%5Cfrac%7Bp%28%5Cmathbb%7BX%7D%7C%5Ctheta%29p%28%5Ctheta%29%7D%7Bp%28%5Cmathbb%7BX%7D%29%7D+~~~+%5C%5C+%26%3D+%5Cfrac%7B%5Ctheta%5Ep%281-%5Ctheta%29%5E%7Bq%7D++%5Cfrac%7B%5Ctheta%5E%7Ba-1%7D%281-%5Ctheta%29%5E%7Bb-1%7D%7D%7BB%28a%2Cb%29%7D%7D%7B%5Cint++%5Ctheta%5Ep%281-%5Ctheta%29%5E%7Bq%7D++%5Cfrac%7B%5Ctheta%5E%7Ba-1%7D%281-%5Ctheta%29%5E%7Bb-1%7D%7D%7BB%28a%2Cb%29%7D%5Cmbox%7Bd%7D%5Ctheta%7D%5C%5C+%5Cend%7Balign%7D+%5C%5C)

因为 ![[公式]](https://www.zhihu.com/equation?tex=B%28a%2Cb%29) 是与 ![[公式]](https://www.zhihu.com/equation?tex=%5Ctheta) 无关，由 ![[公式]](https://www.zhihu.com/equation?tex=a%2Cb) 决定的常数。所以上式可以变形为：

![[公式]](https://www.zhihu.com/equation?tex=%5Cbegin%7Balign%7D+p%28%5Ctheta%7C%5Cmathbb%7BX%7D%29+%26%3D+%5Cfrac%7B%5Ctheta%5Ep%281-%5Ctheta%29%5E%7Bq%7D++%7B%5Ctheta%5E%7Ba-1%7D%281-%5Ctheta%29%5E%7Bb-1%7D%7D%7D%7B%5Cint++%5Ctheta%5Ep%281-%5Ctheta%29%5E%7Bq%7D++%7B%5Ctheta%5E%7Ba-1%7D%281-%5Ctheta%29%5E%7Bb-1%7D%7D%5Cmbox%7Bd%7D%5Ctheta%7D%5C%5C+%26%3D%5Cfrac%7B%5Ctheta%5E%7Ba%2Bp-1%7D%281-%5Ctheta%29%5E%7Bb%2Bq-1%7D%7D%7B%7B%5Cint++%5Ctheta%5E%7Ba%2Bp-1%7D%281-%5Ctheta%29%5E%7Bb%2Bq-1%7D%5Cmbox%7Bd%7D%5Ctheta%7D%7D+%5Cend%7Balign%7D+%5C%5C)

因为分母 ![[公式]](https://www.zhihu.com/equation?tex=%5Cint++%5Ctheta%5E%7Ba%2Bp-1%7D%281-%5Ctheta%29%5E%7Bb%2Bq-1%7D%5Cmbox%7Bd%7D%5Ctheta%3DB%28a%2Bp%2Cb%2Bq%29) 为分子的归一化因子，所以有：

![[公式]](https://www.zhihu.com/equation?tex=p%28%5Ctheta%7C%5Cmathbb%7BX%7D%29+%3DB%28a%2Bp%2Cb%2Bq%29%5C%5C)

证明完毕。

### 2.4 例子

假设进行了三次抛硬币实验，三次结果均为正面。分别为![[公式]](https://www.zhihu.com/equation?tex=%5Cmbox%7BBeta%7D%281%2C1%29)，![[公式]](https://www.zhihu.com/equation?tex=%5Cmbox%7BBeta%7D%285%2C5%29)，和![[公式]](https://www.zhihu.com/equation?tex=%5Cmbox%7BBeta%7D%285%2C1%29)作为先验概率，则求对应的后验概率。

1， ![[公式]](https://www.zhihu.com/equation?tex=%5Cmbox%7BBeta%7D%281%2C1%29) （一无所知）

![[公式]](https://www.zhihu.com/equation?tex=p%28%5Ctheta%7Cx%29%3D%5Cmbox%7BBeta%7D%281%2B3%2C1%2B0%29%5C%5C)

2， ![[公式]](https://www.zhihu.com/equation?tex=%5Cmbox%7BBeta%7D%285%2C5%29) （正反面出现的概率相同）

![[公式]](https://www.zhihu.com/equation?tex=p%28%5Ctheta%7Cx%29%3D%5Cmbox%7BBeta%7D%285%2B3%2C5%2B0%29%5C%5C)

3， ![[公式]](https://www.zhihu.com/equation?tex=%5Cmbox%7BBeta%7D%285%2C1%29) （作弊，正面出现的概率极大）

![[公式]](https://www.zhihu.com/equation?tex=p%28%5Ctheta%7Cx%29%3D%5Cmbox%7BBeta%7D%285%2B3%2C1%2B0%29%5C%5C)

### 2.5 贝叶斯估计（BE）

MLE使用似然函数来估计参数值，而贝叶斯估计（BE）则使用 ![[公式]](https://www.zhihu.com/equation?tex=%5Ctheta) 的概率分布来估计参数值。BE认为 ![[公式]](https://www.zhihu.com/equation?tex=%5Ctheta) 的所有可能性都可能会影响估计。 ![[公式]](https://www.zhihu.com/equation?tex=p%28%5Ctheta%7Cx%29) 表示为：

![[公式]](https://www.zhihu.com/equation?tex=%5Ctheta+%3D+%5Cint_%7B0%7D%5E%7B1%7D%5Ctheta+p%28%5Ctheta%7Cx%29%5Cmbox%7Bd%7D%5Ctheta%3D%5Cint_%7B0%7D%5E%7B1%7D%5Ctheta%5Cfrac%7Bp%28x%7C%5Ctheta%29p%28%5Ctheta%29%7D%7Bp%28x%29%7D%5Cmbox%7Bd%7D%5Ctheta+%5C%5C)

计算前面例子中的参数估计，并理解先验分布对后验分布的影响：

1， ![[公式]](https://www.zhihu.com/equation?tex=%5Cmbox%7BBeta%7D%281%2C1%29) （一无所知）

![[公式]](https://www.zhihu.com/equation?tex=%5Chat%7B%5Ctheta%7D%3D%5Cint_%7B0%7D%5E%7B1%7D%5Ctheta~+p%28%5Ctheta%7Cx%29%5Cmbox%7Bd%7D%5Ctheta%3D%5Cint_%7B0%7D%5E%7B1%7D%5Ctheta~%5Cmbox%7BBeta%7D%281%2B3%2C1%2B0%29%5Cmbox%7Bd%7D%5Ctheta%3D%5Cfrac%7B1%2B3%7D%7B1%2B3%2B1%2B0%7D+%3D+0.8%5C%5C)

2， ![[公式]](https://www.zhihu.com/equation?tex=%5Cmbox%7BBeta%7D%285%2C5%29) （正反面出现的概率相同）

![[公式]](https://www.zhihu.com/equation?tex=%5Chat%7B%5Ctheta%7D%3D%5Cint_%7B0%7D%5E%7B1%7D%5Ctheta~+p%28%5Ctheta%7Cx%29%5Cmbox%7Bd%7D%5Ctheta%3D%5Cint_%7B0%7D%5E%7B1%7D%5Ctheta~%5Cmbox%7BBeta%7D%285%2B3%2C5%2B0%29%5Cmbox%7Bd%7D%5Ctheta%3D%5Cfrac%7B5%2B3%7D%7B5%2B3%2B5%2B0%7D+%3D+0.615%5C%5C)

3， ![[公式]](https://www.zhihu.com/equation?tex=%5Cmbox%7BBeta%7D%285%2C1%29) （作弊，正面出现的概率极大）

![[公式]](https://www.zhihu.com/equation?tex=%5Chat%7B%5Ctheta%7D%3D%5Cint_%7B0%7D%5E%7B1%7D%5Ctheta~+p%28%5Ctheta%7Cx%29%5Cmbox%7Bd%7D%5Ctheta%3D%5Cint_%7B0%7D%5E%7B1%7D%5Ctheta~%5Cmbox%7BBeta%7D%285%2B3%2C1%2B0%29%5Cmbox%7Bd%7D%5Ctheta%3D%5Cfrac%7B5%2B3%7D%7B5%2B3%2B1%2B0%7D+%3D+0.889%5C%5C)

###  3，最大后验估计（MAP）

贝叶斯估计认为所有可能的 ![[公式]](https://www.zhihu.com/equation?tex=%5Ctheta) 都对参数估计有贡献。而最大后验估计则是试图最大化后验概率：

![[公式]](https://www.zhihu.com/equation?tex=%5Chat%7B%5Ctheta%7D%3D%5Cmbox%7Bargmax%7D_%7B%5Ctheta%7Dp%28%5Cmathbb%7BX%7D%7C%5Ctheta%29%3D%5Cmbox%7Bargmax%7D_%7B%5Ctheta%7D%5Cleft%5B+%5Clog%7Bp%28%5Cmathbb%7BX%7D%7C%5Ctheta%29%7D%2B%5Clog%7Bp%28%5Ctheta%29%7D+%5Cright%5D%5C%5C)

**MAP估计可以看作是，在优化似然函数的同时，加入了正则化项（即先验概率的对数）。**

使用MAP，计算前面例子中的参数估计：

1， ![[公式]](https://www.zhihu.com/equation?tex=%5Cmbox%7BBeta%7D%281%2C1%29) （一无所知）

![[公式]](https://www.zhihu.com/equation?tex=%5Chat%7B%5Ctheta%7D%3D%5Cmbox%7Bargmax%7D_%7B%5Ctheta%7D%5Cleft%5B+%5Clog%7Bp%28%5Cmathbb%7BX%7D%7C%5Ctheta%29%7D%2B%5Clog%7Bp%28%5Ctheta%29%7D+%5Cright%5D+%3D%5Cmbox%7Bargmax%7D_%7B%5Ctheta%7D%5Cleft%5B+%5Clog%7B%5Ctheta%5E3%7D%2B%5Clog%7B%5Ctheta%5E%7B1-1%7D%281-%5Ctheta%29%5E%7B1-1%7D%7D+%5Cright%5D++%3D1%5C%5C)

2， ![[公式]](https://www.zhihu.com/equation?tex=%5Cmbox%7BBeta%7D%285%2C5%29) （正反面出现的概率相同）

![[公式]](https://www.zhihu.com/equation?tex=%5Chat%7B%5Ctheta%7D%3D%5Cmbox%7Bargmax%7D_%7B%5Ctheta%7D%5Cleft%5B+%5Clog%7Bp%28%5Cmathbb%7BX%7D%7C%5Ctheta%29%7D%2B%5Clog%7Bp%28%5Ctheta%29%7D+%5Cright%5D%3D%5Cmbox%7Bargmax%7D_%7B%5Ctheta%7D%5Cleft%5B+%5Clog%7B%5Ctheta%5E3%7D%2B%5Clog%7B%5Ctheta%5E%7B5-1%7D%281-%5Ctheta%29%5E%7B5-1%7D%7D+%5Cright%5D%3D%5Cfrac%7B1%7D%7B2%7D%5C%5C)

3， ![[公式]](https://www.zhihu.com/equation?tex=%5Cmbox%7BBeta%7D%285%2C1%29) （作弊，正面出现的概率极大）

![[公式]](https://www.zhihu.com/equation?tex=%5Chat%7B%5Ctheta%7D%3D%5Cmbox%7Bargmax%7D_%7B%5Ctheta%7D%5Cleft%5B+%5Clog%7Bp%28%5Cmathbb%7BX%7D%7C%5Ctheta%29%7D%2B%5Clog%7Bp%28%5Ctheta%29%7D+%5Cright%5D%3D%5Cmbox%7Bargmax%7D_%7B%5Ctheta%7D%5Cleft%5B+%5Clog%7B%5Ctheta%5E3%7D%2B%5Clog%7B%5Ctheta%5E%7B5-1%7D%281-%5Ctheta%29%5E%7B1-1%7D%7D+%5Cright%5D%3D1%5C%5C)

参考资料：

https://www.zhihu.com/question/30269898

[李文哲：机器学习中的MLE、MAP、贝叶斯估计](https://zhuanlan.zhihu.com/p/37215276)

[https://www.youtube.com/watch?v=2_eFIyrOdJc](https://link.zhihu.com/?target=https%3A//www.youtube.com/watch%3Fv%3D2_eFIyrOdJc)

[http://noahsnail.com/2018/05/17/2018-05-17-%E8%B4%9D%E5%8F%B6%E6%96%AF%E4%BC%B0%E8%AE%A1%E3%80%81%E6%9C%80%E5%A4%A7%E4%BC%BC%E7%84%B6%E4%BC%B0%E8%AE%A1%E3%80%81%E6%9C%80%E5%A4%A7%E5%90%8E%E9%AA%8C%E6%A6%82%E7%8E%87%E4%BC%B0%E8%AE%A1/](https://link.zhihu.com/?target=http%3A//noahsnail.com/2018/05/17/2018-05-17-%E8%B4%9D%E5%8F%B6%E6%96%AF%E4%BC%B0%E8%AE%A1%E3%80%81%E6%9C%80%E5%A4%A7%E4%BC%BC%E7%84%B6%E4%BC%B0%E8%AE%A1%E3%80%81%E6%9C%80%E5%A4%A7%E5%90%8E%E9%AA%8C%E6%A6%82%E7%8E%87%E4%BC%B0%E8%AE%A1/)

[https://blog.csdn.net/yangliuy/article/details/8296481](https://link.zhihu.com/?target=https%3A//blog.csdn.net/yangliuy/article/details/8296481)

编辑于 2019-03-29 13:45

[深度学习（Deep Learning）](https://www.zhihu.com/topic/19813032)

赞同 8