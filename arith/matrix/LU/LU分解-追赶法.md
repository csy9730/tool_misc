# LU分解-追赶法

[![pde.pdf](https://pic1.zhimg.com/v2-3d1841d37f1995c17f9cb1c529b985e4_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/pde-pdf)

[pde.pdf](https://www.zhihu.com/people/pde-pdf)





8 人赞同了该文章

引言：追赶法是对三对角、五对角、七对角等矩阵线性方程组求解的快速有效办法，而三对角矩阵在有限差分格式中出现的太多了，除此之外，其在物理、工程等领域也都会用到三对角求解的追赶法。

追赶法本质上是LU分解：

![img](https://pic1.zhimg.com/80/v2-d4b921f6aba39400e68138ce651c3e58_1440w.jpg)

![img](https://pic1.zhimg.com/80/v2-0d42f121171ba87779bfa45ec144fb94_1440w.jpg)

伪代码：

Input:(ai)(bi)(ci)(di)

Step1: ![[公式]](https://www.zhihu.com/equation?tex=b_%7B1%7D%5Cleftarrow+b_%7B1%7D%2Cy_%7B1%7D%5Cleftarrow+d_%7B1%7D%2C)

Step2: for i=2 to n

![[公式]](https://www.zhihu.com/equation?tex=a_%7Bi%7D%5Cleftarrow+%5Cfrac%7Ba_%7Bi%7D%7D%7B%5Cbeta_%7Bi-1%7D%7D%2Cb_%7Bi%7D%3Db_%7Bi%7D-a_%7Bi%7Dc_%7Bi-1%7D%2Cd_%7Bi%7D%3Dd_%7Bi%7D-a_%7Bi%7Dd_%7Bi-1%7D%2C) (追：下标由小到大)

end

Step3: ![[公式]](https://www.zhihu.com/equation?tex=d_%7Bn%7D%3Dd_%7Bn%7D%2Fb_%7Bn%7D)

Step4:for i=n-1to1

![[公式]](https://www.zhihu.com/equation?tex=d_%7Bi%7D%3D%28d_%7Bi%7D-c_%7Bi%7Dd_%7Bi%2B1%7D%29%2Fb_%7Bi%7D) (赶：下标由大到小)

end

Output solution(di)



发布于 2020-11-23 16:21