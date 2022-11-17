# BASH脚本基础：文件切分与合并过程_淼叔的博客-程序员秘密_bash 文件切分

这篇文章介绍一下文件切分和合并的建议过程，使用split进行切分，使用cat进行合并，结合md5sum进行完整性验证，使用其他方式实现的话，整体的流程是可以参考的。

## 切分文件

使用split命令进行文件切分，一般常用两种方式，



### 方式1: 按行切分

对于文本格式的文件可以使用按行切分的方法, 切分命令如下所示执行命令：
``` bash
split -l 切分行数 待切分的源文件 切分后的文件名前缀
```


### 方式2: 按大小切分

对于二进制文件一般可以使用按照大小的方式来切分，比如1000M一个文件的方式，切分命令如下所示：执行命令：
``` bash
split -b 切分的大小 待切分的源文件 切分后的文件名前缀
```

注：切分后的文件名前缀指定之后，split会按照相应格式在后面添加aa、ab、ac等后缀以表示顺序，如果不指定，缺省会以x作为前缀，即会生成xaa、xab、xac等文件名称，无论方式1还是方式2均是如此。

###  合并文件

合并文件使用cat即可，由于切分时已经按照字母顺序生成文件名称了，所以使用如下命令即可

合并文件了执行linking：

``` bash
cat 切分后的文件名前缀* >新文件名
```

### 执行示例1：按行切分与合并的过程

此处以Linux的message日志文件为例进行切分与合并的说明。

#### 事前准备和确认



```bash
[root@liumiaocn ~]# cp /var/log/messages . 
[root@liumiaocn ~]# wc -l messages* 
	3131 messages 
[root@liumiaocn ~]# 
```



#### 步骤1: 确认切分前文件的md5校验和并校验



```bash
`[root@liumiaocn ~]# md5sum messages >md5.checksum.messages 
[root@liumiaocn ~]# cat md5.checksum.messages  
	6aab9c1295927a1fd774fa191d8418dd  messages 
[root@liumiaocn ~]# md5sum -c md5.checksum.messages  
	messages: OK 
[root@liumiaocn ~]#  `
```



#### 步骤2: 安行切分文件（1000行）

```bash
[root@liumiaocn ~]# split -l 1000 messages messages.split. 
[root@liumiaocn ~]# ls messages* messages  messages.split.aa  messages.split.ab  messages.split.ac  messages.split.ad 
[root@liumiaocn ~]# wc -l messages*  
    3131 messages  
    1000 messages.split.aa  
    1000 messages.split.ab  
    1000 messages.split.ac   
    131 messages.split.ad  
    6262 total 
[root@liumiaocn ~]#  `
```



#### 步骤3: 下载切分的文件并合并下载切分文件

```bash
liumiaocn:merge liumiao$ sftp liumiaocn Connected to liumiaocn. 
sftp> mget messages.split.* 
	Fetching /root/messages.split.aa to messages.split.aa /root/messages.split.aa     100%   82KB   5.1MB/s   00:00     
    Fetching /root/messages.split.ab to messages.split.ab /root/messages.split.ab     100%   81KB  17.4MB/s   00:00     
    Fetching /root/messages.split.ac to messages.split.ac /root/messages.split.ac     100%   83KB   2.0MB/s   00:00     
    Fetching /root/messages.split.ad to messages.split.ad /root/messages.split.ad     100%   12KB  10.2MB/s   00:00     
sftp> get md5.checksum.messages 
    Fetching /root/md5.checksum.messages to md5.checksum.messages /root/md5.checksum.messages 100%   43    32.3KB/s   00:00     
sftp> exit liumiaocn:merge liumiao$ wc -l *       
    1 md5.checksum.messages    
    1000 messages.split.aa    
    1000 messages.split.ab    
    1000 messages.split.ac     
    131 messages.split.ad    
    3132 total 
liumiaocn:merge liumiao$ cat md5.checksum.messages  	
	6aab9c1295927a1fd774fa191d8418dd  messages 
liumiaocn:merge liumiao$ wc -l messages    
	3131 messages 
liumiaocn:merge liumiao
```



#### $  `步骤4: 对合并结果进行完整性检查`

```bash
liumiaocn:merge liumiao$ md5sum -c md5.checksum.messages  
	messages: OK 
liumiaocn:merge liumiao$  
```





### `执行示例2：按行文件大小切分与合并的过程`

```bash
# 此处以Subversion Edge的5.2.4安装文件为例进行切分与合并的说明。事前准备和确认
[root@liumiaocn ~]# du -k CollabNetSubversionEdge-5.2.4_linux-x86_64.tar.gz  97036	CollabNetSubversionEdge-5.2.4_linux-x86_64.tar.gz [root@liumiaocn ~]#  
# 步骤1: 确认切分前文件的md5校验和并校验
[root@liumiaocn ~]# md5sum CollabNetSubversionEdge-5.2.4_linux-x86_64.tar.gz >md5.checksum.edge 
[root@liumiaocn ~]# cat md5.checksum.edge  0862eaba2dd1b048dc6c10cb2b1e910b  CollabNetSubversionEdge-5.2.4_linux-x86_64.tar.gz 
[root@liumiaocn ~]#  
[root@liumiaocn ~]# md5sum -c md5.checksum.edge  CollabNetSubversionEdge-5.2.4_linux-x86_64.tar.gz: OK 
[root@liumiaocn ~]#  
# 步骤2: 安行切分文件（30M）
[root@liumiaocn ~]# split -b 30m CollabNetSubversionEdge-5.2.4_linux-x86_64.tar.gz CollabNet.split. 
[root@liumiaocn ~]# du -k CollabNet* 
30720	CollabNet.split.aa 
30720	CollabNet.split.ab 
30720	CollabNet.split.ac 
4876	CollabNet.split.ad 
97036	CollabNetSubversionEdge-5.2.4_linux-x86_64.tar.gz 
[root@liumiaocn ~]# 

# 步骤3: 下载切分的文件并合并下载切分文件
liumiaocn:merge liumiao$ sftp liumiaocn Connected to liumiaocn. 
sftp> mget CollabNet.split.*    
    Fetching /root/CollabNet.split.aa to CollabNet.split.aa /root/CollabNet.split.aa    100%   30MB  24.0MB/s   00:01     
    Fetching /root/CollabNet.split.ab to CollabNet.split.ab /root/CollabNet.split.ab    100%   30MB  24.2MB/s   00:01     
    Fetching /root/CollabNet.split.ac to CollabNet.split.ac /root/CollabNet.split.ac    100%   30MB   5.6MB/s   00:05     
    Fetching /root/CollabNet.split.ad to CollabNet.split.ad /root/CollabNet.split.ad    100% 4875KB  20.4MB/s   00:00     
sftp> get md5.checksum.edge 
Fetching /root/md5.checksum.edge to md5.checksum.edge /root/md5.checksum.edge     100%   84    66.1KB/s   00:00     
sftp> exit liumiaocn:merge liumiao$  
liumiaocn:merge liumiao$ cat md5.checksum.edge  0862eaba2dd1b048dc6c10cb2b1e910b  CollabNetSubversionEdge-5.2.4_linux-x86_64.tar.gz 
liumiaocn:merge liumiao$ cat CollabNet.split.* >CollabNetSubversionEdge-5.2.4_linux-x86_64.tar.gz 
# 步骤4: 对合并结果进行完整性检查
liumiaocn:merge liumiao$ md5sum -c md5.checksum.edge  
CollabNetSubversionEdge-5.2.4_linux-x86_64.tar.gz: OK 
```



版权声明：本文为博主原创文章，遵循[ CC 4.0 BY-SA ](https://creativecommons.org/licenses/by-sa/4.0/)版权协议，转载请附上原文出处链接和本声明。本文链接：https://blog.csdn.net/liumiaocn/article/details/108179232