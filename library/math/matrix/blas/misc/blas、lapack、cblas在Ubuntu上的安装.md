# blas、lapack、cblas在Ubuntu上的安装

[horsetif](https://www.jianshu.com/u/62d1614f4ec8)关注

0.0732019.05.31 11:21:19字数 480阅读 10,198

这是整合借鉴几篇别人的文章，但是做了一点修改。（最初是谁的，忘记了）

### 1.确保机器上安装了gfortran编译器，如果没有安装的话，可以使用

``` bash
sudo apt-get install gfortran
```

### 2.下载blas, cblas, lapack 源代码

这些源码都可以在 [http://www.netlib.org](https://links.jianshu.com/go?to=http%3A%2F%2Fwww.netlib.org) 上找到，下载并解压。这里提供我安装时的下载链接 [http://www.netlib.org/blas/blas.tgz](https://links.jianshu.com/go?to=http%3A%2F%2Fwww.netlib.org%2Fblas%2Fblas.tgz)
[http://www.netlib.org/blas/blast-forum/cblas.tgz](https://links.jianshu.com/go?to=http%3A%2F%2Fwww.netlib.org%2Fblas%2Fblast-forum%2Fcblas.tgz)
[http://www.netlib.org/lapack/lapack-3.4.2.tgz](https://links.jianshu.com/go?to=http%3A%2F%2Fwww.netlib.org%2Flapack%2Flapack-3.4.2.tgz)
解压之后会有三个文件夹,BLAS, CBLAS, lapack-3.4.2

### 3.这里就是具体的编译步骤（一定要按照顺序）

```bash
tar xvf blas.tgz  #解压三个文件
```

##### 1）编译blas

进入BLAS文件夹，执行以下几条命令

```bash
gfortran -c  -O3 *.f  # 编译所有的 .f 文件，生成 .o文件
ar rv libblas.a *.o  # 链接所有的 .o文件，生成 .a 文件
su cp libblas.a /usr/local/lib  # 将库文件复制到系统库目录
##################################################################
#如果上面代码有问题，可以试试下面的编译方法
gfortran -c  -O3  -fPIC  *.f # 编译所有的 .f 文件，生成 .o文件   加上了-fPIC
gcc -shared *.o -fPIC -o  libblas.so
cp libblas.so /usr/local/lib/
ar rv libblas.a *.o  # 链接所有的 .o文件，生成 .a 文件  
su cp libblas.a /usr/local/lib  # 将库文件复制到系统库目录
```

#### 2）编译cblas

进入CBLAS文件夹，首先根据你自己的计算机平台，将目录下某个 Makefile.XXX 复制为 Makefile.in , XXX表示计算机的平台，如果是Linux，那么就将Makefile.LINUX 复制为 Makefile.in，然后执行以下命令

```bash
cp ../BLAS/libblas.a  testing  # 将上一步编译成功的 libblas.a 复制到 CBLAS目录下的testing子目录
make # 编译所有的目录
sudo cp lib/cblas_LINUX.a /usr/local/lib/libcblas.a # 将库文件复制到系统库目录下
```

问题：

```python
File "./lapack_testing.py",line 17
         **except getopt.error, msg:
                            ^**
syntaxError:invalid syntax
Make:***[lapack_testing] Error 1
#注意，这里可能有`一个关于python的保存，主要原因是我们现在使用的是python3，
#但是编译使用的是python2，我们需要把这个文件第一行修改为在python2环境下执行。
#第一行最后加一个2就可以。
```

#### 3）编译 lapack以及lapacke

这一步比较麻烦，首先当然是进入lapack-3.4.2文件夹，然后根据平台的特点，将INSTALL目录下对应的make.inc.XXX 复制一份到 lapack-3.4.2目录下，并命名为make.inc, 这里我复制的是 INSTALL/make.inc.gfortran，因为我这里用的是gfortran编译器。

修改lapack-3.4.2/Makefile, 因为lapack以来于blas库，所以需要做如下修改

```bash
#修改～！
#lib: lapacklib tmglib
lib: blaslib variants lapacklig tmglib
```

修改make.inc 文件

```ruby
BLASLIB  = /usr/local/lib/libblas.a
CBLASLIB = /usr/local/lib/libcblas.a
LAPACKLIB = liblapack.a
TMGLIB = libtmglib.a
LAPACKELIB = liblapacke.a
```

主要是设定好对应的blas和cblas目标文件的链接路径（在系统库目录下的）。接下来运行代码：

```bash
make # 编译所有的lapack文件
cd lapacke # 进入lapacke 文件夹，这个文件夹包含lapack的C语言接口文件
make # 编译lapacke
cp include/*.h /usr/local/include #将lapacke的头文件复制到系统头文件目录
cd .. #返回到 lapack-3.4.2 目录
cp *.a /usr/local/lib # 将生成的所有库文件复制到系统库目录
```

这里的头文件包括： lapacke.h, lapacke_config.h, lapacke_mangling.h, lapacke_mangling_with_flags.h lapacke_utils.h

生成的库文件包括：liblapack.a, liblapacke.a, librefblas.a, libtmglib.a

至此cblas和lapack就成功安装到你的电脑上了。