# ZeroTier 使用 教程

![img](https://csdnimg.cn/release/blogv2/dist/pc/img/original.png)

[云梦惊蝉](https://blog.csdn.net/kai3123919064) 2020-11-12 23:56:21 ![img](https://csdnimg.cn/release/blogv2/dist/pc/img/articleReadEyes.png) 1854 ![img](https://csdnimg.cn/release/blogv2/dist/pc/img/tobarCollect.png) 收藏 3

分类专栏： [linux](https://blog.csdn.net/kai3123919064/category_8747776.html) 文章标签： [linux](https://www.csdn.net/tags/MtjaQg5sMDY0MC1ibG9n.html)

版权

上一章说道怎么利用vm设置虚拟机网络，实现了可以局域网连接vm中虚拟机的效果。但那个只是在局域网中，如果我想在a局域网中连接b局域网中的ip，应该怎么做呢？

网上搜了到有好几种方法[访问不同局域网内主机](https://blog.csdn.net/qq_29837161/article/details/84674552#五、搭建VPN)：

1. 公网ip端口映射
2. 使用花生壳
3. 使用Zerotier

### 端口映射

使用端口映射的方式，端口映射有两种情况，第一种是使用上网拨号的方式，电脑直接连接的光猫，这种类型的不需要进行端口映射。另外一种是电脑通过连接路由器，路由器连接光猫的形式上网，这种情况下，路由器会给我们分配一个192.168.xxx.xxx的ip，这就是我们电脑在这个路由器中的ip，不同的路由器中可能存在相同的ip，所以需要在路由器中配置端口映射，通过访问路由器中公网ip:指定端口，转发请求到 局域网中指定的ip。

但是由于这种方式需要知道路由器的管理账户，房东没给，所以这种方式行不通。

### 花生壳

使用花生壳，据说如果想要长时间使用，需要付费，那指定不行。

### ZeroTier

正在这时，发现了zerotier，使用之后感觉还是不错的，大体的流程是：

1. 到zeroTier官网申请一个账户，创建一个networkId
2. 现在不通平台的客户端，通过第一步创建的networkId加入
3. 到zeroTier 管理页面，通过客户端的请求
4. 使用分配的ip愉快的访问局域网

下面开始进入正题：

#### 1. 创建zeroTier账户

登录网址 https://www.zerotier.com/

![image-20201112205849152](https://raw.githubusercontent.com/hanbeikai/my_pic_repository/master/image_repository/20201112225547.png)

创建账户

![image-20201112210019315](https://raw.githubusercontent.com/hanbeikai/my_pic_repository/master/image_repository/20201112225608.png)

点击注册后，输入的邮箱会收到一个激活右键，进入邮件后，点击激活，才算是真正的创建成功

创建成功后，点击登录，开始创建network

#### 2. 创建NetWorkId

![image-20201112210338176](https://raw.githubusercontent.com/hanbeikai/my_pic_repository/master/image_repository/20201112230514.png)

输入账号密码

![image-20201112210512657](https://raw.githubusercontent.com/hanbeikai/my_pic_repository/master/image_repository/20201112225842.png)

点击创建network

![image-20201112210734964](https://raw.githubusercontent.com/hanbeikai/my_pic_repository/master/image_repository/20201112230645.png) ![image-20201112211247135](https://raw.githubusercontent.com/hanbeikai/my_pic_repository/master/image_repository/20201112211310.png)

点击先创建的id，进入配置详情

![image-20201112211743016_副本](https://raw.githubusercontent.com/hanbeikai/my_pic_repository/master/image_repository/20201112230306.png) ![image-20201112211928834](https://raw.githubusercontent.com/hanbeikai/my_pic_repository/master/image_repository/20201112234054.png)

如果有客户端加入了这个网络，会在这个位置显示，可以通过这个页面对加入的用户进行管理

![image-20201112212004901](https://raw.githubusercontent.com/hanbeikai/my_pic_repository/master/image_repository/20201112225932.png)

注意，这个页面的配置是实时配置的，不用点类似于提交的按钮，直接配置就生效了。

#### 3. 安装客户端

下载地址[download](https://www.zerotier.com/download/)

点击首页download按钮，选择要下载的版本

![image-20201112213211455](https://raw.githubusercontent.com/hanbeikai/my_pic_repository/master/image_repository/20201112230712.png)

选择要下载的版本

![image-20201112213424687](https://raw.githubusercontent.com/hanbeikai/my_pic_repository/master/image_repository/20201112230751.png)

##### 3.1 安装linux客户端

![image-20201112213811398](https://raw.githubusercontent.com/hanbeikai/my_pic_repository/master/image_repository/20201112230909.png)

在linux 中执行命令

```
curl -s https://install.zerotier.com | sudo bash
1
```

安装成功后执行下列命令加入[参考博客](https://blog.csdn.net/u010953692/article/details/78739509)

```sh
# 如果报错
# 使用浏览器下载https://install.zerotier.com/
# 文件重命名为zero,上传到linux
chmod 775 zero
./zero123456
12345
```

配置ZeroTIer One

```sh
# 查看帮助信息
zerotier-cli -h
# 查看版本信息
zerotier-cli -v
# 加入 network， NetworkID 对应的是创建network的时候的id 
zerotier-cli join  NetworkID
123456
```

CentOS 7.2 配置ZeroTier One

```sh
# 状态查看
zerotier-cli listnetworks
# 查看是否在线 以及 id 信息等  200 说明已经加入
zerotier-cli info
200 
# 重启服务
systemctl restart zerotier-one
1234567
```

##### 3.2 安装window客户端

点击windows图标，下载msi文件

![image-20201112222345383](https://raw.githubusercontent.com/hanbeikai/my_pic_repository/master/image_repository/20201112230938.png)

下载后右键执行

![image-20201112222303565](https://raw.githubusercontent.com/hanbeikai/my_pic_repository/master/image_repository/20201112231000.png)

一路下一步执行，完成后

![image-20201112222647865_副本](https://raw.githubusercontent.com/hanbeikai/my_pic_repository/master/image_repository/20201112234824.png)

join network

![image-20201112222711423](https://raw.githubusercontent.com/hanbeikai/my_pic_repository/master/image_repository/20201112231103.png)

输入创建network的时候生成的networkid

然后再管理页面审核通过后，查看详情

![image-20201112222822751_副本](https://raw.githubusercontent.com/hanbeikai/my_pic_repository/master/image_repository/20201112234720.png) ![image-20201112222848227_副本](https://raw.githubusercontent.com/hanbeikai/my_pic_repository/master/image_repository/20201112234618.png)

status 为 ok 的时候，说明加入成功

##### 3.3安装mac客户端

下载页面下载

![image-20201112222957517](https://raw.githubusercontent.com/hanbeikai/my_pic_repository/master/image_repository/20201112231027.png)

一路傻瓜式安装

![image-20201112225231213](https://raw.githubusercontent.com/hanbeikai/my_pic_repository/master/image_repository/20201112225231.png)

安装成功后后 join network

![image-20201112225305249_副本](https://raw.githubusercontent.com/hanbeikai/my_pic_repository/master/image_repository/20201112234501.png)

加入后，在管理页面审核通过，查看客户端状态

![image-20201112225430883](https://raw.githubusercontent.com/hanbeikai/my_pic_repository/master/image_repository/20201112225430.png)

### 4. ZeroTier 审核客户端

在客户端 join NetWorkId 后，进入管理页面。

![image-20201112211247135](https://raw.githubusercontent.com/hanbeikai/my_pic_repository/master/image_repository/20201112211310.png)

进入member 模块

![image-20201112220655721](https://raw.githubusercontent.com/hanbeikai/my_pic_repository/master/image_repository/20201112225532.png)

通过对auth的勾选来审核是否让客户端加入网络