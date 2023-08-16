# noexcept

noexcept 标识符有几种写法: noexcept、noexcept(true)、noexcept(false)、noexcept(expression)、throw() .

- 其中 noexcept 默认表示 noexcept(true).
- 当 noexcept 是 true 时表示函数不会抛出异常,
- 当 noexcept 是 false 时表示函数可能会抛出异常.
- noexcept 只能使用常量表达式
- throw()表示函数可能会抛出异常, 不建议使用该写法, 应该使用 noexcept(false), 因为 C++20 放弃这种写法.

那到底什么时候该用noxcept呢？

如果noexcept的函数执行时出了异常，程序会马上terminate。

大部分情况下，你都很难避免bad_alloc的异常，即使这个函数不直接allocate，有可能编译器执行代码时还是需要allocate。比如最简单的a = b，如果a和b是一个自定义的type，有可能这个type有类似vector，string这些需要allocate的member，那这个赋值语句就可能报错。



noexcept最有用的地方是用在 move constructor和move assignment上, 或者式 std swap函数
因为只有分配内存，构造就有可能抛出异常，而 移动构造和移动赋值可以避免分配内存，所以免于异常。

编译器默认为析构函数添加 noexcept，所以无需添加。回收内存一般也不会抛出异常。
因为如果destructor抛出异常，程序99%会挂掉。

简单的leaf function，像是int，pointer这类的getter，setter用noexcept。因为不可能出错。
