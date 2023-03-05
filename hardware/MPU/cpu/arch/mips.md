# mips



## CISC RISC
CISC(complex instruction set computer)
RISC(reduced instruction set computer)

由于 CISC 和 RISC 不像物理和数学概念一样可以做出无二义性的严谨定义，所以主流观点都认为CISC 的指令隐含有对总线的 load / store 操作，即 add, sub 等算术逻辑指令的操作数允许是一个内存地址，执行操作数为内存地址的算术逻辑指令会先将数据从内存加载到 位于 Execute Unit 里面的 ALU 中进行运算

RISC 的指令若要读写总线则需要使用显式 load / store 指令，除此之外其他类型的指令不能读写总线

### 指令集

- RISC 精简指令集
    - PowerPC系列
    - ARM
    - MIPS
    - RISC-V 
    - SPARC
- CISC 复杂指令集
    - x86/64


### x86架构
在推出x86架构之后，intel就只将这一架构授权给过AMD和VIA等几个芯片公司。而在VIA退出x86架构处理器竞争之后，intel便不再给任何公司x86架构授权。

### ARM

### MIPS
MIPS全名为“无内部互锁流水级的微处理器”（Microprocessor without interlocked piped stages），是基于精简指令集（RISC） 的衍生架构之一，其机制是尽量利用软件办法避免流水线中的数据相关问题。它最早是在80年代初期由斯坦福大学Hennessy教授领导的研究小组研制出来的。

mips是RISC的开山之作，但是生态没有起来。MIPS，MIPS 是早期龙芯的指令集，也是早期很多低端家用路由器，嵌入式设备，VCD/DVD 音响设备的 CPU 主要使用的指令集
### SPARC
1987年，SUN公司开发了RISC微处理器——SPARC。SPARC微处理器最突出的特点就是它的可扩展性，这是业界出现的第一款有可扩展性功能的微处理器。SPARC的推出为SUN赢得了高端微处理器市场的领先地位。

### RISC-V
RISC-V是由加州大学伯克利分校开发的自由和模块化的RISC指令集，“V”包含两层意思，一是这是Berkeley从RISC I开始设计的第五代指令集架构，二是它代表了变化（variation）和向量（vectors）。不同于x86、Arm架构高昂的IP费用，RISC-V架构使用BSD开源协议给予使用者很大自由，允许使用者修改和重新发布开源代码，也允许基于开源代码开发商业软件发布和销售。
