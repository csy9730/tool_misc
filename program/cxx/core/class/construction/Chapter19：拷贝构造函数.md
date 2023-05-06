# Chapter19：拷贝构造函数

[![ZiZar](https://picx.zhimg.com/v2-49658b60ebdc525744cb98988faf6112_l.jpg?source=32738c0c)](https://www.zhihu.com/people/ou-rui-ning)

[ZiZar](https://www.zhihu.com/people/ou-rui-ning)![img](https://pic1.zhimg.com/v2-4812630bc27d642f7cafcd6cdeca3d7a.jpg?source=88ceefae)

坐密室如通衢 驭寸心如六马

15 人赞同了该文章

对于计算机来说，拷贝是指用一份原有的、已经存在的数据创建出一份新的数据，最终的结果是多了一份相同的数据。在 C++中，拷贝并没有脱离它本来的含义，只是将这个含义进行了“特化”，是指用已经存在的对象创建出一个新的对象。从本质上讲，对象也是一份数据，因为它会占用内存。

严格来说，对象的创建包括两个阶段，首先分配空间，再进行初始化。分配内存很好理解，就是在堆区、栈区或者全局数据区留出足够多的字节。此时内存中的内容一般是零值或随机值，没有实际意义。初始化就是首次对内存赋值，让它的数据有意义（再次赋值不叫初始化）。

## 一、拷贝构造函数

关于拷贝构造函数，写一个简单的例子：

```cpp
#include <iostream>
#include <string>
using namespace std;

class Student{
public:
    Student(string name = "", int age = 0, float score = 0.0f); 
    Student(const Student &stu);  
public:
    void display();
private:
    string m_name;
    int m_age;
    float m_score;
};

Student::Student(string name, int age, float score): m_name(name), m_age(age), m_score(score){ }

Student::Student(const Student &stu){
    this->m_name = stu.m_name;
    this->m_age = stu.m_age;
    this->m_score = stu.m_score;
    cout<<"Copy constructor was called."<<endl;
}

void Student::display(){
    cout<<m_name<<" "<<m_age<<" "<<m_score<<endl;
}

int main(){
    Student stu1("James", 16, 90.5);
    Student stu2 = stu1; 
    Student stu3(stu1);  
    stu1.display();
    stu2.display();
    stu3.display();
    return 0;
}
```

拷贝构造函数只有一个参数，它的类型是当前类的引用，而且一般是const引用

首先，为什么必须是当前类的引用呢？如果拷贝构造函数的参数不是当前类的引用，而是当前类的对象，那么在调用拷贝构造函数时，会将另外一个对象直接传递给形参，这本身就是一次拷贝，会再次调用拷贝构造函数，然后又将一个对象直接传递给了形参，将继续调用拷贝构造函数。这个过程会一直持续下去，没有尽头，陷入死循环。只有当参数是当前类的引用时，才不会导致再次调用拷贝构造函数，这不仅是逻辑上的要求，也是 C++ 语法的要求。

再者，为什么是const引用呢？拷贝构造函数的目的是用其它对象的数据来初始化当前对象，并没有期望更改其它对象的数据，添加 const 限制后，这个含义更加明确了。另外一个原因是，添加 const 限制后，可以将 const 对象和非 const 对象传递给形参了，因为非 const 类型可以转换为 const 类型。如果没有 const 限制，就不能将 const 对象传递给形参，因为 const 类型不能转换为非 const 类型，这就意味着，不能使用 const 对象来初始化当前对象了。

如果程序员没有显式定义拷贝构造函数，那么编译器会自动生成一个默认的拷贝构造函数。这个默认的拷贝构造函数很简单，这个函数很简单，就是用旧对象的成员变量生成一个新对象的成员变量，即赋值。对于简单的类，默认拷贝构造函数一般是够用的，但是当类持有其它资源时，如动态分配的内存、打开的文件、指向其他数据的指针、网络连接等，默认拷贝构造函数就有点不够用，得自己显式定义了。

当以拷贝的方式初始化对象时会调用拷贝构造函数。初始化对象是指，为对象分配内存后第一次向内存中填充数据，这个过程会调用构造函数。对象被创建后必须立即被初始化，换句话说，只要创建对象，就会调用构造函数。在定义的同时进行赋值叫做初始化（Initialization），定义完成以后再赋值（不管在定义的时候有没有赋值）就叫做赋值（Assignment）。初始化只能有一次，赋值可以有多次。对于基本类型，初始化和赋值的区别不大，但是对于类，区别非常重要，因为初始化时会调用构造函数（以拷贝的方式初始化时会调用拷贝构造函数），而赋值时会调用重载过的赋值运算符。请看下面的例子：

```cpp
#include <iostream>
#include <string>
using namespace std;

class People{
public:
    People(string name = "", int age = 0, float salary =0.0f);
    People(const People &peo);
public:
    People & operator=(const People &peo);
    void Display();
private:
    string m_name;
    int m_age;
    float m_salary;
};

People::People(string name, int age, float salary):
m_name(name), m_age(age), m_salary(salary){}

People::People(const People &peo){
    this->m_name = peo.m_name;
    this->m_age = peo.m_age;
    this->m_salary = peo.m_salary;
    cout<<"Copy constructor was called."<<endl;
}

People & People::operator=(const People &peo){
    this->m_name = peo.m_name;
    this->m_age = peo.m_age;
    this->m_salary = peo.m_salary;
    cout<<"operator=() was called."<<endl;
    return *this;
}

void People::Display(){
    cout<<m_name<<' '<<m_age<<' '<<m_salary<<endl;
}

int main(int argc, char const *argv[]){
    People p1("Sam", 16, 10000);
    People p2("James", 17, 20000);
    
    People p4 = p1;
    p4.Display();
    
    p4 = p2;
    p4.Display();

    return 0;
}
```

结果如下：

```text
Copy constructor was called.
Sam 16 10000
operator=() was called.
James 17 20000
```

初始化对象时会调用构造函数，不同的初始化方式会调用不同的构造函数：

- 如果用传递进来的实参初始化对象，那么会调用普通的构造函数，我们不妨将此称为普通初始化；
- 如果用其它对象（现有对象）的数据来初始化对象，那么会调用拷贝构造函数，这就是以拷贝的方式初始化。

实际编程中，具体哪些情况以拷贝初始化对象呢？

1. 其它对象作为实参（拷贝构造函数）
2. 在创建对象的同时赋值（赋值运算符）
3. 函数形参为类的类型（隐式调用拷贝构造函数，以初始化形参对象）
4. 函数返回值为类的类型（隐式调用拷贝构造函数，以返回临时对象）

## 二、深拷贝和浅拷贝

什么是浅拷贝？请看下面这个例子：

```cpp
#include <iostream>
#include <cstring>
using namespace std;

class String  
{  
public:  
    String(const char *pStr = "")  
    {  
        if(NULL == pStr)  
        {  
            pstr = new char[1];  
            *pstr = '\0';  
        }  
        else  
        {  
            pstr = new char[strlen(pStr)+1];  
            strcpy(pstr,pStr);  
        }  
    }  
      
    String(const String &s)  
        :pstr(s.pstr)   
    {}  
      
    String& operator=(const String&s)  
    {  
        if(this != &s)  
        {  
            delete[] pstr; 
            pstr = s.pstr;
        }   
        return *this;  
    }  
      
    ~String()  
    {  
        if(NULL != pstr)  
        {  
            delete[] pstr;  
            pstr = NULL;
        }   
    }   
    friend ostream&operator<<(ostream & _cout,const String &s)  
    {  
        _cout<<s.pstr;  
        return _cout;  
    }  
private:  
    char *pstr;       
}; 

int main()  
{     
    String s1("sss");  
    String s2(s1);  
    String s3(NULL);  
    s3 = s1;  
    cout<<s1<<endl;  
    cout<<s2<<endl;  
    cout<<s3<<endl;  
    return 0;  
} 
```

以上的复制行为都是浅拷贝——没有开辟新的空间，而是直接把新的指针指向旧的地址。上面的程序执行完释放s3，可以正常释放，但是释放s2的时候，由于s3已经释放过了，所以s2所指的这段空间已经不属于s1或s2了，所以接下来调用析构函数的delete的时候，必然程序崩溃。

如果把上面的例子改成深拷贝，就不会出错。什么是深拷贝？请看下面这个例子：

```cpp
class String  
{  
public:  
    String(const char* pStr = "")  
    {     
        cout<<"String()"<<endl;  
        if(NULL == pStr)  
        {  
            pstr = new char[1];  
            *pstr = '\0';  
        }  
        else  
        {  
            pstr = new char[strlen(pStr)+1];  
            strcpy(pstr,pStr);   
        }  
    }  
    String(const String &s)  
        :pstr(new char[strlen(s.pstr)+1])  
    {  
        strcpy(pstr,s.pstr);   
    }  
        
    String& operator=(const String &s)  
    {  
        if(this != &s)  
        {  
            char* tmp = new char[strlen(s.pstr)+1];//pstr;  
            delete[] pstr;  
            strcpy(tmp,s.pstr);  
            pstr = tmp;  
        }  
        return *this;  
    }  
        
    ~String()  
    {  
        if(NULL != pstr)  
        {  
            delete[] pstr;  
            pstr = NULL;      
        }  
    }     
private:  
    char *pstr;  
};  
```

每次都开辟了一片新内存，并且把原来的内容复制到里面，所以没有上面的问题。但是，这么做可能会面临内存泄漏，可以用这个方法改进一下：

```cpp
String temp(s._ptr);  
std::swap(_ptr, temp._ptr); 
```

使用临时变量，它会自动调用构造函数开辟空间，然后交换空间，退出函数之后销毁，避免了内存泄漏。

```cpp
String& operator=(const String& s)  
{    
    String temp(s);  
    swap(_ptr, temp._ptr);  
    return *this;  
} 
String(const String& s)  :_ptr(NULL)  
{  
    String temp(s._ptr);  
    std::swap(_ptr, temp._ptr);  
}  
```

如果一个类拥有指针类型的成员变量，那么绝大部分情况下就需要深拷贝，因为只有这样，才能将指针指向的内容再复制出一份来，让原有对象和新生对象相互独立，彼此之间不受影响。如果类的成员变量没有指针，一般浅拷贝足以。

## 三、重载赋值运算符

当以拷贝的方式初始化一个对象时，会调用拷贝构造函数；当给一个对象赋值时，会调用重载过的赋值运算符。即使我们没有显式的重载赋值运算符，编译器也会以默认地方式重载它。默认重载的赋值运算符功能很简单，就是将原有对象的所有成员变量一一赋值给新对象，这和默认拷贝构造函数的功能类似。

对于简单的类，默认的赋值运算符一般就够用了，我们也没有必要再显式地重载它。但是当类持有其它资源时，例如动态分配的内存、打开的文件、指向其他数据的[指针](https://link.zhihu.com/?target=http%3A//c.biancheng.net/c/80/)、网络连接等，默认的赋值运算符就不能处理了，我们必须显式地重载它，这样才能将原有对象的所有数据都赋值给新对象。

```cpp
#include <iostream>
#include <cstdlib>
#include <cstring>
using namespace std;

class Array{
public:
    Array(int len);
    Array(const Array &arr); 
    ~Array();
public:
    int operator[](int i) const { return m_p[i]; } 
    int &operator[](int i){ return m_p[i]; } 
    Array & operator=(const Array &arr);  
    int length() const { return m_len; }
private:
    int m_len;
    int *m_p;
};

Array::Array(int len): m_len(len){
    m_p = (int*)calloc( len, sizeof(int) );
}

Array::Array(const Array &arr){ 
    this->m_len = arr.m_len;
    this->m_p = (int*)calloc( this->m_len, sizeof(int) );
    memcpy( this->m_p, arr.m_p, m_len * sizeof(int) );
}

Array::~Array(){ free(m_p); }

Array &Array::operator=(const Array &arr){ 
    if( this != &arr){  
        this->m_len = arr.m_len;
        free(this->m_p);  
        this->m_p = (int*)calloc( this->m_len, sizeof(int) );
        memcpy( this->m_p, arr.m_p, m_len * sizeof(int) );
    }
    return *this;
}

void printArray(const Array &arr){
    int len = arr.length();
    for(int i=0; i<len; i++){
        if(i == len-1){
            cout<<arr[i]<<endl;
        }else{
            cout<<arr[i]<<", ";
        }
    }
}

int main(){
    Array arr1(10);
    for(int i=0; i<10; i++){
        arr1[i] = i;
    }
    printArray(arr1);
   
    Array arr2(5);
    for(int i=0; i<5; i++){
        arr2[i] = i;
    }
    printArray(arr2);
    arr2 = arr1;  
    printArray(arr2);
    arr2[3] = 234;  
    arr2[7] = 920;
    printArray(arr1);
   
    return 0;
}
```

上面这个例子，首先重载运算符的返回值类型为Array &，这样可以避免返回数据时调用构造函数，还可以像这样连续赋值：

```text
arr4 = arr3 = arr2 = arr1;
```

再者if（this!=&arr）这一语句的作用是判断是否给同一对象赋值，如果是的话跳过，不是的话进行重新分配内存并赋值的过程。

然后，重载运算符的形参类型为const Array &，这样避免在传参时调用拷贝构造函数，还能同时接收非const和const类型的实参。

最后，可以给参数设置默认值，增加鲁棒性。

## 四、拷贝控制操作的三/五法则

定义一个类时，我们显式地或隐式地指定了此类型的对象在拷贝、赋值和销毁时做什么。一个类通过定义三种特殊的成员函数来控制这些操作，分别是**拷贝构造函数**、**赋值运算符**和**析构函数**。拷贝构造函数定义了当用同类型的另一个对象初始化新对象时做什么，赋值运算符定义了将一个对象赋予同类型的另一个对象时做什么，析构函数定义了此类型的对象销毁时做什么。我们将这些操作称为**拷贝控制操作**。

由于拷贝控制操作是由三个特殊的成员函数来完成的，所以我们称此为“C++三法则”。在较新的 C++11 标准中，为了支持移动语义，又增加了移动构造函数和移动赋值运算符，这样共有五个特殊的成员函数，所以又称为“C++五法则”。也就是说，“三法则”是针对较旧的 C++89 标准说的，“五法则”是针对较新的 C++11 标准说的。为了统一称呼，后来人们干把它叫做“C++ 三/五法则”。[[1\]](https://zhuanlan.zhihu.com/p/157833251#ref_1)

如果一个类需要定义析构函数，那么几乎可以肯定这个类也需要一个拷贝构造函数和一个赋值运算符。默认的析构函数不会释放人为设置的内存，所以我们需要显式地定义一个析构函数来释放内存。

我们使用上一小节的Array类，假设我们为其定义了析构函数，但是用默认的拷贝构造函数和赋值运算符，，那么将导致不同对象之间相互干扰，修改一个对象的数据会影响另外的对象。此外还可能会导致内存操作错误：

```cpp
    Array func(Array arr){ 
        Array ret = arr; 
        return ret; 
    }
```

当 func() 返回时，arr 和 ret 都会被销毁，在两个对象上都会调用析构函数，此析构函数会 free() 掉 m_p 成员所指向的动态内存。但是，这两个对象的 m_p 成员指向的是同一块内存，所以该内存会被 free() 两次，这显然是一个错误，将要发生什么是未知的。

此外，func() 的调用者还会继续使用传递给 func() 的对象：

```cpp
    Array arr1(10);
    func(arr1);  
    Array arr2 = arr1;  
```

arr2（以及 arr1）指向的内存不再有效，在 arr（以及 ret）被销毁时系统已经归还给操作系统了。

**如果一个类需要定义析构函数，那么几乎可以肯定它也需要定义拷贝构造函数和赋值运算符。**

需要拷贝操作的类也一定需要赋值操作，反之亦然。虽然很多类需要定义所有（或是不需要定义任何）拷贝控制成员，但某些类所要完成的工作，只需要拷贝或者赋值操作，不需要析构操作。

考虑一个类为每个对象分配一个独有的、唯一的编号。这个类除了需要一个拷贝构造函数为每个新创建的对象生成一个新的编号，还需要一个赋值运算符来避免将一个对象的编号赋值给另外一个对象。但是，这个类并不一定需要析构函数。

**如果一个类需要一个拷贝构造函数，几乎可以肯定它也需要一个赋值运算符；反之亦然。然而，无论需要拷贝构造函数还是需要复制运算符，都不必然意味着也需要析构函数。**

（如有转载请注明作者与出处，欢迎建议和讨论，thanks）

## 参考

1. [^](https://zhuanlan.zhihu.com/p/157833251#ref_1_0)http://c.biancheng.net/view/vip_2338.html

发布于 2020-07-08 23:16