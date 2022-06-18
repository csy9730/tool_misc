# [window和Linux下安装nvidia的apex](https://www.cnblogs.com/peixu/p/14614013.html)

两种方法：

1、去github下下载[apex ](https://github.com/NVIDIA/apex)，之后安装到你的python环境下，我的安装路径：E:\Anaconda\anaconda\envs\pytorch\Lib\site-packages

注：建议用git下载

```
1、git clone git@github.com:NVIDIA/apex.git
2、开cmd命令窗口，切换到apex所在的文件夹

3、python setup.py install
```

如果出现：ModuleNotFoundError错误，建议使用以下代码：

```
pip install --upgrade setuptools
```

2、需要你有anaconda环境，因为需要用到conda命令，我是通过这个方法安装好的。

```
conda install -c conda-forge nvidia-apex
```

 

分类: [python](https://www.cnblogs.com/peixu/category/1653306.html), [配置环境](https://www.cnblogs.com/peixu/category/1855586.html)