# zero cost abstraction 
zero cost abstraction  的表现。
所谓 zero cost abstraction 指的是你在构建一个抽象的时候这个抽象不会造成额外的负担，典型的对比是 struct 和 Java 的 class。如果Java 的类 A 里有类类型 B 的成员，那么通过这个 A 类对象访问 B 成员事实上需要两次指针访问，但如果是 Rust 的 struct，你直接把它分配到栈上，那直接就可以访问到了，就和 C++ 里的 class 一样。你虽然做出了抽象，但是并没有为抽象支付成本，和你不抽象直接把东西放一起是一样的。

其实是付出了代价的，增加了cc的编译时间。


首先他对zero-cost abstractions的定义是引用的C++之父Bjarne的定义

> Iterators are one of Rust's zero-cost abstractions, by which we mean using the abstraction imposes no additional runtime overhead in the same way that Bjarne Stroustrup, the original designer and implementer of C++, defines zero-overhead:
> In general, C++ implementations obey the zero-overhead principle: What you don’t use, you don’t pay for. And further: What you do use, you couldn’t hand code any better.

直译就是你不会为没使用的功能付出代价，而对使用了的功能，你无法手写出更好的代码

有时也可以称为：zero overhead