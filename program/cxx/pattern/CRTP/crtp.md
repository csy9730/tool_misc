
# CRTP

CRTP 全称 ： Curiously Recurring Template Pattern，也就是常说的奇异递归模板模式
``` cpp
// The Curiously Recurring Template Pattern (CRTP)
template<class T>
class Base
{
    // methods within Base can use template to access members of Derived
};
class Derived : public Base<Derived>
{
    // ...
};
```

看上去是继承基类，基类里面又套了自己，非常怪异。
`class Derived : public Base<Derived>`

可以理解成 基类提前获取了子类的性质，暴露到基类里面可以使用。




``` cpp
template <class T> 
struct Base
{
public:
    void interface(){
        // 不用 dynamic_cast 因为主要用在运行时，模板实在编译时就转换的
        static_cast<T*>(this)->implementation();
        // ...
    }

    static void static_func(){
        // ...
        T::static_sub_func();
        // ...
    }
};

struct Derived : Base<Derived>
{
public:
    static void static_sub_func();
private:
    void implementation();
};
```

可以发现，CRTP 利用继承 + 模板让基类在编译期就能知道派生类的函数接口信息，在原来的动态多态中需要通过虚函数查找虚表来获取函数信息，这就实现了静态多态。
#### 如何设计工厂函数
如果是正常基类，直接使用基类作为返回类型。

可是如果是 CRTP类，如何返回类型？

不能将多个不同的CRTP基类指针存储在容器中。


#### demo
```cpp
template <typename D> 
class B {
public:
    B() : i_(0) {}
    void f(int i) { derived()->f(i); }
    int get() const { return i_; }
protected:
    int i_;
private:
    D* derived() { return static_cast<D*>(this); } // 声明一个私有方法获取继承类
};

template <typename D> void apply(B<D>* b, int& i) { b->f(++i); }

class D : public B<D> {
public:
    void f(int i) { i_ += i; }
};
```

#### 4

这实际上是个很经典的问题：为什么析构函数要是虚函数

如果基类指针向派生类对象，则删除此指针时，我们希望调用该指针指向的派生类析构函数，而派生类的析构函数又自动调用基类的析构函数，这样整个派生类的对象完全被释放。

若使用基类指针操作派生类，需要防止在析构时，只析构基类，而不析构派生类。

但是，如果析构函数不被声明成虚函数，则编译器采用的绑定方式是静态绑定，在删除基类指针时，只会调用基类析构函数，而不调用派生类析构函数，这样就会导致基类指针指向的派生类对象析构不完全。若是将析构函数声明为虚函数，则可以解决此问题。


虽然这违背了 CRTP 的初衷但是只有析构函数是虚函数还是可以接受的


``` cpp

template<typename T>
void destroy(Base<T>* b) {
    delete static_cast<T*>(b);
}


int main() {
    Base<Derived>* b = new Derived;
    destroy(b);
    return 0;
}
```

