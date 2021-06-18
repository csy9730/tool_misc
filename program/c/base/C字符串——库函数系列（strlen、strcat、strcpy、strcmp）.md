# [C字符串——库函数系列（strlen、strcat、strcpy、strcmp）](https://www.cnblogs.com/xfxu/p/4083652.html)



 

一定义：

字符串：字符串是由零个或者多个字符组成的有限串行；

子串：字符串中任意个**连续的字符**组成的子序列，并规定**空串**是任意串的子串，**字符串本身**也是子串之一；“abcdefg”，”abc“就是其子串，但是“ade”不属于子串范围。

子序列：不要求字符连续，但是其**顺序**与其在主串中相一致；上例中，“abc”与“ade”都属于子序列范围；

二：C风格字符串包括两种：

1）字符串常量---以双引号括起来的字符序列，编译器自动在其末尾添加一个**空字符**。

2）末尾添加了’0‘的字符数组；

```
`char` `ch1[]={ ``'c'``, ``'+'``, ``'+'``};``//不是C风格字符串``char` `ch2[]={ ``'c'``, ``'+'``, ``'+'``, ``'\0'``};``//C风格字符串``char` `ch3[] = ``"C++"``;``//C风格字符串``sizeof``(ch3) = 4;``strlen(ch3) = 3;`
```

 三：标准库提供的字符串处理函数：

```
`strlen(s) : 返回S的长度，不包括字符串结束符NULL；``strcmp(s1,s2) :比较两个字符串是否相同，若s1==s2，返回0，若s1>s2则返回正数，若s1<s2则返回负数；``strcat(s1,s2)：将字符串s2连接到s1上，返回 s1；``strcpy(s1,s2)：将s2，复制到s1，返回 s1.`
```

 **注意：**
1、自定义str库函数时，首先要明确接收的参数是否为空（assert），这样可有效避免bug；

2、对函数的参数要尽量多的应用const，以避免无意间修改了字符串。

3、要自行添加字符串的结束符‘\0’。

1)自定义实现strlen函数的功能；

![img](https://images.cnblogs.com/OutliningIndicators/ContractedBlock.gif) View Code

2)自定义实现strcat函数的功能；

![img](https://images.cnblogs.com/OutliningIndicators/ContractedBlock.gif) View Code

3)自定义实现strcmp函数的功能；

![img](https://images.cnblogs.com/OutliningIndicators/ContractedBlock.gif) View Code

4)自定义实现strcpy函数的功能；

![img](https://images.cnblogs.com/OutliningIndicators/ContractedBlock.gif) View Code

测试函数如下：



[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
 1 #include <stdio.h>
 2 #include <stdlib.h>
 3 #include <assert.h>
 4 
 5 int main(int argc, char const *argv[])
 6 {
 7     char s1[] = "helloworld";
 8     printf("%d\n", s1);
 9     
10     char s2[100] = "thank you";
11     printf("%s\n", strcat(s2,s1));
12     printf("%d\n", strcmp(s2, s1)); 
13 
14     printf("%s\n", strcpy(s2, s1));
15     return 0;
16 }
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

 



分类: [C/C++](https://www.cnblogs.com/xfxu/category/613309.html)