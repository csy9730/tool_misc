# 三分查找（ternary search）及其示例

![img](https://upload.jianshu.io/users/upload_avatars/195230/5a20334f-efcb-481b-b2a3-c7cf0f4091de.jpg?imageMogr2/auto-orient/strip|imageView2/1/w/96/h/96/format/webp)

[LittleMagic](https://www.jianshu.com/u/49e6a4e2bf69)[![  ](https://upload.jianshu.io/user_badge/b4853dc7-5c16-4875-a2cd-7cf764bbd934)](https://www.jianshu.com/mobile/creator)关注

12020.01.15 23:27:59字数 921阅读 3,096

在这个博客的开头（差不多一年前的事儿了），我曾写过一篇[非常潦草的文章](https://www.jianshu.com/p/52ca160ba96d)来描述二分查找（binary search）算法。二分查找是最经典的在单调序列中查找目标值的算法，不再多费口舌了。

除了二分查找之外，其实还有三分查找（ternary search）算法。它的知名度没有二分查找那么高，但是用处也不小。一句话，**三分查找用来确定函数在凹/凸区间上的极值点**。什么是凹凸性呢？借用同济版《高等数学（上册）》里的图来说明：



![img](https://upload-images.jianshu.io/upload_images/195230-e01fa6e83da45b46.png?imageMogr2/auto-orient/strip|imageView2/2/w/755/format/webp)

上图示出凹凸性的最简单情况。若函数f(x)在区间I上连续，如果对I上任意两点x1、x2，恒有：

> (a) f[(x1 + x2) / 2] < [f(x1) + f(x2)] / 2，那么f(x)在区间I上是**向上凹**的；
> (b) f[(x1 + x2) / 2] > [f(x1) + f(x2)] / 2，那么f(x)在区间I上是**向上凸**的。

可见，凹凸性是相对的。有很多国外的书籍资料判断凹凸性时，是以原点方向为准，而不是y轴正方向，所以图a也可以是**向下凸**的，图b也可以是**向下凹**的。不管怎么说，函数f(x)在区间I上都有单峰（unimodal）性质，亦即有且仅有一个极值。三分查找法就可以确定这个极值。

铺垫了这么多，三分查找与二分查找的本质不同是，在函数f(x)的某个区间[l, r]上取分界点时，不是只取一个中点，而是取两个分别位于1/3处的点，即：

> m1 = l + (r - l) / 3，m2 = r - (r - l) / 3

这两个点把区间分成了三段。以凸函数（即有最大值）为例，有两种情况需要考虑：

- 若f(m1) < f(m2)，说明极值点位于[m1, r]区间内，可以不必再考虑[l, m1]区间；
- 若f(m1) > f(m2)，说明极值点位于[l, m2]区间内，可以不必再考虑[m2, r]区间。

这样，每一轮迭代都会把查找范围限制在原来的2/3，直到最终逼近极值点，即l和r之间的差值接近无穷小。容易推导出三分查找的时间复杂度为：

> T(n) = T(2n / 3) + 1 = O(log3n)

举个最简单的例子吧，[ZOJ 3203（Light Bulb）](https://links.jianshu.com/go?to=https%3A%2F%2Fzoj.pintia.cn%2Fproblem-sets%2F91827364500%2Fproblems%2F91827367865)。



![img](https://upload-images.jianshu.io/upload_images/195230-8d227384b3e51a4a.png?imageMogr2/auto-orient/strip|imageView2/2/w/625/format/webp)

如上图所示，有一个高为H的灯以及一个高为h的人，人与墙都在灯的右侧。灯与墙之间的水平距离为D，人会随灯光在墙上和地上投射出影子。给定H、h和D的值，求影子长度L的最大值。

设人距离灯的水平距离为x，根据相似三角形的知识，容易推导出：

> L = D - x + H - [(H - h) * D] / x

其中，前半部分D - x为地上的影子长度，后半部分H - [(H - h) * D] / x为墙上的影子长度。可见，L = f(x)是一个典型的**对勾函数**，用Sample里的H=2，h=1，D=0.5绘制出其函数图像如下。



![img](https://upload-images.jianshu.io/upload_images/195230-257cbc1e91fe15d5.png?imageMogr2/auto-orient/strip|imageView2/2/w/667/format/webp)

只考虑x > 0的情况，显然它的图像满足单峰性质，可以在(0, D]区间内利用三分查找法解决，代码如下。

```cpp
#include <iostream>
#include <cstdio>
using namespace std;

const double EPS = 1e-8;
double H, h, D;
int T;

double L(double x) {
  return D - x + H - (H - h) * D / x;
}

double ternarySearch(double l, double r) {
  while (r - l >= EPS) {
    double m1 = l + (r - l) / 3.0;
    double m2 = r - (r - l) / 3.0;
    if (L(m1) >= L(m2)) {
      r = m2;
    } else {
      l = m1;
    }
  }
  return l;
}

int main() {
  scanf("%d", &T);
  while (T--) {
    scanf("%lf%lf%lf", &H, &h, &D);
    printf("%.3lf\n", L(ternarySearch(0.01, D)));
  }
  return 0;
}
```

成功AC，民那晚安。