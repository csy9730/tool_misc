# fitting


fitting, approximation

### 插值和拟合的关系

1、联系 都是根据实际中一组已知数据来构造一个能够反映数据变化规律的近似函数的方法。
2、区别  插值问题不一定得到近似函数的表达形式，仅通过插值方法找到未知点对应的值。数据拟合要求得到一个具体的近似函数的表达式。


插值绝对相信数据，拟合不完全相信数据，可以基于全局对数据修正。
### faq

如何描述对数据点的拟合效果？

相关指标有MSE, 


如何逼近函数？
考虑逼近函数，导函数，高阶导函数。




拟合问题，如何挑选采样点，使得拟合效果最好。

拟合问题，如何挑选基函数，使得拟合效果最好。
基函数， 概念上类似母小波函数。
- 线性函数
- 三次样条
- 正交多项式函数 
    - 勒让德多项式
    - 切比雪夫多项式
    - 切比雪夫多项式二型
    - 拉盖尔
    - 埃尔米特
- 三角函数
- 高斯函数


拟合问题，如何选择模型复杂度，避免过拟合。


拟合问题，如何描述数据的复杂程度？


根据拟合区间，如何配置拟合权重系数？


如何描述样本点对全局和局部的影响？

基函数的势函数。

类似小波的支撑长度。



### 正交多项式函数 

权重不同：
- 勒让德多项式针对各点平等对待，适用于有界区间
- 切比雪夫多项式，适用于有界区间，端点的权重大于中点的权重。
- 切比雪夫多项式二型，适用于有界区间，中点的权重大于端点的权重。
- 拉盖尔，适用于单边无界区间，端点的权重大于无穷边界权重。
- 埃尔米特，适用于双边无界区间，中点的权重大于无穷边界权重。

实际使用中：有界区间还能用。无界区间的拉盖尔和埃尔米特基本难以使用，难以对无穷区间积分。

就算是用 切比雪夫多项式，对于奇异性较大的端点，也是难以拟合的。


通过观察切比雪夫采样点，也能发现是区间两边密集，中间稀疏。

#### 龙格现象
不能使用高次多项式拟合 

#### 分段点设计和搜索