# [Matlab - 使用MATLAB进行串口调试的两种方法（转）](https://www.cnblogs.com/Jian-thinker/p/7846077.html)

## tmtool

方法1：在command window界面下输入tmtool，打开Test & Measurement Tool窗口，在Hardware→Serial下面找到已连接的串口设备（单片机开发板通过USB转串口，对应COM2），在communicate选项卡中对串口进行设置即可。

![img](https://images2017.cnblogs.com/blog/1203481/201711/1203481-20171116194838046-382774026.png)

 

需要注意的是，程序功能是上位机发送16bit字符串，单片机通过串口接收并回显给上位机，这16bit的字符串是不包含字符串结束标志\n的，因此在sending data下面的data format下拉菜单中，要选择%s而不是%s\n。

为了使接收字符串的时间变短，可以在configure选项卡中将timeout选项设置为1.0。

 ![img](https://images2017.cnblogs.com/blog/1203481/201711/1203481-20171116194901218-1721045012.png)

 

 ![img](https://images2017.cnblogs.com/blog/1203481/201711/1203481-20171116194922734-593356611.png)

 ## serial toolbox

方法2：直接在command window环境下用matlab提供的函数对串口进行操作，仍然以COM2为例。在command window环境下依次输入以下代码：

 

```matlab
s=serial('COM2')           %将串口2赋给s
s.status                                         %查看串口2的状态
fopen(s)                                         %打开串口2
s.status                                        
fprintf(s,'987654321abcdef')   %给串口2的发送缓存写入数据987654321abcdef
fscanf(s)                                        %从串口2的接收缓存读数据
fclose(s)                                        %关闭串口2
s.status
delete(s)
clear s
```



 

每一个语句的执行情况如下图所示： 

 ![img](https://images2017.cnblogs.com/blog/1203481/201711/1203481-20171116195008546-976237139.png)

![img](https://images2017.cnblogs.com/blog/1203481/201711/1203481-20171116195050718-1472788110.png)

![img](https://images2017.cnblogs.com/blog/1203481/201711/1203481-20171116195108031-85194322.png)

 

 

 

其中需要注意的是fprintf()函数默认采用%s\n格式，因此在这里只能输入15个字符，系统会在15bit字符串的末尾自动添加字符串结束标志\n，该标志不能在数码管上显示。

 

 



分类: [Matlab](https://www.cnblogs.com/Jian-thinker/category/1085310.html)