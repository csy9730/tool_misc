# [Dummary、Fake、Stub、Spy、Mock](https://www.cnblogs.com/cosmoseeker/p/8489746.html)

Test Double(测试替身) 可以分为Dummary、Fake、Stub、Spy、Mock几种。下面是定义：

Dummy 不包含实现的对象（Null也是），在测试中需要传入，但是它没有被真正地使用，通常它们只是被用来填充参数列表。
Fake 有具体实现的，但是实现中做了些捷径，使它们不能应用与生产环境（举个典型的例子：内存数据库）
Stub 返回固定值的实现
State verification 状态验证
Spy 类似于Stub，但会记录被调用那些成员，以确定SUT（System Under Test）与它的交互是否是正确的
Behavior verification 行为验证
Mock 由Mock库动态创建的，能提供类似Dummy、Stub、Spy的功能。
开发人员看不到 Mock object 的代码，但可以设置 Mock object 成员的行为及返回值。

Dummy 通常用于填充参数，并且不会被真正调用到；
Fake 是提供了一套简易的实现，利用简易实现来测试功能；
Stub 通过打桩来固定一些返回值或执行异常操作等；
Spy 创建的对象可以用来监控行为是否被执行、执行顺序等，在mockito中执行Spy方法，真实对象也会影响到，因为spy对象是对真实对象的一个拷贝；
Mock 拥有其他替身的能力，是由动态库生成的，可以设置行为和返回值

其他参考：
http://docs.spring.io/spring/docs/current/spring-framework-reference/pdf/spring-framework-reference.pdf
http://docs.spring.io/spring/docs/current/spring-framework-reference/html/integration-testing.html#spring-mvc-test-framework

from: http://blog.csdn.net/difffate/article/details/77802306

1. dummy
   对象四处传递，但不真正被使用,通常用来填充参数列表
2. Fake
   有实际的工作表现，但通常有一些缺点不适用于产品(如内存数据库)
3. Stub
   对产生的调用提供预备的应答
4. Mock
   更丰富的Stub,更深入模拟对象交互，如:调用了几次,哪些情况抛出异常

from: http://blog.csdn.net/jollyjumper/article/details/51484058

标签: [程序员词典](https://www.cnblogs.com/cosmoseeker/tag/程序员词典/)