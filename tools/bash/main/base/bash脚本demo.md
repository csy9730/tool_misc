 

### Linux 编写一个简单的一键脚本

Linux中我们安装软件或者一些常用操作，都会接触很多命令，有时在关键时刻往往因为忘了一些简单的命令而苦恼，这时，我们不妨把命令写成可执行的批量脚本，可以减少很多重复而又容易忘记的代码，写成一键脚本还有一个好处就是方便迁移，可以直接将写好的sh文件在其他Linux平台运行。

格式：

 文件后缀.sh 
第一行代码需要指定路径来执行程序

`\#!/bin/sh` 或`#!/bin/bash`

建议由后者，参见[shell脚本头,#!/bin/sh与#!/bin/bash的区别.](https://www.cnblogs.com/jonnyan/p/8798364.html)

一般一键脚本会要求用户输入各种选项：

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

``` bash
#提示“请输入姓名”并等待30秒，把用户的输入保存入变量name中
read -t 30 -p "请输入用户名称:" name
echo -e "\n"
echo "用户名为:$name"
#提示“请输入密码”并等待30秒，把用户的输入保存入变量age中，输入内容隐藏
read -t 30 -s -p "请输入用户密码:" age
echo -e "\n"
echo "用户密码为:$age"
#提示“请输入性别”并等待30秒，把用户的输入保存入变量sex中，只接受一个字符输入
read -t 30 -n 1 -p "请输入用户性别:" sex
echo -e "\n"
echo "性别为$sex"
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

![img](https://images2018.cnblogs.com/blog/350840/201808/350840-20180808132543286-1566541324.png)

 

逻辑判断：

``` bash
read -t 30 -p "请输入用户名称:" isYes
if [ "${isYes}" = "yes" ]; then
    echo "输入了Yes"
fi
```

执行并行脚本：

``` bash
wget -c http://www.xxx.com/xx.tar.gz && tar zxf xx.tar.gz && cd xx && ./install.sh
```

方法调用：

``` bash
print_hello()
{
echo "hello"
}
print_hello
```

转自：https://blog.csdn.net/c__chao/article/details/79785571

### echo命令

[Shell内建命令](http://man.linuxde.net/sub/shell%e5%86%85%e5%bb%ba%e5%91%bd%e4%bb%a4)

**echo命令**用于在shell中打印shell变量的值，或者直接输出指定的字符串。linux的echo命令，在shell编程中极为常用, 在终端下打印变量value的时候也是常常用到的，因此有必要了解下echo的用法echo命令的功能是在显示器上显示一段文字，一般起到一个提示的作用。

### 语法

```
echo(选项)(参数)
```

### 选项

```
-e：激活转义字符。
```

使用`-e`选项时，若字符串中出现以下字符，则特别加以处理，而不会将它当成一般文字输出：

- \a 发出警告声；
- \b 删除前一个字符；
- \c 最后不加上换行符号；
- \f 换行但光标仍旧停留在原来的位置；
- \n 换行且光标移至行首；
- \r 光标移至行首，但不换行；
- \t 插入tab；
- \v 与\f相同；
- \\ 插入\字符；
- \nnn 插入nnn（八进制）所代表的ASCII字符；

### 参数

变量：指定要打印的变量。

### 实例

用echo命令打印带有色彩的文字：

**文字色：**

``` bash
echo -e "\e[1;31mThis is red text\e[0m"
This is red text
```

- `\e[1;31m` 将颜色设置为红色
- `\e[0m` 将颜色重新置回

颜色码：重置=0，黑色=30，红色=31，绿色=32，黄色=33，蓝色=34，洋红=35，青色=36，白色=37

**背景色**：

```
echo -e "\e[1;42mGreed Background\e[0m"
Greed Background
```

颜色码：重置=0，黑色=40，红色=41，绿色=42，黄色=43，蓝色=44，洋红=45，青色=46，白色=47

**文字闪动：**

```
echo -e "\033[37;31;5mMySQL Server Stop...\033[39;49;0m"
```

红色数字处还有其他数字参数：0 关闭所有属性、1 设置高亮度（加粗）、4 下划线、5 闪烁、7 反显、8 消隐

转自：http://man.linuxde.net/echo