# [卡特兰(Catalan)数入门详解](https://www.cnblogs.com/Morning-Glory/p/11747744.html)

## 

**目录**

- [基本概念](https://www.cnblogs.com/Morning-Glory/p/11747744.html#_label0)
- [实际问题](https://www.cnblogs.com/Morning-Glory/p/11747744.html#_label1)

 

------

[也许更好的阅读体验](https://blog.csdn.net/Morning_Glory_JR/article/details/102760802)

[回到顶部](https://www.cnblogs.com/Morning-Glory/p/11747744.html#_labelTop)

# 基本概念

## 介绍

学卡特兰数我觉得可能比组合数要难一点，因为组合数可以很明确的告诉你那个公式是在干什么，而卡特兰数却像是在用大量例子来解释什么时卡特兰数
这里，我对卡特兰数做一点自己的理解
卡特兰数是一个在组合数学里经常出现的一个数列，它并没有一个具体的意义，却是一个十分常见的数学规律

对卡特兰数的初步理解：有一些操作，这些操作有着一定的限制，如一种操作数不能超过另外一种操作数，或者两种操作不能有交集等，这些操作的合法操作顺序的数量

为了区分组合数，这里用fnfn表示卡特兰数的第nn项
从零开始，卡特兰数的前几项为1,1,2,5,14,42,132,429,1430,4862,16796,58786,208012,742900,2674440,9694845,35357670,129644790…1,1,2,5,14,42,132,429,1430,4862,16796,58786,208012,742900,2674440,9694845,35357670,129644790…

## 定义

**递归定义**

fn=f0∗fn−1+f1∗fn−2+…+fn−1f0fn=f0∗fn−1+f1∗fn−2+…+fn−1f0，其中n≥2n≥2

**递推关系**

fn=4n−2n+1fn−1fn=4n−2n+1fn−1

**通项公式**

fn=1n+1Cn2nfn=1n+1C2nn

经化简后可得

fn=Cn2n−Cn−12nfn=C2nn−C2nn−1

只要我们在解决问题时得到了上面的一个关系，那么你就已经解决了这个问题，因为他们都是卡特兰数列

------

[回到顶部](https://www.cnblogs.com/Morning-Glory/p/11747744.html#_labelTop)

# 实际问题

先用一个最经典的问题来帮助理解卡特兰数
去掉了所有的掩饰，将问题直接写出来就是

## 例题1

在一个w×hw×h的网格上，你最开始在(0,0)(0,0)上，你每个单位时间可以向上走一格，或者向右走一格，在任意一个时刻，你往右走的次数都不能少于往上走的次数，问走到(n,m),0≤n(n,m),0≤n有多少种不同的合法路径。

**合法路径个数为Cn2n−Cn−12nC2nn−C2nn−1**

直接求不好，考虑求有多少种不合法路径
路径总数为在2n2n次移动中选nn次向上移动，即Cn2nC2nn

画一下图，我们把y=x+1y=x+1这条线画出来，发现所有的合法路径都是不能碰到这条线的，碰到即说明是一条不合法路径
先随便画一条碰到这条线的不合法路径，所有的不合法路径都会与这条线有至少一个交点，我们把第一个交点设为(a,a+1)(a,a+1)
如图

![p1.png](https://imgconvert.csdnimg.cn/aHR0cHM6Ly9pLmxvbGkubmV0LzIwMTkvMTAvMjcvaUlKc2hSVTl6TGx4ZGtULnBuZw?x-oss-process=image/format,png)

我们把(a,a+1)(a,a+1)之后的路径全部按照y=x+1y=x+1这条线对称过去
这样，最后的终点就会变成(n−1,n+1)(n−1,n+1)
![p2.png](https://imgconvert.csdnimg.cn/aHR0cHM6Ly9pLmxvbGkubmV0LzIwMTkvMTAvMjcvSFYzWGhMemRmWllReVNsLnBuZw?x-oss-process=image/format,png)

由于所有的不合法路径一定会与y=x+1y=x+1有这么一个交点
我们可以得出，所有不合法路径对称后都唯一对应着一条到(n−1,n+1)(n−1,n+1)的路径
且所有到(n−1,n+1)(n−1,n+1)的一条路径都唯一对应着一条不合法路径（只需将其对称回去即可）
所以不合法路径总数是Cn−12nC2nn−1

那么合法的路径总数为Cn2n−Cn−12nC2nn−C2nn−1

这是一个非常好用且重要的一个方法，其它的问题也可以用该方法解决
即**找到不合法路径唯一对应的到另一个点的路径**
如[网格计数](https://www.cnblogs.com/Morning-Glory/p/11722333.html)

------

## 方法

先将方法写在前面吧
相信大家都听过烧开水这个数学小故事吧
和学习数学一样，**转化**是基本思路，将一个问题转化为另外一个已经解决了的问题是最重要的

------

## 01序列

你现在有nn个00和nn个11，问有多少个长度为2n2n的序列，使得序列的任意一个前缀中11的个数都大于等于00的个数
例如n=2n=2时
有1100,10101100,1010两种合法序列
而1001,0101,0110,00111001,0101,0110,0011都是不合法的序列

**合法的序列个数为Cn2n−Cn−12nC2nn−C2nn−1**

我们把出现一个11看做向右走一格，出现一个11看做向上走一格，那么这个问题就和上面的例题11一模一样了

**拓展**
如果是nn个1,m1,m个00呢？
不过是最后的终点变为了(n,m)(n,m)罢了
如果是11的个数不能够比mm少kk呢
我们只需将y=x+1y=x+1这条线上下移动即可

------

## 括号匹配

你有nn个左括号，nn个右括号，问有多少个长度为2n2n的括号序列使得所有的括号都是合法的

**合法的序列个数为Cn2n−Cn−12nC2nn−C2nn−1**

要使所有的括号合法，实际上就是在每一个前缀中左括号的数量都不少于右括号的数量
将左括号看做11，右括号看做00，这题又和上面那题一模一样了

------

## 进出栈问题

有一个栈，我们有2n2n次操作，nn次进栈，nn次出栈，问有多少中合法的进出栈序列

**合法的序列个数为Cn2n−Cn−12nC2nn−C2nn−1**

要使序列合法，在任何一个前缀中进栈次数都不能少于出栈次数……
后面就不用我说了吧，和上面的问题又是一模一样的了

------

## 312排列

一个长度为nn的排列aa，只要满足i<j<ki<j<k且aj<ak<aiaj<ak<ai就称这个排列为312312排列
求nn的全排列中不是312312排列的排列个数

答案也是卡特兰数

我们考虑312312排列有什么样的特征
如果考虑一个排列能否被1,2,3,…,n−1,n1,2,3,…,n−1,n排列用进栈出栈来表示
那么312312排列就是所有不能被表示出来的排列
那么这个问题就被转化成进出栈问题了

------

## 不相交弦问题

在一个圆周上分布着 2n2n个点，两两配对，并在这两个点之间连一条弦，要求所得的2n2n条弦彼此不相交的配对方案数
当n=4n=4时，一种合法的配对方案为如图

![p3.png](https://imgconvert.csdnimg.cn/aHR0cHM6Ly9pLmxvbGkubmV0LzIwMTkvMTAvMjcvcDRKMjlWeVJDbWgzSGVQLnBuZw?x-oss-process=image/format,png)

**合法的序列个数为Cn2n−Cn−12nC2nn−C2nn−1**

这个问题没有上面的问题那么显然，我们规定一个点为初始点，然后规定一个方向为正方向
如规定最上面那个点为初始点，逆时针方向为正方向
然后我们把一个匹配第一次遇到的点（称为起点）旁边写一个左括号((，一个匹配第二次遇到的点（称为终点）旁边写一个右括号))
如图

![p4.png](https://imgconvert.csdnimg.cn/aHR0cHM6Ly9pLmxvbGkubmV0LzIwMTkvMTAvMjcvYUJyNGdYd2lzdkQyRlBFLnBuZw?x-oss-process=image/format,png)

看出来吗，在规定了这样的一个顺序后，在任意一个前缀中起点的个数都不能少于终点的个数
于是这又是一个卡特兰数列了

------

## 二叉树的构成问题

有nn个点，问用这nn个点最终能构成多少二叉树

答案仍然是卡特兰数列

这个问题不是用上面的方法，是用递归定义的卡特兰数

一个二叉树分为根节点，左子树，右子树
其中左子树和右子树也是二叉树，左右子树节点个数加起来等于n−1n−1
设ii个点能构成fifi个二叉树
我们枚举左子树有几个点可得
fn=f0∗fn−1+f1∗fn−2+…+fn−1∗f0fn=f0∗fn−1+f1∗fn−2+…+fn−1∗f0
这个和卡特兰数列的递归定义是一模一样的

------

## 凸多边形的三角划分

一个凸的nn边形，用直线连接他的两个顶点使之分成多个三角形，每条直线不能相交，问一共有多少种划分方案

答案还是卡特兰数列

我们在凸多边形中随便挑两个顶点连一条边，这个凸多边形就会被分成两个小凸多边形，由于每条直线不能相交，接下来我们就只要求这两个小凸多边形的划分方案然后乘起来即可

和二叉树的构成问题一样，我们枚举大凸多边形被分成的两个小凸多边形的大小即可

------

## 阶梯的矩形划分

一个阶梯可以被若干个矩形拼出来
图示是两种划分方式

![p5.png](https://imgconvert.csdnimg.cn/aHR0cHM6Ly9pLmxvbGkubmV0LzIwMTkvMTAvMjcveU1HU3A1aUFxSEQ3WjRGLnBuZw?x-oss-process=image/format,png)
![p6.png](https://imgconvert.csdnimg.cn/aHR0cHM6Ly9pLmxvbGkubmV0LzIwMTkvMTAvMjcvdFdBRjMxY0tWdXB5ZmI5LnBuZw?x-oss-process=image/format,png)

像下图是不合法的划分方式
![p7.png](https://imgconvert.csdnimg.cn/aHR0cHM6Ly9pLmxvbGkubmV0LzIwMTkvMTAvMjcvZkRiY3BVd0p6eDdnVGRRLnBuZw?x-oss-process=image/format,png)

问，一个nn阶矩形有多少种矩形划分

答案仍然是卡特兰数列

我们考虑阶梯的每个角

如图
![p8.png](https://imgconvert.csdnimg.cn/aHR0cHM6Ly9pLmxvbGkubmV0LzIwMTkvMTAvMjcvSDlHMkIxejVjWVU3YktGLnBuZw?x-oss-process=image/format,png)

每个角一定是属于不同的矩形的，我们考虑和左下角属于一个矩形的是哪个角
这个矩形将这个梯形又分成两个小梯形，如图

![p9.png](https://imgconvert.csdnimg.cn/aHR0cHM6Ly9pLmxvbGkubmV0LzIwMTkvMTAvMjcveXJBaGtVYjlLMnFzWHA0LnBuZw?x-oss-process=image/format,png)

于是我们又可以写出递推式了
和卡特兰数列的递归式是一样的

卡特兰数就讲这么多吧

> 如有哪里讲得不是很明白或是有错误，欢迎指正
> 如您喜欢的话不妨点个赞收藏一下吧



分类: [理解 ](https://www.cnblogs.com/Morning-Glory/category/1310741.html), [数论](https://www.cnblogs.com/Morning-Glory/category/1318559.html)

[好文要顶](javascript:void(0);) [关注我](javascript:void(0);) [收藏该文](javascript:void(0);) [![img](https://common.cnblogs.com/images/icon_weibo_24.png)](javascript:void(0);) [![img](https://common.cnblogs.com/images/wechat.png)](javascript:void(0);)

![img](https://pic.cnblogs.com/face/1435687/20190928154624.png)

[Morning_Glory](https://home.cnblogs.com/u/Morning-Glory/)
[关注 - 12](https://home.cnblogs.com/u/Morning-Glory/followees/)
[粉丝 - 26](https://home.cnblogs.com/u/Morning-Glory/followers/)





[+加关注](javascript:void(0);)

6

0







[« ](https://www.cnblogs.com/Morning-Glory/p/11743945.html)上一篇： [异或序列 [set优化DP\]](https://www.cnblogs.com/Morning-Glory/p/11743945.html)
[» ](https://www.cnblogs.com/Morning-Glory/p/11754576.html)下一篇： [或与异或 [背包DP\]](https://www.cnblogs.com/Morning-Glory/p/11754576.html)

posted @ 2019-10-27 15:41  [Morning_Glory](https://www.cnblogs.com/Morning-Glory/)  阅读(9586)  评论(4)  [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=11747744)  [收藏](javascript:void(0))  [举报](javascript:void(0))



