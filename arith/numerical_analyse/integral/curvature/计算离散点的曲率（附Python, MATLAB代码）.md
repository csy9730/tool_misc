# 计算离散点的曲率（附Python, MATLAB代码）

[![Pjer](https://pic1.zhimg.com/v2-84d5539033d0baa19f337885376564ed_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/pjer)

[Pjer](https://www.zhihu.com/people/pjer)





科研等 2 个话题下的优秀答主



271 人赞同了该文章

在很多学科中的很多计算任务中都需要用到曲线的曲率（或者曲率半径），numpy库里和matlab build-in里都没有现成的能从离散点来算曲率的方法，网上找到的代码又不敢直接用，毕竟是要高频率用到自己科研上的工具，所以决定结合找到的资料自己推一下，并造出python和matlab的轮子，造福后人



公式很简单：

曲率：

![[公式]](https://www.zhihu.com/equation?tex=%5Ckappa+%3D+%5Cfrac%7B%7C%5Cddot%7B%5Cvec%7Br%7D%7D%5Ctimes%5Cdot%7B%5Cvec%7Br%7D%7D%7C%7D%7B%5Cleft%7C+%5Cdot%7B%5Cvec%7Br%7D%7D%5Cright%7C%5E3%7D)

在二维情况下，其标量形式为：

![[公式]](https://www.zhihu.com/equation?tex=%5Ckappa+%3D+%5Cfrac%7B%7Cx%27%27y%27-x%27y%27%27%7C%7D%7B%5Cleft%28+%28x%27%29%5E2%2B%28y%27%29%5E2%5Cright%29%5E%7B3%2F2%7D%7D)

所以对于解析情况非常简单，可以直接对于曲线表达式进行解析求导，但是对于离散的点，情况反倒会比较复杂，因为这里的x和y的一阶和二阶导数如果直接用差分方法来计算的话会造成比较大的误差。

这里比较保险的做法是，使用三个点确定的二次曲线的的曲率作为我们估计的曲率:

![img](https://pic1.zhimg.com/80/v2-5f2c6761f6e96378e2cbc69ac2072330_1440w.jpg)

然后使用中间这个点(x2,y2)处的曲率作为这三个点的曲率估计

具体方法是先表示成参数方程的样子，

对于曲线参数t，有：

![[公式]](https://www.zhihu.com/equation?tex=%5Cleft%5C%7B+%5Cbegin%7Bmatrix%7D+x+%3D+a_1+%2Ba_2+t%2Ba_3+t%5E2%5C%5C+y%3D+b_1+%2Bb_2+t%2Bb_3+t%5E2+%5Cend%7Bmatrix%7D+%5Cright.)

6个未知数，三个点里有6个已知分量，列六个方程，解出这 (a1,a2,a3), (b1,b2,b3)即可。



这里使用两段矢量的长度来作为取值范围：

![[公式]](https://www.zhihu.com/equation?tex=t_a+%3D+%5Csqrt%7B%28x_2-x_1%29%5E2+%2B+%28y_2-y_1%29%5E2%7D%5C%5C+t_b+%3D+%5Csqrt%7B%28x_3-x_2%29%5E2+%2B+%28y_3-y_2%29%5E2%7D)

这里我们希望参数方程中的t满足如下条件：

![[公式]](https://www.zhihu.com/equation?tex=%28x%2Cy%29%7C_%7Bt%3D-t_a%7D+%3D+%28x_1%2Cy_1%29%5C%5C+%28x%2Cy%29%7C_%7Bt%3D0%7D+%3D+%28x_2%2Cy_2%29%5C%5C+%28x%2Cy%29%7C_%7Bt%3Dt_b%7D+%3D+%28x_3%2Cy_3%29)

则有：

![[公式]](https://www.zhihu.com/equation?tex=%5Cleft%5C%7B+%5Cbegin%7Bmatrix%7D+x_1+%26%3D+%26+a_1+%26-+a_2+t_a+%2Ba_3+t_a%5E2%5C%5C+x_2+%26%3D+%26a_1+%26%5C%5C+x_3+%26%3D+%26a_1+%26%2B+a_2+t_b+%2B+a_3+t_b%5E2+%5Cend%7Bmatrix%7D+%5Cright.)

以及

![[公式]](https://www.zhihu.com/equation?tex=%5Cleft%5C%7B+%5Cbegin%7Bmatrix%7D+y_1+%26%3D+%26+b_1+%26-+b_2+t_a+%2B+b_3+t_a%5E2%5C%5C+y_2+%26%3D+%26b_1+%26%5C%5C+y_3+%26%3D+%26b_1+%26%2B+b_2+t_b+%2B+b_3+t_b%5E2+%5Cend%7Bmatrix%7D+%5Cright.)

写成矩阵形式：

![[公式]](https://www.zhihu.com/equation?tex=%5Cleft%28+%5Cbegin%7Bmatrix%7D+x_1%5C%5C+x_2%5C%5C+x_3%5C%5C+%5Cend%7Bmatrix%7D+%5Cright%29+%3D+%5Cleft%28+%5Cbegin%7Bmatrix%7D+1%26+-t_a+%26t_a%5E2%5C%5C+1%26+0+%26+0%5C%5C+1%26+t_b%26+t_b%5E2%5C%5C+%5Cend%7Bmatrix%7D+%5Cright%29+%5Cleft%28+%5Cbegin%7Bmatrix%7D+a_1%5C%5C+a_2%5C%5C+a_3%5C%5C+%5Cend%7Bmatrix%7D+%5Cright%29+)

以及

![[公式]](https://www.zhihu.com/equation?tex=%5Cleft%28+%5Cbegin%7Bmatrix%7D+y_1%5C%5C+y_2%5C%5C+y_3%5C%5C+%5Cend%7Bmatrix%7D+%5Cright%29+%3D+%5Cleft%28+%5Cbegin%7Bmatrix%7D+1%26+-t_a+%26t_a%5E2%5C%5C+1%26+0+%26+0%5C%5C+1%26+t_b%26+t_b%5E2%5C%5C+%5Cend%7Bmatrix%7D+%5Cright%29+%5Cleft%28+%5Cbegin%7Bmatrix%7D+b_1%5C%5C+b_2%5C%5C+b_3%5C%5C+%5Cend%7Bmatrix%7D+%5Cright%29+)

简写为：

![[公式]](https://www.zhihu.com/equation?tex=X%3DM+A%5C%5C+Y%3DM+B)

可以使用求矩阵逆的方式求解线性方程:

![[公式]](https://www.zhihu.com/equation?tex=A+%3D+M%5E%7B-1%7DX%5C%5C+B+%3D+M%5E%7B-1%7DY)

有了(a1,a2,a3)和(b1,b2,b3)就有了曲线的解析方程，接下来就和解析求曲率一样了，先算变量导数：

![[公式]](https://www.zhihu.com/equation?tex=x%27%3D+%5Cleft.%5Cfrac%7Bdx%7D%7Bdt%7D%5Cright%7C_%7Bt%3D0%7D+%3D+a_2%5C%5C+x%27%27%3D+%5Cleft.%5Cfrac%7Bd%5E2x%7D%7Bdt%5E2%7D%5Cright%7C_%7Bt%3D0%7D+%3D2+a_3%5C%5C+y%27%3D+%5Cleft.%5Cfrac%7Bdy%7D%7Bdt%7D%5Cright%7C_%7Bt%3D0%7D+%3D+b_2%5C%5C+y%27%27%3D+%5Cleft.%5Cfrac%7Bd%5E2y%7D%7Bdt%5E2%7D%5Cright%7C_%7Bt%3D0%7D+%3D2+b_3)

然后就是最终的曲率：

![[公式]](https://www.zhihu.com/equation?tex=%5Ckappa+%3D+%5Cfrac%7Bx%27%27y%27-x%27y%27%27%7D%7B%5Cleft%28+%28x%27%29%5E2%2B%28y%27%29%5E2%5Cright%29%5E%7B3%2F2%7D%7D+%3D+%5Cfrac%7B2%28a_3+b_2-a_2+b_3%29%7D%7B%28a_2%5E2%2Bb_2%5E2%29%5E%7B3%2F2%7D%7D)

这样，任意给定三个点，都可以估计出这三个点是比较【弯的】还是比较【直的】，直的曲率小，van的曲率大。

随手生成两个例子算算：

（1）圆形：

![img](https://pic3.zhimg.com/80/v2-53181e885c5d85e60338820924c9bd62_1440w.jpg)

好理解，圆形所有地方都是一样弯

（2）正弦

![img](https://pic4.zhimg.com/80/v2-4e1197920b0ee071a220abe51a622627_1440w.jpg)

波峰和波谷最弯，0点附近最直。



看起来没毛病，核对了方向和曲率半径大小的数值，都能对上。这是一个可以放心使用的轮子



这里我把这个算法实现为Python和MATLAB，详见github：

[https://github.com/Pjer-zhang/PJCurvaturegithub.com/Pjer-zhang/PJCurvature](https://link.zhihu.com/?target=https%3A//github.com/Pjer-zhang/PJCurvature)



引用方式：

[[Cite\] Pjer-zhang/PJCurvature](https://link.zhihu.com/?target=https%3A//github.com/Pjer-zhang/PJCurvature/blob/master/cite.md)




===================

Pjer内容分类整理：

[精选](https://www.zhihu.com/collection/334151662) [射电](https://www.zhihu.com/collection/334150369) [编程](https://www.zhihu.com/collection/334149416) [科研工具](https://www.zhihu.com/collection/334151416) [太阳物理](https://www.zhihu.com/collection/334150296)

编辑于 2021-03-10 09:34

数值计算

算法

MATLAB