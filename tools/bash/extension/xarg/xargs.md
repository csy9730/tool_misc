# xargs


## misc


redirect to file stdout/stdin/file/argument

命令普遍支持argument
流式命令支持stdin，stdout。
注意区分 argument 和stdin。

xargs将 stdin 转变为 argument 

dir abc  2>&1 > a.log

dir abc   >a.log 2>&1