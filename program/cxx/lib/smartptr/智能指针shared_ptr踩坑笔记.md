# 智能指针shared_ptr踩坑笔记

[![回廊识路](https://picx.zhimg.com/v2-46ddaf931628a3b93f10f69e8cf0254f_l.jpg?source=172ae18b)](https://www.zhihu.com/people/li-yan-44-55-45)

[回廊识路](https://www.zhihu.com/people/li-yan-44-55-45)

“硬件的方向是物理，软件的结局是数学”

27 人赞同了该文章

平时写代码一直避免使用指针，但在某些场景下指针的使用还是有必要的。最近在项目中简单使用了一下智能指针（`shared_ptr`），结果踩了不少坑，差点就爬不出来了。痛定思痛抱着《Cpp Primer》啃了两天，看书的时候才发现自己的理解和实践很浅薄，真的是有种后背发凉的感觉。。。特地记录下这些坑点，且警后人（指后来的自己=。=）.

------

## 写在前面……

本次实验基于的数据结构定义如下：

基类`Polygon`的成员`_points`是一个`shared_ptr`，指向动态分配的`vector`，这样实现了在`Polygon`对象的多个拷贝之间共享相同的`vector`。基于`Polygon`实现了`Rect`和`Circle`两个子类。

```cpp
#include <vector>
#include <string>
#include <memory>
#include <cassert>

using namespace std;

static constexpr double PI = 3.14;

using coord_t = double;

struct Point { coord_t x, y; };

class Polygon {
public:
    Polygon(const vector<Point> &points) :
        _points(make_shared<const vector<Point>>(points)) {}

    virtual string shape() const = 0;

    virtual coord_t area() const = 0;

public:
    const shared_ptr<const vector<Point>> _points;
};

class Rect final : public Polygon {
public:
    Rect(const vector<Point> &points, coord_t width, coord_t height) :
        Polygon(points), _width(width), _height(height) {
        assert(points.size() == 4);
    }

    string shape() const { return "Rect"; }

    coord_t area() const { return _width * _height; }

private:
    const coord_t _width;
    const coord_t _height;
};

class Circle final : public Polygon {
public:
    Circle(const vector<Point> &points, coord_t radius) :
        Polygon(points), _center(points.front()), _radius(radius) {
        assert(points.size() == 1);
    }

    string shape() const { return "Circle"; }

    coord_t area() const { return PI * _radius * _radius; }

private:
    const Point _center;
    const coord_t _radius;
};

using polygon_ptr = shared_ptr<Polygon>;

using rect_ptr = shared_ptr<Rect>;

using circle_ptr = shared_ptr<Circle>;

// 定义一个边长为5的矩形和一个半径为5的圆.
static vector<Point> r_points{ {0,0},{0,5},{5,5},{5,0} };
static coord_t r_width = 5, r_height = 5;
static vector<Point> c_points{ {0,0} };
static coord_t c_radius = 5;
```

## 从正确定义智能指针开始……

在项目中采用智能指针的初衷是为了实现多个对象之间共享数据，避免拷贝造成的开销。然而在使用的时候，我竟然连定义一个智能指针都能制造出五花八门的错误。。。下面分别整理了正确和错误的用法。

### 1. `make_shared`函数：最安全的分配和使用动态内存的方法

类似顺序容器的`emplace`成员，`make_shared`用其参数来构造给定类型的对象。可以是一般的构造函数：

```cpp
shared_ptr<Rect> p1 = make_shared<Rect>(r_points, r_width, r_height);
```

也可以是拷贝构造函数：

```cpp
Rect rect_2(r_points, r_width, r_height);
shared_ptr<Rect> p2 = make_shared<Rect>(rect_2);
```

> **Ps：**需要说明的一点是，由于`p2`指向的对象（即`*p2`）是`rect_2`的拷贝，所以它们的`_points`成员指向相同的内存，共享相同的`vector`。这个`vector`是`r_points`的一份拷贝，保存在动态内存中。

### 2. `shared_ptr`和`new`结合使用

可以用`new`返回的指针来初始化智能指针：

```cpp
shared_ptr<Rect> p3(new Rect(r_points, r_width, r_height));
```

或者将一个`shared_ptr`绑定到一个已经定义的普通指针：

```cpp
Rect *x = new Rect(r_points, r_width, r_height);
shared_ptr<Rect> p4(x);
x = nullptr;
```

> **Ps：这是一种不建议的写法。**原则上当`p4`绑定到`x`时，内存管理的责任就交给了`p4`，就不应该再使用`x`来访问`p4`指向的内存了。因此建议在完成绑定之后立刻将`x`置为空指针`nullptr`，避免在后续代码中使用`delete x`释放`p4`所指的内存，或者又将其他智能指针绑定到`x`上，这都会造成同一块内存多次释放的错误。
> 但这就出现一个尴尬的情况：程序员要时刻记得一个已经存在的变量不能使用，这要求实在是高了点。。。最理想的还是不要制造出`x`，或者说`x`的存在就没有意义。

### 3. 【错误1】试图从raw指针隐式转换到智能指针

```cpp
shared_ptr<Rect> p5 = new Rect(r_points, r_width, r_height); // !!!
```

**【修改】**接受指针参数的智能指针构造函数是`explicit`的，必须使用直接初始化形式：

```cpp
shared_ptr<Rect> p5(new Rect(r_points, r_width, r_height));
```

### 4. 【错误2】将非动态分配的内存托管给智能指针

```cpp
Rect rect_6(r_points, r_width, r_height);
shared_ptr<Rect> p6(&rect_6); // !!!
```

这种写法将`p6`指向一块**栈内存**，相当于局部变量`rect_6`和`p6`管理了同一内存空间，而栈内存中的对象是编译器负责创建和销毁的，而且不能析构一个指向非动态分配的内存的智能指针，因此是不合理的。

**【修改】**创建智能指针时**传递一个空的删除器函数**或者**直接使用raw指针**，详见[stackoverflow](https://stackoverflow.com/questions/24049155/set-shared-ptr-to-point-existing-object)。正如回答中说的：*There is not much point in using a `shared_ptr` for an automatically allocated object.*

```cpp
Rect rect_6(r_points, r_width, r_height);
shared_ptr<Rect> p6(&rect_6, [](Rect*) {});
```

### 5. 【错误3】将同一份动态内存托管给多个智能指针

```cpp
Rect *xx = new Rect(r_points, r_width, r_height);
shared_ptr<Rect> p7(xx);
{
    shared_ptr<Rect> p8(xx); // !!!
    shared_ptr<Rect> p9(p7.get()); // !!!
}
xx = nullptr;
Rect rect_7 = *p7;
```

`p7`、`p8`和`p9`指向了相同的动态内存，但由于它们是相互独立创建的，**因此各自的引用计数都是1**，即相互不知道对方的存在，认为自己是这块内存的唯一管理者。当`p8`、`p9`所在程序块结束时，内存被释放，从而导致`p7`变为**空悬指针**，意味着当试图使用`p7`时将发生未定义的行为；而且也存在同一内存多次释放的危险。

*Ps：在测试中还发现这种多个智能指针托管同一动态内存的情况与上文智能指针指向栈内存的情况，二者报错信息并不相同。*

**【修改】**与错误用法2类似，在创建智能指针时**传递一个空的删除器函数**即可。

```cpp
Rect *xx = new Rect(r_points, r_width, r_height);
shared_ptr<Rect> p7(xx);
{
    shared_ptr<Rect> p8(xx, [](Rect*) {});
    shared_ptr<Rect> p9(p7.get(), [](Rect*) {});
}
xx = nullptr;
Rect rect_7 = *p7;
```

> **小结：**本质上4和5属于同一类型的错误，即同一块内存由多个管理者托管，但它们彼此之间又不知道对方的存在，这样就导致在它们各自生命周期结束时都会释放这块内存的错误。个人认为，5的正确写法在某种程度上还是可以接受的，但4是一种完全不合理的智能指针使用方式，这种情况就应该直接使用raw指针，“只有将指向动态分配的对象的指针交给`shared_ptr`托管才是有意义的”。
> 往往这种错误在编译期间没有问题，但运行时会报错，因此不易排查。为了避免这种错误，应该养成良好的编程意识，《Cpp Primer》中提到几条基本规范，建议严格遵循：
> \1. 不使用相同的raw指针初始化（或reset）多个智能指针。
> \2. 不delete get()返回的指针。
> \3. 不使用get()初始化或reset另一个智能指针。
> \4. 如果你使用get()返回的指针，记住当最后一个对应的智能指针销毁后，你的指针就变为无效了。
> \5. 如果你使用智能指针管理的资源不是new分配的内存，记住传递给它一个删除器。

## 智能指针的使用场景

《Cpp Primer》中提到程序使用动态内存出于以下三种原因之一：

> \1. 程序不知道自己需要使用多少对象
> \2. 程序不知道所需对象的准确类型
> \3. 程序需要在多个对象间共享数据

容器类是出于第一种原因而使用动态内存的典型例子，而2和3的需求可以使用（智能）指针很好地满足。

### 智能指针成员

基类`Polygon`中的`_points`成员是一个`shared_ptr`智能指针，依靠它实现了`Polygon`对象的不同拷贝之间共享相同的`vector`，并且此成员将记录有多少个对象共享了相同的`vector`，并且能在最后一个使用者被销毁时释放该内存。

```cpp
Rect rect_1(r_points, r_width, r_height);
cout << "rect_1 points成员地址: " << rect_1._points.get() << endl;
cout << "rect_1 points引用计数: " << rect_1._points.use_count() << endl;

Rect rect_2 = rect_1;
cout << "rect_2 points成员地址: " << rect_2._points.get() << endl;
cout << "rect_2 points引用计数: " << rect_2._points.use_count() << endl;
```

上述代码的运行结果：

![img](https://pic1.zhimg.com/80/v2-b57047545ef78d3bffb3aad2067cf348_720w.webp)

程序需要在多个对象间共享数据 →（智能）指针成员

### 容器与继承

当我们使用容器存放继承体系中的对象时，因为不允许直接在容器中保存不同类型的元素，通常必须采取间接存储的方式，即我们实际上存放的是基类的（智能）指针，这些指针所指的对象可以是基类对象，也可以是派生类对象。当要使用具体的对象时，要利用多态性将基类指针下行转换为派生类指针。

```cpp
vector<polygon_ptr> polygon_ptrs;
polygon_ptrs.push_back(make_shared<Rect>(r_points, r_width, r_height));
polygon_ptrs.push_back(make_shared<Circle>(c_points, c_radius));

//auto rect = dynamic_cast<Rect*>(polygon_ptrs.front()); // compile error
//auto rect = dynamic_cast<rect_ptr>(polygon_ptrs.front()); // compile error
auto rect = dynamic_pointer_cast<Rect>(polygon_ptrs.front()); // compile success
cout << "polygon_ptrs.front() shape: " << rect->shape() << " area: " << rect->area() << endl;
auto circle = dynamic_pointer_cast<Circle>(polygon_ptrs.back());
cout << "polygon_ptrs.back() shape: " << circle->shape() << " area: " << circle->area() << endl;
```

上述代码的运行结果：

![img](https://pic4.zhimg.com/80/v2-98bed1e41b0d1e777b20fe3356807ec3_720w.webp)

程序不知道所需对象的准确类型 → 容器中放置（智能）指针而非对象

> **智能指针的下行转换**
> \1. 必须使用`dynamic_pointer_cast`，而不是`dynamic_cast`。这是因为父子两种智能指针并非继承关系，而是完全不同的类型。
> \2. 基类必须是多态类型（包含虚函数）。

## [Github] 代码

项目实例均在vs2017上测试，并上传至[GitHub](https://github.com/lyandut/MyCppPitfalls)。

## [Reference] 参考

[Stack Overflow: Set shared_ptr to point existing objectstackoverflow.com/questions/24049155/set-shared-ptr-to-point-existing-object](https://stackoverflow.com/questions/24049155/set-shared-ptr-to-point-existing-object)

[C++11 shared_ptr（智能指针）详解www.cnblogs.com/liushui-sky/p/13632028.html](https://



编辑于 2020-11-14 12:14

[智能指针](https://www.zhihu.com/topic/19616318)

[C++ 编程](https://www.zhihu.com/topic/19836485)

[指针（C / C++）](https://www.zhihu.com/topic/19959489)