# 常微分方程（ODE）和偏微分方程（PDE）的数值方法

作者：lxg1023

链接：https://www.zhihu.com/question/56820475/answer/154630733

来源：知乎

著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。

题主想问的是常微分方程（ODE）和偏微分方程（PDE）的数值方法区别呢还是微分方程这个领域和微分方程数值解领域的区别呢？按照前面@[赵永峰](https://www.zhihu.com/search?q=赵永峰&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A154630733}) 的回答，我也按照前者理解吧。毕竟后者的一些区别是显而易见的。

先说一点共性。微分方程的数值方法，无论是ODE还是PDE，都是将连续的、无限未知数的问题近似为离散的、有限未知数的问题求解。从经典数值分析的角度，通常会关心下面一些问题：相容性、稳定性、收敛性、收敛阶、计算量等等。相容性是指格式在局部是不是做出了正确的近似；稳定性是说局部的近似误差会不会随着计算而积累放大；收敛性是说当离散尺度无穷小的时候数值解是否会趋向于真实解；收敛阶则刻画了收敛的速度，高阶的格式可以用较大的离散尺度获得较好的数值结果，但是代价通常是单步下稍多的计算量。因此[数值方法](https://www.zhihu.com/search?q=数值方法&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A154630733})的最终表现需要在误差和计算量之间找到一个平衡。

先说说ODE。在这个领域里，无论是初值问题还是边值问题，[有限差分方法](https://www.zhihu.com/search?q=有限差分方法&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A154630733})都是最常用的方法，比如说著名的Runge-Kutta方法。最常用的RK4方法就有稳定性条件比较宽泛、收敛阶很高（4阶）、计算量较小的优点。ODE数值方法中，差分方法是绝对的主流。尽管有限元方法、谱方法等等也可以用于解ODE，但是差分法依然更受欢迎。即便是边值问题，基于差分法的打靶法也比有限元更受欢迎。

由于ODE的解行为通常比较好，只要右端项满足一定的Lipschitz连续性，解就存在唯一，对初值参数连续依赖。所以ODE数值方法的特点是[有限差分法](https://www.zhihu.com/search?q=有限差分法&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A154630733})是一种适用面非常广泛的方法。也就是说，如果你是一个工程师，对数值方法并不熟悉。你在实际工作用需要求解一个（规模不太大的）ODE，那么你闭着眼睛把这个方程扔给一个RK4标准程序，效果一般不会太差……

实际应用中ODE数值方法面临的最主要问题是刚性。简单说，如果把方程组理解为一组粒子的运动，那么这些粒子的运动存在时间尺度的分离，而你的数值方法应该要抓住最小的时间尺度，这就意味着超大的计算量。这种问题在分子动力学模拟（MD）中特别常见。本来MD就要计算10^6量级的粒子，再有很强的刚性就会使得模拟几乎无法进行。实际中，无论是从理论上做渐近分析或是平均化（averaging）抑或是数值上构造稳定性条件更加宽松的数值格式都是非常有挑战性的工作。

ODE数值解面对的另一个困难时长时间模拟。再好的数值格式也会有误差，误差总会随着时间积累，时间充分长之后总会让数值解变得不可信。尤其是如果方程的解包含周期结构的时候数值误差很容易在长时间上破坏解的周期性（一个典型的例子是用Euler法求解地球轨道方程，数值解最终会远离太阳而去）。因此一个很有挑战性的问题就是如何在长时间的计算中保持数值解的某种结构，比如说能量守恒。如何构造这种满足特殊要求的数值格式同时还能尽量保持高精度是需要仔细设计的。实际中如果面对超大规模方程的长时间模拟，计算量的限制使得高阶格式都难以应用的时候，其结果的可信度基本属于玄学……

除此之外，ODE数值解还有一些具体的问题。比如说不适定问题的求解、方程在临近分岔时的精确求解等等。总的来说，ODE数值解的领域相对成熟，理论比较完善，有一些可以作为标准方法的解法。实际应用中，可以根据实际问题的特点在这些标准方法上做出改进。

说到PDE数值解，那简直就是天坑……这个领域太大了，即便你说PDE数值解就是全部的计算数学，错的也不算离谱。教授们如果不注意维护自己的个人主页，很容易发现一所高校计算数学系教授的研究兴趣都是偏微分方程数值解……

还是简单说几句好了。从方法构造上，前面@赵永峰 的答案中提到的有限差分法、有限元方法和谱方法确实是最主要的几种方法。有限差分法依然是最基础的。差分法有直观清楚、构造简单、易于编程的优点，对于没有受过专门数值方法训练的工程师来说，差分法依然是最好的选择。精心构造的差分方法可以非常高效。比如在求解流体力学方程的时候，守恒型差分格式有非常成熟的理论和方法。有限差分法的缺点主要是只能用于比较规则的区域，对于复杂区域边界的处理不但困难，而且很容易损失精度，进而影响数值解在全局的精度。

一种改进的方式是有限体积法（Finite Volume Method）。有限体积法的做法是将微分方程写成积分方程，在每一个小区域中用[数值积分](https://www.zhihu.com/search?q=数值积分&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A154630733})来近似精确积分，进而求解方程组。因为数值积分的方法比较灵活，有限体积法对于区域的要求宽松许多，并且可以选择合适的积分法来保持方程的物理性质。缺点则是如果使用较高阶的数值积分方法，那么计算量将非常大，甚至需要求解非线性方程组；而如果使用较低阶的数值积分法，又不如差分法简洁。

差分法的思想是在局部用差商代替微商，这是一个局部的近似。从全局看，差分法相当于用分片常数近似导数，也就是用分片线性函数近似精确解。而分片线性函数在全局其实是不可导的，所以我们通常在连续函数的最大值范数下来考察收敛性。而有限元方法（Finite Element Method）则是用分片多项式来近似精确解，我们不但可以在整体上考虑函数值的收敛性，还可以考虑导数的收敛性。有限元方法的优点在于可以用于不规则的一般区域，原则上可以构造出非常高阶的格式，收敛性和收敛阶有比较成熟的理论，缺点则是有限元的构造比较困难，也不容易写程序。在一些汉译文献中经常混淆有限体积法和[有限元方法](https://www.zhihu.com/search?q=有限元方法&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A154630733})两个术语，需要特别注意。（一个特别有名的例子，LeVeque的名著“Finite Volume Methods for Hyperbolic Problems”就被翻译成了有限元方法……）

谱方法则是一种无网格方法。它不像差分法和有限元那样需要首先将区域做剖分，而是将解按照一组正交基做展开（也就是广义的Fourier展开），截取有限项作为近似，需要求解的是对应的[Fourier系数](https://www.zhihu.com/search?q=Fourier系数&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A154630733})。谱方法的好处是高精度，以及搭配一些快速算法（比如快速Fourier变换）计算速度很快，缺点则是一般只适用于非常规则的区域，并且对边界条件有比较苛刻的限制。此外，将谱方法和有限元方法结合起来的谱元法也是当下比较热门的领域。

可以看到，和ODE不同，PDE数值解没有一种占绝对优势地位的方法乃至于框架。一般来说，我们需要针对不同的方程设计不同的数值方法。所以[PDE方程](https://www.zhihu.com/search?q=PDE方程&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A154630733})的数值求解是一件技术含量比较高的事情。如果你是一个对数值方法不熟悉的工程师，在实际应用中需要求解一个PDE，那么最好还是找一本书简单学习一下。即便是最简单的方程、最简单的差分法，也需要一些知识来设计合适的格式（举两个学生作业中常见的例子，对流方程的差分格式需要满足CFL条件，对流占优的对流扩散方程也需要仔细设计格式来避免数值耗散对解的污染，即便这些方程都是常系数的）。

PDE数值解的困难主要在于PDE的解表现出的行为太丰富了。很多时候，我们对要求解的方程性质都缺少基本的认识，更说不上根据方程的特点设计有效的算法。实际中我们只能针对一类方程来设计一类格式，这一类格式对另一类方程很可能根本就不灵。我们都知道，![[公式]](https://www.zhihu.com/equation?tex=u_%7Bxx%7D%2Bu_%7Byy%7D%3D0) 和![[公式]](https://www.zhihu.com/equation?tex=u_%7Bxx%7D-u_%7Byy%7D%3D0) 一个符号之差就是两种完全不一样的方程。适用于前者的格式根本就解不了后者。

ODE中我们提到的困难对于PDE都存在，比如刚性，比如长时间行为。但是这都不是PDE数值解的主要问题。因为PDE的数值解还远到不了讨论这么精细问题的程度，当务之急还是在有限的计算时间内解出来。对ODE数值解要求4、5阶的精度不算过分，但是PDE数值解能有时空2阶精度就非常令人满意了。

和ODE相比，PDE的数值解更加强调对方程物理性质的保持。因为PDE问题通常都来自物理背景。计算流体力学中要求保持物理量的守恒性，还要能够准确的捕捉激波。既要利用[数值粘性](https://www.zhihu.com/search?q=数值粘性&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A154630733})来避免数值振荡，还要尽量减小数值粘性来保持解的守恒性。这些使得某一种PDE的数值求解都变成一门需要深入研究的学问。泛泛的谈PDE的数值解通常是谈不出什么来的。

PDE数值解的另一个巨大困难就是[维数灾难](https://www.zhihu.com/search?q=维数灾难&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A154630733})（curse of dimensionality）。一般的说，PDE需要求解的未知数数量是随着问题维数指数增加的。这就意味着合理的计算量根本处理不了高维的问题。现今，无论是差分法、有限元还是谱方法，一般都只能处理三维以下的问题。超过三维，如果没有可以利用的对称性，基本可以宣告放弃了。然而高维的PDE求解在统计物理中随处可见。即便要求解[Boltzmann方程](https://www.zhihu.com/search?q=Boltzmann方程&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A154630733})，也是7维的，远远超出了传统方法的能力范围。

对于一类特殊的PDE，我们可以将它视作是某个随机变量的期望，然后利用Monte Carlo方法来计算这个期望。众所周知，Monte Carlo方法的优点就是计算量对维数的增加不敏感，可以针对少量特殊点求解方程而不必在全局解出整个解，可并行化程度高，是求解[高维PDE](https://www.zhihu.com/search?q=高维PDE&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A154630733})的一种很有吸引力的方法。当然，Monte Carlo方法的缺点也很多。比如说收敛慢（通常只有半阶）、精度低、随机误差不可避免、对问题形式要求严苛等等。

总的来说，PDE的求解通常是根据具体问题设计具体方法的，泛泛地说PDE的数值方法很难深入下去。PDE求解的问题和困难非常之多，如果说解ODE的时候闭着眼睛上RK4是个不算糟糕的方案，那么解PDE就一定要对待求解的方程和[数值方法理论](https://www.zhihu.com/search?q=数值方法理论&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A154630733})本身都有基本的认识。

[发布于 2017-03-31 17:10](http://www.zhihu.com/question/56820475/answer/154630733)