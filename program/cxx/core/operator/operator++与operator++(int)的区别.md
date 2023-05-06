# operator++与operator++(int)的区别

[![彪莫婆婆](https://picx.zhimg.com/v2-614172245a20b9858588a065c35e47fc_l.jpg?source=32738c0c)](https://www.zhihu.com/people/biao-mo-po-po)

[彪莫婆婆](https://www.zhihu.com/people/biao-mo-po-po)

我是要成为海贼王的男人

2 人赞同了该文章

在进行侯捷老师的STL源码阅读时碰到了重载函数operator++() 与operator++(int) ，这让我产生比较大的困惑，为什么operator++(int)需要站位参数，有什么区别么？

刚开始由于无法区分++与--的前缀调用与后缀调用一直被人诟病，最后C++语言得到了扩展，允许重载++与--;



然而语法上确有一个问题，重载函数的区别在于他们参数类型的差异。但不论++与--的前缀和后缀都只有一个参数，***\*C++规定后缀调用需要有一个int型参数作为区分前缀与后缀调用的区别\****

~~~cpp
```cpp
class ListNode {
public：
	ListNode& operator++();

	const ListNode operator++(int);

	ListNode& operator--();

	const ListNode operator--(int);
	ListNode& operator+=(int);
};

void test()
{
	ListNode test;

	test++; //其实就是调用operator++（0）；

	++test; //其实就是调用operator++();

	--test; //其实就是调用operator--（）；

	test--; //其实就是调用operator--(int);
}
```
~~~



其中要注意的是后缀返回一个const类型，与前缀不同。



***\*我们都知道前缀叫做增加后取回，后缀是取回后增加\****

所以在使用后缀的时候需要进行const进行限制，这样也符合规范；



~~~cpp
```cpp
ListNode& ListNode::operator++()
{
	*this += 1; //增加

	return *this;//返回值
}

const ListNode ListNode::operator++(int)
{
	ListNode tmp = *this;//取值

	++(*this); //增加

	return tmp; //返回被取回的值
}
```
~~~



**后缀的参数并没有使用只是用来区分与前缀的区别调用，后缀必须返回一个对象（增加前的值），假设没有const对象**



~~~cpp
```cpp
ListNode i;

i++++; 进行两次增加操作
```
~~~



其实上面的写法等于这种

~~~cpp
```cpp
i.operator++(0).operator++(0);
```
~~~



很明显第一个operator++调用了第二个operator++函数。



有两个理由导致我们应该厌恶上述这种做法，第一是与内置类型行为不一致。当设计一个类遇到问题时，一个好的准则是使该类的行为与int类型一致。而int类型不允许连续进行两次后缀++：



~~~cpp
```cpp
int i;
i++++; // 错误!
```
~~~



　　第二个原因是使用两次后缀++所产生的结果与调用者期望的不一致。如上所示，第二次调用operator++改变的值是第一次调用返回对象的值，而不是原始对象的值。因此如果：



~~~cpp
```cpp
i++++;
```
~~~



是合法的，i将仅仅增加了一次。这与人的直觉相违背，使人迷惑（对于int类型和ListNode都是一样）,所以最好禁止这么做。



　　C++禁止int类型这么做，同时你也必须禁止你自己写的类有这样的行为。最容易的方法是让后缀++返回const对象。当编译器遇到这样的代码：



~~~cpp
```cpp
i++++; // same as i.operator++(0).operator++(0);
```
~~~



这这种情况下没第一个operator++函数返回了一个const对象，接着又调用了operator++，然而这个函数是一个non-const成员函数，所以不能调用这个函数。





　　如果你很关心效率问题，当你第一次看到后缀++函数时, 你可能觉得有些问题。这个函数必须建立一个临时对象以做为它的返回值，上述实现代码建立了一个显示的临时对象（test），这个临时对象必须被构造并在最后被结构。前缀++函数没有这样的临时对象。由此得出一个令人惊讶的结论，如果仅为了提高代码效率，ListNode的调用者应该尽量使用前缀++，少用后缀++，除非确实需要使用后缀++。让我们明确一下，当处理用户定义的类型时，尽可能地使用前缀++，因为它的效率较高。



　　我们再观察一下后缀与前缀++操作符。它们除了返回值不同外，所完成的功能是一样的，即值加一。简而言之，它们被认为功能一样。那么你如何确保后缀++和前缀++的行为一致呢？当不同的程序员去维护和升级代码时，有什么能保证它们不会产生差异？除非你遵守上述代码里的原则，这才能得到确保。这个原则是后缀++和--应该根据它们的前缀形式来实现。你仅仅需要维护前缀版本，因为后缀形式自动与前缀形式的行为一致。





本文借鉴与引用作者[[operator++()和operator++(int)的区别_cjluxuwei的专栏-CSDN博客\]](https://link.zhihu.com/?target=https%3A//blog.csdn.net/cjluxuwei/article/details/41810867%3Futm_medium%3Ddistribute.pc_relevant.none-task-blog-baidujs_title-1%26spm%3D1001.2101.3001.4242)



发布于 2021-04-15 11:14

[C++](https://www.zhihu.com/topic/19584970)

[C / C++](https://www.zhihu.com/topic/19601705)

[编程](https://www.zhihu.com/topic/19554298)