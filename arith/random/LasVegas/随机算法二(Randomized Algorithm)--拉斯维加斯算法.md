# 随机算法二(Randomized Algorithm)--拉斯维加斯算法

[![佩伯军士](https://pic1.zhimg.com/v2-a8fd0071ea4b192d8affb544ce7f7fed_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/lianhuilin)

[佩伯军士](https://www.zhihu.com/people/lianhuilin)

在校小学生



14 人赞同了该文章

**拉斯维加斯算法 (Las Vegas)** 是另一种随机算法，因此它具备随机算法最为重要的特征之一 —— **基于随机数进行求解**。与 [蒙特卡洛算法 (Monte Carlo)](https://zhuanlan.zhihu.com/p/80629756) 一样，拉斯维加斯算法也不是一种具体的算法，而是一种思想。但不同的是，拉斯维加斯算法在生成随机值的环节中，会不断的进行尝试，直到生成的随机值令自己满意。在这过程中也许会一直无法产生这样的随机值，因此拉斯维加斯算法的时间效率通常比蒙特卡洛算法来的低，并且最终可能无法得到问题的解，但是一旦算法找到一个解，那么这个解一定是问题的正确解。

**快速排序**是一种经典的排序算法，其所需要的辅助空间通常比相同规模的的归并排序来的少。但是传统的快速排序存在一个问题，即排序的时间复杂度不稳定，我们应用拉斯维加斯算法的思想改进快速排序，得到一种**随机快速排序算法**，能使得快速排序算法的时间复杂度稳定在![[公式]](https://www.zhihu.com/equation?tex=O%28n%5C%2Clog%5C%2Cn%29) 。

------

### 传统快速排序

在这之前，我们先来复习下传统的快速排序算法，传统快速排序算法通常分为两个步骤：

1. **分 (Divide)：**从无序数组 ![[公式]](https://www.zhihu.com/equation?tex=A) 中选择一个枢轴 (pivot) ![[公式]](https://www.zhihu.com/equation?tex=x) ，将 ![[公式]](https://www.zhihu.com/equation?tex=A) 分成两个子数组 ![[公式]](https://www.zhihu.com/equation?tex=L) 和 ![[公式]](https://www.zhihu.com/equation?tex=R) 。其中 ![[公式]](https://www.zhihu.com/equation?tex=L%3D%5Clbrace+L_i%7CL_i+%3C+x%5Cland+L_i%5Cin+A+%5Crbrace) ， ![[公式]](https://www.zhihu.com/equation?tex=R%3D%5Clbrace+R_i%7CR_i+%3E+x%5Cland+R_i%5Cin+A+%5Crbrace) 。
2. **治 (Conquer)：**分别对 ![[公式]](https://www.zhihu.com/equation?tex=L) 和 ![[公式]](https://www.zhihu.com/equation?tex=R) 递归的重复上述步骤，直到数组有序。

整个算法的关键在于枢轴的选择，传统的快速排序算法通常以 ![[公式]](https://www.zhihu.com/equation?tex=A%5B0%5D) 作为枢轴，即数组的第一个元素，下面是传统快速排序一次**分割 (partition)** 后的结果：

![img](https://pic2.zhimg.com/80/v2-5e9609e01630aeeea6514ce2d91ee235_1440w.jpg)数组A

![img](https://pic2.zhimg.com/80/v2-2ef82090df86e70a327d914fde46b155_1440w.jpg)一次分割

我们通过递归处理 ![[公式]](https://www.zhihu.com/equation?tex=L) 和 ![[公式]](https://www.zhihu.com/equation?tex=R) 数组，最终将得到一个完全有序的数组。快速排序是分治法的一个典型应用，每次分割都要完整的扫描一遍数组，所以一次分割所需要的时间复杂度为 ![[公式]](https://www.zhihu.com/equation?tex=O%28n%29) 。分割的结果是得到两个规模较小的子问题。在最坏的情况下，每次选择的枢轴都是数组中最大的元素，算法时间复杂度的递归式为：

![[公式]](https://www.zhihu.com/equation?tex=+%5Cbegin%7Baligned%7D+T%28n%29%3D%26T%280%29%2BT%28n-1%29%2BO%28n%29%5C%5C+%3D%26O%281%29%2BT%28n-1%29%2BO%28n%29%5C%5C++%3D%26O%28n%5E2%29%5C%5C+%5Cend%7Baligned%7D+%5C%5C)

从上面的分析我们可以很明显的看出，整个算法的时间复杂度与我们所需要执行的**分割次数**密切相关，每次分割我们都要尽可能使得 ![[公式]](https://www.zhihu.com/equation?tex=L) 和 ![[公式]](https://www.zhihu.com/equation?tex=R) 的规模相等，这样就能都大大降低我们分割的次数。一种可行的办法是优化枢轴的选择，在执行分割前找出待排序数组的中值，这样就能确保分割后的两个子问题规模相等。通过中值查找算法，我们能够在 ![[公式]](https://www.zhihu.com/equation?tex=O%28n%29) 的时间复杂度内找到数组的中值（这边不详细叙述该算法）。这样算法的时间复杂度递归式就变为：

![[公式]](https://www.zhihu.com/equation?tex=%5Cbegin%7Baligned%7D+T%28n%29%3D%262T%28%7Bn+%5Cover+2%7D%29%2BO%28n%29%2BO%28n%29%5C%5C+%3D%26O%28n%5C%2Clog%5C%2Cn%29%5C%5C+%5Cend%7Baligned%7D%5C%5C)

其中第一个 ![[公式]](https://www.zhihu.com/equation?tex=O%28n%29) 为查找中值所消耗的时间，第二个 ![[公式]](https://www.zhihu.com/equation?tex=O%28n%29) 为分割数组所消耗的时间，使用**主方法 (master method)** 我们可以很容易的计算该递归式。

------

### 随机快速排序

上述优化虽然在理论上达到了 ![[公式]](https://www.zhihu.com/equation?tex=O%28n%5C%2Clog%5C%2Cn%29) 的时间复杂度，但由于中值查找算法时间复杂度前的常系数很大，因此在实际应用中，算法的表现效果仍然差于归并排序。随机快速排序是对快速排序的另一种优化，接下来我们来看下它的算法步骤：

1. 从数组 ![[公式]](https://www.zhihu.com/equation?tex=A) 中随机选择一个元素 ![[公式]](https://www.zhihu.com/equation?tex=x) 作为枢轴，数组 ![[公式]](https://www.zhihu.com/equation?tex=A) 分成两个子数组 ![[公式]](https://www.zhihu.com/equation?tex=L) 和 ![[公式]](https://www.zhihu.com/equation?tex=R) 。其中 ![[公式]](https://www.zhihu.com/equation?tex=L%3D%5Clbrace+L_i%7CL_i+%3C+x%5Cland+L_i%5Cin+A+%5Crbrace%24%EF%BC%8C%24R%3D%5Clbrace+R_i%7CR_i+%3E+x%5Cland+R_i%5Cin+A+%5Crbrace) 。
2. 当 ![[公式]](https://www.zhihu.com/equation?tex=%7CL%7C%5Cle+%7B3+%5Cover+4%7D%7CA%7C) 并且 ![[公式]](https://www.zhihu.com/equation?tex=%7CR%7C%5Cle+%7B3+%5Cover+4%7D%7CA%7C) 时，我们继续执行算法，递归处理 ![[公式]](https://www.zhihu.com/equation?tex=L) 和 ![[公式]](https://www.zhihu.com/equation?tex=R) 。否则回到步骤1，重新选择一个枢轴。

算法同样是对枢轴的选择进行了优化，但并没采取中值查找，而是随机选择出一个枢轴，同时该枢轴还要满足特定条件。我们来重点分析该算法的时间复杂度：

在这之前，首先来定义“好枢轴”和“坏枢轴”的概念：

- **好枢轴：**能满足条件 ![[公式]](https://www.zhihu.com/equation?tex=L) 和 ![[公式]](https://www.zhihu.com/equation?tex=R) 都 ![[公式]](https://www.zhihu.com/equation?tex=%5Cle+%7B3+%5Cover+4%7Dn) 的枢轴
- **坏枢轴：**不能满足条件 ![[公式]](https://www.zhihu.com/equation?tex=L) 和 ![[公式]](https://www.zhihu.com/equation?tex=R) 都 ![[公式]](https://www.zhihu.com/equation?tex=%5Cle+%7B3+%5Cover+4%7Dn) 的枢轴

对于任意一个子问题，“好枢轴”都分布在中间的那部分

![img](https://pic2.zhimg.com/80/v2-63729509cd50c0711b77da16c613e0b1_1440w.jpg)

也就是说， ![[公式]](https://www.zhihu.com/equation?tex=P) **(选择到好枢轴)** ![[公式]](https://www.zhihu.com/equation?tex=%3E%7B1%5Cover2%7D) ，这样的话我们处理每个子问题时选择枢轴的次数的期望值将小于2，即 ![[公式]](https://www.zhihu.com/equation?tex=E) **(选择枢轴次数)** ![[公式]](https://www.zhihu.com/equation?tex=%3C2) 。可以类比投掷硬币， ![[公式]](https://www.zhihu.com/equation?tex=P) **(正面)** ![[公式]](https://www.zhihu.com/equation?tex=%3D%7B1%5Cover+2%7D) ，所以在理想的情况下通常我们投掷两次硬币就会出现一次正面。算法在最坏的情况下每次随机选择到的好枢轴都正好是最小或者最大的那个，这样算法时间复杂度的递归式就可以表示为：

![[公式]](https://www.zhihu.com/equation?tex=%5Cbegin%7Baligned%7D+T%28n%29%5Cle%26T%28%7Bn%5Cover+4%7D%29%2BT%28%7B3n%5Cover+4%7D%29%2BE%28iterations%5C+time%29O%28n%29%5C%5C+%3D%26T%28%7Bn%5Cover+4%7D%29%2BT%28%7B3n%5Cover+4%7D%29%2B2cn%5C%5C+%5Cend%7Baligned%7D%5C%5C)

这个递归式无法通过主方法(master method)进行求解，我们使用画递归树的方法求解：

![img](https://pic1.zhimg.com/80/v2-c1110a4dc76df853f876daa59cde2738_1440w.jpg)递归树

对于每个子问题，分割(partition)所需要的时间复杂度为 ![[公式]](https://www.zhihu.com/equation?tex=2%5C%2CO%28N%29) ，其中 ![[公式]](https://www.zhihu.com/equation?tex=N) 为问题的规模，随着分割的深入 ![[公式]](https://www.zhihu.com/equation?tex=N) 不断缩小。假设分割的时间复杂度前的常系数为 ![[公式]](https://www.zhihu.com/equation?tex=c) ，则 ![[公式]](https://www.zhihu.com/equation?tex=2%5C%2CO%28N%29%3D2cN) 。由于每次分割后子问题的规模大小不一致，所以递归树不同分支的深度不一样，沿 ![[公式]](https://www.zhihu.com/equation?tex=3%5Cover+4) （最右边）分支一直下去的那条路径最长，深度为 ![[公式]](https://www.zhihu.com/equation?tex=log_%7B4%5Cover+3%7D+2cn) ，同时相同层次的时间和总为 ![[公式]](https://www.zhihu.com/equation?tex=2cn) ，因此算法的期望时间复杂度为：

![[公式]](https://www.zhihu.com/equation?tex=%5Cbegin%7Baligned%7D+T%28n%29%5Cle%262cn%5Ctimes+log_%7B4%5Cover+3%7D+2cn%5C%5C+%3D%26O%28n%5C%2Clog%5C%2Cn%29%5C%5C+%5Cend%7Baligned%7D%5C%5C) 这样我们就使算法的期望时间复杂度达到了 ![[公式]](https://www.zhihu.com/equation?tex=O%28n%5C%2Clog%5C%2Cn%29) 。



以上内容参考自 MIT 6.046J。

发布于 2019-09-08 13:57

算法

编程

算法与数据结构