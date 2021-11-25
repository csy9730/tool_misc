# 【小记】BLAS、OpenBLAS、ATLAS、MKL

分类专栏： [深度学习](https://blog.csdn.net/qq_31347869/category_9072615.html) [# 芝士就是力量](https://blog.csdn.net/qq_31347869/category_9072650.html)

# BLAS

BLAS的全称是Basic Linear Algebra Subprograms，中文可以叫做基础线性代数子程序。它定义了一组应用程序接口（API）标准，是一系列初级操作的规范，如向量之间的乘法、矩阵之间的乘法等。许多数值计算软件库都实现了这一核心。

BALS是用Fortran语言开发的，Netlib实现了BLAS的这些API接口，得到的库也叫做BLAS。Netlib只是一般性地实现了基本功能，并没有对运算做过多的优化。

# LAPACK

LAPACK （linear algebra package），是著名的线性代数库，也是Netlib用fortran语言编写的。其底层是BLAS，在此基础上定义了很多矩阵和向量高级运算的函数，如矩阵分解、求逆和求奇异值等。该库的运行效率比BLAS库高。
从某个角度讲，LAPACK也可以称作是一组科学计算（矩阵运算）的接口规范。Netlib实现了这一组规范的功能，得到的这个库叫做LAPACK库。

Linear Algebra Package，线性代数包，底层使用BLAS，使用Fortran语言编写。在BLAS的基础上定义很多矩阵和向量高级运算的函数，如矩阵分解、求逆和求奇异值等。该库的运行效率比BLAS库高。为了进行C语言的开发，开发了CBLAS和CLAPACK。

# CBALS & CLAPACK

前面BLAS和LAPACK的实现均是用的Fortran语言。为了方便c程序的调用，Netlib开发了CBLAS和CLAPACK。其本质是在BLAS和LAPACK的基础上，增加了c的调用方式。

# ATLAS

上面提到，可以将BLAS和LAPACK看做是接口规范，那么其他的组织、个人和公司，就可以根据此规范，实现自己的科学计算库。

开源社区实现的科学计算（矩阵计算）库中，比较著名的两个就是atlas和openblas。它们都实现了BLAS的全部功能，以及LAPACK的部分功能，并且他们都对计算过程进行了优化。

Atlas （Automatically Tuned Linear Algebra Software）能根据硬件，在运行时，自动调整运行参数。

Automatically Tuned Linear Algebra Software，自动化调节线性代数软件。可以根据硬件，在运行时，自动调整运行参数。

# OpenBLAS

Openblas在编译时根据目标硬件进行优化，生成运行效率很高的程序或者库。Openblas的优化是在编译时进行的，所以其运行效率一般比atlas要高。但这也决定了openblas对硬件依赖性高，换了机器，可能就要重新编译了。（例如A和B两台机器cpu架构、指令集不一样，操作系统一样，在A下编译的openblas库，在B下无法运行，会出现“非法指令”这样的错误）

# Intel MKL

英特尔数学核心函数库，Intel Math Kernel Library

Intel的MKL和AMD的ACML都是在BLAS的基础上，针对自己特定的CPU平台进行针对性的优化加速。以及NVIDIA针对GPU开发的cuBLAS。

商业公司对BLAS和LAPACK的实现，有Intel的MKL和AMD的ACML。他们对自己的cpu架构，进行了相关计算过程的优化，实现算法效率也很高。
NVIDIA针对其GPU，也推出了cuBLAS，用以在GPU上做矩阵运行。

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190612000430391.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzMxMzQ3ODY5,size_16,color_FFFFFF,t_70)



  