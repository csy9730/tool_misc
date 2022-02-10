# 用MATLAB求定积分



[叶云夕](https://blog.csdn.net/u010999396) ![img](https://csdnimg.cn/release/blogv2/dist/pc/img/newCurrentTime.png) 于 2017-12-21 10:57:20 发布 ![img](https://csdnimg.cn/release/blogv2/dist/pc/img/articleReadEyes.png) 112016 ![img](https://csdnimg.cn/release/blogv2/dist/pc/img/tobarCollect.png) 收藏 126

分类专栏： [matlab](https://blog.csdn.net/u010999396/category_6644340.html)



[![img](https://img-blog.csdnimg.cn/20201014180756922.png?x-oss-process=image/resize,m_fixed,h_64,w_64)matlab](https://blog.csdn.net/u010999396/category_6644340.html)专栏收录该内容

9 篇文章1 订阅

订阅专栏



## 一、符号积分
符号积分由函数int来实现。该函数的一般调用格式为：
int(s)：没有指定积分变量和积分阶数时，系统按findsym函数指示的默认变量对被积函数或符号表达式s求不定积分；
int(s,v)：以v为自变量，对被积函数或符号表达式s求不定积分；
int(s,v,a,b)：求定积分运算。a,b分别表示定积分的下限和上限。该函数求被积函数在区间[a,b]上的定积分。a和b可以是两个具体的数，也可以是一个符号表达式，还可以是无穷(inf)。当函数f关于变量x在闭区间[a,b]上可积时，函数返回一个定积分结果。当a,b中有一个是inf时，函数返回一个广义积分。当a,b中有一个符号表达式时，函数返回一个符号函数。
例：
求函数`x^2+y^2+z^2`的三重积分。内积分上下限都是函数，对z积分下限是sqrt(x*y)，积分上限是x^2*y；对y积分下限是sqrt(x)，积分上限是x^2；对x的积分下限1，上限是2，求解如下：

```matlab
syms x y z  %定义符号变量
F2=int(int(int(x^2+y^2+z^2,z,sqrt(x*y),x^2*y),y,sqrt(x),x^2),x,1,2)  %注意定积分的书写格式
F2 =
1610027357/6563700-6072064/348075*2^(1/2)+14912/4641*2^(1/4)+64/225*2^(3/4)    %给出有理数解
VF2=vpa(F2)  %给出默认精度的数值解
VF2 =
224.92153573331143159790710032805
```



## 二、数值积分
### 1.数值积分基本原理
求解定积分的数值方法多种多样，如简单的梯形法、辛普生(Simpson)法、牛顿－柯特斯(Newton-Cotes)法等都是经常采用的方法。它们的基本思想都是将整个积分区间[a,b]分成n个子区间[xi,xi+1]，i=1,2,…,n，其中x1=a，xn+1=b。这样求定积分问题就分解为求和问题。
### 2.数值积分的实现方法

### quad

基于变步长辛普生法，MATLAB给出了quad函数来求定积分。该函数的调用格式为：

```matlab
[I,n]=quad('fname',a,b,tol,trace)
```

### quadl


基于变步长、牛顿－柯特斯(Newton-Cotes)法，MATLAB给出了quadl函数来求定积分。该函数的调用格式为：

```matlab
[I,n]=quadl('fname',a,b,tol,trace)
```


其中fname是被积函数名。a和b分别是定积分的下限和上限。tol用来控制积分精度，缺省时取tol=0.001。trace控制是否展现积分过程，若取非0则展现积分过程，取0则不展现，缺省时取trace=0。返回参数I即定积分值，n为被积函数的调用次数。
例：
求函数`exp(-x*x)`的定积分，积分下限为0，积分上限为1。

```
fun=inline('exp(-x.*x)','x');  %用内联函数定义被积函数fname
Isim=quad(fun,0,1)  %辛普生法
Isim =
  0.746824180726425
IL=quadl(fun,0,1)   %牛顿－柯特斯法
IL =
0.746824133988447
```



### trapz
trapz(x,y)—梯形法沿列方向求函数Y关于自变量X的积分(向量形式，数值方法)。



```
d=0.001;
x=0:d:1;
S=d*trapz(exp(-x.^2))
S= 
0.7468
```


或：

```
format long g
x=0:0.001:1;  %x向量，也可以是不等间距
y=exp(-x.^2);   %y向量，也可以不是由已知函数生成的向量
S=trapz(x,y);   %求向量积分
S =
    0.746824071499185 
```

### integral

Numerical integration

```
- `q = integral(fun,xmin,xmax)`
- `q = integral(fun,xmin,xmax,Name,Value)`
```



## 附：int与quad区别
int的积分可以是定积分，也可以是不定积分（即有没有积分上下限都可以积）可以得到解析的解，比如你对x^2积分，得到的结果是1/3*x^3，这是通过解析的方法来解的。如果int(x^2,x,1,2)得到的结果是7/3


quad是数值积分，它只能是定积分（就是有积分上下限的积分），它是通过simpson数值积分来求得的（并不是通过解析的方法得到解析解，再将上下限代入，而是用小梯形的面积求和得到的）。如果f=inline('x.^2');quad(f,1,2)得到的结果是2.333333，这个数并不是7/3


int是符号解，无任何误差，唯一问题是计算速度；quad是数值解，有计算精度限制，优点是总是能有一定的速度，即总能在一定时间内给出一个一定精度的解。