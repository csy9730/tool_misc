# react

MVVM （Model，view， ViewModel）

* compoent ：React 应用都是构建在组件之上。
  * props 是组件包含的两个核心概念之一，另一个是 state
  * 概念类似一个状态机？
  * 生命周期
* Virtaul Dom & True Dom 使用差分算法，局部更新
* JSX
* Data Flow





react只是关注view层，它的核心思想就是UI = f(data)

control 部分通过 事件->action->dispatch->store -> State --> View ，通过操控state。



react使用了 责任链模式，  树形结构，父级组件的状态很容易传到子级组件，反过来就不成立。
react使用了单向绑定，控件根据state 表现ui，不能根据ui输入直接改变state，只有添加反向环节，才能构成MVVM框架完整的双向绑定，
输入框通过onChange监视用户输入，通知回调函数，通过回调函数调用setState，从而更新应用。

mixin, hoc(high order component) , hook
高阶组件(hoc)可以看作React对装饰模式的一种实现，高阶组件就是一个函数，且该函数接受一个组件作为参数，并返回一个新的组件。

**Q**: 装饰器（反向继承）和普通继承有何区别？
**A**: 普通继承侧重点在于新的结构，与基类无法分离，装饰器的侧重点在于装饰器，与基类可以随意分离随意拼装。

## 无状态组件

你也可以用纯粹的函数来定义无状态的组件(stateless function)

