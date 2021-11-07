# [postman---post请求数据类型](https://www.cnblogs.com/qican/p/11496820.html)

　　我们都知道接口post方法中有不同的请求类型，再写postman中发送请求的时候只是简单的写了一种，今天我们重新了解下Postman如何发送post的其他数据类型

## Postman中post的数据类型

post中有以下数据类型

1、form-data

2、x-www-form-urlencoded

3、raw

4、binary

![img](https://img2018.cnblogs.com/blog/1171635/201909/1171635-20190910163907275-1632395192.png)

 

## Postman请求不同的post数据类型 

### from-data

multipart/form-data，它将表单的数据组织成Key-Value形式，也可以上传文件，当上传的字段是文件时，会有 content-type 来说明文件类型；content-disposition，用来说明字段的一些信息；由于有 boundary 隔离，所以 multipart/form-data 既可以上传文件，也可以上传键值对，它采用了键值对的方式，所以可以上传多个文件。

正常数据

输入post请求地址，选择form-data请求类型，输入对应参数，点击Send发送请求

![img](https://img2018.cnblogs.com/blog/1171635/201909/1171635-20190910153229203-2029985315.png)

**form-data上传文件**

**选择File格式**

 **![img](https://img2018.cnblogs.com/blog/1171635/201909/1171635-20190910162845000-779646834.png)**

 **点击上传文件，发送请求**

这里我选择了上传二进制文件，其他的都是一样的内容

![img](https://img2018.cnblogs.com/blog/1171635/201909/1171635-20190910163347708-690576637.png)

 

### x-www-form-urlencoded

application/x-www-from-urlencoded，将表单内的数据转换为Key-Value

![img](https://img2018.cnblogs.com/blog/1171635/201909/1171635-20190910153724032-612123172.png)

 可以通过返回内容看出来，我们需要请求的数据类型是否正确

![img](https://img2018.cnblogs.com/blog/1171635/201909/1171635-20190910153813521-489825934.png)

###  raw

可以通过raw进行传输txt，json xml，html的数据

**xml方法**

**![img](https://img2018.cnblogs.com/blog/1171635/201909/1171635-20190910154033236-672354837.png)**

查看返回内容

![img](https://img2018.cnblogs.com/blog/1171635/201909/1171635-20190910154057842-428377099.png)

**json数据**

![img](https://img2018.cnblogs.com/blog/1171635/201909/1171635-20190910154319615-29984667.png)

 

 我们通过请求后，继续查看返回后的内容，发现现实的数据类型也是json的

![img](https://img2018.cnblogs.com/blog/1171635/201909/1171635-20190910154401815-1725703887.png)

 

###  binary

表示只可以上传二进制数据，用来上传文件，一次只能上传1个数据

给大家举个小栗子，桌面创建二进制文件，保存在桌面，后缀名为.bin格式

![img](https://img2018.cnblogs.com/blog/1171635/201909/1171635-20190910160024135-827330566.png)

 

 上传创建好的二进制文件，查看返回内容

 ![img](https://img2018.cnblogs.com/blog/1171635/201909/1171635-20190910155915048-1427204419.png)

 

 

### 其中肯定会有人问，form-data和x-www-form-urlencoded有什么区别呢？

form-data：既可以上传文件等二进制数据，也可以上传表单键值对。

x-www-form-urlencoded：只能上传键值对，不能用于文件上传。

 

不同的接口参数不同，请求方式也可能不同。学习的是如何请求的方法，方法学会了，剩下的就是多次灵活运用了。俗话说，孰能生巧！用的多了，就会了。 

 

 

**感觉写的对您有帮助的话，右下角点个关注呗，点个关注，不迷路~~~~**

 

等包的过程中写的文章，有哪里不对的地方下方留言，看到后及时修改。**祝大家中秋节快乐~~** 

###  

 



分类: [postman](https://www.cnblogs.com/qican/category/1540442.html)