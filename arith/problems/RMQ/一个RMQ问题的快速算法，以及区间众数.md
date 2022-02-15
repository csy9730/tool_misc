# 一个RMQ问题的快速算法，以及区间众数

[![hqztrue](https://pic3.zhimg.com/v2-f2bd7ea527837d49abd5eb655c5ec72e_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/hqztrue)

[hqztrue](https://www.zhihu.com/people/hqztrue)

TCS



180 人赞同了该文章

之前写[这个回答](https://www.zhihu.com/question/300065962/answer/519188661)的时候从电脑里翻出了这个解决RMQ问题的算法。由于年代久远出处记不太清了，框架是受到MODULE 1e9+7在blog里写的 ![[公式]](https://www.zhihu.com/equation?tex=O%28n%5Clog%5E%2A+n%29)-![[公式]](https://www.zhihu.com/equation?tex=O%281%29) RMQ做法启发得到的(现在那个blog页面已经不存在了，还好我本地离线存了一份。大概就是对[1,2]这两篇文章的介绍)。<del>优化到 ![[公式]](https://www.zhihu.com/equation?tex=O%28n%29) 预处理的位运算做法或许是我自己原创的也说不定</del>。

update. 评论区提示这个算法在02年的文章[6]中介绍related results的部分已经被提到过了。所以果然又是重新发明。那么好奇众数的那部分是新的么...？

(原来那个网页的标题叫这个)

![img](https://pic4.zhimg.com/80/v2-bf80aab549994eec655950d98e091d4f_1440w.jpg)

首先回顾一下常见的几种RMQ做法。

1. 线段树。 ![[公式]](https://www.zhihu.com/equation?tex=O%28n%29) - ![[公式]](https://www.zhihu.com/equation?tex=O%28%5Clog+n%29) (这里前一个是预处理复杂度，后一个是单次询问复杂度)，或者 ![[公式]](https://www.zhihu.com/equation?tex=O%28n%5Clog+n%29) - ![[公式]](https://www.zhihu.com/equation?tex=O%281%29) (比如在[5]中有提到。现在好像有的人把这个变种叫作[猫树](https://link.zhihu.com/?target=http%3A//immortalco.blog.uoj.ac/blog/2102))。

\2. ST表。 ![[公式]](https://www.zhihu.com/equation?tex=O%28n%5Clog+n%29) - ![[公式]](https://www.zhihu.com/equation?tex=O%281%29) 。

\3. RMQ转LCA，离线tarjan LCA。 ![[公式]](https://www.zhihu.com/equation?tex=O%28n%5Calpha%28n%29%29) 。(为了方便，这里假设询问数 ![[公式]](https://www.zhihu.com/equation?tex=m) 与 ![[公式]](https://www.zhihu.com/equation?tex=n) 同阶)

update. 最近学到了怎么把tarjan LCA做到 ![[公式]](https://www.zhihu.com/equation?tex=O%28n%29) ，可以看[这里](https://link.zhihu.com/?target=http%3A//ljt12138.blog.uoj.ac/blog/4874)。但目测不好写。

\4. 离线并查集。![[公式]](https://www.zhihu.com/equation?tex=O%28n%5Calpha%28n%29%29) 。本质和上一个类似但不需要显式地和LCA扯上关系。

\5. RMQ转LCA再转±1RMQ。![[公式]](https://www.zhihu.com/equation?tex=O%28n%29) - ![[公式]](https://www.zhihu.com/equation?tex=O%281%29) 。这是大家熟知的那个理论最好的做法，但是常数比较大。

\6. RMQ转LCA，然后用LCA的Schieber Vishkin algorithm(可以在[这里](https://link.zhihu.com/?target=https%3A//blog.csdn.net/kksleric/article/details/7836649)看到相关介绍)。![[公式]](https://www.zhihu.com/equation?tex=O%28n%29) - ![[公式]](https://www.zhihu.com/equation?tex=O%281%29) 。历史上是先有的这个做法，然后出现了方法5，大家认为方法5更[简单](https://link.zhihu.com/?target=https%3A//sarielhp.org/blog/%3Fp%3D1078)。

对于常见数据范围(几十万， ![[公式]](https://www.zhihu.com/equation?tex=n%5Capprox+m) )实际速度最快的应该是方法4，然后是方法1的zkw线段树实现。方法6我没写过，但目测不会比zkw快。我猜BZOJ上跑得最快的那些除了我之外都是方法4。



下面介绍一个实际速度更快的位运算做法，在BZOJ(题号[1699](https://link.zhihu.com/?target=https%3A//www.lydsy.com/JudgeOnline/problem.php%3Fid%3D1699))和poj(题号[3264](https://link.zhihu.com/?target=http%3A//poj.org/problem%3Fid%3D3264))上都是rank1。其实跟方法5有一点像但是不需要归约到LCA问题。

考虑把序列按 ![[公式]](https://www.zhihu.com/equation?tex=B%3D%5CTheta%28%5Clog+n%29) 大小分块，把每个块缩成一个数之后用ST表预处理询问的两端点恰好为块的端点的情况。因为在 ![[公式]](https://www.zhihu.com/equation?tex=O%28%5Cfrac%7Bn%7D%7B%5Clog+n%7D%29) 个数上建ST表，所以预处理的复杂度为 ![[公式]](https://www.zhihu.com/equation?tex=O%28n%29) 。如果询问的一个端点落在某个块的中间，且询问区间与至少两个块相交，那么只需要对每块内预处理前/后缀min就可以 ![[公式]](https://www.zhihu.com/equation?tex=O%281%29) 回答询问。难点在于询问的两端点落在同一块内的情况。方法5的解决方案是对于 ±1RMQ，一共只有 ![[公式]](https://www.zhihu.com/equation?tex=O%282%5EB%29%3DO%28n%5E%7B1-%5Cepsilon%7D%29) 种本质不同的块，所以可以预处理所有可能询问的答案。但这对于一般的RMQ不适用。

在word-RAM model中，一个常见的假设是字长 ![[公式]](https://www.zhihu.com/equation?tex=w%5Cgeq+%5Clog+n) 。现在考虑对每个块从左到右维护递增的单调栈，队列中最多只存放了 ![[公式]](https://www.zhihu.com/equation?tex=O%28%5Clog+n%29) 个数(所对应的块内下标)，可以pack到一个word里。如果我们要询问一块内 ![[公式]](https://www.zhihu.com/equation?tex=l) 到 ![[公式]](https://www.zhihu.com/equation?tex=r) 之间的最小值，只需要求第 ![[公式]](https://www.zhihu.com/equation?tex=r) 个时刻所对应的单调栈中第一个 ![[公式]](https://www.zhihu.com/equation?tex=%5Cgeq+l) 的下标就行。这可以使用__builtin_ctz ![[公式]](https://www.zhihu.com/equation?tex=O%281%29) 计算。(我之前的[一篇文章](https://zhuanlan.zhihu.com/p/70950198)介绍了为什么这个操作在理论上是 ![[公式]](https://www.zhihu.com/equation?tex=O%281%29) 的。另外因为这里 ![[公式]](https://www.zhihu.com/equation?tex=W%3D%5Cmathop%7B%5Cmathrm%7Bpoly%7D%7D%28n%29) ，所以预处理打表也行。)

代码如下：

```cpp
const int N=100105,D_max=18,L=27,inf=1<<30;
int f[N/L][D_max],M[N/L],a[N+L],stack[L+1],n,q,D;
struct node{
    int state[L+1],*a;
    int Qmin(int x,int y){return a[x+__builtin_ctz(state[y]>>x)];}
    void init(int *_a){
        int top=0;a=_a;
        for (int i=1;i<=L;++i){
            state[i]=state[i-1];
            while (top&&a[i]<=a[stack[top]])state[i]-=1<<stack[top],--top;
            stack[++top]=i;state[i]+=1<<i;
        }
    }
}c[N/L];
void build(){
    int nn=n/L;M[0]=-1;
    for (int i=1;i<=nn;++i){
        f[i][0]=inf;for (int j=1;j<=L;++j)f[i][0]=min(f[i][0],a[(i-1)*L+j]);
    }
    for (int i=1;i<=nn;++i)M[i]=!(i&(i-1))?M[i-1]+1:M[i-1];
    for (int j=1;j<=D;++j)
        for (int i=1;i<=nn-(1<<j)+1;++i)f[i][j]=min(f[i][j-1],f[i+(1<<(j-1))][j-1]);
    for (int i=1;i<=nn+1;++i)c[i].init(a+(i-1)*L);
}
inline int Qmin_ST(int x,int y){
    int z=M[y-x+1];return min(f[x][z],f[y-(1<<z)+1][z]);
}
inline int Qmin(int x,int y){
    int xx=(x-1)/L+1,yy=(y-1)/L+1,res;
    if (xx+1<=yy-1)res=Qmin_ST(xx+1,yy-1);else res=inf;
    if (xx==yy)res=min(res,c[xx].Qmin(x-(xx-1)*L,y-(yy-1)*L));
    else res=min(res,c[xx].Qmin(x-(xx-1)*L,L)),res=min(res,c[yy].Qmin(1,y-(yy-1)*L));
    return res;
}
```

(交BZOJ1699的完整代码可以看[这里](https://www.zhihu.com/question/300065962/answer/519188661)。)



我还曾经思考过能不能把这个做法推广到 ![[公式]](https://www.zhihu.com/equation?tex=O%28n%29) - ![[公式]](https://www.zhihu.com/equation?tex=O%281%29) 的静态区间最大子段和询问(或者出现次数严格大于半数的区间众数询问)，但似乎不太行。其中一个区别是对于RMQ我们可以 ![[公式]](https://www.zhihu.com/equation?tex=O%281%29) 合并两个相交区间的答案，而对于后两个问题不行；对于完整包含几个块的情况我们可以把ST表换成猫树，但是处理块内询问看起来不太容易(即使块的大小非常小)。后两个问题的更一般化情况是序列 ![[公式]](https://www.zhihu.com/equation?tex=A%5B1%2C%5Cdots%2Cn%5D) 中的元素为一个半群中的元素(运算为 ![[公式]](https://www.zhihu.com/equation?tex=%5Ccirc) ，有结合律)，然后询问 ![[公式]](https://www.zhihu.com/equation?tex=A%5Bl%5D%5Ccirc%5Cdots%5Ccirc+A%5Br%5D) ，称为semi-group sum problem。对这个一般化的情况[1,2]给了一个 ![[公式]](https://www.zhihu.com/equation?tex=O%28n%5Calpha%28n%29%29) 的做法(对于一般 ![[公式]](https://www.zhihu.com/equation?tex=m) 的话是每次询问![[公式]](https://www.zhihu.com/equation?tex=%5Calpha%28m%2Cn%29) 。p.s. [1]是Yao写的)。对于静态区间最大子段和这个特例，[3]给了一个 ![[公式]](https://www.zhihu.com/equation?tex=O%28n%29) - ![[公式]](https://www.zhihu.com/equation?tex=O%281%29) 的做法，但看起来和本文不是一个思路。

对于出现次数严格大于半数的众数询问的目前最优做法我一下子还没找到。看起来这个领域的paper希望优化的是预处理的空间而不太关心预处理时间，比如[4]可以做到 ![[公式]](https://www.zhihu.com/equation?tex=O%28n%5Clog+n%29) 预处理， ![[公式]](https://www.zhihu.com/equation?tex=O%28n%29) 空间， ![[公式]](https://www.zhihu.com/equation?tex=O%281%29) 询问，当然它做的是一个更一般的情况 ![[公式]](https://www.zhihu.com/equation?tex=%5Calpha) -majority。[8]推广到了动态众数的情况。



update:

## 静态区间众数询问

下面介绍在静态情况下对于出现次数严格大于半数的区间众数询问如何做到![[公式]](https://www.zhihu.com/equation?tex=O%28n%29) - ![[公式]](https://www.zhihu.com/equation?tex=O%281%29)。这也就是LeetCode 1157. Online Majority Element In Subarray的题解：

[Loading...leetcode.com/problems/online-majority-element-in-subarray/![img](https://pic1.zhimg.com/v2-0c435ab948b151fd834be55f80a09794_180x120.jpg)](https://link.zhihu.com/?target=https%3A//leetcode.com/problems/online-majority-element-in-subarray/)

首先考虑不要求检测出答案不存在的情况，即如果询问区间内存在出现次数严格大于半数的众数，则返回那个数，否则可以返回任何值。

就像常见的那个线段树做法一样，我们维护的信息是一个pair(数字，抵消后的出现次数)。比如我们要合并两个信息为 ![[公式]](https://www.zhihu.com/equation?tex=%28v_1%2Cs_1%29) 和 ![[公式]](https://www.zhihu.com/equation?tex=%28v_2%2Cs_2%29) 的区间，若 ![[公式]](https://www.zhihu.com/equation?tex=v_1%3Dv_2) 则合并结果为 ![[公式]](https://www.zhihu.com/equation?tex=%28v_1%2Cs_1%2Bs_2%29) ，否则不妨设 ![[公式]](https://www.zhihu.com/equation?tex=s_1%5Cgeq+s_2) ，合并结果为 ![[公式]](https://www.zhihu.com/equation?tex=%28v_1%2Cs_1-s_2%29) ，表示 ![[公式]](https://www.zhihu.com/equation?tex=v_1)的一部分出现次数和 ![[公式]](https://www.zhihu.com/equation?tex=v_2)抵消了。容易验证我们可以用之前提到的对于半群中元素求区间和的算法维护这个信息。(这里还是有必要详细说明一下：直接套定义的话我们维护的信息是不满足结合律的，但是在存在出现次数严格大于半数的众数的情况下，按任意顺序结合计算，再将答案经过映射 ![[公式]](https://www.zhihu.com/equation?tex=f%3A%28v%2Cs%29%5Cmapsto+v) 得到的结果是唯一的那个众数，所以相当于满足结合律。)

现在我们还是把序列按 ![[公式]](https://www.zhihu.com/equation?tex=B%3D%5CTheta%28%5Clog+n%29) 大小分块，对于完整包含几块的询问，可以把ST表换成猫树，复杂度不变。那么只需要处理询问区间完整包含在一个长度为 ![[公式]](https://www.zhihu.com/equation?tex=%5CTheta%28%5Clog+n%29) 的块内的情况。将这个算法递归一层，即按 ![[公式]](https://www.zhihu.com/equation?tex=B%27%3D%5CTheta%28%5Clog+%5Clog+n%29) 大小再分块，那么只需要处理询问区间完整包含在一个长度为 ![[公式]](https://www.zhihu.com/equation?tex=%5CTheta%28%5Clog+%5Clog+n%29) 的小块内的情况。将块内数字离散化后只有 ![[公式]](https://www.zhihu.com/equation?tex=%28%5Clog%5Clog+n%29%5E%7B%5CTheta%28%5Clog%5Clog+n%29%7D) 种本质不同的块，对每个块有 ![[公式]](https://www.zhihu.com/equation?tex=O%28%28%5Clog%5Clog+n%29%5E2%29) 种可能的询问，所以可以预处理答案然后 ![[公式]](https://www.zhihu.com/equation?tex=O%281%29) 回答。

p.s. 这里比一般半群的情况复杂度更好的原因是，当询问区间足够小的时候我们可以根据问题的特殊性质直接做到 ![[公式]](https://www.zhihu.com/equation?tex=O%281%29) 。这个做法对最大子段和不work的原因是虽然当 ![[公式]](https://www.zhihu.com/equation?tex=B%27) 足够小时本质不同的块数可以不超过 ![[公式]](https://www.zhihu.com/equation?tex=O%28n%5E%7B1-%5Cepsilon%7D%29) ，但是不容易在 ![[公式]](https://www.zhihu.com/equation?tex=O%28B%27%29) 的时间内识别出每块属于哪种本质不同的情况。

现在考虑如何检验我们得到的候选数 ![[公式]](https://www.zhihu.com/equation?tex=v) 是否真的在询问区间![[公式]](https://www.zhihu.com/equation?tex=%5Bl%2Cr%5D)内出现了半数以上。不妨直接统计 ![[公式]](https://www.zhihu.com/equation?tex=v) 在区间内的出现次数。令![[公式]](https://www.zhihu.com/equation?tex=s_v%5Bi%5D) 表示数 ![[公式]](https://www.zhihu.com/equation?tex=v) 在区间![[公式]](https://www.zhihu.com/equation?tex=%5B1%2Ci%5D) 中的出现次数，我们只需要知道 ![[公式]](https://www.zhihu.com/equation?tex=s_v%5Br%5D-s_v%5Bl-1%5D) 。问题是如何在预处理时快速计算 ![[公式]](https://www.zhihu.com/equation?tex=s_v%5B%5Ccdot%5D) (不需要也没法对全部下标都算)。

Lemma 1. 如果数 ![[公式]](https://www.zhihu.com/equation?tex=v) 在整个数组中一共出现了 ![[公式]](https://www.zhihu.com/equation?tex=t) 次，那么把所有存在严格众数且为 ![[公式]](https://www.zhihu.com/equation?tex=v) 的区间 ![[公式]](https://www.zhihu.com/equation?tex=%5Bl%27%2Cr%27%5D) 拿出来取并集，并集最多覆盖了 ![[公式]](https://www.zhihu.com/equation?tex=O%28t%29) 个数组中的元素。

Proof. 考虑那个(大家或许见过的)求区间并的贪心算法，归纳假设是已经求出了并集在 ![[公式]](https://www.zhihu.com/equation?tex=%5B1%2Ci%5D) 中的部分，每次在未被当前并集完整包含的区间中找到左端点 ![[公式]](https://www.zhihu.com/equation?tex=%5Cleq+i) ，右端点最大的一个区间，和当前的并集取并。如果找不到左端点 ![[公式]](https://www.zhihu.com/equation?tex=%5Cleq+i) 的区间则取左端点最小(且右端点最大)的区间。这样我们可以用一部分区间的并表示并集，且每个元素最多被覆盖2次。接下来令 ![[公式]](https://www.zhihu.com/equation?tex=x_i%5Cin+%5C%7B0%2C1%5C%7D) 表示数组的第 ![[公式]](https://www.zhihu.com/equation?tex=i) 个元素是否为 ![[公式]](https://www.zhihu.com/equation?tex=v) ，用线性规划写一系列不等式就能得证。

Lemma 2. 我们可以在 ![[公式]](https://www.zhihu.com/equation?tex=O%28t%29) 的时间内求出这个并集。

Algorithm. 不妨假设所有数 ![[公式]](https://www.zhihu.com/equation?tex=v) 的出现位置已经按顺序存在一个数组中。对于每个下标 ![[公式]](https://www.zhihu.com/equation?tex=k) ，我们希望计算 ![[公式]](https://www.zhihu.com/equation?tex=k) 是否在并集中，这当且仅当存在 ![[公式]](https://www.zhihu.com/equation?tex=i%3Ck) ， ![[公式]](https://www.zhihu.com/equation?tex=j%5Cgeq+k) 且 ![[公式]](https://www.zhihu.com/equation?tex=s_v%5Bj%5D-s_v%5Bi%5D%5Cgeq+%28j-i%29%2F2) ，即 ![[公式]](https://www.zhihu.com/equation?tex=2s_v%5Bj%5D-j%5Cgeq+2s_v%5Bi%5D-i) (为了简单，这里我们忽略取整的细节)。那么我们只需要维护一下 ![[公式]](https://www.zhihu.com/equation?tex=2s_v%5Bi%5D-i) 的前后缀min/max就行。可以发现有意义的 ![[公式]](https://www.zhihu.com/equation?tex=k) 最多只有 ![[公式]](https://www.zhihu.com/equation?tex=O%28t%29) 个。

现在对于数 ![[公式]](https://www.zhihu.com/equation?tex=v) ，我们只需要预处理计算下标在并集中的 ![[公式]](https://www.zhihu.com/equation?tex=s_v%5B%5Ccdot%5D) ，直接算就行。对于所有数 ![[公式]](https://www.zhihu.com/equation?tex=v) 所需复杂度的和是 ![[公式]](https://www.zhihu.com/equation?tex=O%28n%29) 的。询问时若某个需要的![[公式]](https://www.zhihu.com/equation?tex=s_v%5B%5Ccdot%5D)未被预先计算则说明一定不存在严格众数。



References:

[1] Yao A C. Space-time tradeoff for answering range queries[C]//Proceedings of the fourteenth annual ACM symposium on Theory of computing. ACM, 1982: 128-136.

[2] Alon N, Schieber B. Optimal preprocessing for answering on-line product queries[M]. Tel-Aviv University. The Moise and Frida Eskenasy Institute of Computer Sciences, 1987.

[3] Chen K Y, Chao K M. On the range maximum-sum segment query problem[C]//International Symposium on Algorithms and Computation. Springer, Berlin, Heidelberg, 2004: 294-305.

[4] Durocher S, He M, Munro J I, et al. Range majority in constant time and linear space[C]//International Colloquium on Automata, Languages, and Programming. Springer, Berlin, Heidelberg, 2011: 244-255.

[5] Yuan H, Atallah M J. Data structures for range minimum queries in multidimensional arrays[C]//Proceedings of the twenty-first annual ACM-SIAM symposium on Discrete Algorithms. Society for Industrial and Applied Mathematics, 2010: 150-160.

[6] Alstrup S, Gavoille C, Kaplan H, et al. Nearest common ancestors: a survey and a new distributed algorithm[C]//Proceedings of the fourteenth annual ACM symposium on Parallel algorithms and architectures. ACM, 2002: 258-264.

[7] Navarro G, Thankachan S V. Optimal encodings for range majority queries[J]. Algorithmica, 2016, 74(3): 1082-1098.

[8] Elmasry A, He M, Munro J I, et al. Dynamic range majority data structures[C]//International Symposium on Algorithms and Computation. Springer, Berlin, Heidelberg, 2011: 150-159.

编辑于 2021-02-28 10:27

OI（信息学奥林匹克）

算法

ACM 竞赛