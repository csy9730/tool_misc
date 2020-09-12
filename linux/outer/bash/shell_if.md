# [[shell\]shell中if语句的使用](https://www.cnblogs.com/aaronLinux/p/7074725.html)



转自：http://lovelace.blog.51cto.com/1028430/1211353

 

bash中如何实现条件判断？
**条件测试类型**：
    整数测试
    字符测试
    文件测试

**一、条件测试的表达式：**
    [ expression ]  括号两端必须要有空格
    [[ expression ]] 括号两端必须要有空格
    test expression
**组合测试条件**：

- -a: and
- -o: or
- !:  非

**二、整数比较：**

- -eq 测试两个整数是否相等
- -ne 测试两个整数是否不等
- -gt 测试一个数是否大于另一个数
- -lt 测试一个数是否小于另一个数
- -ge 大于或等于
- -le 小于或等于

**命令间的逻辑关系**

- 逻辑与：&&

​        第一个条件为假 第二个条件不用在判断，最总结果已经有
​        第一个条件为真，第二个条件必须得判断

- 逻辑或：||

**三、字符串比较**

- == 等于  两边要有空格
- != 不等
- \>  大于
- <  小于

**四、文件测试**

- -z string 测试指定字符是否为空，空着真，非空为假
- -n string 测试指定字符串是否为不空，空为假 非空为真
- -e FILE 测试文件是否存在
- -f file 测试文件是否为普通文件
- -d file 测试指定路径是否为目录
- -r file 测试文件对当前用户是否可读
- -w file 测试文件对当前用户是否可写
- -x file 测试文件对当前用户是都可执行
- -z  是否为空  为空则为真
- -a  是否不空

**五、if语法**

if 判断条件 0为真 其他都为假

- .单分支if语句

```
if 判断条件；then
    statement1
    statement2
    .......
fi
```

- .双分支的if语句：

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
if 判断条件；then
    statement1
    statement2
    .....
    else
    statement3
    statement4
fi
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

**Note:**
if语句进行判断是否为空
 [ "$name” = "" ] 
等同于

```
[ ! "$name" ]
[ -z "$name" ]    
```

**Note:**
使用if语句的时候进行判断如果是进行**数值类**的判断，建议**使用**let(())进行判断，对于**字符串**等**使用**test[ ] or [[ ]] 进行判断
(())中变量是可以不使用$来引用的

example：表述数字范围的时候 可以使用if可以是使用case

```
if [ $x -gt 90 -o $x -lt 100 ]
case $x in
100)
9[0-9]) 
```

这个语句的意思是如果$name为空，那么X=X成立折执行下面的结果；

```
if [ "X$name" != "x" ]
```

写脚本的时候很多时候需要用到回传命令，**$?如果上一个命令执行成功**，回传值为0，否则为1~255之间的任何一个

- 0为真
- 非0为假

**条件测试的写法**：

1、执行一个命令的结果
 if grep -q "rm" fs.sh;then 

2、传回一个命令执行结果的相反值
 if ！grep -q "rm" fs.sh;then 

3、使用复合命令（（算式））
 if ((a>b));then 

4、使用bash关键字 [[判断式]]
 if [[ str > xyz ]];then 

5、使用内置命令：test 判断式
 if test "str" \> "xyz";then 

6、使用内置命令：[判断式]  类似test
 if [ "str" \> "xyz" ];then 

7、使用-a -o进行逻辑组合
 [ -r filename -a -x filename ] 

8、命令&&命令
 if grep -q "rm" fn.sh && [ $a -lt 100 ];then 

9、命令||命令
 if grep -q "rm" fn.sh || [ $a -lt 100 ];then 

示例脚本（

写一段脚本，输入一个测验成绩，根据下面的标准，输出他的评分

成绩（A-F）。

A: 90–100

B: 80–89

C: 70–79

D: 60–69

F: <60

）    

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
#/bin/bash
#Verson:0.1
#Auther:lovelace
#Pragram:This pragram is calculation your grade
#import an argument
read -p "Please input your grade:" x
declare -i x
#jugemet $x value is none or not
if [ "$x" == "" ];then
    echo "You don't input your grade...."
    exit 5
fi
#jugement the gread level
if [[ "$x" -ge "90" && "$x" -le "100" ]];then
    echo "Congratulation,Your grade is A."
elif [[ "$x" -ge "80" && "$x" -le "89" ]];then
    echo "Good,Your grade is B."
elif [[ "$x" -ge "70" && "$x" -le "79" ]];then
    echo "Ok.Your grade is C."
elif [[ "$x" -ge "60" && "$x" -le "69" ]];then
    echo "Yeah,Your grade is D."
elif [[ "$x" -lt "60" ]];then
    echo "Right,Your grade is F."
else
    echo "Unknow argument...."
fi
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

执行结果：

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
[root@lovelace if]# ./grade.sh
    Please input your grade:
    You don't input your grade....
[root@lovelace if]# ./grade.sh
    Please input your grade:53
    Right,Your grade is F.
[root@lovelace if]# ./grade.sh
    Please input your grade:88
    Good,Your grade is B.
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

总结：条件判断在shell语句中经常用到，需要熟练掌握，在此基础上才能练就一手很好的脚本编写能力。祝各位每天都能获得很大的进步.....