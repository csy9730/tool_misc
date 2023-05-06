# 【C++】标准模板库（STL）：超快入门！算法竞赛必看！

[![Nice小夫](https://pic3.zhimg.com/v2-3b84d858c1064597e9fe15c01ebf48f0_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/fu-yan-ying-65)

[Nice小夫](https://www.zhihu.com/people/fu-yan-ying-65)

我知道得越多，越觉得自己渺小



87 人赞同了该文章



![img](https://pic4.zhimg.com/80/v2-9f7ca16b24333ffc938601c6c192e3fb_1440w.jpg)

## 什么是C++标准模板库（STL）？

**标准模板库 STL**（Standard Template Library），是 C++ 标准库的一部分，不需要单独安装，只需要#include 头文件。

C++ 对模板（Template）支持得很好，STL 就是借助模板把常用的数据结构及其算法都实现了一遍，并且做到了**数据结构和算法的分离**。

C++ 语言的核心优势之一就是便于软件的复用。

C++ 语言有两个方面体现了复用：

- 面向对象的继承和多态机制
- 通过模板的概念实现了对泛型程序设计的支持

C++中的模板，就好比英语作文的模板，**只换主题，不换句式和结构**。对应到C++模板，就是**只换类型，不换方法**。

## STL有什么优势？

STL封装了很多实用的容器，省时省力，能够让你将更多心思放到解决问题的步骤上，而非费力去实现数据结构诸多细节上，**像极了用python时候的酣畅淋漓**。

P.S. 如果你对STL源码颇有兴趣，那你不妨拜读C++大师[侯捷](https://link.zhihu.com/?target=https%3A//baike.baidu.com/item/%E4%BE%AF%E6%8D%B7/1760197%3Ffr%3Daladdin)的杰作《**STL源码剖析**》。

![img](https://pic1.zhimg.com/80/v2-a51e894ba7ab3b87eea0747d818d4534_1440w.jpg)

学习编程的人都知道，阅读、剖析名家代码乃是提高水平的捷径。

**源码之前，了无秘密。**

大师们的缜密思维、经验结晶、技术思路、独到风格，都原原本本体现在源码之中。

## STL六大部件

- 容器（Containers）
- 分配器（Allocators）
- 算法（Algorithm）
- 迭代器（Iterators）
- 适配器（Adapters）
- 仿函数（Functors）

要真正提高C++编程效率，需要将STL六大部件结合使用，才能大放异彩。所谓部件，也即是零件，需要将这六大零件组装在一起，配合使用，整整齐齐。

## 知识点总览

![img](https://pic2.zhimg.com/80/v2-6375b40ce368789ee75ac6dc25d292c1_1440w.jpg)



------

![img](https://pic2.zhimg.com/80/v2-9b2eec7cdf9ac3ea6134fddaaa4022e5_1440w.jpg)

------

vector（矢量），是一种「**变长数组**」，即“自动改变数组长度的数组”。

值得一提的是，vector可以用来以**邻接表**的方式储存图，非常友好，非常简洁。

要使用vector，需要添加头文件：

```cpp
#include <vector>
using namespace std;
```

## 1.vector的定义

像定义变量一样定义vector变量：

```cpp
vector<类型名> 变量名;
```

类型名可以是int、double、char、struct，也可以是STL容器：vector、set、queue。

```cpp
vector<int> name;
vector<double> name;
vector<char> name;
vector<struct node> name;
vector<vector<int> > name;//注意：> >之间要加空格
```

**注意：**vector<vector<int> > name; **>>之间要加空格。**

vector数组就是一个一维数组,如果定义成vector数组的数组，那就是二维数组**。**

```text
vector<int> array[SZIE]; //二维变长数组
```

在此，我送你一句话非常受用的话：**低维是高维的地址。**

**二维数组中，它的一维形式就是地址。例如：**

```cpp
#include <iostream>
using namespace std;

int main(){
    int arr[3][2];//定义一个3行2列的地址
    cout<<arr[0]<<endl; //输出arr第1行的地址
    cout<<arr[1]<<endl; //输出arr第2行的地址
    cout<<arr[2]<<endl; //输出arr第3行的地址
    return 0;
}
```

输出：

```cpp
0x61fe00 //arr第1行的地址
0x61fe08 //arr第2行的地址
0x61fe10 //arr第3行的地址
```

所以，vector容器也可以这样理解。

## 2.vector容器内元素的访问

vector一般有两种访问方式：

**（1）通过下标访问**

```cpp
#include <iostream>
#include <vector>
using namespace std;

int main(){
    vector<int> vi;
    vi.push_back(1);
    cout<<vi[0]<<endl;
    return 0;
}
```

输出：

```cpp
1
```

**（2）通过迭代器访问**

迭代器（iterator）可以理解为指针：

```cpp
vector<类型名>::iterator 变量名;
```

例如：

```cpp
vector<int>::iterator it;
vector<double>::iterator it;
```

举个栗子：

```cpp
#include <iostream>
#include <vector>
using namespace std;

int main(){
    vector<int> v;
    for (int i = 0; i < 5; i++)
    {
        v.push_back(i);
    }
    //v.begin()返回v的首元素地址
    vector<int>::iterator it=v.begin();
    for (int i = 0; i < v.size(); i++)
    {
       cout<<it[i]<<" ";
    }
    return 0;
}
```

输出：

```cpp
0 1 2 3 4
```

for循环迭代部分也可以写成：

```cpp
    vector<int>::iterator it=v.begin();
    for (int i = 0; i < v.size(); i++)
    {
       cout<<*(it+i)<<" ";
    }
```

也即是

```cpp
it[i] = *(it+i) //这两个写法等价
```

这是简单的常识，以后不再提及。

与此同时，迭代器与for循环还有一种优雅的写法。

```cpp
#include <iostream>
#include <vector>
using namespace std;

int main(){
    vector<int> v;
    for (int i = 0; i < 5; i++)
    {
        v.push_back(i);
    }
    //vector的迭代器不支持it<v.end()的写法，因此循环条件只能it!=v.end()
    for (vector<int>::iterator it=v.begin(); it!=v.end();it++)
    {
        cout<<*it<<" ";
    }
    return 0;
}
```

此种写法与**遍历字符串**有**异曲同工之妙**：

```cpp
#include <iostream>
#include <vector>
using namespace std;

int main(){
    string str;
    str="Hello World";
    for (int i = 0; str[i]!='\0'; i++)
    {
        cout<<str[i]<<" ";
    }
    return 0;
}
```

输出：

```cpp
H e l l o   W o r l d
```

## 3.vector常用函数实例解析

- push_back()
- pop_back()
- size()
- clear()
- insert()
- erase()

### **（1）push_back()**

```cpp
void std::vector<int>::push_back(const int &__x)
```

见名知意，push_back(item)就是在vector后面添加一个元素item。

用例：

```cpp
#include <iostream>
#include <vector>
using namespace std;

int main(){
    vector<int> v;
    for (int i = 0; i < 5; i++)
    {
        v.push_back(i);
    }
    for (int i = 0; i < v.size(); i++)
    {
        cout<<v[i]<<" ";
    }
    return 0;
}
```

以前还要为定长数组内存分配而苦恼时，现在只需要无脑push_back()就好了。

### **（2）pop_back()**

```cpp
void std::vector<int>::pop_back()
```

push和pop时一对反义词，学过数据结构的人都知道，栈元素的压入和弹出就是push和pop。

须知，pop_back()一次弹出一个元素，vector容器就会减少一个预算。

之所以叫容器，就是能往里面装一个一个的元素。

用例：

```cpp
#include <iostream>
#include <vector>
using namespace std;

int main(){
    vector<int> v;
    for (int i = 0; i < 5; i++)
    {
        v.push_back(i);
    }
    cout<<"pop_back前:"<<endl;
    for (int i = 0; i < v.size(); i++)
    {
        cout<<v[i]<<" ";
    }
    cout<<endl;
    v.pop_back();
    cout<<"pop_back后:"<<endl;

    for (int i = 0; i < v.size(); i++)
    {
        cout<<v[i]<<" ";
    }
    return 0;
}
```

输出：

```cpp
pop_back前:
0 1 2 3 4
pop_back后:
0 1 2 3
```

### （3）size()

```cpp
std::size_t std::vector<int>::size()
```

szie()返回vector中所含元素的个数，时间复杂度为O(1)。

用例：

```cpp
#include <iostream>
#include <vector>
using namespace std;

int main(){
    vector<int> v;
    for (int i = 0; i < 5; i++)
    {
        v.push_back(i);
    }
    cout<<v.size()<<endl;
    return 0;
}
```

输出：

```cpp
5
```

### （4）clear()

```cpp
void std::vector<int>::clear()
```

clear()用于**一键清空vector中的所有元素**，**时间复杂度为O(N)**，其中N为vector中原属和元素的个数。

用例：

```cpp
#include <iostream>
#include <vector>
using namespace std;

int main(){
    vector<int> v;
    for (int i = 0; i < 5; i++)
    {
        v.push_back(i);
    }
    for (int i = 0; i < v.size(); i++)
    {
        cout<<v[i]<<" ";
    }
    v.clear();
    cout<<endl;
    cout<<"size = "<<v.size()<<endl;
    return 0;
}
```

输出：

```cpp
0 1 2 3 4 
size = 0
```

### （5）insert()

```cpp
insert(__position,__x);
insert(要插入的地址，要插入的元素);

参数：
__position：– A const_iterator into the %vector.
__x:– Data to be inserted.
```

与push_back()无脑在尾部添加元素不同的是，insert()是根据指定位置在vector中插入元素。

用例：

```cpp
#include <iostream>
#include <vector>
using namespace std;

int main(){
    vector<int> v;
    for (int i = 0; i < 5; i++)
    {
        v.push_back(i);
    }
    for (int i = 0; i < v.size(); i++)
    {
        cout<<v[i]<<" ";
    }
    v.insert(v.begin()+2,-1); //将-1插入v[2]的位置
    cout<<endl;
    for (int i = 0; i < v.size(); i++)
    {
        cout<<v[i]<<" ";
    }
    return 0;
}
```

输出：

```cpp
0 1 2 3 4 
0 1 -1 2 3 4
```

### **（6）erase()**

```cpp
erase(__position);
```

同样，与clear()简单粗暴清空vector不同的是erase()，删除指定位置的元素。

erase()有两种用法：

- 删除一个元素
- 删除一个区间内的元素

**1.删除一个元素**

```cpp
erase(__position);
```

用例：

```cpp
#include <iostream>
#include <vector>
using namespace std;

int main(){
    vector<int> v;
    for (int i = 0; i < 5; i++)
    {
        v.push_back(i);
    }
    for (int i = 0; i < v.size(); i++)
    {
        cout<<v[i]<<" ";
    }
    //删除v[3]
    v.erase(v.begin()+3);
    cout<<endl;
    for (int i = 0; i < v.size(); i++)
    {
        cout<<v[i]<<" ";
    }
    return 0;
}
```

输出：

```cpp
0 1 2 3 4 
0 1 2 4
```

**2.删除一个区间内的元素**

```cpp
erase(__positionBegin,__positionEnd);
```

即是删除[ __positionBegin,__positionEnd )区间内的元素，注意：是左闭右开！

用例：

```cpp
#include <iostream>
#include <vector>
using namespace std;

int main(){
    vector<int> v;
    for (int i = 0; i < 5; i++)
    {
        v.push_back(i);
    }
    for (int i = 0; i < v.size(); i++)
    {
        cout<<v[i]<<" ";
    }
    //删除v[1]到v[4]的元素
    v.erase(v.begin()+1,v.begin()+4);
    cout<<endl;
    for (int i = 0; i < v.size(); i++)
    {
        cout<<v[i]<<" ";
    }
    return 0;
}
```

输出：

```cpp
0 1 2 3 4 
0 4
```

## 3.vector常见用途

**（1）储存数据**

vector本身可以作为数组使用，而且在一些元素个数不确定的场合可以很好地节省空间。

**（2）用邻接表存储图**

使用vector实现邻接表，更为简单。

------

![img](https://pic4.zhimg.com/80/v2-1391b3bbb9d6f476dd36f65fc90f8bcf_1440w.jpg)

------

set（集合），是一个**内部自动有序**且**不含重复元素**的容器。

set可以在需要去重复元素的情况大放异彩，节省时间，减少思维量。

要使用set，需要添加头文件：

```cpp
#include <set>
using namespace std;
```

## 1.set的定义

像定义变量一样定义set变量：

```cpp
set<类型名> 变量名;
```

类型名可以是int、double、char、struct，也可以是STL容器：vector、set、queue。

用例：

```cpp
set<int> name;
set<double> name;
set<char> name;
set<struct node> name;
set<set<int> > name;//注意：> >之间要加空格
```

set数组的定义和vector相同：

```cpp
set<类型名> array[SIZE];
```

例如：

```cpp
set<int> arr[10];
```

## 2.set容器内元素的访问

**set只能通过迭代器(iterator)访问**：

```cpp
set<int>::iterator it;
set<char>::iterator it;
```

这样，就得到了迭代器it，并且可以通过***it**来访问set里的元素。

注意：

除了vector和string之外的STL容器都不支持*(it+i)的访问方式，因此只能按照如下方式枚举：

```cpp
#include <iostream>
#include <set>
using namespace std;

int main()
{
    set<int> st;
    st.insert(5);
    st.insert(2);
    st.insert(6);
    for (set<int>::iterator it = st.begin(); it != st.end(); it++)
    {
        cout << *it << endl;
    }
    return 0;
}
```

输出：

```cpp
2
5
6
```

我们可以看到，原本无序的元素，被插入set集合后，**set内部的元素自动递增排序，并且自动去除了重复元素**。

## 3.set常用函数实例解析

**（1）insert()**

插入元素十分简单。

```cpp
#include <iostream>
#include <set>
using namespace std;

int main()
{
    set<char> st;
    st.insert('C');
    st.insert('B');
    st.insert('A');
    for (set<char>::iterator it = st.begin(); it != st.end(); it++)
    {
        cout << *it << endl;
    }
    return 0;
}
```

**（2）find()**

**find(value)返回的是set中value所对应的迭代器，也就是value的指针（地址）**。

```cpp
#include <iostream>
#include <set>
using namespace std;
int main()
{
    set<int> st;
    for (int i = 1; i <= 3; i++)
    {
        st.insert(i);
    }

    set<int>::iterator it = st.find(2); //在set中查找2，返回其迭代器
    cout << *it << endl;

    // 以上可以直接x携程
    cout << *(st.find(2)) << endl;
    return 0;
}
```

输出：

```cpp
2
2
```

**（3）erase()**

erase()有两种用法：删除单个元素、删除一个区间内的所有元素。

**1.删除单个元素**

删除单个元素有两种方法：

- st.erase(it)，其中it为所需要删除元素的迭代器。时间复杂度为O(1)。可以结合find()函数来使用。

```cpp
#include <iostream>
#include <set>
using namespace std;

int main()
{
    set<int> st;
    st.insert(100);
    st.insert(200);
    st.insert(100);
    st.insert(300);
    // 删除单个元素
    st.erase(st.find(100)); //利用find()函数找到100,然后用erase删除它
    st.erase(st.find(200));
    for (set<int>::iterator it = st.begin(); it != st.end(); it++)
    {
        cout << *it << endl;
    }
    return 0;
}
```

输出：

```cpp
300
```

- st.erase(value)，value为所需要删除元素的值。其时间复杂度为O(logN)，N为set内的元素个数。

```cpp
#include <iostream>
#include <set>
using namespace std;

int main()
{
    set<int> st;
    st.insert(100);
    st.insert(200);
    st.insert(100);
    st.insert(300);
    // 删除单个元素
    st.erase(100);
    for (set<int>::iterator it = st.begin(); it != st.end(); it++)
    {
        cout << *it << endl;
    }
    return 0;
}
```

输出：

```cpp
200
300
```

**2.删除一个区间内的所有元素**

**st.erase(iteratorBegin , iteratorEnd)可以删除一个区间内的所有元素。**

其中**iteratorBegin**为所需要删除区间的起始迭代器

**iteratorEnd**为所需要删除区间的结束迭代器的下一个地址

也即是**[iteratorBegin,iteratorEnd)**

```cpp
#include <iostream>
#include <set>
using namespace std;

//2.删除一个区间内的所有元素

int main()
{
    set<int> st;
    st.insert(100);
    st.insert(200);
    st.insert(100);
    st.insert(300);
    set<int>::iterator it = st.find(200);
    st.erase(it, st.end());
    for (it = st.begin(); it != st.end(); it++)
    {
        cout << *it << endl;
    }
    return 0;
}
```

输出：

```cpp
100
```

**（4）size()**

不难理解，szie()用来实时获得set内元素的个数，时间复杂度为O(1)。

```cpp
#include <iostream>
#include <set>
using namespace std;
int main()
{
    set<int> st;
    st.insert(2);
    st.insert(5);
    st.insert(4);
    cout << st.size() << endl;
    return 0;
}
```

输出：

```cpp
3
```

未完，更新ing。

![img](https://pic3.zhimg.com/80/v2-141d34ceb526af4e19d5444e7c005a42_1440w.jpg)

------







编辑于 2021-07-27 18:50

STL

C++

教程