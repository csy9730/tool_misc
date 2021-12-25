## [linux 缺少动态连接库.so--cannot open shared object file: No such file or directory](https://www.cnblogs.com/youxin/p/5116243.html)

2016-01-09 13:40  [youxin](https://www.cnblogs.com/youxin/)  阅读(37291)  评论(0)  [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=5116243)  [收藏](javascript:void(0))  [举报](javascript:void(0))

error while loading shared libraries的解決方法
 
 执行行程式時，如此遇到像下列這種錯誤： 

./tests: error while loading shared libraries: xxx.so.0:cannot open shared object file: No such file or directory


那就表示系統不知道xxx.so 放在哪個目錄下。

這個時候就要在/etc/ld.so.conf中加入xxx.so所在的目錄。

 一般而言，有很多so檔會在/usr/local/lib這個目錄下，所以在/etc/ld.so.conf中加入/usr/local/lib這一行，可以解決此問題。

 或者加入一行xx.so所在的绝对路径，如/usr/local/log4cxx/lib/ 也行。

將 /etc/ld.so.conf存檔後，還要執行`/sbin/ldconfig –v`來更新一下才會生效。

 

如果共享库文件安装到了其它"非/lib或/usr/lib" 目录下,  但是又不想在/etc/ld.so.conf中加路径(或者是没有权限加路径). 那可以export一个全局变量`LD_LIBRARY_PATH`, 然后运行程序的时候就会去这个目录中找共享库.

​     `LD_LIBRARY_PATH`的意思是告诉loader在哪些目录中可以找到共享库. 可以设置多个搜索目录, 这些目录之间用冒号分隔开. 比如安装了一个mysql到/usr/local/mysql目录下, 其中有一大堆库文件在/usr/local/mysql/lib下面, 则可以在.bashrc或.bash_profile或shell里加入以下语句即可:

`export LD_LIBRARY_PATH=/usr/local/mysql/lib:$LD_LIBRARY_PATH`

一般来讲这只是一种临时的解决方案, 在没有权限或临时需要的时候使用.

总结：

总结下来主要有3种方法：

1. 用ln将需要的so文件链接到/usr/lib或者/lib这两个默认的目录下边

```
ln -s /where/you/install/lib/*.so /usr/lib
sudo ldconfig
```



2. 修改LD_LIBRARY_PATH

 ```bash
export LD_LIBRARY_PATH=/where/you/install/lib:$LD_LIBRARY_PATH
sudo ldconfig
 ```

3. 修改/etc/ld.so.conf，然后刷新ldconfig

`vim /etc/ld.so.conf`

添加安装库的路径

`sudo ldconfig`

 