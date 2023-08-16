# C++ Union高级剖析

[![img](https://cdn2.jianshu.io/assets/default_avatar/14-0651acff782e7a18653d7530d6b27661.jpg)](https://www.jianshu.com/u/47e5c5b5d697)

[1m0nster](https://www.jianshu.com/u/47e5c5b5d697)关注IP属地: 台湾

0.12019.09.29 12:30:16字数 757阅读 2,562

### 简介

C++的Union继承自C语言的Union，所以意义是一样的。但是由于C++ ADT机制，所以就需要C++的Union支持ADT的特性。但是很奇怪的是，C++直到C++11的版本之后才增加了Union对于ADT的支持。

### union基本概念

Union在C++内存模型，可以理解为一块“共享内存”(不是多线（进）程概念中的共享内存)。Union开辟的大小，是其内部定义的所有元素中最大的元素。比如:



```cpp
union U {
    char a;
    int b;
    long long c;
}
```

`sizeof(U)` == `max((sizeof(char), sizeof(int)),sizeof(long long))` == 8bytes，所以在声明了一个类型为union U的变量之后，就会开辟一块8 bytes的内存来存放改变量。

### union对于ADT的支持

在C++11之前，union是不支持含有non-trivial ADT的，即对于下面的声明是不合法的:



```cpp
class A {
    A() {}
};
class B {
    B() {}
};
union U {
    A a;
    B b;
    std::string s;
}
```

在c++11之后，便支持了这种声明，但是有一些**附加条件**：

- union可以有成员函数，但是不能是虚函数
- union不能作为基类
- union不能有非静态成员变量的引用
  **并且**
  如果非静态内部成员变量的类有以下的函数，这些函数并且union的这些函数将会默认为delete
- non-trivial copy/move constructor
- non-trivial destructor
- non-trivial copy/move assignment

所以，初始化一个union必须程序人员自己实现，而不能使用编译器自动生成的构造函数。其实这个很容易理解，这一块内存编译器并不知道应该被定义为哪一个成员变量的类型，所以这一块内存就需要下发到程序人员这一层来决定。

有如下的初始化方法：

1. 自定构造函数



```cpp
union U {
    std::string s;
    std::vector<int> v;
    U (int t) {
        if (t == 0) {
            new (&s) std::string;
        } else if (t==1) {
            new (&v) std::vector<int>;
        } else {
            assert(false);
        }
    } // 构造，根据需要将这块内存定义为std::string或者std::vector<int>
    
    ~U() {} // 析构，根据需要主动调用std::string或std::vector<int>的析构函数
}

int main() {
    U au(1); // au这块内存就被定义为std::vector<int>
    au.v.~vector; // 手动析构
    return 0;
}
```

1. 利用union第一个有default member initializer的元素来构造这块内存区域



```cpp
union U {
    std::string s;
    std::vector<int> v;
    
    ~U() {} // 析构，根据需要主动调用std::string或std::vector<int>的析构函数
}

int main() {
    U au = {"Hello World"}; // au初始化构造为std::string
    au.s.~basic_string();
    
    new (&au.v) std::vector<int>; //au构造为std::vector<int>
    au.v.~vector();
    
    return 0;
}
```

### Tagged union

在上面的代码演示中我们可以看到，一个union在析构的时候需要一个标记（tag）来记录当前的状态，才能选择相应的析构函数，来析构这一块内存区域。我们把这种数据结构叫做**tagged union**。
如下的数据结构可以来实现tagged union



```cpp
struct TaggedUnion {
    enum Tag {STRING, IVECTOR};
    Tag tag;
    union U {
        std::string s;
        std::vector<int> v;
        U(Tag t) {
            if (t == STRING) {
                new (&s) std::string;
            } else if (t == IVECTOR) {
                new (&v) std::vector<int>;
            } else {
                assert(false);
            }
        }
        ~U() {}
    } au;
    
    TaggedUnion(Tag t) :
        au(t) {
    }
    
    ~TaggedUnion() {
        if (tag == STRING) {
            au.s.~basic_string();
        } else if (tag == IVECTOR) {
            au.v.~vector();
        } else {
            assert(false);
        }
    }
};

int main(int argc, char const *argv[]) {
    TaggedUnion tagu(TaggedUnion::STRING);
    return 0;
}
```

上面的struct结构也叫做**Union-like class**

### 匿名union

如下的union定义叫做匿名union



```cpp
int main() {
    union {
        int a;
        char b;
    };
    a = 1;
    b = '+';
    return 0;
}
```

### variant number

当一个union中的成员变量被激活的时候，那么这个时候就是union的一个变体(variant number)。这个专用术语在函数式语言中用的比较多。

### 如何做到不使用union但是达到union的效果

由于union使用起来限制过多，所以是否可以利用现有的语言支持达到union的效果呢？答案是可以
可以使用继承来达到这个效果。比如我们声明了如下的union



```cpp
union {
    std::string s;
    std::vector<int> v;
}
```

其等同的使用继承



```css
class TypeBase {
public:
    TypeBase() = 0;
};

class StringVariant : public TypeBase {
public:
    StringVariant();
private:
    std::string m_string;
};

class iVectorVariant: public TypeBase {
public:
    iVectorVariant();
private:
    std::vector<int>m_vector;
};
```

©著作权归作者所有,转载或内容合作请联系作者