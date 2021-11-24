# CRTP(Curiously Recurring Template Prattern)

看了很多有关CRTP(Curiously Recurring Template Prattern)的介绍，知道CRTP是什么，但不知道究竟应该在什么情况下用，请高手回答。

为了便于说明，以下给出三种类的继承方式：

### overwrite
第一种，普通继承，没有虚函数，子类同名函数完全覆盖父类：

```cpp
struct Base{
	void Func() { std::cout << " base's func" << std::endl; }
};

struct Drv : public Base{
	void Func() { std::cout << " drv's func" << std::endl; }
};
```

### override

第二种，普通继承，用虚函数：

``` cpp
struct Base{
  	virtual  void Func() { std::cout << " base's func" << std::endl; }
};
struct Drv : public Base{
	void Func() { std::cout << " drv's func" << std::endl; }
};
```


### CRTP模式
第三种：采用CRTP模式：

``` cpp
template <typename Derived>

struct Base{
	void Func() { static_cast<Derived&>(*this).FuncImpl(); }
	void FuncImpl() { std::cout << "base's func" << std::endl; }
};
struct Drv : public Base<Drv>{
	void FuncImpl() { std::cout << "drv's func" << std::endl; }
};
```

