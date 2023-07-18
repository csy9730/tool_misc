# [shell脚本执行返回的状态码](https://www.cnblogs.com/MyEyes/archive/2012/01/12/2320529.html)

Linux下一条命令或一个进程执行完成会返回一个一个状态码。

- 0   ===   成功执行
- 非0 ===  执行过程中出现异常或非正常退出

在Shell脚本中 最后执行的一条命令将决定整个shell脚本的状态. 此外 shell的内部命令exit也可以随时终止shell脚本的执行，返回Shell脚本的状态码

当shell脚本执行结束前 的最后一个命令是不带参数的exit ，那么 shell脚本的最终返回值 就是 exit 语句前一条语句的返回值，根据这个值可以判断脚本成功执行与否。

 $? 可以查看 最后一条命令的返回值 该变量可以在shell 脚本中的任何地方使用.



```
#! /bin/bash
echo "please input the branch you want to compare"
read $MY_BRANCH
for i in $(cat list)
do
        git-diff --quiet $MY_BRANCH $i    [--quiet 选项的意思是不要输出比较后各个diff出来的结果]
        if [ $? -eq 0 ]        [$? 就是上一条命令执行的状态码]
        then  
            echo $i
        fi
done
```





![img](https://pic002.cnblogs.com/images/2012/335757/2012011214413057.jpg)





分类: [Shell](https://www.cnblogs.com/MyEyes/category/348918.html)



在shell中运行的每个命令都使用了退出状态码告诉shell它已经运行完毕。退出状态码是一个0~255的整数值，在命令运行时由命令传给shell。可以捕获这个值并在脚本中使用。

查看退出状态码
Linux提供了一个专门的变量? 来 保 存 上 个 已 执 行 的 退 出 状 态 码 。 对 于 需 要 进 行 检 查 的 命 令 ， 必 须 在 运 行 完 毕 后 立 刻 查 看 ?来保存上个已执行的退出状态码。对于需要进行检查的命令，必须在运行完毕后立刻查看?来保存上个已执行的退出状态码。对于需要进行检查的命令，必须在运行完毕后立刻查看?变量。它的值会变成由shell所执行的最后一条命令的退出码。

Linux退出状态码

状态码	描述
0	命令成功结束
1	一般性未知错误
2	不适合的shell命令
126	命令不可执行
127	没有找到命令
128	无效的退出参数
128+x	与Linux信号x相关的严重错误
130	通过Ctrl +C终止的命令
255	正常范围之外的退出状态码