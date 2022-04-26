# wget 递归下载整个网站

[渡人即渡己](https://www.jianshu.com/u/1463f972c028)关注

2018.01.26 16:54:49字数 279阅读 6,474

有时间看到别人网站的页面比较漂亮，就想给扒皮下来，学习学习。分享一个我常用网站扒皮命令wget这个命令可以以递归的方式下载整站，并可以将下载的页面中的链接转换为本地链接。

wget加上参数之后，即可成为相当强大的下载工具。

```
wget -r -p -np -k http://xxx.com/xxx
```

- -r, --recursive（递归） specify recursive download.（指定递归下载）
- -L 递归时不进入其它主机
- -l, –level=NUMBER 最大递归深度 (inf 或 0 代表无穷).
- -m, –mirror 等价于 `-r -N -l inf -nr`.
- -nd 递归下载时不创建一层一层的目录，把所有的文件下载到当前目录
- -k, --convert-links（转换链接） make links in downloaded HTML point to local files.（将下载的HTML页面中的链接转换为相对链接即本地链接）
- -p, --page-requisites（页面必需元素） get all images, etc. needed to display HTML page.（下载所有的图片等页面显示所需的内容）
- -np, --no-parent（不追溯至父级） don't ascend to the parent directory.

- -E, –html-extension 将所有text/html文档以.html扩展名保存


另外断点续传用`-nc`参数 , 日志 用`-o`参数

拿我自己的网站扒皮试一下吧
执行 `wget -r -p -np -k https://wujunze.com/` 命令

## 转载来自：[ wget 递归下载整个网站(网站扒皮必备)](https%3A%2F%2Fwujunze.com%2Flinux_wget.jsp)

## runs

``` bash
# wget
wget -r -p -np -k  https://www.jianshu.com/p/f5ce2c6fca43 -U 'Mozilla/5.0 (X11; Linux x86_64; rv:30.0) Gecko/20100101 Firefox/30.0'

wget -r -p -np -k  https://zhuanlan.zhihu.com/p/380793959 -U 'Mozilla/5.0 (X11; Linux x86_64; rv:30.0) Gecko/20100101 Firefox/30.0'

wget -r -p -np -k --level=0 -E --ignore-length -x  -erobots=off  -N https://zhuanlan.zhihu.com/p/380793959 -U 'Mozilla/5.0 (X11; Linux x86_64; rv:30.0) Gecko/20100101 Firefox/30.0'
```


