# C++的一大误区——深入解释直接初始化与复制初始化的区别



[ljianhui](https://me.csdn.net/ljianhui) 2013-07-04 18:07:51 ![img](https://csdnimg.cn/release/phoenix/template/new_img/articleRead.png) 25672 ![img](https://csdnimg.cn/release/phoenix/template/new_img/collect.png) 收藏 20

展开

不久前，在博客上发表了一篇文章——[提高程序运行效率的10个简单方法](http://blog.csdn.net/ljianhui/article/details/9212817)，对于其中最后一点，多使用直接初始化，有很多读者向我提出了疑问，并写了一些测试程序，来说明直接初始化与复制初始化是同一件事。让我了解到大家对于直接初始化与复制初始化的区别的确是不太清楚，无可否认，那篇文章的例子用得的确不太好，在这里表示歉意！所以我觉得还是有必要跟大家详细分享一下我对直接初始化和复制初始化的理解。



一、Primer中的说法

首先我们来看看经典是怎么说的：

“当用于类类型对象时，初始化的复制形式和直接形式有所不同：直接初始化直接调用与实参匹配的构造函数，复制初始化总是调用复制构造函数。复制初始化首先使用指定构造函数创建一个临时对象，然后用复制构造函数将那个临时对象复制到正在创建的对象”

还有一段这样说，

“通常直接初始化和复制初始化仅在低级别优化上存在差异，然而，对于不支持复制的类型，或者使用非explicit构造函数的时候，它们有本质区别：

ifstream file1("filename")://ok:direct initialization

ifstream file2 = "filename";//error:copy constructor is private

”



二、通常的误解

从上面的说法中，我们可以知道，直接初始化不一定要调用复制构造函数，而复制初始化一定要调用复制构造函数。然而大多数人却认为，直接初始化是构造对象时要调用复制构造函数，而复制初始化是构造对象时要调用赋值操作函数（operator=），其实这是一大误解。因为只有对象被创建才会出现初始化，而赋值操作并不应用于对象的创建过程中，且primer也没有这样的说法。至于为什么会出现这个误解，可能是因为复制初始化的写法中存在等号（=）吧。



为了把问题说清楚，还是从代码上来解释比较容易让人明白，请看下面的代码：



```cpp
#include <iostream>



#include <cstring>



using namespace std;



 



class ClassTest



{



public:



ClassTest()



{



c[0] = '\0';



cout<<"ClassTest()"<<endl;



}



ClassTest& operator=(const ClassTest &ct)



{



strcpy(c, ct.c);



cout<<"ClassTest& operator=(const ClassTest &ct)"<<endl;



return *this;



}



ClassTest(const char *pc)



{



strcpy(c, pc);



cout<<"ClassTest (const char *pc)"<<endl;



}



// private:



ClassTest(const ClassTest& ct)



{



strcpy(c, ct.c);



cout<<"ClassTest(const ClassTest& ct)"<<endl;



}



private:



char c[256];



};



 



int main()



{



cout<<"ct1: ";



ClassTest ct1("ab");//直接初始化



cout<<"ct2: ";



ClassTest ct2 = "ab";//复制初始化



cout<<"ct3: ";



ClassTest ct3 = ct1;//复制初始化



cout<<"ct4: ";



ClassTest ct4(ct1);//直接初始化



cout<<"ct5: ";



ClassTest ct5 = ClassTest();//复制初始化



return 0;



}
```

输出结果为：

![img](https://img-blog.csdn.net/20130704180452187?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvbGppYW5odWk=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)





从输出的结果，我们可以知道对象的构造到底调用了哪些函数，从ct1与ct2、ct3与ct4的比较中可以看出，ct1与ct2对象的构建调用的都是同一个函数——ClassTest(const char *pc)，同样道理，ct3与ct4调用的也是同一个函数——ClassTest(const ClassTest& ct)，而ct5则直接调用了默认构造函数。



于是，很多人就认为ClassTest ct1("ab");等价于ClassTest ct2 = "ab";，而ClassTest ct3 = ct1;也等价于ClassTest ct4(ct1);而且他们都没有调用赋值操作函数，所以它们都是直接初始化，然而事实是否真的如你所想的那样呢？答案显然不是。



三、层层推进，到底谁欺骗了我们

很多时候，自己的眼睛往往会欺骗你自己，这里就是一个例子，正是你的眼睛欺骗了你。为什么会这样？其中的原因在谈优化时的补充中也有说明，就是因为编译会帮你做很多你看不到，你也不知道的优化，你看到的结果，正是编译器做了优化后的代码的运行结果，并不是你的代码的真正运行结果。



你也许不相信我所说的，那么你可以把类中的复制函数函数中面注释起来的那行取消注释，让复制构造函数成为私有函数再编译运行这个程序，看看有什么结果发生。



很明显，发生了编译错误，从上面的运行结果，你可能会认为是因为ct3和ct4在构建过程中用到了复制构造函数——ClassTest(const ClassTest& ct)，而现在它变成了私有函数，不能在类的外面使用，所以出现了编译错误，但是你也可以把ct3和ct4的函数语句注释起来，如下所示：



```cpp
int main()



{



cout<<"ct1: ";



ClassTest ct1("ab");



cout<<"ct2: ";



ClassTest ct2 = "ab";



// cout<<"ct3: ";



// ClassTest ct3 = ct1;



// cout<<"ct4: ";



// ClassTest ct4(ct1);



cout<<"ct5: ";



ClassTest ct5 = ClassTest();



return 0;



}
```

然而你还是非常遗憾地发现，还是没有编译通过。这是为什么呢？从上面的语句和之前的运行结果来看，的确是已经没有调用复制构造函数了，为什么还是编译错误呢？



经过实验，main函数只有这样才能通过编译：



```cpp
int main()



{



cout<<"ct1: ";



ClassTest ct1("ab");



return 0;



}
```

在这里我们可以看到，原来是复制构造函数欺骗了我们。



四、揭开真相

看到这里，你可能已经大惊失色，下面就让我来揭开这个真相吧！



还是那一句，什么是直接初始化，而什么又是复制初始化呢？



简单点来说，就是定义对象时的写法不一样，一个用括号，如ClassTest ct1("ab")，而一个用等号，如ClassTest ct2 = "ab"。



但是从本质来说，它们却有本质的不同：直接初始化直接调用与实参匹配的构造函数，复制初始化总是调用复制构造函数。复制初始化首先使用指定构造函数创建一个临时对象，然后用复制构造函数将那个临时对象复制到正在创建的对象。所以当复制构造函数被声明为私有时，所有的复制初始化都不能使用。



现在我们再来看回main函数中的语句，

1、ClassTest ct1("ab");这条语句属于直接初始化，它不需要调用复制构造函数，直接调用构造函数ClassTest(const char *pc)，所以当复制构造函数变为私有时，它还是能直接执行的。



2、ClassTest ct2 = "ab";这条语句为复制初始化，它首先调用构造函数ClassTest(const char *pc)函数创建一个临时对象，然后调用复制构造函数，把这个临时对象作为参数，构造对象ct2；所以当复制构造函数变为私有时，该语句不能编译通过。



3、ClassTest ct3 = ct1;这条语句为复制初始化，因为ct1本来已经存在，所以不需要调用相关的构造函数，而直接调用复制构造函数，把它值复制给对象ct3；所以当复制构造函数变为私有时，该语句不能编译通过。



4、ClassTest ct4（ct1）；这条语句为直接初始化，因为ct1本来已经存在，直接调用复制构造函数，生成对象ct3的副本对象ct4。所以当复制构造函数变为私有时，该语句不能编译通过。



注：第4个对象ct4与第3个对象ct3的创建所调用的函数是一样的，但是本人却认为，调用复制函数的原因却有所不同。因为直接初始化是根据参数来调用构造函数的，如ClassTest ct4（ct1），它是根据括号中的参数（一个本类的对象），来直接确定为调用复制构造函数ClassTest(const ClassTest& ct)，这跟函数重载时，会根据函数调用时的参数来调用相应的函数是一个道理；而对于ct3则不同，它的调用并不是像ct4时那样，是根据参数来确定要调用复制构造函数的，它只是因为初始化必然要调用复制构造函数而已。它理应要创建一个临时对象，但只是这个对象却已经存在，所以就省去了这一步，然后直接调用复制构造函数，因为复制初始化必然要调用复制构造函数，所以ct3的创建仍是复制初始化。



5、ClassTest ct5 = ClassTest();这条语句为复制初始化，首先调用默认构造函数产生一个临时对象，然后调用复制构造函数，把这个临时对象作为参数，构造对象ct5。所以当复制构造函数变为私有时，该语句不能编译通过。





五、假象产生的原因

产生上面的运行结果的主要原因在于编译器的优化，而为什么把复制构造函数声明为私有（private）就能把这个假象去掉呢？主要是因为复制构造函数是可以由编译默认合成的，而且是公有的（public），编译器就是根据这个特性来对代码进行优化的。然而如里你自己定义这个复制构造函数，编译则不会自动生成，虽然编译不会自动生成，但是如果你自己定义的复制构造函数仍是公有的话，编译还是会为你做同样的优化。然而当它是私有成员时，编译器就会有很不同的举动，因为你明确地告诉了编译器，你明确地拒绝了对象之间的复制操作，所以它也就不会帮你做之前所做的优化，你的代码的本来面目就出来了。



举个例子来说，就像下面的语句：

ClassTest ct2 = "ab";

它本来是要这样来构造对象的：首先调用构造函数ClassTest(const char *pc)函数创建一个临时对象，然后调用复制构造函数，把这个临时对象作为参数，构造对象ct2。然而编译也发现，复制构造函数是公有的，即你明确地告诉了编译器，你允许对象之间的复制，而且此时它发现可以通过直接调用重载的构造函数ClassTest(const char *pc)来直接初始化对象，而达到相同的效果，所以就把这条语句优化为ClassTest ct2（"ab"）。



而如果把复制构造函数声明为私有的，则对象之前的复制不能进行，即不能把临时对像作为参数，调用复制构造函数，所以编译就认为ClassTest ct2 = "ab"与ClassTest ct2（"ab"）是不等价的，也就不会帮你做这个优化，所以编译出错了。



注：根据上面的代码，有些人可能会运行出与本人测试不一样的结果，这是为什么呢？就像前面所说的那样，编译器会为代码做一定的优化，但是不同的编译器所作的优化的方案却可能有所不同，所以当你使用不同的编译器时，由于这些优化的方案不一样，可能会产生不同的结果，我这里用的是g++4.7。