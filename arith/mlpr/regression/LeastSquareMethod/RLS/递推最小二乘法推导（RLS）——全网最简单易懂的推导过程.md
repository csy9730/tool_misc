# 递推最小二乘法推导（RLS）——全网最简单易懂的推导过程

[阿Q在江湖](https://www.zhihu.com/people/a-q-zai-jiang-hu)

微信公众号：新能源动力电池与BMS



88 人赞同了该文章

**欢迎关注我的微信公众号【新能源动力电池与BMS】，头条号：【阿Q在江湖】**；**所有文章资料会在公众号首发。**

**1.先从一般最小二乘法开始说起**

最小二乘要解决的问题是

![[公式]](https://www.zhihu.com/equation?tex=y+%3D+%5Cbegin%7Bbmatrix%7Dx_1+%26+%5Ccdots+%26+x_n%5Cend%7Bbmatrix%7D+%5Cbegin%7Bbmatrix%7D+%5Ctheta_1+%5C%5C+%5Cvdots+%5C%5C+%5Ctheta_n+%5Cend%7Bbmatrix%7D) 已知x和y的一系列数据，求解参数theta的估计。用矩阵的形式来表达更方便一些

![[公式]](https://www.zhihu.com/equation?tex=%5Cbegin%7Bbmatrix%7Dy_1+%5C%5C+%5Cvdots++%5C%5Cy_k%5Cend%7Bbmatrix%7D+%3D+%5Cbegin%7Bbmatrix%7D%5Cphi_1%5ET+%5C%5C+%5Cvdots+%5C%5C+%5Cphi_k%5ET%5Cend%7Bbmatrix%7D+%5CTheta) 其中k代表有k组观测到的数据，

![[公式]](https://www.zhihu.com/equation?tex=%5Cphi_i%5ET+%3D+%5Cbegin%7Bbmatrix%7Dx_1%5Ei+%26+%5Ccdots+%26+x_n%5Ei%5Cend%7Bbmatrix%7D+%5Cin+%5Cmathbb%7BR%7D%5E%7B1+%5Ctimes+n%7D%2C+%5CTheta+%3D+%5Cbegin%7Bbmatrix%7D%5Ctheta_1+%5C%5C+++%5Cvdots+%5C%5C+%5Ctheta_n%5Cend%7Bbmatrix%7D+%5Cin+%5Cmathbb%7BR%7D%5E%7Bn%5Ctimes+1%7D) 表示第i组数据的输入观测量，yi表示第i组数据的输出观测量。令 ![[公式]](https://www.zhihu.com/equation?tex=%5CPhi_k+%3D+%5Cbegin%7Bbmatrix%7D%5Cphi_1%5ET+%5C%5C+%5Cvdots+%5C%5C+%5Cphi_k%5ET%5Cend%7Bbmatrix%7D+%5Cin+%5Cmathbb%7BR%7D%5E%7Bk%5Ctimes+n%7D%2C+Y_k+%3D+%5Cbegin%7Bbmatrix%7Dy_1+%5C%5C+%5Cvdots+%5C%5C+y_k%5Cend%7Bbmatrix%7D+%5Cin+%5Cmathbb%7BR%7D%5E%7Bk%5Ctimes+1%7D) ，则最小二乘的解很简单，等价于 ![[公式]](https://www.zhihu.com/equation?tex=%5CPhi_k%5E%7BT%7D%28Y_k-%5CPhi_k%5Chat%7B%5CTheta_k%7D%29%3D0) ,即参数解为： ![[公式]](https://www.zhihu.com/equation?tex=%5Chat%7B%5CTheta%7D_k%3D+%28%5CPhi_k%5ET%5CPhi_k%29%5E%7B-1%7D%5CPhi_k%5ET+Y_k) ，如果数据是在线的不断的过来，不停的采用最小二乘的解法来解是相当消耗资源与内存的，所以要有一种递推的形式来保证对 ![[公式]](https://www.zhihu.com/equation?tex=%5Chat%7B%5CTheta%7D_k) 的在线更新。

------

**2.进一步推导出递推最小二乘法（RLS）**

我们的目的是从一般最小二乘法的解 ![[公式]](https://www.zhihu.com/equation?tex=%5Chat%7B%5CTheta%7D_k%3D+%28%5CPhi_k%5ET%5CPhi_k%29%5E%7B-1%7D%5CPhi_k%5ET+Y_k) ，推导出 ![[公式]](https://www.zhihu.com/equation?tex=%5Chat%7B%5CTheta%7D_k+%3D+%5Chat%7B%5CTheta%7D_%7Bk-1%7D+%2B+%E4%BF%AE%E6%AD%A3%E9%87%8F+) 递推形式。一定要理解这里的下标k代表的意思，是说在有k组数据情况下的预测，所以k比k-1多了一组数据，所以可以用这多来的一组数据来对原本的估计进行修正，这是一个很直观的理解。下面是推导过程：

先看一般最小二乘法的解 ![[公式]](https://www.zhihu.com/equation?tex=%5Chat%7B%5CTheta%7D_k%3D+%28%5CPhi_k%5ET%5CPhi_k%29%5E%7B-1%7D%5CPhi_k%5ET+Y_k) ，下面分别对![[公式]](https://www.zhihu.com/equation?tex=%5CPhi_k%5ET%5CPhi_k%E5%92%8C%5CPhi_k%5ETY_k) 这两部分进行推导变换， 令 ![[公式]](https://www.zhihu.com/equation?tex=P_k%5E%7B-1%7D+%3D+%5CPhi_k%5ET%5CPhi_k)

得到下面**公式（1）**![[公式]](https://www.zhihu.com/equation?tex=%5CPhi_k%5ET%5CPhi_k+%3D+%5Cbegin%7Bbmatrix%7D%5Cphi_1+%26+%5Ccdots+%26%5Cphi_k%5Cend%7Bbmatrix%7D+++%5Cbegin%7Bbmatrix%7D%5Cphi_1%5ET+%5C%5C+%5Cvdots+%5C%5C+%5Cphi_k%5ET%5Cend%7Bbmatrix%7D+%3D++%5Csum_%7Bi%3D1%7D%5E%7Bk%7D%7B%5Cphi_i%5Cphi_i%5ET%7D++%3D+%5Csum_%7Bi%3D1%7D%5E%7Bk-1%7D%7B%5Cphi_%7Bi%7D%5Cphi_i%5ET%2B%5Cphi_k%5Cphi_k%5ET%7D+%3D+P_%7Bk-1%7D%5E%7B-1%7D+%2B+%5Cphi_k%5Cphi_k%5ET)

下面来变换 ![[公式]](https://www.zhihu.com/equation?tex=%5CPhi_k%5ET+Y_k) ，得到***公式（2）***

![[公式]](https://www.zhihu.com/equation?tex=%5CPhi_k%5ET+Y_k+%3D+%5Cbegin%7Bbmatrix%7D%5Cphi_1+%26+%5Ccdots+%26%5Cphi_k%5Cend%7Bbmatrix%7D+++%5Cbegin%7Bbmatrix%7D+y_1+%5C%5C+%5Cvdots+%5C%5C+y_k%5Cend%7Bbmatrix%7D+%3D++%5Csum_%7Bi%3D1%7D%5E%7Bk%7D%7B%5Cphi_i+y_i%7D++%3D+%5Csum_%7Bi%3D1%7D%5E%7Bk-1%7D%7B%5Cphi_%7Bi%7D+y_i%2B%5Cphi_k+y_k%7D+%3D+%5CPhi_%7Bk-1%7D%5ET+Y_%7Bk-1%7D%2B+%5Cphi_k+y_k)

下面再来，根据一般最小二乘法的解，我们知道下式成立，得到***公式（3）***（*注：后续公式推导用到*）

![[公式]](https://www.zhihu.com/equation?tex=%5Chat%7B%5CTheta%7D_%7Bk-1%7D%3D+%28%5CPhi_%7Bk-1%7D%5ET%5CPhi_%7Bk-1%7D%29%5E%7B-1%7D%5CPhi_%7Bk-1%7D%5ET+Y_%7Bk-1%7D)

![[公式]](https://www.zhihu.com/equation?tex=%5CRightarrow+%5Chat%7B%5CTheta%7D_%7Bk-1%7D%3D+P_%7Bk-1%7D%5CPhi_%7Bk-1%7D%5ET+Y_%7Bk-1%7D)

![[公式]](https://www.zhihu.com/equation?tex=%5CRightarrow+P_%7Bk-1%7D%5E%7B-1%7D+%5Chat%5CTheta_%7Bk-1%7D+%3D+%5CPhi_%7Bk-1%7D%5ET+Y_%7Bk-1%7D) ***（3）***

好了，有了上面最主要的三步推导，下面就简单了,将上面推导的结果依次代入公式即可：

![[公式]](https://www.zhihu.com/equation?tex=%5Chat%7B%5CTheta%7D_k%3D+%28%5CPhi_k%5ET%5CPhi_k%29%5E%7B-1%7D%5CPhi_k%5ET+Y_k+)

![[公式]](https://www.zhihu.com/equation?tex=%3D+P_K+%5CPhi_k%5ET+Y_k+)

![[公式]](https://www.zhihu.com/equation?tex=%3DP_k+%28+%5CPhi_%7Bk-1%7D%5ET+Y_%7Bk-1%7D%2B+%5Cphi_k+y_k%29) 公式2结果替代得到

![[公式]](https://www.zhihu.com/equation?tex=%3DP_k+%28P_%7Bk-1%7D%5E%7B-1%7D+%5Chat%5CTheta_%7Bk-1%7D+%2B+%5Cphi_k+y_k%29) 公式3结果替代得到

![[公式]](https://www.zhihu.com/equation?tex=%3D+P_k+%5B%28P_k%5E%7B-1%7D+-+%5Cphi_k%5Cphi_k%5ET%29+%5Chat%5CTheta_%7Bk-1%7D+%2B+%5Cphi_k+y_k%5D) 由公式1变换

![[公式]](https://www.zhihu.com/equation?tex=%3D+%5Chat%5CTheta_%7Bk-1%7D+-+P_k++%5Cphi_k%5Cphi_k%5ET+%5Chat%5CTheta_%7Bk-1%7D+%2BP_k%5Cphi_k+y_k)

![[公式]](https://www.zhihu.com/equation?tex=%3D+%5Chat%5CTheta_%7Bk-1%7D+%2B+P_k%5Cphi_k%28y_k-+%5Cphi_k%5ET+%5Chat%5CTheta_%7Bk-1%7D%29)

![[公式]](https://www.zhihu.com/equation?tex=%3D+%5Chat%5CTheta_%7Bk-1%7D+%2B+K_k%5Cvarepsilon_k)

至此，终于变成 ![[公式]](https://www.zhihu.com/equation?tex=%5Chat%7B%5CTheta%7D_k+%3D+%5Chat%7B%5CTheta%7D_%7Bk-1%7D+%2B+%E4%BF%AE%E6%AD%A3%E9%87%8F+) 的形式了。

***总结RLS方程为：***

![[公式]](https://www.zhihu.com/equation?tex=%5Chat%5CTheta_%7Bk%7D%3D+%5Chat%5CTheta_%7Bk-1%7D+%2B+K_k%5Cvarepsilon_k) **（4）**

![[公式]](https://www.zhihu.com/equation?tex=K_k+%3D+P_k%5Cphi_k%E6%88%96%E8%80%85K_k%3DP_%7Bk-1%7D+%5Cphi_k%5B1%2BP_%7Bk-1%7D%5Cphi_k%5Cphi_k%5ET%5D%5E%7B-1%7D) **（5）**

![[公式]](https://www.zhihu.com/equation?tex=%5Cvarepsilon_k+%3D+y_k-+%5Cphi_k%5ET+%5Chat%5CTheta_%7Bk-1%7D) **（6）**

![[公式]](https://www.zhihu.com/equation?tex=P_k+%3D+%28P_%7Bk-1%7D%5E%7B-1%7D+%2B%5Cphi_k%5Cphi_k%5ET%29%5E%7B-1%7D%E6%88%96%E8%80%85P_k+%3D+%5BI-K_k+%5Cphi_k%5ET%5DP_%7Bk-1%7D) **（7） 左边其实是根据公式1，右边I为单位矩阵**

*注意上式（5）和（7）中，有些文献资料是用右边的方程描述，实际上是等效的，只需稍微变换即可。例如（5）式右边表达式是将公式（1）代入计算的。为简化描述，我们下面还是只讨论左边表达式为例。*

上面第7个公式要计算矩阵的逆，求逆过程还是比较复杂，需要用矩阵引逆定理进一部简化。

矩阵引逆定理：

![[公式]](https://www.zhihu.com/equation?tex=%5BA%2BBCD%5D%5E%7B-1%7D%3DA%5E%7B-1%7D-A%5E%7B-1%7DB%5BC%5E%7B-1%7D%2BDA%5E%7B-1%7DB%5D%5E%7B-1%7DDA%5E%7B-1%7D)

设 ![[公式]](https://www.zhihu.com/equation?tex=A%3DP_%7BK-1%7D%5E%7B-1%7D%3BB%3D%5Cphi_k%3BC%3D1%3BD%3D%5Cphi_k%5ET)

公式7：![[公式]](https://www.zhihu.com/equation?tex=P_k+%3D+%28P_%7Bk-1%7D%5E%7B-1%7D+%2B%5Cphi_k%5Cphi_k%5ET%29%5E%7B-1%7D+)

![[公式]](https://www.zhihu.com/equation?tex=%3D%5BA%2BBCD%5D%5E%7B-1%7D%3DA%5E%7B-1%7D-A%5E%7B-1%7DB%5BC%5E%7B-1%7D%2BDA%5E%7B-1%7DB%5D%5E%7B-1%7DDA%5E%7B-1%7D)

![[公式]](https://www.zhihu.com/equation?tex=%3DP_%7Bk-1%7D-P_%7Bk-1%7D%5Cphi_k%5B1%2B%5Cphi_k%5ET+P_%7Bk-1%7D%5Cphi_k%5D%5E%7B-1%7D%5Cphi_k%5ET+P_%7Bk-1%7D)

![[公式]](https://www.zhihu.com/equation?tex=%3DP_%7Bk-1%7D-%5Cfrac%7BP_%7Bk-1%7D%5Cphi_k+%5Cphi_k%5ET+P_%7Bk-1%7D%7D%7B1%2B%5Cphi_k%5ETP_%7Bk-1%7D%5Cphi_k%7D) **（8）**

**最终RLS的方程解为：**

![[公式]](https://www.zhihu.com/equation?tex=%5Chat%5CTheta_%7Bk%7D%3D+%5Chat%5CTheta_%7Bk-1%7D+%2B+K_k%5Cvarepsilon_k) **（4）**

![[公式]](https://www.zhihu.com/equation?tex=K_k+%3D+P_k%5Cphi_k) **（5）**

![[公式]](https://www.zhihu.com/equation?tex=%5Cvarepsilon_k+%3D+y_k-+%5Cphi_k%5ET+%5Chat%5CTheta_%7Bk-1%7D) **（6）**

![[公式]](https://www.zhihu.com/equation?tex=P_k%3DP_%7Bk-1%7D-%5Cfrac%7BP_%7Bk-1%7D%5Cphi_k+%5Cphi_k%5ET+P_%7Bk-1%7D%7D%7B1%2B%5Cphi_k%5ETP_%7Bk-1%7D%5Cphi_k%7D) **（8）**

**好了，至此完毕！以上应该算是最简单的推导过程了，相信都能看得懂了。**

**PS:后续我将增加带遗忘因子的RLS推导步骤，毕竟工程上的实际用途很多用此方法。**

**欢迎大家一起交流电池管理系统（BMS）算法研究。**



**微信公众号：【新能源动力电池与BMS】，**头**条号：【阿Q在江湖】；后续有关动力电池、BMS相关文章会在公众号首发，欢迎关注**

[http://weixin.qq.com/r/b0MhOVDElQ3qrRRa9xZ9](https://link.zhihu.com/?target=http%3A//weixin.qq.com/r/b0MhOVDElQ3qrRRa9xZ9) (二维码自动识别)







编辑于 2020-06-24

回归分析

高等数学

最小二乘法