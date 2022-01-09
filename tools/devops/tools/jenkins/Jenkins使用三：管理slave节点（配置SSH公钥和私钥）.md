# [Jenkins使用三：管理slave节点（配置SSH公钥和私钥）](https://www.cnblogs.com/zhongyehai/p/11337279.html)

 

添加slave

![img](https://img2018.cnblogs.com/blog/1406024/201908/1406024-20190811222514556-54485599.png)

 

给节点起个名字

![img](https://img2018.cnblogs.com/blog/1406024/201908/1406024-20190811222735900-2120473053.png)

 

1.远程工作目录：/test/workspace
--这个地址是测试机的 jenkins 的 workspace 工作目录，自己随便写个本机的路径
2.用法
--尽可能的使用这个节点：其它的job也能在这台机器上运行,如果只想运行测试自动化代码，就不选这个
--只允许运行绑定到这台机器的 Job：测试自动化的 Job 绑定这个机器后，就只能在这个机器运行了
3.启动方法：
--windows 上启动方法最好通过 Java web start 来启动 slave
--linux 上启动选：Launch slave agents via SSH

![img](https://img2018.cnblogs.com/blog/1406024/201908/1406024-20190811223526820-1413919302.png)

主机：填host

![img](https://img2018.cnblogs.com/blog/1406024/201908/1406024-20190811223757547-1929799872.png)

![img](https://img2018.cnblogs.com/blog/1406024/201908/1406024-20190811223819582-1219701274.png)

 

生成ssh公钥和私钥

执行：ssh-keygen，一路回车

![img](https://img2018.cnblogs.com/blog/1406024/201908/1406024-20190811224246758-325563594.png)

进入.ssh文件夹：cd .ssh/
id_rsa：私钥
id_rsa.pub：公钥

![img](https://img2018.cnblogs.com/blog/1406024/201908/1406024-20190811224437020-647802165.png)

 把公钥写到authorized_keys文件：cat id_rsa.pub > authorized_keys

![img](https://img2018.cnblogs.com/blog/1406024/201908/1406024-20190811224826132-1863083485.png)

![img](https://img2018.cnblogs.com/blog/1406024/201908/1406024-20190811230626092-2071137048.png)

 

复制私钥：cat id_rsa

![img](https://img2018.cnblogs.com/blog/1406024/201908/1406024-20190811225151539-658722011.png)

 

继续配置

![img](https://img2018.cnblogs.com/blog/1406024/201908/1406024-20190811225053482-338230615.png)

 ![img](https://img2018.cnblogs.com/blog/1406024/201908/1406024-20190811232718123-1802082655.png)

 

继续配置，点保存

![img](https://img2018.cnblogs.com/blog/1406024/201908/1406024-20190811232325158-1447683869.png)

 

![img](https://img2018.cnblogs.com/blog/1406024/201908/1406024-20190811225656114-2134232129.png)

![img](https://img2018.cnblogs.com/blog/1406024/201908/1406024-20190811225715876-612090449.png)

 

连接成功

![img](https://img2018.cnblogs.com/blog/1406024/201908/1406024-20190811232520965-1810391211.png)

 

![img](https://img2018.cnblogs.com/blog/1406024/201908/1406024-20190811232438502-846925054.png)

 

讨论群：249728408

分类: [Jenkins安装和使用](https://www.cnblogs.com/zhongyehai/category/1522573.html)