# 随机算法一(Randomized Algorithm)--蒙特卡洛算法

[![佩伯军士](https://pic2.zhimg.com/v2-a8fd0071ea4b192d8affb544ce7f7fed_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/lianhuilin)

[佩伯军士](https://www.zhihu.com/people/lianhuilin)

在校小学生



44 人赞同了该文章

> **随机化算法**是在算法中使用了随机函数，且随机函数的返回值直接或者间接的影响了算法的执行流程或执行结果。

以上是百度百科给出的随机化算法解释。通俗的说，就是在算法执行的某个步骤中将生成随机数，而该随机数将会影响到整个算法的最终结果。因此，我们可以将随机算法大致分为以下两类：

- **蒙特卡洛算法(Monte Carlo)**
- **拉斯维加斯算法(Las Vegas)**

## 蒙特卡洛算法

蒙特卡洛算法并不是一种具体的算法，而是一类算法的统称。其基本思想是基于随机事件出现的概率。蒙特卡洛算法得到的最终结果并不一定是正确的，我们可以通过计算算法出错的概率值，然后进行多次求解，使得最终得到正确结果的可能性变得很高。接下来我们来讨论一种蒙特卡洛算法：

------

**弗里瓦德算法(Frievald's Algorithm)**

> **问题模型** 对于任意三个 ![[公式]](https://www.zhihu.com/equation?tex=n%5Ctimes+n) 的矩阵 ![[公式]](https://www.zhihu.com/equation?tex=A%2C+B%2C+C) , 我们需要检测出 ![[公式]](https://www.zhihu.com/equation?tex=A+%5Ctimes+B) 是否与 ![[公式]](https://www.zhihu.com/equation?tex=C) 相等。

问题本身十分简单，通常的做法是将A与B进行矩阵的乘法运算，并将结果与C进行比较。然而矩阵的乘法运算本身是比较费时的，t所需要的时间复杂度为 ![[公式]](https://www.zhihu.com/equation?tex=O%28n%5E3%29) ，即使使用复杂的施特拉森算法(Strassen Algorithm)也需要 ![[公式]](https://www.zhihu.com/equation?tex=O%28n%5E%7Blog_2+7%7D%29) 的时间复杂度。对于该问题，我们并不需要计算出 ![[公式]](https://www.zhihu.com/equation?tex=AB) 的具体数值，因此通过随机算法能够很容易的将求解的时间复杂度降为 ![[公式]](https://www.zhihu.com/equation?tex=O%28n%5E2%29) ，再配合多次求解，从而使得算法的正确性也得以提高。

------

> **算法步骤**

1. 从0和1中随机取 n 次，组成一个长度为 n 的列向量 ![[公式]](https://www.zhihu.com/equation?tex=+%5Cvec+r)
2. 判断 ![[公式]](https://www.zhihu.com/equation?tex=A%28B%5Cvec+r%29) 与 ![[公式]](https://www.zhihu.com/equation?tex=C%5Cvec+r) 是否相等，即 ![[公式]](https://www.zhihu.com/equation?tex=A%28B%5Cvec+r%29-C%5Cvec+r%3D0)
3. 若相等，则认为 ![[公式]](https://www.zhihu.com/equation?tex=A+%5Ctimes+B+%3D+C) ,并在屏幕上输出‘YES’，否则我们可认为 ![[公式]](https://www.zhihu.com/equation?tex=A+%5Ctimes+B+%5Cneq+C)

> **算法分析**

算法步骤本身十分简单，但其分析过程值得我们去思考。我们首先对算法的时间复杂度进行分析，考虑一个 n 维矩阵 A 与一个 n 维列向量 r 相乘：

![[公式]](https://www.zhihu.com/equation?tex=%5Cbegin%7Bpmatrix%7D+a_%7B11%7D%26a_%7B12%7D%26%5Ccdots%26a_%7B1n%7D%5C%5C+a_%7B21%7D%26a_%7B22%7D%26%5Ccdots%26a_%7B2n%7D%5C%5C+%5Cvdots%26%5Cvdots%26%5Cddots%26%5Cvdots%5C%5C+a_%7Bn1%7D%26a_%7Bn2%7D%26%5Ccdots%26a_%7Bnn%7D%5C%5C+%5Cend%7Bpmatrix%7D+%5Cbegin%7Bpmatrix%7D+r_%7B11%7D%5C%5C+r_%7B21%7D%5C%5C+%5Cvdots%5C%5C+r_%7Bn1%7D%5C%5C+%5Cend%7Bpmatrix%7D%3D+%5Cbegin%7Bpmatrix%7D+c_%7B11%7D%5C%5C+c_%7B21%7D%5C%5C+%5Cvdots%5C%5C+c_%7Bn1%7D%5C%5C+%5Cend%7Bpmatrix%7D+%5C%5C)

最终的结果将是个 ![[公式]](https://www.zhihu.com/equation?tex=n%5Ctimes1) 的列向量，因此该运算过程的时间复杂度是 ![[公式]](https://www.zhihu.com/equation?tex=O%28n%5E2%29) ，对于上述算法，其关键步骤在于第二步的矩阵运算，其涉及到3次n维矩阵与n维列向量的乘法运算,以及1次减法运算。因此总的时间复杂度为 ![[公式]](https://www.zhihu.com/equation?tex=O%283n%5E2%29%2BO%28n%29%3DO%28n%5E2%29) 。

接着我们来考虑该算法的正确性，对于算法的第二步我们可以对其进行分解：

![[公式]](https://www.zhihu.com/equation?tex=A%28B%5Cvec+r%29-C%5Cvec+r%3D%28AB%29%5Cvec+r-C%5Cvec+r%3D%28AB-C%29%5Cvec+r%5C%5C) 因此当 ![[公式]](https://www.zhihu.com/equation?tex=A%28B%5Cvec+r%29-C%5Cvec+r+%3D+0) 时，我们可以**近似**的认为 ![[公式]](https://www.zhihu.com/equation?tex=AB+-+C+%3D+0) ，但这并不总是正确的，由于矩阵乘法并不具备消去率，因此我们只能从 ![[公式]](https://www.zhihu.com/equation?tex=AB+%3D+C+%5Crightarrow+AB%5Cvec+r+%3D+C%5Cvec+r) ，即该性质只具备充分关系，而没有必要关系。我们来看下面两个例子：

![img](https://pic1.zhimg.com/80/v2-74f7b35f4a0bcedadc9d4cf691f68cb4_1440w.jpg)例1

![img](https://pic3.zhimg.com/80/v2-8e9df5e478ed64fdc2ec9f3272dca932_1440w.jpg)例2

很明显对于第一个例子，算法判断出错了。根据问题的不同，我们可以将算法的执行分成下面两种情况：

- 如果 ![[公式]](https://www.zhihu.com/equation?tex=A+%5Ctimes+B+%3D+C) ，那么执行的结果一定是正确， ![[公式]](https://www.zhihu.com/equation?tex=P%28output%3DYES%29%3D1)
- 如果 ![[公式]](https://www.zhihu.com/equation?tex=A+%5Ctimes+B+%5Cneq+C) ，那么执行的结果有可能是错误的，![[公式]](https://www.zhihu.com/equation?tex=P%28output%3DYES%29%5Cle%7B1%5Cover+2%7D) ，即出错的可能性 ![[公式]](https://www.zhihu.com/equation?tex=%5Cle+%7B1%5Cover+2%7D) ，我们会对这一概率进行具体分析。

对于第一种情况，由矩阵乘法的性质，很显然是正确的。而第二种情况我们将基于随机算法的特点对其进行分析，这将是整个算法的重点与难点所在,接下来我们将证明第二种情况算法执行正确的概率 ![[公式]](https://www.zhihu.com/equation?tex=%5Cge+%7B1%5Cover+2%7D) 。

------

以下为算法概率的证明部分，对理解随机算法的概念很有帮助。若只需了解算法，则这部分可以略过。

> 证明：当 ![[公式]](https://www.zhihu.com/equation?tex=AB+%5Cneq+C) 时， ![[公式]](https://www.zhihu.com/equation?tex=P%28AB+%5Cvec+r+%5Cneq+C+%5Cvec+r%29+%5Cge+%7B1+%5Cover+2%7D) .
> 令 ![[公式]](https://www.zhihu.com/equation?tex=D+%3D+AB-C) ，原证明等价于当 ![[公式]](https://www.zhihu.com/equation?tex=D+%5Cneq+0) 时， ![[公式]](https://www.zhihu.com/equation?tex=P%28D%5Cvec+r+%5Cneq+0%29+%5Cge+%7B1+%5Cover+2%7D) 。假设 ![[公式]](https://www.zhihu.com/equation?tex=R) 为所有能使得 ![[公式]](https://www.zhihu.com/equation?tex=D%5Cvec+r+%3D+0) 的 ![[公式]](https://www.zhihu.com/equation?tex=%5Cvec+r) 集合，我们的目标是要找出符合这样的 ![[公式]](https://www.zhihu.com/equation?tex=%5Cvec+r) 的数量。
> ![[公式]](https://www.zhihu.com/equation?tex=D+%3D+AB-C+%5Cneq+0+%5CRightarrow+%5Cexists+i%2Cj) ，使得 ![[公式]](https://www.zhihu.com/equation?tex=d_%7Bij%7D+%5Cneq+0) ，令向量 ![[公式]](https://www.zhihu.com/equation?tex=%5Cvec+v) 为除了 ![[公式]](https://www.zhihu.com/equation?tex=v_%7Bi%7D+%3D+1) ，其余行全为 ![[公式]](https://www.zhihu.com/equation?tex=0) 的列向量，则： ![[公式]](https://www.zhihu.com/equation?tex=D%5Ctimes+%5Cvec+v%3D+%5Cbegin%7Bpmatrix%7D+d_%7B11%7D%26%5Ccdots%26d_%7B1j%7D%26%5Ccdots%26d_%7B1n%7D%5C%5C+d_%7B21%7D%26%5Ccdots%26d_%7B2j%7D%26%5Ccdots%26d_%7B2n%7D%5C%5C+%5Cvdots%26%5Cddots%26%5Cvdots%26%5Cddots%26%5Cvdots%5C%5C+d_%7Bi1%7D%26%5Ccdots%26d_%7Bij%7D%26%5Ccdots%26d_%7B1n%7D%5C%5C+%5Cvdots%26%5Cddots%26%5Cvdots%26%5Cddots%26%5Cvdots%5C%5C+d_%7Bn1%7D%26d_%7Bn2%7D%26d_%7Bn2%7D%26d_%7B1n%7D%26d_%7Bnn%7D%5C%5C+%5Cend%7Bpmatrix%7D+%5Cbegin%7Bpmatrix%7D+0%5C%5C+0%5C%5C+%5Cvdots%5C%5C+1%5C%5C+%5Cvdots%5C%5C+0%5C%5C+%5Cend%7Bpmatrix%7D%3D+%5Cbegin%7Bpmatrix%7D+d_%7B1j%7D%5C%5C+d_%7B2j%7D%5C%5C+%5Cvdots%5C%5C+d_%7Bij%7D%5C%5C+%5Cvdots%5C%5C+d_%7Bnj%7D%5C%5C+%5Cend%7Bpmatrix%7D%5C%5C)![[公式]](https://www.zhihu.com/equation?tex=%28D%5Cvec+v%29i+%3D+d%7Bij%7D+%5Cneq+0+%5CRightarrow+D+%5Cvec+v+%5Cneq+0) ，对于 ![[公式]](https://www.zhihu.com/equation?tex=%5Cforall+%5Cvec+r_k+%5Cin+R) ，均有 ![[公式]](https://www.zhihu.com/equation?tex=D%5Cvec+r_k+%3D+0) 。我们根据 ![[公式]](https://www.zhihu.com/equation?tex=%5Cvec+r_k) 第 ![[公式]](https://www.zhihu.com/equation?tex=i) 行的数值是 ![[公式]](https://www.zhihu.com/equation?tex=0) 还是 ![[公式]](https://www.zhihu.com/equation?tex=1) ，令： ![[公式]](https://www.zhihu.com/equation?tex=%5Cvec+r%27+%3D+%5Cvec+r_k+%2B+%5Cvec+v+%E6%88%96+%5Cvec+r%27+%3D+%5Cvec+r_k+-+%5Cvec+v%5C%5C) ![[公式]](https://www.zhihu.com/equation?tex=D%5Cvec+r%27%3DD%28%5Cvec+r_k+%2B+%5Cvec+v%29%3DD%5Cvec+r_k+%2B+D%5Cvec+v+%3D+D%5Cvec+v+%5Cneq+0) ，减法同理。其中 ![[公式]](https://www.zhihu.com/equation?tex=%5Cvec+r_k) 是随机生成的能使的我们算法出错的向量，而 ![[公式]](https://www.zhihu.com/equation?tex=%5Cvec+r%27) 是使得算法正确的向量，并且 ![[公式]](https://www.zhihu.com/equation?tex=%5Cvec+r_k) 与 ![[公式]](https://www.zhihu.com/equation?tex=%5Cvec+r%27) 的差别只在第 ![[公式]](https://www.zhihu.com/equation?tex=i) 行。
> 也就是说，对于 ![[公式]](https://www.zhihu.com/equation?tex=AB+%5Cneq+C) 这种情况来说，每当有一个随机产生的能使我们算法出错的向量 ![[公式]](https://www.zhihu.com/equation?tex=%5Cvec+r_k) ， 我们均能找到一个与之对应的能使算法正确的向量 ![[公式]](https://www.zhihu.com/equation?tex=%5Cvec+r%27) 。所以：![[公式]](https://www.zhihu.com/equation?tex=%5Cvec+r%27%E7%9A%84%E6%95%B0%E9%87%8F+%5Cge+%5Cvec+r_k%E7%9A%84%E6%95%B0%E9%87%8F%5C%5C) 所以在第二种情况下算法执行正确的概率 ![[公式]](https://www.zhihu.com/equation?tex=%5Cge+%7B1+%5Cover+2%7D) ，证得： ![[公式]](https://www.zhihu.com/equation?tex=P%28AB+%5Cvec+r+%5Cneq+C+%5Cvec+r%29+%5Cge+%7B1+%5Cover+2%7D)

综合以上的分析，在第一种情况下，我们的算法能够正确的进行矩阵乘积检查；而即使在第二种情况下，算法执行正确的概率也 ![[公式]](https://www.zhihu.com/equation?tex=%5Cge+%7B1+%5Cover+2%7D) 。在实际的应用中，我们只需多次执行该算法，就能基本达到每次执行结果均为正确。以上就是蒙特卡洛的一个例子。

以上内容参考自 MIT 6.046J。

编辑于 2019-09-08 13:54

算法

算法分析

MIT 公开课程