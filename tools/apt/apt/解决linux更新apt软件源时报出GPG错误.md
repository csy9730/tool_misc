# [解决linux更新apt软件源时报出GPG错误](https://www.cnblogs.com/DragonStart/p/8146272.html)

今天给树莓派换源,爆出N个这错误:
W: GPG error: http://mirrors.neusoft.edu.cn/raspbian/raspbian wheezy InRelease: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY 9165938D90FDDD2E
经过多番查找资料,解决了问题,记录下解决过程.

# 介绍:

## GPG是啥:

这玩意又叫GnuPG,是一个加密/解密相关的工具,据说是模仿PGP开发的(PGP另一个加密工具,收费的)

## apt为何用到GPG:

apt在下载包的时候会加密,而GPG在其中提供加密,解密相关的支持

# 解决问题:

从上面的提示可看出,似乎缺少了某Pubkey,所以要把它补上,使用如下命令:

```shell
gpg --keyserver 服务器 --recv-keys 提示语句最后的那串玩意儿 && apt-key add /root/.gnupg/pubring.gpg
#例子:
gpg --keyserver keyserver.ubuntu.com --recv-keys 9165938D90FDDD2E && apt-key add /root/.gnupg/pubring.gpg
```

有些系统可以尝试用这个:

```shell
sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 9165938D90FDDD2E 
```

命令执行后,再次apt update,发现之前的GPG错误没了.问题解决~

# 国内可用key server列表:

keyserver.ubuntu.com
pgp.mit.edu
subkeys.pgp.net
www.gpg-keyserver.de

# 参考资料(里面有更详细的内容):

http://blog.chinaunix.net/uid-20420254-id-2890214.html
http://www.ruanyifeng.com/blog/2013/07/gpg.html
http://zqscm.qiniucdn.com/data/20070530161730/index.html

"随笔"类型下的内容为原创,转载请注明来源. http://www.cnblogs.com/DragonStart/

分类: [Linux操作](https://www.cnblogs.com/DragonStart/category/1027290.html)