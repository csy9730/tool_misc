# python安装

[TOC]

linux下软件安装方法分为make install和

注意：linux系统内置了python程序，并且很多其他程序依赖着个python(apt-get和yum依赖python2)，所以这个内置python很重要，不能随便卸载，可能版本不能满足我们使用需求，这种情况下要安装多个python。

## 安装依赖

``` bash

sudo apt install build-essential python-dev python-setuptools

# 对于Python3：
sudo apt install build-essential python3-dev  python3-setuptools
```
### 安装openssl

pip3依赖openssl和devel，需要先安装openssl

####  包管理安装openssl

以下是包管理安装方法：

```bash
# centos：
yum install openssl-devel
# ubuntu：
sudo apt-get install openssl
sudo apt-get install libssl-dev
```

#### 编译安装openssl

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

python相关路径：
``` bash
# 执行路径
/usr/bin/python2.7 
/usr/bin/python 
/usr/bin/python3.6 
/usr/bin/python3.6m 
/usr/bin/python2.7-config 

# lib路径和include路径和其他路径
/usr/lib/python2.7 /usr/lib/python3.6 
/usr/lib64/python2.7 /usr/lib64/python3.6 
/usr/include/python2.7 /usr/include/python3.6m 
/usr/local/lib/python3.6 
/usr/share/man/man1/python.1.gz 
/etc/python

```

conda 的路径
```
/root/miniconda3/bin/python /root/miniconda3/bin/python3.7m /root/miniconda3/bin/python3.7 
/root/miniconda3/bin/python3.7-config /root/miniconda3/bin/python3.7m-config /usr/share/man/man1/python.1.gz

/usr/bin/conda -> /root/miniconda3/bin/conda
/root/miniconda3/condabin/conda ( conda.cli::main)

```

``` 
/usr/bin/pip == /usr/bin/pip2.7
/usr/bin/pip2.7
/usr/bin/pip3
/usr/bin/pip-3 -> ./pip-3.6
/usr/bin/pip-3.6 -> ./pip3.6
/usr/bin/pip3.6 == /usr/bin/pip3

/root/miniconda3/bin/pip

```


###  包管理安装

包管理文件安装

``` bash

# 包管理安装pip
sudo apt-get install python-pip
sudo apt install python3-pip

# get-pip
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py   # 下载安装脚本
sudo python get-pip.py    # 运行安装脚本


pip --version 
pip3 --version
sudo pip3 install virtualenv
```
注意： pip安装的包在 `/usr/lib/python2.7/site-packages`  路径下。
也有的安装在`/usr/lib/python2.7/dist-packages`路径下。


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

