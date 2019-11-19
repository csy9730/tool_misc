# python安装

[TOC]

linux下软件安装方法分为make install和

注意：linux系统内置了python程序，并且很多其他程序依赖着个python(apt-get和yum依赖python2)，所以这个内置python很重要，不能随便卸载，可能版本不能满足我们使用需求，这种情况下要安装多个python。

## 安装openssl

pip3依赖openssl和devel，需要先安装openssl

###  包管理安装

以下是包管理安装方法：

```bash
# centos：
yum install openssl-devel
# ubuntu：
sudo apt-get install openssl
sudo apt-get install libssl-dev
```



1. 下载和解压openssl 
2. 编译openssl
3. 配置环境

```bash
wget https://www.openssl.org/source/openssl-1.0.2h.tar.gz
tar zxf openssl-1.0.2h.tar.gz

cd openssl-1.0.2h
./config shared zlib
# 需要在build之前做make depend
make depend
make
make install 
mv /usr/bin/openssl /usr/bin/openssl.bak 
mv /usr/include/openssl /usr/include/openssl.bak 
ln -s /usr/local/ssl/bin/openssl /usr/bin/openssl 
ln -s /usr/local/ssl/include/openssl /usr/include/openssl 
echo “/usr/local/ssl/lib” >> /etc/ld.so.conf ldconfig -v

openssl version -a # 检测安装是否成功
```



## python安装

主要分为包管理文件安装和源码安装

###  包管理安装

包管理文件安装

``` bash
#python 相关
sudo apt-get install python-pip
#sudo pip3 install

pip --version 
pip3 --version
sudo pip3 install virtualenv
```

### 源码安装

源码安装

``` bash
wget https://www.python.org/ftp/python/3.6.2/Python-3.6.2.tar.xz
tar xf Python-3.6.2.tar.xz
cd Python-3.6.2
./configure && make && sudo make install
```



## anaconda安装

`https://repo.continuum.io/archive/Anaconda3-4.4.0-Linux-x86_64.sh`

