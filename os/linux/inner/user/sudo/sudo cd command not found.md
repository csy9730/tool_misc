[![Return Home](https://www.cnblogs.com/skins/custom/images/logo.gif)](https://www.cnblogs.com/yuyutianxia/)

# [sudo: cd: command not found ](https://www.cnblogs.com/yuyutianxia/p/7755579.html)



# 原因

------

## shell

shell是一个命令解析器

所谓shell是一个交互式的应用程序。

shell执行外部命令的时候，是通过fork/exec生成一个子进程，然后执行这个程序。

## sudo

------

sudo 是一种程序
sudo的意思是，以别人的权限生成一个进程，并运行程序。

## cd

------

type用来区分某个命令到底是由shell自带的，还是由shell外部的独立二进制文件提供的。

```
$ type cd 

cd is a shell builtin
```



 

cd是shell的内部命令。 也就是说，是直接由shell运行的，不生成子进程。 

 

# 解决办法

------

 

那么我们该怎么办呢？
一个有限的办法就是为该目录增加当前用户的可执行权限，但是对我们来说这样并不是很安全 
那么还有没有解决办法呢？
使用`su` 命令即可获取用户的权限，但是root权限怎么获取呢，没有root账户的密码

那就是`sudo su` 默认缺省为获取`root` 用户 