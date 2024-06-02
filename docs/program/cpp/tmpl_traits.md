
#### std::integral_constant
integral_constant 是 type traits 的基础类型。

integral_constant 就是定义一个自定义类型存放了一个常量值。
为什么 integral_constant 倾向使用 static 存变量，因为很多值没法用 enum 存放。
为什么使用仿函数，而不是 static 函数，可能static 函数必须严格对应一个函数，不能内联优化掉。

元编程一等公民：类型。核心思路，对类型进行操作。

