# placement new机制

[![AlexNoBug](https://pica.zhimg.com/v2-7b291b9b38c5c8fc361069d34cc38a8f_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/alex-61-32-44)

[AlexNoBug](https://www.zhihu.com/people/alex-61-32-44)



腾讯 研发工程师



16 人赞同了该文章

一般来说，使用new申请空间时，是从系统的“堆”（heap）中分配空间。申请所得的空间的位置是根据当时的内存的实际使用情况决定的。但是，在某些特殊情况下，可能需要在已分配的特定内存创建对象，这就是所谓的“定位放置new”（placement new）操作。

定位放置new操作的语法形式不同于普通的new操作。例如，一般都用如下语句A* p=new A;申请空间，而定位放置new操作则使用如下语句A* p=new (ptr)A;申请空间，其中ptr就是程序员指定的内存首地址。考察如下程序。

```cpp
#include <iostream>
using namespace std;
 
class A
{
public:
	A()
	{
		cout << "A's constructor" << endl;
	}
 
 
	~A()
	{
		cout << "A's destructor" << endl;
	}
	
	void show()
	{
		cout << "num:" << num << endl;
	}
	
private:
	int num;
};
 
int main()
{
	char mem[100];
	mem[0] = 'A';
	mem[1] = '\0';
	mem[2] = '\0';
	mem[3] = '\0';
	cout << (void*)mem << endl;
	A* p = new (mem)A;
	cout << p << endl;
	p->show();
	p->~A();
	getchar();
}
```

1）用定位放置new操作，既可以在栈(stack)上生成对象，也可以在堆（heap）上生成对象。如本例就是在栈上生成一个对象。

（2）使用语句A* p=new (mem) A;定位生成对象时，指针p和数组名mem指向同一片存储区。所以，与其说定位放置new操作是申请空间，还不如说是利用已经请好的空间，真正的申请空间的工作是在此之前完成的。

（3）使用语句A *p=new (mem) A;定位生成对象时，会自动调用类A的构造函数，但是由于对象的空间不会自动释放（对象实际上是借用别人的空间），所以必须显示的调用类的析构函数，如本例中的p->~A()。

（4）如果有这样一个场景，我们需要大量的申请一块类似的内存空间，然后又释放掉，比如在在一个server中对于客户端的请求，每个客户端的每一次上行数据我们都需要为此申请一块内存，当我们处理完请求给客户端下行回复时释放掉该内存，表面上看者符合c++的内存管理要求，没有什么错误，但是仔细想想很不合理，为什么我们每个请求都要重新申请一块内存呢，要知道每一次内从的申请，系统都要在内存中找到一块合适大小的连续的内存空间，这个过程是很慢的（相对而言)，极端情况下，如果当前系统中有大量的内存碎片，并且我们申请的空间很大，甚至有可能失败。为什么我们不能共用一块我们事先准备好的内存呢？可以的，我们可以使用placement new来构造对象，那么就会在我们指定的内存空间中构造对象。