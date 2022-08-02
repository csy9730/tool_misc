# C++单分派和双分派问题

wx_14678 2020-05-30 16:13:26  226  收藏 1
分类专栏： C++ 文章标签： c++
版权

C++
专栏收录该内容
33 篇文章0 订阅
订阅专栏



分派说的是根据对象的类型和参数类型来确定最终调用的实际函数，体现出来也就是多态性。C++多态一般分为两种，一种是静态多态，也就是通过重载（同名不同参）以及通过模板的实现；另一种就是动态多态，也称运行时多态，通过虚函数的继承与重写来实现的。

单分派：也就是只能同时进行一种方式的分派，也即要么就是通过重载实现静态多态，要么就是通过虚函数继承实现运行时多态。具体化表现就是：只能根据对象的动态类型以及参数的静态类型，来确定实际调用函数。

双分派：也就是可以在支持静态多态的基础上再进行动态多态。可以根据对象的动态类型和参数的动态类型来确定实际调用函数。

## 单分派

C++仅支持单分派，举个栗子：经典的工程师解决问题.
    

```cpp
#include <iostream>
using namespace std;

// 三个问题类，一个问题父类，两个子类； 两个工程师类，基础工程师和资深工程师
class problem{
public:
    virtual void display(){
       cout <<"default problem" <<endl; 
    }
};

class simpleProblem : public problem{
public:
    virtual void display() override{
        cout <<"simpleProblem" <<endl;
    }
};

class diffcultProblem : public problem{
public:
    virtual void display() override{
        cout <<"diffcultProblem" <<endl;
    }
};

//------------------------------------------------------------
class primaryEngineer{
public:
    virtual void solve(problem* p){
        cout <<"primaryEngineer solve defaultProblem" <<endl;
    }
    virtual void solve(simpleProblem* p){
        cout <<"primaryEngineer solve simpleProblem" <<endl;
    }
    virtual void solve(diffcultProblem* p){
        cout <<"primaryEngineer solve diffcultProblem" <<endl;
    }
};

class seniorEngineer : public primaryEngineer{
public:
    virtual void solve(problem* p) override {
        cout <<"seniorEngineer solve defaultProblem" <<endl;
    }
    virtual void solve(simpleProblem* p) override {
        cout <<"seniorEngineer solve simpleProblem" <<endl;
    }
    virtual void solve(diffcultProblem* p) override {
        cout <<"seniorEngineer solve diffcultProblem" <<endl;
    }
};

int main()
{
    problem *p1 = new simpleProblem();
    problem *p2 = new diffcultProblem();
    p1->display();
    p2->display();
    // p1, p2 静态类型都为父类problem，但是实际类型不一样，display体现C++运行时多态
    /*** 分别将p1, p2作为参数传入 e1, e2的 solve函数，
**/
    primaryEngineer *e1 = new primaryEngineer();
    e1->solve(p1);
    e1->solve(p2);
    
    primaryEngineer *e2 = new seniorEngineer();
    e2->solve(p1);
    e2->solve(p2);

return 0;
}
```

我们期望的结果应该是：

```
simpleProblem
diffcultProblem
primaryEngineer solve simpleProblem        // e1->solve(p1)
primaryEngineer solve diffcultProblem      // e1->solve(p2)
seniorEngineer solve simpleProblem         // e2->solve(p1)
seniorEngineer solve diffcultProblem       // e2->solve(p2)
```




但是结果却是这样的：

```
simpleProblem
diffcultProblem
primaryEngineer solve defaultProblem  
primaryEngineer solve defaultProblem 
seniorEngineer solve defaultProblem 
seniorEngineer solve defaultProblem 
```



因为C++只支持单分派模式。结果可知，在solve 函数的分派上，可以根据调用对象的实际类型，来决定调用函数（虚函数表决定），但是参数类型却不能根据传入参数的实际类型进行选择，只能根据静态类型选择。 

我们做一下改变：传入时就将类型确定，看是否会如想象中输出。还是原来的代码，将p1 p2类型直接指定。

``` cpp
// problem *p1 = new simpleProblem();
// problem *p2 = new diffcultProblem();
simpleProblem *p1 = new simpleProblem();
diffcultProblem *p2 = new diffcultProblem();
```


结果如下：因为是单分派写法，所以确实都如所想一般。



## C++双分派的实现
那么问题来了，就想实现双分派呢？C++可以实现双分派吗？当然是可以的！我们观察到，在第一次的实现中，p1, p2的静态类型是 problem父类， 但是实际类型却是两个子类，他们的函数调用自然也是在虚函数表中指定好了的正确调用。既然如此，那就可以通过两次 运行时多态的特性 来实现一个类似双分派的功能。直接上代码：   

```cpp
#include <iostream>
using namespace std;

class primaryEngineer;
class seniorEngineer;
class problem{
public:
    virtual void display(){
       cout <<"default problem" <<endl; 
    }
    virtual void solve(primaryEngineer* e){
        cout <<"primaryEngineer solve defaultProblem" <<endl;
    }
    virtual void solve(seniorEngineer* e){
        cout <<"seniorEngineer solve defaultProblem" <<endl;
    }
};

class simpleProblem : public problem{
public:
    virtual void display() override{
        cout <<"simpleProblem" <<endl;
    }
    virtual void solve(primaryEngineer* e) override{
        cout <<"primaryEngineer solve simpleProblem" <<endl;
    }
    virtual void solve(seniorEngineer* e) override{
        cout <<"seniorEngineer solve simpleProblem" <<endl;
    }
};

class diffcultProblem : public problem{
public:
    virtual void display() override{
        cout <<"diffcultProblem" <<endl;
    }
    virtual void solve(primaryEngineer* e) override{
        cout <<"primaryEngineer solve diffcultProblem" <<endl;
    }
    virtual void solve(seniorEngineer* e) override{
        cout <<"seniorEngineer solve diffcultProblem" <<endl;
    }
};

//------------------------------------------------------------
class primaryEngineer{
public:
    virtual void solve(problem* p){
        // 将this 指针作为参数传入 p，此时 this 类型确定，
        // 而p 调用solve则是根据虚函数表里的实际函数, 遵循多态规则。
        p->solve(this);
    }
};

class seniorEngineer : public primaryEngineer{
public:
    virtual void solve(problem* p) override{
        p->solve(this);
    }
};

int main()
{
    problem *p1 = new simpleProblem();
    problem *p2 = new diffcultProblem();
    p1->display();
    p2->display();// 调用上用静态参数类型
    primaryEngineer *e1 = new primaryEngineer();
    primaryEngineer *e2 = new seniorEngineer();
    e1->solve(p1);
    e1->solve(p2);
    e2->solve(p1);
    e2->solve(p2);

return 0;
}
```


结果如下：




