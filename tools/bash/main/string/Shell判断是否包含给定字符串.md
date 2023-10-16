# Shell判断是否包含给定字符串

[![Python头条](https://picx.zhimg.com/v2-be4cebdf2af0ffb372a8f1e742a032e3_l.jpg?source=172ae18b)](https://www.zhihu.com/people/gao-xin-shi-zhan-ai-hao-zhe)

[Python头条](https://www.zhihu.com/people/gao-xin-shi-zhan-ai-hao-zhe)

在 bash 脚本中，有不止一种检查子字符串的方法，我们今天介绍一些简单的例子，然后在分享一个常用的 bash 脚本。

我们在写 bash 脚本的时候，假如有一个字符串，我们想检查其中是否包含另一个子字符串，那这个时候需要怎样做呢？这里介绍Shell判断字符串包含关系的几种方法

#### grep
1、通过grep来判断：

``` bash
str1="abcdefgh"
str2="def"
result=$(echo $str1 | grep "${str2}")
if [[ "$result" != "" ]]
then
    echo "包含"
else
    echo "不包含"
fi
```

先打印长字符串，然后在长字符串中 grep 查找要搜索的字符串，用变量result记录结果，如果结果不为空，说明str1包含str2。如果结果为空，说明不包含。这个方法充分利用了grep 的特性，最为简洁。

#### string =~
2、字符串运算符

``` bash
str1="abcdefgh"
str2="def"
if [[ $str1 =~ $str2 ]]
then
    echo "包含"
else
    echo "不包含"
fi
```

利用字符串运算符 =~ 直接判断str1是否包含str2。
#### 通配符*
3、利用通配符

``` bash
str1="abcdefgh"
str2="def"
if [[ $str1 == *$str2* ]]
then
    echo "包含"
else
    echo "不包含"
fi
```

用通配符*号代理str1中非str2的部分，如果结果相等说明包含，反之不包含。
#### case in
4、利用case in 语句

``` bash
str1="abcdefgh"
str2="def"
case $str1 in 
    *"$str2"*) echo Enemy Spot ;;
    *) echo nope ;;
esac
```
#### 字符替换
5、利用替换

``` bash
str1="abcdefgh"
str2="def"
if [[ ${str1/${str2}//} == $str1 ]]
    then
       echo "不包含"
    else
      echo "包含"
fi
```

注意下文中的用的是[[]]还是[]

## Shell判断文件是否包含给定字符串

给定一个字符，比方说“Hello Weijishu”，查找相应文件中是否包含该字符。
#### grep
方式1：grep

``` bash
# grep -c 返回 file中，与str匹配的行数
grep -c str file


FIND_FILE="/home/linduo/test/Test.txt"
FIND_STR="Hello Weijishu"
# 判断匹配函数，匹配函数不为0，则包含给定字符
if [ `grep -c "$FIND_STR" $FIND_FILE` -ne '0' ];then
    echo "The File Has Hello Weijishu!"
    exit 0
fi 
```
#### cat
方式2：cat、while、read组合使用。使用这种方式，要注意时while read 在子shell中运行。

``` bash
FIND_FILE="/home/weijishu/test/Test.txt"
FIND_STR="Hello Weijishu"
cat $FIND_FILE| while read line
do
if [[ $line =~ $FIND_STR ]];then
    echo "The File Has Hello Weijishu!"
fi
done
```

> *链接：[https://blog.csdn.net/bandaoyu/article/details/115484153](https://link.zhihu.com/?target=https%3A//blog.csdn.net/bandaoyu/article/details/115484153)（版权归原作者所有，侵删）*

[Docker容器超全详解，别再说不会用Docker了！mp.weixin.qq.com/s/PDmxWT2wn-sKNr4mYhpugQ![img](https://pic2.zhimg.com/v2-d7c41354b4ebd1a3b7a55a1b1577a5fd_ipico.jpg)](https://link.zhihu.com/?target=https%3A//mp.weixin.qq.com/s/PDmxWT2wn-sKNr4mYhpugQ)



发布于 2023-07-18 10:48・IP 属地河南