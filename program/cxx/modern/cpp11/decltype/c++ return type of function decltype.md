# c++ return type of function decltype

在C++中，`decltype`是一个操作符，它可以推断出一个表达式的类型。在函数中，`decltype`操作符可以用来推断函数返回值的类型。

例如，下面是一个使用`decltype`来推断函数返回类型的示例代码：

```cpp
cpp复制代码int foo() {
  int x = 0;
  return x;
}

decltype(foo()) bar() {
  int y = 0;
  return y;
}
```

在这个示例中，`foo()`函数返回`int`类型的值，因此我们可以使用`decltype(foo())`来推断它的返回类型。在`bar()`函数中，我们使用`decltype`操作符来推断`foo()`函数的返回类型，并将其作为`bar()`函数的返回类型。因此，`bar()`函数的返回类型也是`int`。

需要注意的是，`decltype`不会执行表达式，它只会推断出表达式的类型。因此，在使用`decltype`时，我们需要保证表达式是有效的，并且能够正确推断出其类型。