## Opencv中如何保存Mat矩阵

​      最近在学机器学习，用opencv的时候对于如何保存Mat矩阵纠结死了，查了N久的网页终于给找到了！！

 

在OpenCV2.0以后的版本中，加入了对C++的支持，大大减少了程序代码量，方便了程序编写，也更符合现代编程思想。



在视觉处理过程中，往往需要保存中间数据。这些数据的数据类型往往并不是整数。

OpenCV的C++接口中，用于保存图像的imwrite只能保存整数数据，且需作为图像格式。当需要保存浮点数据或XML/YML文件时，OpenCV的C语言接口提供了cvSave函数，但这一函数在C++接口中已经被删除。取而代之的是FileStorage类。



具体使用方法参照这个例子：

矩阵存储

1. Mat mat = Mat::eye(Size(12,12), CV_8UC1);
2. FileStorage fs(".\\vocabulary.xml", FileStorage::WRITE);
3. fs<<"vocabulary"<<mat;
4. fs.release();

在另一处，需要加载这个矩阵数据。代码如下：

1. FileStorage fs(".\\vocabulary.xml", FileStorage::READ);
2. Mat mat_vocabulary;
3. fs["vocabulary"] >> mat_vocabulary;

在存储数据时，fs<<"vocabulary"<<mat将mat矩阵保存在了声明fs对象时制定的xml文件的vocabulary标签下，也可换成其它标签。可以多个<<符号连续使用，程序将自动将引号内容理解为标签名，不带引号的理解为数据变量或者常量。

在读取数据时，[ ]中的内容为指定的标签，并将数据读入>>的变量中。

参考链接<http://blog.csdn.net/mmjwung/article/details/6913540>