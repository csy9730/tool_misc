# gtest

## gtest

## Test Doubles
测试相关的Doubles包括Dummy， Fake，Stubs，Mocks
- Dummy 是个哑巴，啥也不会干。
- Stubs 会按照预定的备案输出，（含义是桩，一般充当占位符）
- Mocks 可以设置更加灵活的输出策略。
- Fake 可以实际工作,但是有缺陷，不适合用于产品
按照模拟级别排序:
Dummy < Stubs < Mocks < Fake < True

## gmock

mock的思想是偷梁换柱，如何实现偷梁换柱？
1. 使用继承类，并且实现和接口分离，

定义一个接口类（虚类）
定义一个mock类，继承于虚类
在mock类中，定义mock方法，包含整个函数签名信息（返回类型，函数名，参数，函数类型）。
运行环境中，定义mock对象，为mock方法定义期望：为mock对象方法设置期望的返回值。替换被测函数的Foo对象为MockFoo对象。
执行mock对象的方法，获取返回值


期望函数
使用链式返回方式，定义返回值。
匹配器

### demo

可以模拟子类的方法，包括公共/保护/私有方法。
``` cpp
class Foo{
    public:
        virtual bool DoSth() = 0;
    private:
        virtual int getTimeout();

}

class MockFoo:public Foo{
    public:
        MOCK_METHOD(bool,DoSth,(),(override));
        MOCK_METHOD(int,getTimeout,(),(override));
}
```

**Q**:  如何模拟对象？
**A**: 

## misc
侵入式和非侵入式：
侵入式是 干脆目标类继承于功能类，（注意区分多继承和单继承）
或者 目标类内部会拥有一个功能类
非侵入式， 目标类内部不会有任何改变，功能类嵌套了目标类，嵌套类的运行时不会更改目标类的运行，可以修改运行之前和运行之后的行为。

类的继承可以：
继承类的成员变量和成员函数
追加类的成员变量。
追加类的成员函数。
覆盖类的成员函数。

装饰器可以：
类的成员变量和成员函数不变
修饰函数，定义前置钩子行为和后置钩子行为。
添加装饰器可访问的成员（闭包变量）
添加函数

继承经历了单继承，多继承，mixin继承，装饰器模式。

定义一个Logger类
定义一个业务类Business
定义一个组合类 BusinessWithLogger
``` python
class Logger:
    def __init__():
        pass
    def log():
        pass

class Business:
    def __init__():
        pass

class BusinessWithLogger(Business):
    def __init__(self):
        Business.__init__(self)
        self._logger = Logger()
    def log():
        self._logger.log()

class BusinessMixinMixinLogger(Business,Logger):
    def __init__(self):
        pass

class BusinessLogger(Business):
    @Logger()
    def __init__():
        pass
   

```

归根结底，编程就是 就是变量和函数，一个描述静态，一个描述动态/变化。
