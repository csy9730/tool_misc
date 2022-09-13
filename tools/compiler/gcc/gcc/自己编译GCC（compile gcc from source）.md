# [自己编译GCC（compile gcc from source）](https://www.cnblogs.com/windtail/p/8317285.html)



有的时候，我不是第一次遇到这种时候，编译内核时报出编译器BUG。如果是ubuntu还好一点，默认软件仓库中就有好几个GCC，换一换总能找到一个好使的，实在不行还有个Tooltrain的ppa，但Debian却没什么选择，可能可以去testing里或unstable里找找，不过这些都不够灵活，让我们直接编译GCC吧！

听起来很高大上的东西，实则很简单了，参考如下两篇文章即可

- <https://gcc.gnu.org/wiki/InstallingGCC>
- <https://solarianprogrammer.com/2016/10/07/building-gcc-ubuntu-linux/>

第一篇文章是官方文档，多看看。

## 安装需要的库

``` bash
sudo apt install libgmp-dev libmpfr-dev libmpc-dev
```

## 下载GCC

 到[官方镜像](http://gcc.gnu.org/mirrors.html)页找个离着近点的镜像（比如日本），下载release中的版本，比如 http://ftp.tsukuba.wide.ad.jp/software/gcc/releases/gcc-6.4.0/gcc-6.4.0.tar.xz

## 编译和安装


``` bash
tar xf gcc-6.4.0.tar.xz
mkdir gcc-build
cd gcc-build
../gcc-6.4.0/configure --prefix=/usr/local/gcc-6.4.0 --enable-checking=release --enable-languages=c,c++ --disable-multilib --program-suffix=-6.4
make -j8
sudo make install
```

## 安装alternative

上面我们编译完的gcc路径是 /usr/local/gcc-4.6.0/bin/gcc-4.6，我希望使用的时候直接替换系统的cc，但又要便于我来回切换，update-alternatives 已经有这样的功能了，下面我们就来安装alternative

``` bash
sudo update-alternativess --install /usr/bin/cc cc /usr/local/gcc-4.6.0/bin/gcc-4.6 30
sudo update-alternativess --install /usr/bin/c++ c++ /usr/local/gcc-4.6.0/bin/g++-4.6 30
```

 最后一个参数是优先级，优先级最高的会被默认选中，还可以手动选择使用哪个alternative，选择的方法是

``` bash
sudo update-alternativess --config cc
```

 

把cc换成c++，就可以选择c++了

 

\------------------------------------------------------------
本文由WindTaiL在cnblogs中发布，转载请注明出处



分类: [Linux](https://www.cnblogs.com/windtail/category/401718.html), [嵌入式](https://www.cnblogs.com/windtail/category/401721.html)

标签: [linux](https://www.cnblogs.com/windtail/tag/linux/), [gcc](https://www.cnblogs.com/windtail/tag/gcc/), [cc](https://www.cnblogs.com/windtail/tag/cc/)