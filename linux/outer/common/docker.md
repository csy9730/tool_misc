# docker

## install



```bash
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get update
sudo apt-get install     apt-transport-https     ca-certificates     curl     gnupg-agent     software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository    "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs)   stable"

sudo apt-get install docker-ce docker-ce-cli containerd.io


```



## 运行

``` bash
docker version
docker pull hello-world
docker images 
docker ps # 查看
sudo docker run hello-world

sudo systemctl start docker
sudo systemctl enable docker # 启动并加入开机启动

docker pull ubuntu:latest
docker run -it ubuntu bash
```
### run help
docker run 支持以下配置项 
-d: 意思为后台运行容器，并返回容器ID。
--name="nginx-lb": 为容器指定一个名称。
-v 绑定一个卷,主机的目录映射到容器的目录
-a stdin: 指定标准输入输出内容类型，可选 STDIN/STDOUT/STDERR 三项；
-t: 为容器重新分配一个伪输入终端，通常与 -i 同时使用；
-e username="ritchie": 设置环境变量；
-m :设置容器使用内存最大值；
--link=[]: 添加链接到另一个容器
-P 标记时，Docker 会随机映射一个 49000~49900 的端口到内部容器开放的网络端口
使用 docker ps 可以看到，本地主机的 49155 被映射到了容器的 5000 端口。此时访问本机的 49155 端口即可访问容器内 web 应用提供的界面。
-p（小写）则可以指定要映射的IP和端口，但是在一个指定端口上只可以绑定一个容器。支持的格式有 hostPort:containerPort、ip:hostPort:containerPort、 ip::containerPort。

使用 docker port 来查看当前映射的端口配置，也可以查看到绑定的地址


## misc



**Q**:  Cannot connect to the Docker daemon at unix:///var/run/docker.sock. Is the docke
r daemon running?        

**A**:  开启docker服务即可。

``` bash
systemctl daemon-reload
sudo service docker restart
sudo service docker status # (should see active (running))
```



``` bash
Get:1 file:/var/cuda-repo-10-1-local-10.1.105-418.39  InRelease
Ign:1 file:/var/cuda-repo-10-1-local-10.1.105-418.39  InRelease
Get:2 file:/var/cuda-repo-10-1-local-10.1.105-418.39  Release [574 B]
Get:2 file:/var/cuda-repo-10-1-local-10.1.105-418.39  Release [574 B]
Hit:4 http://mirrors.aliyun.com/ubuntu xenial InRelease
Hit:5 http://dl.google.com/linux/chrome/deb stable InRelease
Hit:6 http://mirrors.aliyun.com/ubuntu xenial-security InRelease
Hit:7 http://mirrors.aliyun.com/ubuntu xenial-updates InRelease
Hit:8 https://mirrors.tuna.tsinghua.edu.cn/ubuntu bionic InRelease
Get:10 http://mirrors.aliyun.com/ubuntu xenial-proposed InRelease [260 kB]
Get:11 https://mirrors.tuna.tsinghua.edu.cn/ubuntu bionic-updates InRelease [88.7 kB]
Get:12 https://mirrors.tuna.tsinghua.edu.cn/ubuntu bionic-backports InRelease [74.6 kB]
Hit:13 http://ppa.launchpad.net/plushuang-tw/uget-stable/ubuntu bionic InRelease
Hit:14 https://download.docker.com/linux/ubuntu bionic InRelease
Ign:15 http://ppa.launchpad.net/t-tujikawa/ppa/ubuntu bionic InRelease
Ign:16 https://download.docker.com/linux/ubuntu/dists bionic InRelease
Hit:17 http://mirrors.aliyun.com/ubuntu xenial-backports InRelease
Err:18 https://download.docker.com/linux/ubuntu/dists bionic Release
  404  Not Found [IP: 2600:9000:219a:8e00:3:db06:4200:93a1 443]
Get:9 http://ppa.launchpad.net/graphics-drivers/ppa/ubuntu bionic InRelease [21.3 kB]
Err:9 http://ppa.launchpad.net/graphics-drivers/ppa/ubuntu bionic InRelease
  The following signatures couldn't be verified because the public key is not available: NO_PUBKEY FCAE110B1118213C
Get:19 https://mirrors.tuna.tsinghua.edu.cn/ubuntu bionic-security InRelease [88.7 kB]
Get:20 https://mirrors.tuna.tsinghua.edu.cn/ubuntu bionic-proposed InRelease [242 kB]
Err:21 http://ppa.launchpad.net/t-tujikawa/ppa/ubuntu bionic Release
  404  Not Found [IP: 2001:67c:1560:8008::15 80]
Reading package lists... Done
W: Skipping acquire of configured file 'stablebionic/binary-amd64/Packages' as repository 'https://download.docker.com/linux/ubuntu bionic InRelease' doesn't have the component 'stablebionic' (component misspelt in sources.list?)
W: Skipping acquire of configured file 'stablebionic/i18n/Translation-en' as repository 'https://download.docker.com/linux/ubuntu bionic InRelease' doesn't have the component 'stablebionic' (component misspelt in sources.list?)
W: Skipping acquire of configured file 'stablebionic/i18n/Translation-en_US' as repository 'https://download.docker.com/linux/ubuntu bionic InRelease' doesn't have the component 'stablebionic' (component misspelt in sources.list?)
W: Skipping acquire of configured file 'stablebionic/dep11/Components-amd64.yml' as repository 'https://download.docker.com/linux/ubuntu bionic InRelease' doesn't have the component 'stablebionic' (component misspelt in sources.list?)
W: Skipping acquire of configured file 'stablebionic/dep11/icons-48x48.tar' as repository 'https://download.docker.com/linux/ubuntu bionic InRelease' doesn't have the component 'stablebionic' (component misspelt in sources.list?)
W: Skipping acquire of configured file 'stablebionic/dep11/icons-64x64.tar' as repository 'https://download.docker.com/linux/ubuntu bionic InRelease' doesn't have the component 'stablebionic' (component misspelt in sources.list?)
W: Skipping acquire of configured file 'stablebionic/cnf/Commands-amd64' as repository 'https://download.docker.com/linux/ubuntu bionic InRelease' doesn't have the component 'stablebionic' (component misspelt in sources.list?)
E: The repository 'https://download.docker.com/linux/ubuntu/dists bionic Release' does not have a Release file.
N: Updating from such a repository can't be done securely, and is therefore disabled by default.
N: See apt-secure(8) manpage for repository creation and user configuration details.
W: GPG error: http://ppa.launchpad.net/graphics-drivers/ppa/ubuntu bionic InRelease: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY FCAE110B1118213C
E: The repository 'http://ppa.launchpad.net/graphics-drivers/ppa/ubuntu bionic InRelease' is not signed.
N: Updating from such a repository can't be done securely, and is therefore disabled by default.
N: See apt-secure(8) manpage for repository creation and user configuration details.
E: The repository 'http://ppa.launchpad.net/t-tujikawa/ppa/ubuntu bionic Release' does not have a Release file.
N: Updating from such a repository can't be done securely, and is therefore disabled by default.
N: See apt-secure(8) manpage for repository creation and user configuration details.

```
