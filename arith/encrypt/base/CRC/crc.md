# crc

CRC即循环冗余校验码（Cyclic Redundancy Check）：是数据通信领域中最常用的一种查错校验码，其特征是信息字段和校验字段的长度可以任意选定。循环冗余检查（CRC）是一种数据传输检错功能，对数据进行多项式计算，并将得到的结果附在帧的后面，接收设备也执行类似的算法，以保证数据传输的正确性和完整性。


#### 二进制
```
[15,14,13,12],[11,10,9,8],[7,6,5,4],[3,2,1,0]

0x1021 = 0001 0000 0010 0001

0x1 04C1 1DB7 = 0001 0000 0100 1100 0001 0001 1101 1011 0111

```

#### 模2除法


#### CRC算法参数
CRC算法参数模型解释： 
- NAME：参数模型名称。 
- WIDTH：宽度，即CRC比特数。 
- FULL POLY：生成多项式。 
- POLY：生成多项式的简写，以16进制表示。例如：CRC-32即是0x04C11DB7，忽略了最高位的"1"，即完整的生成项是0x104C11DB7。 
- INIT：这是算法开始时寄存器（crc）的初始化预置值，十六进制表示。 
- REFIN (reflect input)：待测数据的每个字节是否按位反转，True或False。 
- REFOUT (reflect checksum)：在计算后之后，异或输出之前，整个数据是否按位反转，True或False。 
- XOROUT (final xor)：计算结果与此参数异或后得到最终的CRC值。


- 初始值是给CRC计算一个初始值，可以是0，也可以是其他值；结果异或值是把计算结果再异或某一个值；这么做的目的是防止全0数据的CRC一直为0。
- 输入数据反转是指输入数据以字节为单位按位逆序处理；输出数据反转是指CRC计算结果整体按位逆序处理；这么做的目的我看到的一个合理解释是右移比左移更容易计算，效率高，它跟大小端无关。



#### CRC算法表格

|NAME|FULL POLY|WIDTH|POLY|INIT|XOROUT|REFIN|REFOUT|
|----|---|---|---|---|---|---|---|
|crc-4|$x^4+x+1$|4|0x13,03|0|0|true|true|
|crc-8|$x^8+x^2+x+1$|8|0x107,07|0|0|false|false|
|crc-8/ITU|$x^8+x^2+x+1$|8|0x107,07|0|0x55|false|false|
|crc-16/CCITT|$x^{16}+x^{12}+x^5+1$|16|0x11021,1021|0|0|true|true|
|crc-16/CCITT-false|$x^{16}+x^{12}+x^5+1$|16|0x11021,1021|0xffff|0|false|false|
|crc-16/XMODEM|$x^{16}+x^{12}+x^5+1$|16|0x11021,1021|0|0|false|false|
|crc-16/IBM|$x^{16}+x^{15}+x^2+1$|16|0x18005,8005|0|0|true|true|
|crc-16/MODBUS|$x^{16}+x^{15}+x^2+1$|16|0x18005,8005|0xffff|0|true|true|
|crc32|$x^{32}+ x^{26}+ x^{23}+x^{22}+ x^{16} + x^{12}+ x^{11}+x^{10}+x^8+ x^7+x^5+x^4 +x^2+x+1$|32|0x104C11DB7,04C11DB7|0xFFFFFFFF|0xFFFFFFFF|true|true|
|crc32/MPEG-2|$x^{32}+ x^{26}+ x^{23}+x^{22}+ x^{16} + x^{12}+ x^{11}+x^{10}+x^8+ x^7+x^5+x^4 +x^2+x+1$|32|0x104C11DB7,04C11DB7|0xFFFFFFFF|0|false|false|

#### crc表

由于CRC的计算过程中需要不停的循环做异或运算，占用CPU较多，算法上有一种空间换时间的做法：提前把0x00-0xFF共256个数据的CRC码提前算好保存，那么计算时可以节省CPU，这个提前算好的表叫CRC表（CRC表仅与多项式有关）。

#### CRC16-CCITT

## misc

### reference

[https://zhuanlan.zhihu.com/p/396165368](https://zhuanlan.zhihu.com/p/396165368)

https://github.com/damonlear/crc16-ccitt

### lib

matlab crc

python binascii.crc32

zlib.crc32

