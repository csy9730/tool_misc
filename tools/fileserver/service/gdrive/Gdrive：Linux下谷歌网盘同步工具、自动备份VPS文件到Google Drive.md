# Gdrive：Linux下谷歌网盘同步工具、自动备份VPS文件到Google Drive

- 博主： [Rat's](https://www.moerats.com/author/1/)
-  

-  发布时间：2017 年 09 月 14 日
-  

-  16976 次浏览
-  

-  [ 10 条评论](https://www.moerats.com/archives/296/#comments)
-  

-  1768 字数
-  

-  分类：[建站知识](https://www.moerats.com/category/jzzs/)

1. [ 首页](https://www.moerats.com/)
2. 正文 
3. 分享到：  

## 简介

`Gdrive`，`Linux`下上传、下载`Google Drive`文件的一款`CLI`工具，安装简单、使用方便。

## 安装

`centos 7`下测试通过。
1、安装

```
wget -O /usr/bin/gdrive "https://docs.google.com/uc?id=0B3X9GlR6EmbnQ0FtZmJJUXEyRTA&export=download"
chmod +x /usr/bin/gdrive
```

2、授权

```
gdrive about
```

然后会出现一串网址并询问验证码。
[![请输入图片描述](https://www.moerats.com/usr/picture/Gdrive(1).jpg)](https://www.moerats.com/usr/picture/Gdrive(1).jpg)
将地址粘贴到浏览器并登陆账号，会返回一串代码。
[![请输入图片描述](https://www.moerats.com/usr/picture/Gdrive(2).jpg)](https://www.moerats.com/usr/picture/Gdrive(2).jpg)
将代码粘贴到SSH下，然后会返回你的账户信息。
[![请输入图片描述](https://www.moerats.com/usr/picture/Gdrive(3).jpg)](https://www.moerats.com/usr/picture/Gdrive(3).jpg)
`gdrive`程序会自动将你的`token`保存在用户目录下的`.gdrive`目录中，所以如果不需要了记得把这个文件删掉。

## 使用

常用命令如下，更多查看`gdrive`官网：https://github.com/prasmussen/gdrive。

1、列出`Google Drive`根目录下文件、文件夹

```
gdrive list
```

2、下载`Google Drive`根目录下文件到本地（`xxxx`为文件名）

```
gdrive download xxxx
```

3、下载`Google Drive`根目录下文件夹到本地（`xxx`为文件夹名）

```
gdrive download xxx
```

4、把本地文件上传到`Google Drive`根目录下（`xxxx`为文件名）

```
gdrive upload xxxx
```

5、在`Google Drive`根目录下创建文件夹（`xxx`为文件夹名）

```
gdrive mkdir xxx
```

## 自动备份

1、网站自动备份脚本（基于`Mysql`数据库）
脚本下载：[googledrive.sh](https://www.moerats.com/usr/down/googledrive.sh)
修改以下部分：

```
第3行：my-database-name改为自己的数据库名
第4行：my-database-user改为自己的数据库用户名
第5行：my-database-password改为自己的数据库用户名对应的密码
第7行：yourdomain.com改为自己的网站目录
第8行：/home/wwwroot改为自己的网站所在目录（即需备份目录为/home/wwwroot/yourdomain.com）
第9行：/backups改为备份文件存放目录
第35行：youremail@yourdomain.com修改为自己的邮箱
```

2、更改权限

```
chmod +x googledrive.sh
```

3、创建定时任务

```
vi  /etc/crontab
```

添加

```
0 2 * * * /backups/googledrive.sh
```

以上备份脚本存放在`/backups/`下，每日`2`点备份。

4、重启crontab

```
/etc/init.d/crond restart
```

**原文参考：**[Gdrive：Linux下同步Google Drive文件、自动备份网站到Google Drive](https://zhujiwiki.com/11147.html)

------

> 版权声明：本文为原创文章，版权归 [Rat's Blog](https://www.moerats.com/) 所有，转载请注明出处！
>
> 本文链接：https://www.moerats.com/archives/296/
>
> 如教程需要更新，或者相关链接出现404，可以在文章下面评论留言。