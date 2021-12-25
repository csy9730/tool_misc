# Ubuntu 16.04设置rc.local开机启动命令/脚本的方法（通过update-rc.d管理Ubuntu开机启动程序/服务）--debian与ubuntu类似

**注意：rc.local脚本里面启动的用户默认为root权限。**

## **一、rc.local脚本**

rc.local脚本是一个Ubuntu开机后会自动执行的脚本，我们可以在该脚本内添加命令行指令。该脚本位于/etc/路径下，需要root权限才能修改。

该脚本具体格式如下：

``` bash
#!/bin/sh -e
#
# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "exit 0" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.
#
# By default this script does nothing.
  
exit 0
```

**注意:** 一定要将命令添加在exit 0之前。里面可以直接写命令或者执行Shell脚本文件sh。

## **二、关于放在rc.local里面时不启动的问题：**

1、可以先增加日志输出功能，来查看最终为什么这个脚本不启动的原因，这个是Memcached启动时的样例文件：


``` bash
#!/bin/sh -e
#
# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "exit 0" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.
#
# By default this script does nothing.

#log
exec 2> /tmp/rc.local.log  # send stderr from rc.local to a log file  
exec 1>&2                  # send stdout to the same log file  
set -x                     # tell sh to display commands before execution 

#Memcached
/usr/local/memcache/bin/memcached -p 11211 -m 64m -d -u root

exit 0
```


2、rc.local文件头部/bin/sh修改为/bin/bash

3、如果是执行sh文件，那么要赋予执行权限sudo chmod +x xxx.sh，然后启动时加上sudo sh xxx.sh

## **三、 update-rc.d增加开机启动服务**

**给Ubuntu添加一个开机启动脚本，操作如下：**

**1、新建个脚本文件new_service.sh**

``` bash
#!/bin/bash
# command content
  
exit 0
```

**2、设置权限**

``` bash
sudo chmod 755 new_service.sh
#或者
sudo chmod +x new_service.sh
```

**3、把脚本放置到启动目录下**

``` bash
sudo mv new_service.sh /etc/init.d/
```

**4、将脚本添加到启动脚本**

执行如下指令，在这里90表明一个优先级，越高表示执行的越晚

``` bash
cd /etc/init.d/
sudo update-rc.d new_service.sh defaults 90
```

**5、移除Ubuntu开机脚本**

``` bash
sudo update-rc.d -f new_service.sh remove
```

**6、通过sysv-rc-conf来管理上面启动服务的启动级别等，还是开机不启动**

``` bash
sudo sysv-rc-conf 
```

**7、update-rc.d的详细参数**

使用update-rc.d命令需要指定脚本名称和一些参数，它的格式看起来是这样的（需要在 root 权限下）：

```
update-rc.d [-n] [-f] <basename> remove
update-rc.d [-n] <basename> defaults
update-rc.d [-n] <basename> disable|enable [S|2|3|4|5]
update-rc.d <basename> start|stop <NN> <runlevels>
-n: not really
-f: force
```

其中：

- disable|enable：代表脚本还在/etc/init.d中，并设置当前状态是手动启动还是自动启动。
- start|stop：代表脚本还在/etc/init.d中，开机，并设置当前状态是开始运行还是停止运行。（启用后可配置开始运行与否）
- NN：是一个决定启动顺序的两位数字值。（例如90大于80，因此80对应的脚本先启动或先停止）
- runlevels：则指定了运行级别。

实例：

（1）、添加一个新的启动脚本sample_init_script，并且指定为默认启动顺序、默认运行级别（还记得前面说的吗，首先要有实际的文件存在于/etc/init.d，即若文件/etc/init.d/sample_init_script不存在，则该命令不会执行）：

```
update-rc.d sample_init_script defaults
```

上一条命令等效于（中间是一个英文句点符号）：

```
update-rc.d sample_init_script start 20 2 3 4 5 . stop 20 0 1 6
```

（2）、安装一个启动脚本sample_init_script，指定默认运行级别，但启动顺序为50：

```
update-rc.d sample_init_script defaults 50
```

（3）、安装两个启动脚本A、B，让A先于B启动，后于B停止：

```
update-rc.d A 10 40
update-rc.d B 20 30
```

（4）、删除一个启动脚本sample_init_script，如果脚本不存在则直接跳过：

```
update-rc.d -f sample_init_script remove
```

这一条命令实际上做的就是一一删除所有位于/etc/rcX.d目录下指向/etc/init.d中sample_init_script的链接（可能存在多个链接文件），update-rc.d只不过简化了这一步骤。

（5）禁止Apache/MySQL相关组件开机自启：

```
update-rc.d -f apache2 remove
update-rc.d -f mysql remove
```

**8、服务的启动停止状态**

``` bash
#通过service，比如
sudo service xxx status
sudo service xxx start
sudo service xxx stop
sudo service xxx restart
```

**9、查看全部服务列表**

```
sudo service --status-all
```

 

参考：

<http://www.jamescoyle.net/cheat-sheets/791-update-rc-d-cheat-sheet>（查看全部服务列表）

<http://blog.csdn.net/typ2004/article/details/38712887>

<http://blog.csdn.net/shb_derek1/article/details/8489112>

<http://blog.sina.com.cn/s/blog_79159ef50100z1ax.html>

<http://www.linuxidc.com/Linux/2013-01/77553p2.htm>

<http://www.jb51.net/article/100413.htm>

<http://blog.csdn.net/yplee_8/article/details/50342563>

<http://blog.163.com/zhu329599788@126/blog/static/66693350201731211940840/>

rc.local不启动的原因：

<http://fantaxy025025.iteye.com/blog/2097862>

<http://www.linuxidc.com/Linux/2016-12/138665.htm>

<http://blog.csdn.net/sea_snow/article/details/51051289>

<http://blog.csdn.net/benbenxiongyuan/article/details/58597036>

<http://www.cnblogs.com/liulanghe/p/3376380.html>

<http://blog.csdn.net/zhe_d/article/details/50312967>

 转自：https://www.cnblogs.com/EasonJim/p/7573292.html

