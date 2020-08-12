# 换行符自动转换

不少开发者可能遇到过这个问题：从git上拉取服务端代码，然后只修改了一处地方，准备提交时，用diff软件查看，却发现整个文件都被修改了。这是git自动转换换行符导致的问题。

原因
不同操作系统使用的换行符是不一样的。Unix/Linux使用的是LF，Mac后期也采用了LF，但Windows一直使用CRLF【回车(CR, ASCII 13, \r) 换行(LF, ASCII 10, \n)】作为换行符。而git入库的代码采用的是LF格式，它考虑到了跨平台协作的场景，提供了“换行符自动转换”的功能：如果在Windows下安装git，在拉取文件时，会自动将LF换行符替换为CRLF；在提交时，又会将CRLF转回LF。但是这个转换是有问题的：有时提交时，CRLF转回LF可能会不工作，尤其是文件中出现中文字符后有换行符时。


解决方案
1.禁用git的自动换行功能：
在本地路径C:\Users\[用户名]\.gitconfig下修改git配置[core]，如果没有就直接添加上去：
``` ini
[core]
autocrlf = false
filemode = false
safecrlf = true
```
git bash命令行也可以修改，最终也是修改.gitconfig配置文件：
分别执行：
``` bash
git config --global core.autocrlf false 
git config --global core.filemode false 
git config --global core.safecrlf true


git config --get core.autocrlf # 显示false
```

`git config --global core.autocrlf true --global core.safecrlf false`


## misc
在windows平台下git add 的时候经常会出现如下错误

git在windows下，默认是CRLF作为换行符，git add 提交时，检查文本中有LF 换行符（linux系统里面的），则会告警。所以问题的解决很简单，让git忽略该检查即可

`git config --global core.autocrlf warn `

Git提供了一个换行符检查功能（core.safecrlf），可以在提交时检查文件是否混用了不同风格的换行符。这个功能的选项如下：

* false - 不做任何检查
* warn - 在提交时检查并警告
* true - 在提交时检查，如果发现混用则拒绝提交

建议使用最严格的 true 选项。

