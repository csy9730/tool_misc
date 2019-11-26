# 反汇编

反汇编(Disassembly)：把目标代码转为[汇编](https://baike.baidu.com/item/汇编/627224)代码的过程，也可以说是把机器语言转换为汇编语言代码、低级转高级的意思，常用于软件破解（例如找到它是如何注册的，从而解出它的注册码或者编写注册机）、外挂技术、病毒分析、逆向工程、软件汉化等领域。学习和理解反汇编语言对软件调试、漏洞分析、OS的内核原理及理解高级语言代码都有相当大的帮助，在此过程中我们可以领悟到软件作者的编程思想。总之一句话：软件一切神秘的运行机制全在反汇编代码里面。



用的静态分析工具是[W32DASM](https://baike.baidu.com/item/W32DASM)、[PEiD](https://baike.baidu.com/item/PEiD)、FileInfo、 [Hex Rays Ida](https://baike.baidu.com/item/Hex Rays Ida)和HIEW等。

反汇编工具如：[OD](https://baike.baidu.com/item/OD)、[IDA Pro](https://baike.baidu.com/item/IDA Pro)、radare2、[DEBUG](https://baike.baidu.com/item/DEBUG)、C32等。

反汇编可以通过反汇编的一些软件实现，比如DEBUG就能实现反汇编，当DEBUG文件位置设置为-u时，即可实现反汇编。 而使用OD实现反汇编时，杀毒软件可能会报告有病毒与木马产生，此时排除即可，且使用OD需要有扎实的基础才能看懂。



基础工具：file， pe tools，peID，nm，ldd，objdump，otool，dumpbin， cfilt，strings，