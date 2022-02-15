# [RMQ（ST算法）](https://www.cnblogs.com/zyf0163/p/4782133.html)



RMQ（Range Minimum/Maximum Query），即区间最值查询，是指这样一个问题：对于长度为n的数列a，回答若干询问RMQ（A,i,j）(i, j<=n)，返回数列a中下标在i，j之间的最小/大值。如果只有一次询问，那样只有一遍for就可以搞定，但是如果有许多次询问就无法在很快的时间处理出来。在这里介绍一个在线算法。所谓在线算法，是指用户每输入一个查询便马上处理一个查询。该算法一般用较长的时间做预处理，待信息充足以后便可以用较少的时间回答每个查询。ST（Sparse Table）算法是一个非常有名的在线处理RMQ问题的算法，它可以在O(nlogn)时间内进行预处理，然后在O(1)时间内回答每个查询。

步骤如下：

假设a数组为：

1， 3， 6， 7， 4， 2， 5

**1.首先做预处理（以处理区间最小值为例）**

设mn[i][j]表示从第i位开始连续2^j个数中的最小值。例如mn[2][1]为第2位数开始连续2个的数的最小值，即3, 6之间的最小值，即mn[2][1] = 3;

之后我们很容想到递推方程：

**mn[i][j] = min(mn[i][j - 1], mn[i + (1 << j - 1)][j - 1])**

附上伪代码：

```c++
`for``(``int` `j = 0; j < 20; j ++)``    ``for``(``int` `i = 1; i + (1 << j) <= n + 1; i ++)``        ``mn[i][j] = min(mn[i][j - 1], mn[i + (1 << (j - 1))][j - 1]);`
```

咦？为什么第二行是i + （1 << j) <= n + 1呢？因为mn[i][j]表示连续2^j个数，所以mn[i][j]所维护的区间为[i, i + (1 << j) - 1],所以在最后要+1，其实是为了方便，写成i + (1 << j) - 1 <= n感觉左边太长了，所以写在右边了。

那么为什么j要写在外围？如果写在里面的输出结果是这样的

![img](https://images2015.cnblogs.com/blog/727740/201509/727740-20150904182450278-1925666624.png)

我们会发现没有更新过，这是为什么呢？ 因为我们在更新的时候是通过要通过2^(j - 1)的区间来更新2^j的区间，来看状态转移方程：

**mn[i][j] = min(mn[i][j - 1], mn[i + (1 << j - 1)][j - 1])**

我们发现如果j写在里面的话，在更新mn[i][j]的时候会发现mn[i +(1<<j - 1)][j - 1]还没有更新，所以才会出现这样的结果，正确结果如下：

![img](https://images2015.cnblogs.com/blog/727740/201509/727740-20150904183225294-870999263.png)

 

咦？为什么还有0？我们来看伪代码：

```cpp
`for``(``int` `j = 0; j < 20; j ++)``    ``for``(``int` `i = 1; i + (1 << j) <= n + 1; i ++)``        ``mn[i][j] = min(mn[i][j - 1], mn[i + (1 << (j - 1))][j - 1]);`
```

看第二行会发现，对于i + （1  << j) - 1超过n的，我们没有更新，如图中的mn[5][2]，5 + 2^2 - 1 = 8 > 7所以没有更新，但这并不影响询问的结果。

**2.查询**

假设我们需要查询区间[l, r]中的最小值，令k = log2(r - l + 1); 则区间[l, r]的最小值RMQ[l,r] = min(mn[l][k], mn[r - (1 << k) + 1][k]);

那么为什么这样就可以保证为区间最值吗?

mn[l][k]维护的是[l, l + 2 ^ k - 1], mn[r - (1 << k) + 1][k]维护的是[r - 2 ^ k + 1, r] 。

那么我们只要保证r - 2 ^ k + 1 <= l + 2 ^ k - 1就能保证RMQ[l,r] = min(mn[l][k], mn[r - (1 << k) + 1][k])；

我们用分析法来证明下：

若r - 2 ^ k + 1 <= l + 2 ^ k - 1;

则r - l + 2 <= 2 ^ (k + 1);

又因为 k = log2(r - l + 1)；

则r - l + 2 <= 2 *(r - l + 1);

则r - l >= 0;

显然可得。

由此得证。

我们来举个例子 l = 4, r = 6;

此时k = log2(r - l + 1) = log2(3) = 1;

所以RMQ[4, 6] = min(mn[4][1], mn[5][1]);

mn[4][1] = 4, mn[5][1] = 2;

所以RMQ[4, 6] = min(mn[4][1], mn[5][1]) = 2;

我们很容易看出来了答案是正确的。

附上总代码：（以结构体的形式写出）：



```cpp
#include <cstdio>
#include <algorithm>
using namespace std;
const int N = 100000 + 5;

int a[N];

int mn[N][25];

int n, q, l, r;

struct RMQ{
    int log2[N];
    void init(){
        for(int i = 0; i <= n; i ++)log2[i] = (i == 0 ? -1 : log2[i >> 1] + 1);
        for(int j = 1; j < 20; j ++)
            for(int i = 1; i + (1 << j) <= n + 1; i ++)
                mn[i][j] = min(mn[i][j - 1], mn[i + (1 << j - 1)][j - 1]);
    }
    int query(int ql, int qr){
        int k = log2[qr - ql + 1];
        return min(mn[ql][k], mn[qr - (1 << k) + 1][k]);
    }
}rmq;

void work(){
    rmq.init();
    scanf("%d", &q);
    while(q --){
        scanf("%d%d", &l, &r);
        printf("%d\n", rmq.query(l, r));
    }
}

int main(){
    while(scanf("%d", &n) == 1){
        for(int i = 1; i <= n; i ++)scanf("%d", a + i), mn[i][0] = a[i];
        work();
    }
    return 0;
}
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

 

 参考论文：<http://blog.csdn.net/niushuai666/article/details/6624672/>

既然要做，那就好好做! 自己选的路，自己走完!



分类: [区间最值](https://www.cnblogs.com/zyf0163/category/731184.html)