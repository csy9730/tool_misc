## undefined symbol: “PyUnicodeUCS4_FromEncodedObject“错误





技术标签： [Linux](https://codeleading.com/tag/Linux/)  [linux](https://codeleading.com/tag/linux/)  [python](https://codeleading.com/tag/python/)



最近编译代码需要python2.7，但是系统默认的是高版本，所以手动编译，python编译完成之后。

进行boot编译的时候出现**undefined symbol: "PyUnicodeUCS4_FromEncodedObject"****错误。**

找了很久在stackoverflow上面找到原因，是因为python默认的字符编码不对，编译的时候加上

**--enable-unicode=ucs4**选项就不会出现这个错误了。

 

stackoverflow原文链接：<https://stackoverflow.com/questions/8010384/pyunicodeucs4-fromencodedobject-error>

最后附上ubuntu编译python2.7.6的方法：

1. 官网下载源码包
2. 解压后进入源码目录
3. 执行 `./configure --enable-shared --prefix=/usr/local/python2.7.6 --enable-unicode=ucs4`
4. `make `
5. `sudo make install`
6. 编译完成之后修改默认python软链接：

```
(1) cd /usr/bin/


(2) sudo rm python

(3) sudo ln -s /usr/local/python2.7.6/bin/python2.7 python
```

7.到此python2.7安装完成，可以直接执行python查看当前版本:

![img](https://codeleading.com/imgrdrct/https://img-blog.csdnimg.cn/20210513183356835.png)

配置选项说明：--enable-shared生成共享库

​            --prefix=/usr/local/python2.7安装路径

​            --enable-unicode=ucs4设置字符编码为ucs4(没有这一项编译代码可能会出现**undefined symbol: PyUnicodeUCS4_FromEncodedObject**错误)

（中间可能会出现缺少依赖库的问题，根据提示安装相应的依赖库）