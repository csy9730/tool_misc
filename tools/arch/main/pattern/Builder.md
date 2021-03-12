# Builder模式
Builder模式，实现一个new 对象的功能，这个对象携带较多的参数。参数是必选和可选的区分，
当我们要创建的对象很复杂的时候（通常是由很多其他的对象组合而成）。
创建和配置分离。


分析builder模式，需要实现以下功能：
1. 构造对象，newer （必须）
2. 设置对象属性和读取属性，setter和getter （必须）
   1. 能够配置一些final属性，
   2. 参数存在先于对象存在
   3. 支持链式的setter
   4. 属性attribute可以是其他复杂对象 component

简单的使用 new对象，由于有多个参数，需要使用构造函数多态，

1. 一般使用重叠构造器模式（telescoping constructor）。参数过多时，构造函数复杂，难以维护使用。构造器调用通常需要许多你本不想设置的参数，但还是不得不为它们传递值。一句话：重叠构造器可行，但是当有许多参数的时候，创建使用代码会很难写，并且较难以阅读。

2. 先使用无参数new Foo(), 再使用 foo.setAttr(), 这种方法难以配置final属性。

3. javaBeans模式使用链式调用，`new Foo(a,b).setAttr(b).setAttr2(d)` ，这种方法的setAttr既改变属性又返回对象，职责过多。

以上方法都有缺陷，而builder模式可以解决以上问题。
## misc
为什么要用builder模式？
这种模式，相当于配置参数和具体对象分离，单独维护一份配置参数，直到需要时才根据配置参数生成具体对象。直到需要时, 说明怎么维护setter的参数，最后才执行newer。

**Q**: 为什么要专门抽象出director？

**A**:  builder 和 director中，核心在于builder，director 不是必需的，可以去除。抽象出 director 和 builder ，是为了提高 builder 的复用能力, 削弱了 builder，把不通用的部分移到了director。


Builder方法封装了创建 component 的接口。
另外，需要指出的一点。单纯的Builder模式中，“不同Product类型”的组成部件之间，不能进行组合或替换。
Director 可以聚合多个同类别的component实例。Director 调用 Builder 完成组装，Director 可以选择性执行组装。


**Q**: 如何区分 template模式和 builder模式？
**A**: 
template 模式，强调的是固定 函数框架，定义接口函数，把接口函数实现的权利下放。比较类似于框架定义spi，客户端中实现spi。
描述的是对函数/接口的组装，把接口函数定义的时机延迟。
个人觉得，template模式 侧重于往框架中填充函数（动词），而一般理解的 template 是往系统中填充子结构（名词），例如往字符模板中填充字符串。

**Q**: 
如何区分 factory 模式和 builder模式？

**A**: 

我们需要重新考虑 builder，product，和 component的关系。

工厂模式，侧重于考虑 用factory 描述 product的多态。
builder模式 侧重于 用builder描述的 product 和 component 的关系。

考虑product 和 component 的关系，可能有：
* 个体和群体
* 严格对应，例如下面的URLBuilder 的字符串和具体字段
* 有序约束，神经网络和网络层的关系，对应 Builder的复数component情况？。


``` java
String url = URLBuilder.builder() // 创建Builder
        .setDomain("www.abc.com") // 设置domain
        .setScheme("https") // 设置scheme
        .setPath("/") // 设置路径
        .setQuery(Map.of("a", "123", "q", "K&R")) // 设置query
        .build(); // 完成build
```

另外，需要指出的一点。单纯的Builder模式中，“不同Product类型”的组成部件之间，不能进行组合或替换。