# ssh

## repo

仓库地址可以使用ssh协议，也可以使用http协议。
传统的git使用ssh协议，属于系统用户的协议。
而http使用数据库用户管理，属于应用级协议，更加适合。

典型的ssh协议地址：
`ssh://root@192.168.22.56/d/githubs/unet/unet-master`

## misc



**Q**: git upload pack not found

**A**:

``` bash
git push origin master
bash: git-upload-receive: command not found
fatal: 
```
查看获取到服务器上的PATH，是否包含有含git-upload-pack的路径。没有，给服务器上加上，再试。

我的就没有，我就给服务器上加上环境变量，服务器重启后再尝试连接，就OK了。

git相关文件有：`git.exe、git-receive-pack.exe、git-upload-archive.exe、git-upload-pack.exe、libiconv-2.dll`