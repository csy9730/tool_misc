# [opencv-访问Mat中每个像素的值](https://www.cnblogs.com/Tang-tangt/p/9392945.html) 

参考：[【OpenCV】访问Mat中每个像素的值（新）](https://blog.csdn.net/xiaowei_cqu/article/details/19839019)   膜拜大佬

 

以下例子代码均针对8位单通道灰度图。

 

**1 .ptr和[]操作符**

 Mat最直接的访问方法是通过.ptr<>函数得到**一行的指针**，并用[]操作符访问某一列的像素值。

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
Mat image(rows,cols,CV_8UC1);
    for (int j=0; j<image.rows; j++) 
    {
        uchar* pdata= image.ptr<uchar>(j);
        for (int i=0; i<image.cols; i++) 
        {
            uchar data=pdata[i];
        }                 
    }
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

 

**2 .ptr和指针操作**

除了[]操作符，我们可以使用移动指针*++的组合方法访问某一行中所有像素的值。

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
Mat image(rows,cols,CV_8UC1);
    for (int j=0; j<image.rows; j++) 
    {
        uchar* pdata= image.ptr<uchar>(j);
        for (int i=0; i<image.cols; i++) 
        {
            uchar data=*pdata++;
        }                 
    }
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

 

**3 Mat _iterator**

用Mat提供的迭代器代替前面的[]操作符或指针，血统纯正的官方方法~

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
1     Mat image(rows,cols,CV_8UC1);
2 
3     Mat_<uchar>::iterator it=image.begin<uchar>();
4     Mat_<uchar>::iterator itend=image.end<uchar>();
5 
6     for (;it != itend;++it)
7     {
8         uchar data=*it;
9     }
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

 

**4 图像坐标 at**

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
    Mat image(rows,cols,CV_8UC1);

    for (int j=0; j<image.rows; j++) 
    {
        for (int i=0; i<image.cols; i++) 
        {
            uchar data=image.at<uchar>(j,i);
        }                 
    }
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

 

 

其中，指针*++访问是最快的方法；另外迭代器访问虽然安全，但性能远低于指针运算；通过图像坐标(j,i)访问是最慢的。

 



分类: [opencv](https://www.cnblogs.com/Tang-tangt/category/1266206.html)

标签: [opencv](https://www.cnblogs.com/Tang-tangt/tag/opencv/), [C++](https://www.cnblogs.com/Tang-tangt/tag/C%2B%2B/), [Mat](https://www.cnblogs.com/Tang-tangt/tag/Mat/)