# [TEA加密/解密算法](https://www.cnblogs.com/chevin/p/5681228.html)

在游戏项目中，一般需要对资源或数据进行加密保护，最简单高效的加密算法就是采用位与或之类的，但是比较容易被人分析出来。
TEA加密算法不但比较简单，而且有很强的抗差分分析能力，加密速度也比较快。可以根据项目需求设置加密轮数来增加加密强度。
1.加密核心函数

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
 1 void EncryptTEA(unsigned int *firstChunk, unsigned int *secondChunk, unsigned int* key)
 2 {
 3     unsigned int y = *firstChunk;
 4     unsigned int z = *secondChunk;
 5     unsigned int sum = 0;
 6 
 7     unsigned int delta = 0x9e3779b9;
 8 
 9     for (int i = 0; i < 8; i++)//8轮运算(需要对应下面的解密核心函数的轮数一样)
10     {
11         sum += delta;
12         y += ((z << 4) + key[0]) ^ (z + sum) ^ ((z >> 5) + key[1]);
13         z += ((y << 4) + key[2]) ^ (y + sum) ^ ((y >> 5) + key[3]);
14     }
15 
16     *firstChunk = y;
17     *secondChunk = z;
18 }
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

2.解密核心函数

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
 1 void DecryptTEA(unsigned int *firstChunk, unsigned int *secondChunk, unsigned int* key)
 2 {
 3     unsigned int  sum = 0;
 4     unsigned int  y = *firstChunk;
 5     unsigned int  z = *secondChunk;
 6     unsigned int  delta = 0x9e3779b9;
 7 
 8     sum = delta << 3; //32轮运算，所以是2的5次方；16轮运算，所以是2的4次方；8轮运算，所以是2的3次方
 9 
10     for (int i = 0; i < 8; i++) //8轮运算
11     {
12         z -= (y << 4) + key[2] ^ y + sum ^ (y >> 5) + key[3];
13         y -= (z << 4) + key[0] ^ z + sum ^ (z >> 5) + key[1];
14         sum -= delta;
15     }
16 
17     *firstChunk = y;
18     *secondChunk = z;
19 }
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

3.封装对输入数据进行加密函数

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
 1 //buffer：输入的待加密数据buffer，在函数中直接对元数据buffer进行加密；size：buffer长度；key是密钥；
 2 void EncryptBuffer(char* buffer, int size, unsigned int* key)
 3 {
 4     char *p = buffer;
 5 
 6     int leftSize = size;
 7 
 8     while (p < buffer + size &&
 9         leftSize >= sizeof(unsigned int) * 2)
10     {
11         EncryptTEA((unsigned int *)p, (unsigned int *)(p + sizeof(unsigned int)), key);
12         p += sizeof(unsigned int) * 2;
13 
14         leftSize -= sizeof(unsigned int) * 2;
15     }
16 }
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

4.封装对加密数据进行解密函数

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
 1 //buffer：输入的待解密数据buffer，在函数中直接对元数据buffer进行解密；size：buffer长度；key是密钥；
 2 void DecryptBuffer(char* buffer, int size, unsigned int* key)
 3 {
 4     char *p = buffer;
 5 
 6     int leftSize = size;
 7 
 8     while (p < buffer + size &&
 9         leftSize >= sizeof(unsigned int) * 2)
10     {
11         DecryptTEA((unsigned int *)p, (unsigned int *)(p + sizeof(unsigned int)), key);
12         p += sizeof(unsigned int) * 2;
13 
14         leftSize -= sizeof(unsigned int) * 2;
15     }
16 }
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

5.测试加密/解密文件例子(windows下)

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
 1 //-----设置密钥，必须需要16个字符或以上（这里的长度错误由评论#3楼legion提出修正，表示感谢。）
 2 unsigned int *key = (unsigned int *)"testkey123456789";
 3 //-----读取文件
 4 unsigned int pSize = 0;
 5 char * pBuffer = NULL;
 6 FILE *fp;
 7 int err = fopen_s(&fp, sFileName, "rb"); //sFileName是读取的加密/解密文件名 TODO:处理错误
 8 fseek(fp, 0, SEEK_END);
 9 pSize = ftell(fp); //得到长度
10 fseek(fp, 0, SEEK_SET);
11 pBuffer = new char[pSize]; //开辟内存空间
12 pSize = fread(pBuffer, sizeof(char), pSize, fp); //读取内容
13 fclose(fp); //关闭文件
14 
15 //-----对原始文件进行加密
16 EncryptBuffer(pBuffer, pSize, key);
17 
18 //如果是已经加密过的文件，则对应为解密函数
19 //DecryptBuffer(pBuffer, pSize, key);
20 
21 //-----将数据写入文件当中
22 FILE *fDestFile;
23 fopen_s(&fDestFile, sTagetFileName, "wb"); //sTagetFileName是写入的加密/解密文件名
24 fwrite(pBuffer, sizeof(char), pSize, fDestFile);
25 fclose(fDestFile);//关闭文件
26 
27 delete[]pBuffer;
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

 

 

PS:

1.对于cocos2d来说，使用pvr或者pvr.ccz等方式也是能加密的，但是在引擎内部进行解密的时候需要开辟一块内存空间进行解密，会提高游戏对内存的需求。所以，直接对读入内存中的文件缓存进行解密可以避免这种情况的发生。

2.在cocos2d-x-3.10\cocos\base里的base64.h & base64.cpp文件里，实现了base64的加解base64Encode/解密base64Decode方法。



分类: [cocos2dx](https://www.cnblogs.com/chevin/category/852624.html)

标签: [cocos2dx](https://www.cnblogs.com/chevin/tag/cocos2dx/), [加密](https://www.cnblogs.com/chevin/tag/加密/), [解密](https://www.cnblogs.com/chevin/tag/解密/), [TEA](https://www.cnblogs.com/chevin/tag/TEA/), [base64](https://www.cnblogs.com/chevin/tag/base64/)