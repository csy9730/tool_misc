# longjmp
setjmp.h是C标准函数库中提供“非本地跳转”的头文件：控制流偏离了通常的子程序调用与返回序列。互补的两个函数setjmp与longjmp提供了这种功能。

setjmp/longjmp的典型用途是例外处理机制的实现：利用longjmp恢复程序或线程的状态，甚至可以跳过栈中多层的函数调用。

int setjmp(jmp_buf env)	建立本地的jmp_buf缓冲区并且初始化，用于将来跳转回此处。这个子程序[1] 保存程序的调用环境于env参数所指的缓冲区，env将被longjmp使用。如果是从setjmp直接调用返回，setjmp返回值为0。如果是从longjmp恢复的程序调用环境返回，setjmp返回非零值。

void longjmp(jmp_buf env, int value)	恢复env所指的缓冲区中的程序调用环境上下文，env所指缓冲区的内容是由setjmp子程序[1]调用所保存。value的值从longjmp传递给setjmp。longjmp完成后，程序从对应的setjmp调用处继续执行，如同setjmp调用刚刚完成。如果value传递给longjmp零值，setjmp的返回值为1；否则，setjmp的返回值为value。

jmp_buf	数组类型，例如struct int[16][2]或struct __jmp_buf_tag[3]，用于保存恢复调用环境所需的信息。

setjmp保存当前的环境（即程序的状态）到平台相关的一个数据结构 (jmp_buf)，该数据结构在随后程序执行的某一点可被 longjmp用于恢复程序的状态到setjmp调用所保存到jmp_buf时的原样。这一过程可以认为是"跳转"回setjmp所保存的程序执行状态。setjmp的返回值指出控制是正常到达该点还是通过调用longjmp恢复到该点。因此有编程的惯用法: `if( setjmp(x) ){/* handle longjmp(x) */}`。



longjmp实现了非本地跳转，微软的IA32程序设计环境中正常的"栈卷回"("stack unwinding")因而没有发生，所以诸如栈中已定义的局部变量的析构函数的调用（用于销毁该局部变量）都没有执行。所有依赖于栈卷回调用析构函数所做的扫尾工作，如关闭文件、释放堆内存块等都没有做。但在微软的X64程序设计环境，longjmp启动了正常的"栈卷回"。[4]

如果setjmp所在的函数已经调用返回了，那么longjmp使用该处setjmp所填写的对应jmp_buf缓冲区将不再有效。这是因为longjmp所要返回的"栈帧"(stack frame)已经不再存在了，程序返回到一个不再存在的执行点，很可能覆盖或者弄坏程序栈.

``` cpp
#include <stdio.h> 
#include <setjmp.h>  
static jmp_buf buf;  
void second(void) {     
	printf("second\n");         // 打印     
	longjmp(buf,1);             // 跳回setjmp的调用处 - 使得setjmp返回值为1 
}  

void first(void) {     
	second();     
	printf("first\n");          // 不可能执行到此行 
}  

int main() {   
    if ( ! setjmp(buf) ) {         
		first();                // 进入此行前，setjmp返回0     
	} else {                    // 当longjmp跳转回，setjmp返回1，因此进入此行         
		printf("main\n");       // 打印     }  
    return 0; 
}
```

意到虽然first()子程序被调用，"first"不可能被打印。"main"被打印，因为条件语句if ( ! setjmp(buf) )被执行第二次。

## misc
### reference
SO C标准要求setjmp必须是宏实现，但POSIX明确称未定义setjmp是宏实现还是函数实现。

Microsoft Visual C++ 2010 x32或x64与Intel ICC 2011 (version 12) x32或x64，编译结果都是longjmp启动了正常的"栈卷回"。但GCC 4.4 x32版编译的longjmp不执行"栈卷回"。可见，是否“栈卷回”不具有移植性。

https://my.oschina.net/wxwHome/blog/51311

### ps
跳转机制类似 函数内跳转goto。

函数间的跳转比较复杂，涉及到错误和异常的处理。

两个分支都可以执行，这个分叉表现类似fork函数。