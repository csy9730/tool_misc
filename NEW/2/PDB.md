# PDB

调试工具

pdb 模块定义了一个交互式源代码调试器，用于 Python 程序。它支持在源码行间设置（有条件的）断点和单步执行，检视堆栈帧，列出源码列表，以及在任何堆栈帧的上下文中运行任意 Python 代码。它还支持事后调试，可以在程序控制下调用。

调试器是可扩展的——调试器实际被定义为 Pdb 类。该类目前没有文档，但通过阅读源码很容易理解它。扩展接口使用了 bdb 和 cmd 模块。

[https://docs.python.org/zh-cn/3/library/pdb.html](https://docs.python.org/zh-cn/3/library/pdb.html)

