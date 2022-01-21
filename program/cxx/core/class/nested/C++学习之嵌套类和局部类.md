# [C++学习之嵌套类和局部类 ](https://www.cnblogs.com/sunfie/p/4394591.html)
​       在一个类的内部定义另一个类，我们称之为嵌套类（nested class），或者嵌套类型。之所以引入这样一个嵌套类，往往是因为外围类需要使用嵌套类对象作为底层实现，并且该嵌套类只用于外围类的实现，且同时可以对用户隐藏该底层实现。

​       **虽然嵌套类在外围类内部定义，但它是一个独立的类，基本上与外围类不相关。它的成员不属于外围类，同样，外围类的成员也不属于该嵌套类。嵌套类的出现只是 告诉外围类有一个这样的类型成员供外围类使用。并且，外围类对嵌套类成员的访问没有任何特权，嵌套类对外围类成员的访问也同样如此，它们都遵循普通类所具有的标号访问控制。**

​      若不在嵌套类内部定义其成员，则其定义只能写到与外围类相同的作用域中，且要用外围类进行限定，**不能把定义写在外围类中**。例如，嵌套类的静态成员就是这样的一个例子。（如何完成？）

​       前面说过，之所以使用嵌套类的另一个原因是达到底层实现隐藏的目的。为了实现这种目的，我们需要在另一个头文件中定义该嵌套类，而只在外围类中前向声明这个嵌套类即可。当然，在外围类外面定义这个嵌套类时，应该使用外围类进行限定。使用时，只需要在外围类的实现文件中包含这个头文件即可。

​      另外，嵌套类可以直接引用外围类的静态成员、类型名和枚举成员，即使这些是private的。一个好的嵌套类设计：嵌套类应该设成私有。嵌套类的成员和方法可以设为public。

## 嵌套类名字的解析过程

嵌套类定义的名字解析过程：

出现在名字使用点前的嵌套类的声明。

出现在名字使用点前外围类的声明。

嵌套类定义前名字空间域的声明。

嵌套类的成员定义中的名字解析过程：

成员函数局部声明。

嵌套类成员的声明。

外围类成员的声明。

成员函数定义前名字空间域中出现的声明。

## 参考实例

```cpp
#include <iostream>

using namespace std;

 

class A

{

private:

 int n;

public:

 A(int n)

 {

  this->n=n;

  cout<<"Aconstructor"<<endl;

 }

 

voidshow();

 

class B

{

 public:

​      B( )

​      {

​      cout<<"B constructor"<<endl;

​      }

 

voiddisp()

​    {

​      cout<<"B disp"<<endl;

​    }

};

 

Bb;

};

 

voidA::show()

{

 cout<<n<<endl;

}

 

void main()

{

 A a(1);

 a.show();

 a.b.disp();

}

 

class Outter

**{**

**// friend class Inner 加了这行也白搭**

**（理解为什么）正确写法应该是;**

protected:

voidFoo(){}

private:

voidFoo2(){}

public:

voidFoo3(){}

 

private:

classInner

**{**

Inner(Outter*pFather)

{

pFather->Foo();// Error, compiler complain !!

pFather->Foo2();//Error, compiler complain !!

pFather->Foo3();//OK !
}

**};**

**};**
```



嵌套的结构(当然包括类)并不能自动获得访问private成员的权限，要获得的话，必须遵守特定的规则：首先声明(不是定义)一个嵌套结构，然后声明它是全局范围使用的一个friend,最后定义这个结构。结构的定义必须与friend声明分开，否则不会把它看做成员。

改成这样，就可以通过编译了

```cpp
class Outter

**{**

protected:

voidFoo(){};

private:

voidFoo2(){};

public:

voidFoo3(){};

 

private:

class Inner; // 声明  **（是否可以省略声明？不可以）**

friend Inner; // 声明为友元

classInner

**{**

Inner(Outter*pFather)

{

pFather->Foo();

pFather->Foo2();

pFather->Foo3();

}

**};**

**};**
```





分类: [C++](https://www.cnblogs.com/sunfie/category/675042.html)

