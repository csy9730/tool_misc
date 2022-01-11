

由四个控制点定义的三次Bezier曲线P_0^3可被定义为分别由(P0,P1,P2)和(P1,P2,P3)确定的二条二次Bezier曲线的线性组合，由(N+1)个控制点P_i(i=0,1,...,N)定义的N次Bezier曲线, P_N可被定义为分别由前、后N个控制点定义的两条(N-1)次Bezier曲线P_0^(n-1)与P_1^(n-1)的线性组合：

$$
P_0^N=(1-t)P_0^{N-1}+tP_1^{N-1}, 0<=t<=1
$$

由此得到Bezier曲线的递推计算公式


$$
P_i^k=\begin{cases} P_i & k=0\\
(1-t)P_i^{k-1}+tP_{i+1}^{k-1} & k=1,2...N, i=0,1,...N-k
\end{cases}
$$

这就是这就是de Casteljau算法，可以简单阐述三阶贝塞尔曲线原理。


### 贝塞尔曲线 公式

P_i 是固定的控制点。
$$
P(t)=\sum_{i=0}^n{P_iB_{i,n}(t)} \\
B_{i,n}(t)=C_n^it^i(1-t)^{n-i}=\frac{n!}{i!(n-i)!}t^i(1-t)^{n-i}
$$

#### 求导公式

$$
\frac{d}{dt}B_{n,i}(t)=\frac{d}{dt}(\frac{n!}{i!(n-i)!}t^i(1-t)^{n-i})\\
=\frac{n!}{i!(n-i)!}(it^{i-1}(1-t)^{n-i}-t^i(1-t)^{n-i-1}(n-i))\\
=\frac{n!}{i!(n-i)!}(i-tn)t^{i-1}(1-t)^{n-i-1}\\
=n\frac{(n-1)!}{i!(n-i)!}(i-tn)t^{i-1}(1-t)^{n-i-1}\\
= n(B_{n-1,i-1}(t)-B_{n-1,i}(t))
$$



导数还是贝塞尔曲线, 只不过是控制点是原来控制点的组合而已.



以此类推:贝塞尔曲线的导数还是贝塞尔曲线.

### 性质

  1 各项系数之和为1.
这个很好理解,因为是系数是二项式的展开(t+(1-t))^n = (1)^n非负性. 好理解, 二项式的展开啊

2 对称性
第i项系数和倒数第i项系数相同, 从二项式的展开来思考,这个也好理解  

3 [递归性](https://www.zhihu.com/search?q=递归性&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A1184466425})
递归性指其系数满足下式：

 凸包性质
贝塞尔曲线始终会在**包含了所有控制点的最小凸多边形**中, 不是按照控制点的顺序围成的[最小多边形](https://www.zhihu.com/search?q=最小多边形&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A1184466425}). 这点大家一定注意.　这一点的是很关键的，也就是说可以通过控制点的凸包来限制[规划曲线](https://www.zhihu.com/search?q=规划曲线&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A1184466425})的范围，在路径规划是很需要的一个性质．

５端点性质
第一个控制点和最后一个控制点，恰好是曲线的起始点和终点．这一点可以套用二项式展开来理解，ｔ＝１或者０的时候，相乘二项式的系数，出了初始点或者末尾点，其余的都是０．