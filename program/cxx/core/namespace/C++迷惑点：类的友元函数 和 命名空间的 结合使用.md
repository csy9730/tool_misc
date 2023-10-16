# C++迷惑点：类的友元函数 和 命名空间的 结合使用

[![知乎用户788hn8](https://picx.zhimg.com/v2-abed1a8c04700ba7d72b45195223e0ff_l.jpg?source=172ae18b)](https://www.zhihu.com/people/Zarhani)

[知乎用户788hn8](https://www.zhihu.com/people/Zarhani)

1 人赞同了该文章

假设有一种情况，命名空间 MySpace 中有一个类叫 MyClass, 里面有一个**私有的静态变量 amount,** 现使用类外函数 MySpace::MyFriend()读取 MySpace::MyClass::amount 的值：

![img](https://pic1.zhimg.com/80/v2-4c57d82b8f7cd11229f39fcf9dfbaa30_720w.webp)

显然，上图的结构是错误的，因为amount 是**私有成员**，类外函数无法访问。



那么，将类外函数 MySpace::MyFriend()设置为 类 MyClass 的**友元函数**呢？

![img](https://pic2.zhimg.com/80/v2-54b344fde3dd84c0d5b3af033f877df1_720w.webp)

```text
#include <iostream>

namespace MySpace
{
    class MyClass
    {
       private:
         static int amount;
         friend void MyFriend();// 默认指的是 MySpace::MyFriend();
    };
}

namespace MySpace
{
    int MyClass::amount = 10;

    void MyFriend()   // 友元函数的实现 MyFriend，这里必须将其包含到命名空间中，而不是使用using namespace
    {
        using namespace std;
        std::cout << MyClass::amount;
    } 
}

int main()
{
    using namespace MySpace;
    MyFriend();
    return 0;
}
```

编译后输出「10」，结果正确。

![img](https://pic2.zhimg.com/80/v2-ed2b93f1f3c55961b6c65f72a9dc0e39_720w.webp)

注意上述代码中的这个地方



上一种方法，是直接将友元函数的实现**用大括号包含到命名空间中**，不需要额外的函数声明。

下面这种方法，将友元函数的实现**用「::」符号包含到了命名空间中**，**此时必须需要额外的函数声明，否则报错**

### **（friend 关键词只告诉编译器它能访问私有成员，并不能达到声明函数的效果！！！）**

```text
#include <iostream>

namespace MySpace
{
    class MyClass
    {
       private:
         static int amount;
         friend void MyFriend();// 默认指的是 MySpace::MyFriend();
    };
	
	// ↓↓↓↓↓↓ ↓↓↓↓ ↓↓↓↓↓↓↓↓ ↓↓
	 void MyFriend(); // ===如果使用这种写法，必须在这里加入声明!!!!!!!!!!!!
	// ↑↑↑↑↑↑↑↑↑↑ ↑↑↑↑↑↑↑↑↑↑ ↑↑↑↑↑↑↑↑↑↑
}

//========== 另一种方式：使用「::」号将其包含到命名空间中：

int MySpace::MyClass::amount = 10;

void MySpace::MyFriend()   // 友元函数的实现 MyFriend，这里必须将其包含到命名空间中，而不是使用using namespace
{
	using namespace std;
	std::cout << MyClass::amount;
} 


int main()
{
    using namespace MySpace;
    MyFriend();
    return 0;
}
```

![img](https://pic4.zhimg.com/80/v2-23f49a4304d13802fc0965f3161d78af_720w.webp)

注意代码中的这个地方

![img](https://pic4.zhimg.com/80/v2-3f325406704cadbec599078a5c2e4227_720w.webp)

这里也发生了改变

编译通过，与前一种代码效果相同。







------



再看看这种情况，我们 **将友元函数 MyFriend() 放到了 命名空间的外面：**

![img](https://pic3.zhimg.com/80/v2-0bd4a9fc3e91fc415b65ee5993119bd6_720w.webp)

MyFriend() 放到了命名空间的外面

因为类定义中 friend void MyFriend(); 语句**表示的是 MySpace::MyFriend()**，它会报错，因为我们声明的是 全局::MyFriend(), 而不是 MySpace::MyFriend();

**（类中的 friend 函数声明 默认 代表的是 类所在的命名空间内）**

我们将类定义中的 friend void MyFriend(); 改为 friend void **::MyFriend()**; （前面什么也不放，后面跟着双冒号代表**全局命名空间**）：

![img](https://pic3.zhimg.com/80/v2-fcf355027f77c585360b2b7edd4bb826_720w.webp)

改为 ::MyFriend(), 友元函数定位到全局命名空间

```text
#include <iostream>

namespace MySpace
{
    class MyClass
    {
       private:
         static int amount;
         friend void ::MyFriend();
    };
}


int MySpace::MyClass::amount = 10;

void MyFriend()
{
    using namespace std;
	using namespace MySpace;
    std::cout << MyClass::amount;
} 


int main()
{
    using namespace MySpace;
    MyFriend();
    return 0;
}
```



编译不通过，报错

![img](https://pic3.zhimg.com/80/v2-4418ac3812d2b5dfaf58c2bf49825b0a_720w.webp)



此时，**需要在类定义的前面声明这个友元函数！**

```text
#include <iostream>

// ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
void MyFriend();	// ！！！在这里添加声明！！！
// ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑

namespace MySpace
{
	
    class MyClass
    {
       private:
         static int amount;
         friend void ::MyFriend();
    };
}


int MySpace::MyClass::amount = 10;

void MyFriend()
{
	
    std::cout << MySpace::MyClass::amount;
} 


int main()
{
    MyFriend();
    return 0;
}
```

![img](https://pic3.zhimg.com/80/v2-e58a8af2eb9c23dd814ef42c3b349eae_720w.webp)

注意代码中的这个地方

此代码编译通过！yeah！



### **最后，提醒一下：友元关系不继承，且与放到private或public无关。**

**此外，当 A类 是 B类的 友元类（可以通过 A类的 成员函数 读取 B类的 私有成员）时，如果 A类 有一个友元函数，那么这个友元函数不随着类友元关系友元到B类中，即只能读取 A类的 私有成员，不能读取 B类的 私有成员——**

```text
#include <iostream>

#include <iostream>

class A
{
    friend class B;

// ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
    friend void MyFriend(); //不加这一句会出错，因为友元函数关系不随着友元类关系而友元
// ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑

  private:
	int a = 10; //使用B类的友元函数读取A类的私有成员
  public:

};

class B
{
    friend void MyFriend();//友元函数

  private:
	A* p_A;// 指向A类的指针
  public:
    // 构造函数，创建 B类对象时 自动给其中 p_A指针 创建 A对象
	B(){
		p_A = new A;
	}
};


B bb;  //类的实例化



void MyFriend()//友元函数
{
	std::cout << bb.p_A->a; //访问 A类的 私有成员 和 B类的 私有成员
}

int main()
{
	MyFriend();
	return 0;
}
```









编辑于 2022-03-09 11:47

[C++](https://www.zhihu.com/topic/19584970)

[C / C++](https://www.zhihu.com/topic/19601705)

[命名空间](https://www.zhihu.com/topic/19966392)