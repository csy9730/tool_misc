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
sudo docker pull helloworld
sudo docker run hello-world

sudo systemctl start docker
sudo systemctl enable docker # 启动并加入开机启动
```



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
