# 嵌入式设备里，SOC与MCU的区别是什么?

跑裸机或者 RTOS，就认为是 MCU 方案，

跑Linux 或者 Android的，就认为是 SOC 方案，


mcu是微处理器，soc是片上系统，总的来说soc集成度更高，集成了cpu gpu等多种ic模块，而mcu则集成度更低些，有时需要外接芯片才能使用，从性能上来看，soc性能强，可执行功能多，mcu性能更低，可执行功能少，但开发成本低廉。

MCU可以算是CPU+RAM+ROM+UART+TIMER+RTC等简单外设。
SOC可以算是MCU+复杂功能外设，比如基带芯片，比如flash存储器，比如显示核心等等，放到一个封装里。