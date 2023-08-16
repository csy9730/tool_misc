# 深度探索C++对象模型：三种对象模型

[![哪有岁月静好](https://pic4.zhimg.com/v2-5a63beb1803f601572cc079bb338ad5e_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/kuang-zao-de-cyu-yan)

[哪有岁月静好](https://www.zhihu.com/people/kuang-zao-de-cyu-yan)





3 人赞同了该文章

## 引言

现在有一个 `Point` 类，声明如下：

```text
class Point {
 public:
  Point(float xval);
  virtual ~Point();

  float x() const;
  static int PointCount();

 protected:
  virtual ostream& print(ostream &os) const;

  float _x;
  static int _point_count;
};
```

这个类在机器上是通过什么模型来表示的呢？下面就介绍三种不同的实现方式。转载请注明出处：单刀土豆

## 1. 简单对象模型

简单对象模型名副其实，十分简单。在简单对象模型中，一个 `object` 是由一系列 `slots` 组成，每个 `slot` 相当于一个指针，指向一个 `member` ， `memebers` 按照声明的顺序与 `slots` 一一对应，这里的 `members` 包括 `data members` 和 `function members` 。如果将简单对象模型应用在 `Point Class` 上，结构图如下：

![img](https://pic4.zhimg.com/80/v2-e219173619882e9db258f43b2990c73b_720w.jpg)

- 优点：十分简单，降低了编译器设计的复杂度。
- 缺点：空间和时间上的效率降低。由于所有 `member` 都对应一个 `slot` 指针，所以每个 `object` 在空间上额外多出： `member's number 乘以指针大小` 的空间。同时由于访问 `object` 的每个 `member` 都需要一次 `slot` 的额外索引，所以在时间的效率也会降低。

## 2. 表格驱动对象模型

表格驱动对象模型将 `member data` 和 `member function` 分别映射成两个表格 `member data table` 和 `function member table` ，而 `object` 本身只存储指向这两个表格的指针。 其中 `function member table` 是由一系列的 `slot` 组成，每个 `slot` 指向一个 `member function` ; `member data table` 则直接存储的 `member data` 本身。如果将表格驱动对象模型应用在 `Point Class` 上，结构图如下：

![img](https://pic2.zhimg.com/80/v2-ded0fecef202957cc4c82e93e1e0a8dd_720w.jpg)

- 优点：采用两层索引机制，对 `object` 变化提供比较好的弹性，在 `object` 的 `nonstatic data member` 有所改变时，而应用程序代码没有改变，这时是不需要重新编译的。
- 缺点：空间和时间上的效率降低，具体原因可以参考简单对象模型的缺点分析。

## 3. C++ 对象模型

Stroustrup 早期设计的 `C++` 对象模型是从简单对象模型改进而来的，并对内存空间和存取时间进行了优化。主要是将 `nonstatic data members` 存储在每一个 `object` 中，而 `static data members` 以及所有的 `function members` 被独立存储在所有 `object` 之外。对虚函数的支持主要通过以下几点完成的：

- 所有包含虚函数或者继承自有虚函数基类的 `class` 都会有一个 `virtual table` ，该虚函数表存储着一堆指向该类所包含的虚函数的指针。
- 每个 `class` 所关联的 `type_info object` 也是由 `virtual table` 存储的，一般会存在该表格的首个 `slot` ， `type_info` 用于支持 `runtime type identification` ( `RTTI` )。

如果将 `C++` 对象模型应用在 `Point Class` 上，结构图如下：



![img](https://pic4.zhimg.com/80/v2-91bcf8b17e90fa952bd0a7b3f4051a97_720w.jpg)

- 优点：空间和存取效率高，所有 `static data members` 以及所有的 `function members` 被独立存储在所有 `object` 之外，可以减少每个 `object` 的大小，而 `nonstatic data members` 存储在每一个 `object` 中，又提升了存取效率。
- 缺点：如果应用程序的代码未曾更改，但所用到的 `class` 的 `nonstatic data members` 有所更改，那么那些代码仍然需要全部重新编译，而前面的表格驱动模型在这方面提供了较大的弹性，因为他多提供了一层间接性，当然是付出了时间和空间上的代价。

## 在加上继承情况下的对象模型

`C++` 支持单继承、多继承、虚继承，下面来看下 `base class` 实体在 `derived class` 中是如何被构建的。

简单对象模型中可以通过 `derived class object` 中的一个 `slot` 来存储 `base class subobject` 的地址，这样就可以通过该 `slot` 来访问 `base class` 的成员。这种实现方式的主要缺点是：因为间接性的存储而导致空间和存取时间上存在额外负担；优点是： `derived class` 的结构不会因为 `base class` 的改变而改变。

表格驱动对象模型中可以利用一个类似 `base class table` 的表格来存储所有基类的信息。该表格中存储一系列 `slot` ，每个 `slot` 存储一个 `base class` 的地址。这种实现方式的缺点是：因为间接性的存储而导致空间和存取时间上存在额外负担；优点是：一是所有继承的 `class` 都有一致的表现形式（包含一个 `base table` 指针，指向基类表）与基类的大小和数目没有关系，二是 `base class table` 增加了子类的扩展性，当基类发生改变时，可以通过扩展、缩小或者更改 `base class table` 来进行调整。

以上两种实现方式都存在一个重要的问题，就是由于间接性而导致的空间和时间上的额外负担，并且该间接性的级数会随着继承的深度而增加。

`C++` 最初采用的继承模型并不采用任何间接性，所有基类的数据直接存储在子类当中，这样在存储结构和访问效率上是最高效的。当然也有缺点：当 `base class members` 有任何改变，用到此 `base class` 或者 `derived class` 的对象必须重新编译。在 `C++ 2.0` 引入了 `virtual base class` ，需要一些间接性的方式来支持该特性，一般会导入一个 `virtual base class table` 或者扩展已有的 `virtual table` ，详细会在后面博文讨论。

![img](https://pic4.zhimg.com/80/v2-27b6e8318a0304038608f78f5af26e3b_720w.jpg)

![img](https://pic1.zhimg.com/80/v2-db7b25549da37fb60594e9716fff63a8_720w.jpg)

![img](https://pic3.zhimg.com/80/v2-58436c4a6ea50e05a26233a794a7800a_720w.jpg)

点击链接领取资料，先到先得：

[点击链接：领取新手礼包，学习资料jq.qq.com/?_wv=1027&k=uaKxXmO0](https://jq.qq.com/%3F_wv%3D1027%26k%3DuaKxXmO0)

发布于 2020-07-11 16:07

C / C++

C++ 编程

计算机