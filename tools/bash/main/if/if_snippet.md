#  我使用过的Linux命令之if - Bash中的条件判断语句

 

## 用途说明

Shell中的条件判断语句，与其他编程语言类似。

如果需要知道有哪些条件判断方式，通过man test就可以得到帮助。

## 常用格式

### 格式一
```
if 条件; then
​    语句
fi
```

### 格式二
```
if 条件; then
​    语句
else
​    语句
fi
```
### 格式三
```
if 条件; then
​    语句
elif 条件; then
​    语句
fi
```
### 格式四
``` bash
if 条件; then
​    语句
elif 条件; then
​    语句
else
​    语句
fi
```

## 使用示例

### 示例一

Bash代码

``` bash
if [ "foo" = "foo" ]; then
    echo expression evaluated as true
fi
```

 

[root@jfht ~]# if [ "foo" = "foo" ]; then
\>     echo expression evaluated as true
\> fi
expression evaluated as true
[root@jfht ~]#

### 示例二

Bash代码 


``` bash
if [ "foo" = "foo" ]; then
    echo expression evaluated as true
else
    echo expression evaluated as false
fi
```

### 示例三

Bash代码 

```
T1="foo"
T2="bar"
if [ "$T1" = "$T2" ]; then
    echo expression evaluated as true
else
    echo expression evaluated as false
fi
```

### 示例四 判断命令行参数数量

```
#!/bin/sh

if [ "$#" != "1" ]; then
    echo "usage: $0 <file>"
    exit 1
fi
```

### 示例五 判断文件中是否包含某个字符串

```
if grep -q root /etc/passwd; then
    echo account root exists
else
    echo account root not exist
fi
```

### 示例六 判断文件是否存在


```
if [ -e myfile ]; then
    echo myfile exists
else
    touch myfile
    echo myfile created
fi
```

 

### 示例七 判断两个文件是否相同

```
echo 1 >file1
echo 2 >file2
if ! diff -q file1 file2; then
    echo file1 file2 diff
else
    echo file1 file2 same
fi 
```


## 问题思考

1. 怎么判断字符串非空？
2. 怎么判断文件非空？
3. 怎么判断文件可执行？
4. 怎么判断目录？
5. 怎么判断数值大小判断？

## 相关资料

【1】BASH Programming [6.1 Dry Theory](http://www.faqs.org/docs/Linux-HOWTO/Bash-Prog-Intro-HOWTO.html#ss6.1)

【2】刘 泰山的博客 [bash if 条件判断](http://blog.myspace.cn/e/405974342.htm)

[top](https://www.cnblogs.com/haivey/archive/2012/09/04/2669870.html#a0)

 