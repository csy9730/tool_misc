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

