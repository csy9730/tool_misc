# ln

## 一、介绍

ln命令用于将一个文件创建链接,链接分为软链接(类似于windows系统中的快捷方式)和硬链接(相当于对源文件copy,程序或命令对该文件block的另一个访问路口)，命令默认使用硬链接。

## 二、使用方法

```
语法：``ln` `[选项][文件]``选项：-s 对源文件创建软链接
```

 

## 三、案例：

1.对文件创建软链接

```
[root@``ping` `~]``# ln -s /root/student.sql /root/db/ln.sql``[root@``ping` `~]``# ls -lh db/ln.sql ``lrwxrwxrwx 1 root root 17 2月  23 15:31 db``/ln``.sql -> ``/root/student``.sql
```

2.对目录创建软链接

```
[root@``ping` `~]``# ln -s db data``[root@``ping` `~]``# ll -h data/``lrwxrwxrwx 1 root root 17 2月  23 15:31 ``ln``.sql -> ``/root/student``.sql``[root@``ping` `~]``# ln student.sql db/
```

3.对文件创建硬链接

```
[root@``ping` `~]``# ln student.sql db/``[root@``ping` `~]``# ls -lh db/``lrwxrwxrwx 1 root root   17 2月  23 15:31 ``ln``.sql -> ``/root/student``.sql``-rw-r--r-- 2 root root 2.9K 2月  12 10:17 student.sql
```

 

## 三、软、硬链接说明　

软链接：不可以删除源文件，删除源文件导致链接文件找不到，出现文件红色闪烁
硬链接：可以删除源文件，链接文件可以正常打开