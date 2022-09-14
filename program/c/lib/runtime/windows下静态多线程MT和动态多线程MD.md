# windows下静态多线程MT和动态多线程MD



### 多线程编译选项

| 描述             | VC编译选项 | C 运行时库                       | 库文件      |
| ---------------- | ---------- | -------------------------------- | ----------- |
| 静态             | /ML        | Single thread(static link)       | libc.lib    |
| 静态调试         | /MLd       | Debug single thread(static link) | libcd.lib   |
| 多线程静态库     | /MT        | MultiThread(static link) MT      | libcmt.lib  |
| 多线程静态库调试 | /MTd       | Debug multiThread(static link)   | libcmtd.lib |
| 多线程DLL        | /MD        | MultiThread(dynamic link)        | msvert.lib  |
| 多线程调试DLL    | /MDd       | Debug multiThread(dynamic link)  | msvertd.lib |



其中以小写“d”结尾的选项表示的DEBUG版本的，没有“d”的为RELEASE版本。

大型项目中必须要求所有组件和第三方库的运行时库是统一的，否则将会出现LNK2005井喷。

单线程运行时库选项/ML和/MLd在VS2003以后就被废了


/MT和/MTd表示采用多线程CRT库的静态lib版本。该选项会在编译时将运行时库以静态lib的形式完全嵌入。该选项生成的可执行文件运行时不需要运行时库dll的参加，会获得轻微的性能提升，但最终生成的二进制代码因链入庞大的运行时库实现而变得非常臃肿。当某项目以静态链接库的形式嵌入到多个项目，则可能造成运行时库的内存管理有多份，最终将导致致命的“Invalid Address specified to RtlValidateHeap”问题。另外托管C++和CLI中不再支持/MT和/MTd选项。

/MD和/MDd表示采用多线程CRT库的动态dll版本，会使应用程序使用运行时库特定版本的多线程DLL。链接时将按照传统VC链接dll的方式将运行时库MSVCRxx.DLL的导入库MSVCRT.lib链接，在运行时要求安装了相应版本的VC运行时库可再发行组件包（当然把这些运行时库dll放在应用程序目录下也是可以的）。 因/MD和/MDd方式不会将运行时库链接到可执行文件内部，可有效减少可执行文件尺寸。当多项目以MD方式运作时，其内部会采用同一个堆，内存管理将被简化，跨模块内存管理问题也能得到缓解。