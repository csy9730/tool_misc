# [RMQ问题(线段树算法，ST算法优化)](https://www.cnblogs.com/ECJTUACM-873284962/p/6613342.html)
![返回主页](https://www.cnblogs.com/skins/custom/images/logo.gif)

# [Angel_Kitty](https://www.cnblogs.com/ECJTUACM-873284962/)

## 我很弱，但是我要坚强！绝不让那些为我付出过的人失望！



[Return Top](https://www.cnblogs.com/ECJTUACM-873284962/p/6613342.html#_labelTop)

## RMQ (Range Minimum/Maximum Query)问题是指：

对于长度为n的数列A，回答若干询问RMQ(A,i,j)(i,j<=n)，返回数列A中下标在[i,j]里的最小(大）值，也就是说，RMQ问题是指求区间最值的问题



主要方法及复杂度(处理复杂度和查询复杂度)如下:

1.朴素（即搜索） O(n)-O(n)

2.线段树(segment tree) O(n)-O(qlogn)

3.ST（实质是动态规划） O(nlogn)-O(1)


### 线段树方法
**线段树方法**:

线段树能在对数时间内在数组区间上进行更新与查询。

定义线段树在区间[i, j] 上如下：

第一个节点维护着区间 [i, j] 的信息。

if i<j , 那么左孩子维护着区间[i, (i+j)/2] 的信息，右孩子维护着区间[(i+j)/2+1, j] 的信息。

可知 N  个元素的线段树的高度 为 [logN] + 1(只有根节点的树高度为0) .

下面是区间 [0, 9]  的一个线段树:



![img](http://dl.iteye.com/upload/attachment/196191/c1effd0f-0915-3c8d-b16a-aea1e5a69ae2.jpg)



线段树和堆有一样的结构, 因此如果一个节点编号为 x ，那么左孩子编号为2*x  右孩子编号为2*x+1.



使用线段树解决RMQ问题，关键维护一个数组M[num]，num=2^(线段树高度+1).

M[i]:维护着被分配给该节点(编号:i 线段树根节点编号:1)的区间的最小值元素的下标。 该数组初始状态为-1.

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

``` cpp
#include<iostream>

using namespace std;

#define MAXN 100
#define MAXIND 256 //线段树节点个数

//构建线段树,目的:得到M数组.
void initialize(int node, int b, int e, int M[], int A[])
{
    if (b == e)
        M[node] = b; //只有一个元素,只有一个下标
    else
    {
    //递归实现左孩子和右孩子
        initialize(2 * node, b, (b + e) / 2, M, A);
        initialize(2 * node + 1, (b + e) / 2 + 1, e, M, A);
    //search for the minimum value in the first and
    //second half of the interval
    if (A[M[2 * node]] <= A[M[2 * node + 1]])
        M[node] = M[2 * node];
    else
        M[node] = M[2 * node + 1];
    }
}

//找出区间 [i, j] 上的最小值的索引
int query(int node, int b, int e, int M[], int A[], int i, int j)
{
    int p1, p2;


    //查询区间和要求的区间没有交集
    if (i > e || j < b)
        return -1;

    //if the current interval is included in
    //the query interval return M[node]
    if (b >= i && e <= j)
        return M[node];

    //compute the minimum position in the
    //left and right part of the interval
    p1 = query(2 * node, b, (b + e) / 2, M, A, i, j);
    p2 = query(2 * node + 1, (b + e) / 2 + 1, e, M, A, i, j);

    //return the position where the overall
    //minimum is
    if (p1 == -1)
        return M[node] = p2;
    if (p2 == -1)
        return M[node] = p1;
    if (A[p1] <= A[p2])
        return M[node] = p1;
    return M[node] = p2;

}


int main()
{
    int M[MAXIND]; //下标1起才有意义,保存下标编号节点对应区间最小值的下标.
    memset(M,-1,sizeof(M));
    int a[]={3,1,5,7,2,9,0,3,4,5};
    initialize(1, 0, sizeof(a)/sizeof(a[0])-1, M, a);
    cout<<query(1, 0, sizeof(a)/sizeof(a[0])-1, M, a, 0, 5)<<endl;
    return 0;
}
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)
### ST算法
**ST算法**（Sparse Table）:它是一种动态规划的方法。

以最小值为例。a为所寻找的数组.

用一个二维数组f(i,j)记录区间[i,i+2^j-1](持续2^j个)区间中的最小值。其中f[i,0] = a[i];

所以，对于任意的一组(i,j)，f(i,j) = min{f(i,j-1),f(i+2^(j-1),j-1)}来使用动态规划计算出来。

这个算法的高明之处不是在于这个动态规划的建立，而是它的查询：它的查询效率是O(1).

假设我们要求区间[m,n]中a的最小值，找到一个数k使得2^k<n-m+1.

这样，可以把这个区间分成两个部分：[m,m+2^k-1]和[n-2^k+1,n].我们发现，这两个区间是已经初始化好的.

前面的区间是f(m,k)，后面的区间是f(n-2^k+1,k).

这样，只要看这两个区间的最小值，就可以知道整个区间的最小值！

``` cpp
#include<iostream>
#include<cmath>
#include<algorithm>
using namespace std;

#define M 100010
#define MAXN 500
#define MAXM 500
int dp[M][18];
/*
*一维RMQ ST算法
*构造RMQ数组 makermq(int n,int b[]) O(nlog(n))的算法复杂度
*dp[i][j] 表示从i到i+2^j -1中最小的一个值(从i开始持续2^j个数)
*dp[i][j]=min{dp[i][j-1],dp[i+2^(j-1)][j-1]}
*查询RMQ rmq(int s,int v)
*将s-v 分成两个2^k的区间
*即 k=(int)log2(s-v+1)
*查询结果应该为 min(dp[s][k],dp[v-2^k+1][k])
*/

void makermq(int n,int b[])
{
    int i,j;
    for(i=0;i<n;i++)
        dp[i][0]=b[i];
    for(j=1;(1<<j)<=n;j++)
        for(i=0;i+(1<<j)-1<n;i++)
            dp[i][j]=min(dp[i][j-1],dp[i+(1<<(j-1))][j-1]);
}
int rmq(int s,int v)
{
    int k=(int)(log((v-s+1)*1.0)/log(2.0));
    return min(dp[s][k],dp[v-(1<<k)+1][k]);
}

void makeRmqIndex(int n,int b[]) //返回最小值对应的下标
{
    int i,j;
    for(i=0;i<n;i++)
        dp[i][0]=i;
    for(j=1;(1<<j)<=n;j++)
        for(i=0;i+(1<<j)-1<n;i++)
            dp[i][j]=b[dp[i][j-1]] < b[dp[i+(1<<(j-1))][j-1]]? dp[i][j-1]:dp[i+(1<<(j-1))][j-1];
}
int rmqIndex(int s,int v,int b[])
{
    int k=(int)(log((v-s+1)*1.0)/log(2.0));
    return b[dp[s][k]]<b[dp[v-(1<<k)+1][k]]? dp[s][k]:dp[v-(1<<k)+1][k];
}

int main()
{
    int a[]={3,4,5,7,8,9,0,3,4,5};
    //返回下标
    makeRmqIndex(sizeof(a)/sizeof(a[0]),a);
    cout<<rmqIndex(0,9,a)<<endl;
    cout<<rmqIndex(4,9,a)<<endl;
    //返回最小值
    makermq(sizeof(a)/sizeof(a[0]),a);
    cout<<rmq(0,9)<<endl;
    cout<<rmq(4,9)<<endl;
    return 0;
}
```

作　　者：**Angel_Kitty**
出　　处：<https://www.cnblogs.com/ECJTUACM-873284962/>
关于作者：阿里云ACE，目前主要研究方向是Web安全漏洞以及反序列化。如有问题或建议，请多多赐教！
版权声明：本文版权归作者和博客园共有，欢迎转载，但未经作者同意必须保留此段声明，且在文章页面明显位置给出原文链接。
特此声明：所有评论和私信都会在第一时间回复。也欢迎园子的大大们指正错误，共同进步。或者[直接私信](http://msg.cnblogs.com/msg/send/Angel_Kitty)我
声援博主：如果您觉得文章对您有帮助，可以点击文章右下角**【推荐】**一下。您的鼓励是作者坚持原创和持续写作的最大动力！