# third libs


* glog
* gflags




## C++程序分类
您在开发C++程序呀？


* 目标设备
    * 目标平台呢？x86、x64、arm64、cross……
    * 哪个系统啊？Win、Linux……
* 编译器
    * 谁家编译器啊？VC、GCC、MinGW、clang++……
    * 啥语言版本啊？98、03、11、14、17、20……
    * 用了C++20的模块？传说有module、export、import
* 编译参数
    * 目标文件咧？exe、lib、dll、c、asm……
    * 开优化/分析不？Debug、Release、O123、-g、-pg……
    * 函数调用方式？cdecl、stdcall、fastcall……
    * 要线程不？ML/MT/MD……
    * 异常模型用的啥？SJLJ、SEH、DW2……
    * 字符集涅？MBCS、Unicode……
    * 客户还要兼容XP啊？v141_xp + WinSDK7考虑一下……
* 数据分布
    * 数据存储方式？auto、static、const、constexpr、extern、mutable、volatile、register、thread_local……
    * asm的指针分near、far、huge呢
    * char带符号不？
    * wchar_t是2字节还是4字节？


### 多线程编译选项

| 描述             | VC编译选项 | C 运行时库                       | 库文件      |
| ---------------- | ---------- | -------------------------------- | ----------- |
| 静态             | /ML        | Single thread(static link)       | libc.lib    |
| 静态调试         | /MLd       | Debug single thread(static link) | libcd.lib   |
| 多线程静态库     | /MT        | MultiThread(static link) MT      | libcmt.lib  |
| 多线程静态库调试 | /MTd       | Debug multiThread(static link)   | libcmtd.lib |
| 多线程DLL        | /MD        | MultiThread(dynamic link)        | msvert.lib  |
| 多线程调试DLL    | /MDd       | Debug multiThread(dynamic link)  | msvertd.lib |

