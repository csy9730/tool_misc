# windows bash 配置


## encoding

执行`ping www.baidu.com` ,`ipconfig -all`都会出现乱码


### 修改bash支持编码
查看git-bash的编码
`echo $LANG`

修改git-bash的编码为gbk。
`export LANG=zh_CN.gbk`

修改git-bash的编码为原来的utf8。
`export LANG="zh_CN.UTF-8"`

### winpty
winpty可以提供一个终端。
注意，winpty在`export LANG=zh_CN.gbk`会导致乱码

## interactive console

直接在bash下执行python，会导致卡死，按ctrl+A才能退出。

使用`python -i` 虽然可以执行，但是上下方向键错误。
使用`winpty python`可以正常执行python。

``` bash
winpty node
winpty powershell
winpty bash


```

编辑 ~/.bashrc  
添加以下内容：
``` 
alias mysql="winpty mysql"
alias node="winpty node"
alias python="winpty python"
alias ipython="winpty ipython"
alias psql="winpty psql"
alias redis-cli="winpty redis-cli"
```
## other 
vim 可以更改编码
tmux 不支持编码


## misc

msys2 ssh 和git-for-windows 相同，都是基于linux bash方式的调用方法。
git-for-windows 有比较多的缺点：
1. 不默认支持gbk编码，很多windows命令显示是乱码 ，`ping www.baidu.com`
2. 通过`python -i `支持交互会话
3. 通过`node -i `支持交互会话，上下左右键不正确。
4. 不支持斜杠/ , `ipconfig /all`
5. 支持tmux
6. 不支持windows式路径，支持linux路径
7. 支持 `taskmgr`,`explorer .`

server：openssh ， client： openssh， putty，
1. 支持gbk编码转换成utf-8 
2. 支持python交互会话
3. 支持node，勉强支撑anaconda/node
4. 支持斜杠/ , `ipconfig /all`
5. 不支持tmux
6. 支持windows式路径，不支持linux路径
7. 不支持 `taskmgr`,`explorer .`？

openssh下的git-bash支持python和nodejs
