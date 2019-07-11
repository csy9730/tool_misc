
apt install yum

#Ubuntu终端出现Unable to lock the administration directory (/var/lib/dpkg/)
ps -ef | grep apt-get命令找到相关进程 然后使用Kill -9 进程号

sudo rm -rf /var/lib/dpkg/lock
sudo rm -rf /var/cache/apt/archives/lock
sudo apt-get update
sudo dpkg --configure -a

sudo apt-get purge nvidia-common
sudo apt-get install nvidia-common


#python安装
wget https://www.python.org/ftp/python/3.6.2/Python-3.6.2.tar.xz
tar xf Python-3.6.2.tar.xz
cd Python-3.6.2
./configure && make && sudo make install

#python 相关
sudo apt-get install python-pip
#sudo pip3 install

pip --version 
pip3 --version
sudo pip3 install virtualenv

#anaconda安装
https://repo.continuum.io/archive/Anaconda3-4.4.0-Linux-x86_64.sh

apt-get，yum依赖python2，pip3依赖openssl和devel
https://www.openssl.org/source/openssl-1.0.2l.tar.gz

centos：
yum install openssl-devel
ubuntu：
sudo apt-get install openssl
sudo apt-get install libssl-dev

1.安装openssl
wget https://www.openssl.org/source/openssl-1.0.2h.tar.gz
2.解压
tar zxf openssl-1.0.2h.tar.gz
3.安装
cd openssl-1.0.2h
./config shared zlib
#提醒需要在build之前做make depend
make depend
4.
make
make install 
　mv /usr/bin/openssl /usr/bin/openssl.bak 
　mv /usr/include/openssl /usr/include/openssl.bak 
　ln -s /usr/local/ssl/bin/openssl /usr/bin/openssl 
　ln -s /usr/local/ssl/include/openssl /usr/include/openssl 
　echo “/usr/local/ssl/lib” >> /etc/ld.so.conf 
　ldconfig -v
4.检测安装是否成功
openssl version -a

dpkg -L python-dev | grep Python.h

