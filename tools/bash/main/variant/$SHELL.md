# $SHELL

如果shell是Zsh，则定义变量`$ZSH_VERSION`。同样适用于Bash和`$BASH_VERSION`。

```
if [ -n "$ZSH_VERSION" ]; then
   # assume Zsh
elif [ -n "$BASH_VERSION" ]; then
   # assume Bash
else
   # asume something else
fi
```

但是，这些变量只能告诉您使用哪个shell来运行上面的代码。所以你必须在用户的shell中使用

```
source
```

这个片段。 作为替代方案，您可以使用

```
$SHELL
```

环境变量(应包含用户首选shell的绝对路径)并根据该变量的值猜测shell：

```
case $SHELL in
*/zsh) 
   # assume Zsh
   ;;
*/bash)
   # assume Bash
   ;;
*)
   # assume something else
esac
```

当然，当

```
/bin/sh
```

是

```
/bin/bash
```

的符号链接时，上述操作将失败。 如果你想依赖

```
$SHELL
```

，实际执行一些代码会更安全：

```
if [ -n "`$SHELL -c 'echo $ZSH_VERSION'`" ]; then
   # assume Zsh
elif [ -n "`$SHELL -c 'echo $BASH_VERSION'`" ]; then
   # assume Bash
else
   # asume something else
fi
```

无论使用哪个shell来运行脚本，都可以从脚本运行最后一个建议。