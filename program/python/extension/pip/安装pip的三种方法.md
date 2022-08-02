# 安装pip的三种方法

[凤非飞](https://www.jianshu.com/u/a46b932d0675)关注

0.6012018.10.19 14:09:12字数 478阅读 89,658

### 1.get-pip.py安装

(官方)[https://pip.pypa.io/en/stable/installing/#installing-with-get-pip-py](https://pip.pypa.io/en/stable/installing/#installing-with-get-pip-py)

```bash
wget https://bootstrap.pypa.io/get-pip.py

sudo python get-pip.py    # 运行安装脚本

wget https://bootstrap.pypa.io/pip/3.6/get-pip.py # pip 对应的是 Python 3.6

wget https://bootstrap.pypa.io/pip/2.7/get-pip.py # pip 对应的是 Python 2.7
``` 

注意：用哪个版本的 Python 运行安装脚本，pip 就被关联到哪个版本，如果是 Python3 则执行以下命令：

```bash
sudo python3 get-pip.py    # 运行安装脚本。
```

一般情况 pip 对应的是 Python 2.7，pip3 对应的是 Python 3.x
如果显示

```
root@66b6f8945ca1:/# python get-pip.py
Looking in indexes: https://pypi.tuna.tsinghua.edu.cn/simple
Collecting pip
  Downloading https://pypi.tuna.tsinghua.edu.cn/packages/c2/d7/90f34cb0d83a6c5631cf71dfe64cc1054598c843a92b400e55675cc2ac37/pip-18.1-p
y2.py3-none-any.whl (1.3MB)
    100% |████████████████████████████████| 1.3MB 1.8MB/s
Installing collected packages: pip
  Found existing installation: pip 18.1
    Uninstalling pip-18.1:
      Successfully uninstalled pip-18.1
Successfully installed pip-18.1
```



### 2.debian系列安装

``` bash
apt-get install -y pip       # (python2.x就去安装pip2)
apt-get install -y pip-python3    #   (python3.x就去安装pip3)
```


### 3.RHEL系列

```bash
 wget --no-check-certificate https://github.com/pypa/pip/archive/9.0.1.tar.gz
 tar -zvxf 9.0.1.tar.gz -C pip-9.0.1    # 解压文件
 cd pip-9.0.1
 python3 setup.py install
 pip install --upgrade pip       #升级pip(可选)
```


也就是说1.3方法都是二进制（源代码），但是我都去装了，都显示正确的信息，如1。但是无论是pip,还是pip3，还是pip -V,或者pip3 -V。都没反应，如同没装。不知道为何，记录一下，以后再试
为什么想要去用二进制装呢，因为我在制作docker的images，而`apt install`，需要先`apt update`，这样images会立刻增加200M。所以为了缩减，就想用二进制装一些必要的
现在有一个想法，是否需要建立软连接（ln s ），就如同二进制安装python时需要建立软连接。(20181019)


找到原因了，需要添加到环境里，第一种我有试了下，和之前返回成功信息一样，但这次信息里多了一些（我把默认改为python3.x）

```
root@853e19c0f418:/# python -V
Python 3.7.1rc2
root@853e19c0f418:/# python3 -V
Python 3.7.1rc2

root@3547dc8d3d33:/# python get-pip.py
Looking in indexes: https://pypi.tuna.tsinghua.edu.cn/simple
Collecting pip
  Downloading https://pypi.tuna.tsinghua.edu.cn/packages/c2/d7/90f34cb0d83a6c5631cf71dfe64cc1054598c843a92b400e55675cc2ac37/pip-18.1-py2.py3-none-any.whl (1.3MB)
    100% |████████████████████████████████| 1.3MB 1.9MB/s
Collecting wheel
  Downloading https://pypi.tuna.tsinghua.edu.cn/packages/fc/e9/05316a1eec70c2bfc1c823a259546475bd7636ba6d27ec80575da523bc34/wheel-0.32.1-py2.py3-none-any.whl
Installing collected packages: pip, wheel
  Found existing installation: pip 10.0.1
    Uninstalling pip-10.0.1:
      Successfully uninstalled pip-10.0.1
  The script wheel is installed in '/usr/python/bin' which is not on PATH.
  Consider adding this directory to PATH or, if you prefer to suppress this warning, use --no-warn-script-location.
Successfully installed pip-18.1 wheel-0.32.1
root@3547dc8d3d33:/# pip
bash: pip: command not found
root@3547dc8d3d33:/# pip3
bash: pip3: command not found
root@3547dc8d3d33:/# pip list
bash: pip: command not found
```

显示成功但还是没反应，但是多了一条警告，说是

```
The script wheel is installed in '/usr/python/bin' which is not on PATH.
  Consider adding this directory to PATH or, if you prefer to suppress this warning, use --no-warn-script-location.
```

说是没有添加到path环境里，只是在 '/usr/python/bin'，所以你在非其安装路径下是不可以执行pip相关命令
你如果去其安装路径执行pip命令，就可以了

```
root@3547dc8d3d33:/usr/python/bin# ls
2to3  2to3-3.7  easy_install-3.7  idle3  idle3.7  pip  pip3  pip3.7  pydoc3  pydoc3.7  python3  python3-config  python3.7  python3.7-config  python3.7m  python3.7m-config  pyvenv  pyvenv-3.7  wheel
root@3547dc8d3d33:/usr/python/bin# ./pip
Usage:
  pip <command> [options]

Commands:
  install                     Install packages.
  download                    Download packages.
  uninstall                   Uninstall packages.
  freeze                      Output installed packages in requirements format.
  list                        List installed packages.
  show                        Show information about installed packages.
  check                       Verify installed packages have compatible dependencies.
  config                      Manage local and global configuration.
  search                      Search PyPI for packages.
  wheel                       Build wheels from your requirements.
  hash                        Compute hashes of package archives.
  completion                  A helper command used for command completion.
  help                        Show help for commands.

```

所以你只需要把其安装路径添加到path环境里，就可以全局调用(前两句（加入，生效）)

```
root@3547dc8d3d33:/# echo 'export PATH=/usr/python/bin:$PATH' >>~/.bashrc
root@3547dc8d3d33:/# source ~/.bashrc
root@3547dc8d3d33:/# cd /
root@853e19c0f418:/# pip
Usage:
  pip <command> [options]

Commands:
  install                     Install packages.
  download                    Download packages.
  uninstall                   Uninstall packages.
  freeze                      Output installed packages in requirements format.
  list                        List installed packages.
  show                        Show information about installed packages.
  check                       Verify installed packages have compatible dependencies.
  config                      Manage local and global configuration.
  search                      Search PyPI for packages.
  wheel                       Build wheels from your requirements.
  hash                        Compute hashes of package archives.
  completion                  A helper command used for command completion.
  help                        Show help for commands.
..............
root@853e19c0f418:/# pip3
Usage:
  pip <command> [options]

Commands:
  install                     Install packages.
  download                    Download packages.
  uninstall                   Uninstall packages.

root@853e19c0f418:/# pip -V
pip 18.1 from /usr/python/lib/python3.7/site-packages/pip (python 3.7)
root@853e19c0f418:/# pip3 -V
pip 18.1 from /usr/python/lib/python3.7/site-packages/pip (python 3.7)
```

pip和pip3都可以
所以第三种安装方法也应该需要这样才可以使用。（20181021）