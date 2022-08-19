# MSE

- SSE
- MSE
- RMSE
- MAE
- PRD


### RMS

$$
RMS = \sqrt{\frac{\sum_1^N{x_i}}{N}}
$$

### SSE

SSE（和方差）
$$
SSE = \sum_{i=1}^N{(\hat y_i - y_i)^2}
$$
接下来的MSE和RMSE因为和SSE是同出一宗，所以效果一样。

### 均方误差（MSE）
数理统计中均方误差是指参数估计值与参数真值之差平方的期望值，记为MSE。MSE是衡量“平均误差”的一种较方便的方法，MSE可以评价数据的变化程度，MSE的值越小，说明预测模型描述实验数据具有更好的精确度。

均方误差（Mean Square Error，MSE）,反映估计量与被估计量之间差异程度的一种度量。设t是根据子样确定的总体参数θ的一个估计量，(θ-t)2的数学期望，称为估计量t的均方误差。它等于σ2+b2，其中σ2与b分别是t的方差与偏倚。



$$
MSE = \sum_{i=1}^N{(\hat y_i - y_i)^2}/N
$$

范围[0,+∞)，当预测值与真实值完全吻合时等于0，即完美模型；误差越大，该值越大。
总而言之，值越小，机器学习网络模型越精确，相反，则越差。


### 均方根误差（RMSE）
均方根误差（Root Mean Square Error，RMSE），从名称来看，我们都能猜得到是什么意思。多了一个根，这个“根”的意思顾名思义，就只是加了个根号。均方根误差是预测值与真实值偏差的平方与观测次数n比值的平方根，在实际测量中，观测次数n总是有限的，真值只能用最可信赖（最佳）值来代替。
$$
RMSE = \sqrt{\sum_{i=1}^N{(\hat y_i -  y_i)^2}/N}
$$

RMSE就是MSE开个根号。可以更好的描述数据偏差，保持量纲一致，避免MSE的平方的放缩效果。

### 平均绝对误差（MAE）
平均绝对误差（Mean Absolute Error，MAE）,绝对偏差平均值即平均偏差，指各次测量值的绝对偏差绝对值的平均值。平均绝对误差可以避免误差相互抵消的问题，因而可以准确反映实际预测误差的大小。


$$
MAE = \sum_{i=1}^N{|\hat y_i - y_i|}/N
$$
RMSE 与 MAE 的量纲相同，但求出结果后我们会发现RMSE比MAE的要大一些。

这是因为RMSE是先对误差进行平方的累加后再开方，它其实是放大了较大误差之间的差距。

而MAE反应的就是真实误差。因此在衡量中使RMSE的值越小其意义越大，因为它的值能反映其最大误差也是比较小的。
### 平均绝对百分比误差（MAPE）
平均绝对百分比误差（Mean Absolute Percentage Error，MAPE），平均绝对百分比误差之所以可以描述准确度是因为平均绝对百分比误差本身常用于衡量预测准确性的统计指标,如时间序列的预测。

### R Squared

> coefficient of determination
决定系数，反映因变量的全部变异能通过回归关系被自变量解释的比例。

$$
R^2=1-\frac{SS_{residual}}{SS_{total}}
$$

2
$$
R^2=1-\frac{\sum_i{(\hat y_i-y_i)^2}}{\sum_i{(\bar y-y_i)^2}}
$$

我们可发现，上面其实就是MSE，下面就是方差


### PRD
percent root meansquare difference (PRD)

$$
PRD=\sqrt{\frac{\sum {(\hat x_i -  x_i)^2}}{\sum x_i^2}}*100
$$

## reference

[https://www.researchgate.net/publication/336601061_Combination_of_the_CEEM_Decomposition_with_Adaptive_Noise_and_Periodogram_Technique_for_ECG_Signals_Analysis](https://www.researchgate.net/publication/336601061_Combination_of_the_CEEM_Decomposition_with_Adaptive_Noise_and_Periodogram_Technique_for_ECG_Signals_Analysis)

