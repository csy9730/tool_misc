# [shell 语句出错或者异常自动退出 不继续执行](https://my.oschina.net/u/2409113/blog/490833)

原创

[玉山灵烟](https://my.oschina.net/u/2409113)

[工作日志](https://my.oschina.net/u/2409113?tab=newest&catalogId=3343084)

2015/08/11 17:11

阅读数 7.9W

[【手语服务，助力沟通无障碍】12月29日19:00 直播报名>>>![img](https://www.oschina.net/img/hot3.png)](https://e.cn.miaozhen.com/r/k=2279224&p=83hDR&dx=__IPDX__&rt=2&pro=s&ns=__IP__&ni=__IESID__&v=__LOC__&xa=__ADPLATFORM__&tr=__REQUESTID__&o=https://my.oschina.net/HMSCore/blog/5377484)

 
今天操作的时候遇到一个问题，需要把内容重定向到文件，然后再把文件重命名使用，结果重定向的时候已经抛异常了，下面的自然也会接着出现各种问题。所以，还是觉得一些关键操作要做一些判断或者捕获异常，避免出现更严重的问题。

解决办法如下：



### 使用set -e


你写的每一个脚本的开始都应该包含set -e。这告诉bash一但有任何一个语句返回非真的值，则退出bash。

使用-e的好处是避免错误滚雪球般的变成严重错误，能尽早的捕获错误。更加可读的版本：set -o errexit

使用-e把你从检查错误中解放出来。如果你忘记了检查，bash会替你做这件事。

不过你也没有办法使用$? 来获取命令执行状态了，因为bash无法获得任何非0的返回值。

你可以使用另一种结构，使用command

### 使用command

``` bash
if [ "$?"-ne 0]; then echo "command failed"; exit 1; fi "
```
可以替换成： 

`command ||  echo "command failed"; exit 1; `（这种写法并不严谨，我当时的场景是执行ssh "commond"，
所以可以返回退出码后面通过[ #？ -eq 0 ]来做判断，如果是在shell中无论成功还是失败都会exit）

修改如下（谢谢评论的朋友指正）

``` bash
command ||  （echo "command failed"; exit 1） ; 
```
或者使用： 
``` bash
if ! command; then echo "command failed"; exit 1; fi
```