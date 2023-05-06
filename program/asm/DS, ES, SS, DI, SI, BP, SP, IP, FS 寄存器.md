## [DS, ES, SS, DI, SI, BP, SP, IP, FS 寄存器](https://www.cnblogs.com/awpatp/archive/2010/07/07/1772725.html)

DS is called data segment register. It points to the segment of the data used by the running program. You can point this to anywhere you want as long as it contains the desired data.

DS叫做段寄存器, 指向当前运行着的程序的数据段. 你可以把它指向任何你想要的地方, 只要那个地方有你想要的数据.

 

ES is called extra segment register. It is usually used with DI and doing pointers things. The couple DS:SI and ES:DI are commonly used to do string operations.

ES叫做额外的段寄存器. 它通常跟DI一起用来做指针使用. DS:SI和ES:DI配对时通常用来执行一些字符串操作.

 

SS is called stack segment register. It points to stack segment.

SS叫做栈段寄存器, 它指向栈段.

The register SI and DI are called index registers. These registers are usually used to process arrays or strings.

SI和DI两个寄存器叫做索引寄存器, 这两个寄存器通常用来处理数组或字符串.

 

SI is called source index and DI is destination index. As the name follows, SI is always pointed to the source array and DI is always pointed to the destination. This is usually used to move a block of data, such as records (or structures) and arrays. These register is commonly coupled with DS and ES.
SI叫做源索引寄存器, DI叫做目的索引寄存器. 正如它们的命名, SI通常指向源数组, DI通常指向目的数组. 他们通常被用来成块地移动数据, 比如移动数组或结构体. SI和DI通常和DS和ES一起使用.

 

The register BP, SP, and IP are called pointer registers.

BP, SP, 和IP叫做指针寄存器.

 

BP is base pointer, SP is stack pointer, and IP is instruction pointer. Usually BP is used for preserving space to use local variables.

BP是基指针, SP是栈指针, IP是指令指针. 通常BP用来保存使用局部变量的地址.

 

SP is used to point the current stack. Although SP can be modified easily, you must be cautious. It's because doing the wrong thing with this register could cause your program in ruin.

SP用来指向当前的栈. 尽管SP可以被很容易地修改, 你还是一定要非常小心. 因为如果这个寄存器搞错了, 你的程序就毁了.

 

IP denotes the current pointer of the running program. It is always coupled with CS and it is NOT modifiable.

IP用来指示当前运行程序的当前指针. 通常和CS一起使用, IP是不允许修改的.

 

So, the couple of CS:IP is a pointer pointing to the current instruction of running program. You can NOT access CS nor IP directly.

所以, CS:IP配对用来指示当前运行的指令地址. 你不能直接访问CS, 也不能直接访问IP.

 

FS和GS寄存器是从386开始才有的. FS主要用来指向Thread Information Block(TIB).

 

参考资料:

DS,CS,SS,ES???

http://www.tek-tips.com/viewthread.cfm?qid=717198&page=18

FS register in Win32

http://stackoverflow.com/questions/4860225/fs-register-in-win32

分类: [Assembly](https://www.cnblogs.com/awpatp/category/216378.html)