# Linux上的MT和MD
浏览 11关注 0回答 1得票数 2
原文
我很好奇为什么在Windows上有这么多关于MT和MD的东西，却没有人谈论linux。在linux中，libc.so等同于MD，libc.a等同于MT。

由于可以静态或动态地链接c运行时，并且在构建单个可执行文件时可以将静态和动态库链接在一起，因此您必须遇到与在windows上组合MT和MD库或多个版本的c运行时相同的问题。

那么我的问题是，linux上是否存在同样的问题，或者linux上是否有一些系统/模式可以防止这些问题？在我看来，这些问题和在windows上是一样的，只是奇怪的是我找不到太多关于这些问题的信息。


> /MT and /MD are not really Windows, but Visual Studio. While both are from Microsoft, there is a very important distinction. The two products are far more separated than is typically the case on Linux.

> In particular, on Linux it's never been clear whether libc is part of the OS, or part of the C compiler. That didn't really matter much, though as C didn't evolve that fast anyway. The real problem on Linux is libstdc++, which depends on libc, and as such got dragged into the same dependency issue.

> The result is that Visual Studio 2019 can compile C++20 code for Windows XP, and with /MT it will just work. But compile on Debian 10, and you'll get a dependency on the Debian 10 libc which won't even work on Debian 9.