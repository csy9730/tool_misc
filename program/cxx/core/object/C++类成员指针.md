# C++类成员指针

土豆吞噬者  于 2019-04-21 20:46:35 发布  3683  收藏 13
分类专栏： C/C++ 文章标签： 类成员指针
版权

C/C++
专栏收录该内容
108 篇文章4 订阅
订阅专栏
类成员指针时指可以指向类的非静态成员的指针，一般情况下，一个指针指向一个对象，但是成员指针指示的是类的成员，而非类的对象。指向类的静态成员的指针和普通指针没有什么区别。

## 类数据成员指针
与普通指针不同的是，类数据成员指针必须在*前添加classname::以表示当前定义的指针可以指向classname的成员。



```cpp
class Person
{
public:
	const std::string name="1234";
};

int main(void)
{
	Person person1;
Person* person2 = new Person();
//str为指向Person对象的const string成员的指针
//str指定了成员name，此时没有指向任何数据
const std::string Person::*str = &Person::name;
//使用对象实例解引用成员指针
std::cout<< person1.*str <<std::endl;
std::cout << person2->*str << std::endl;
system("pause");
return 0;
}
```


## 类成员函数指针
我们也可以定义指向类的成员函数的指针，和指向数据成员的指针一样，我们使用classname::*的形式声明一个指向成员函数的指针。


	

```cpp
class Person
{
public:
	const std::string name="1234";
	bool testFunc(int height)
	{
		std::cout << height << std::endl;
		return true;
	};
};

int main(void)
{
bool (Person::*func)(int height)=&Person::testFunc;
Person person1;
(person1.*func)(10);
Person* person2 = new Person();
(person2->*func)(20);
system("pause");
return 0;
}
```


————————————————
版权声明：本文为CSDN博主「土豆吞噬者」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/xiongya8888/article/details/89439104