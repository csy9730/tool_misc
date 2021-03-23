# cmd命令重定向到剪切板
## Windows下

使用系统自带的 clip 命令。
``` bash
# 位于 C:\Windows\system32\clip.exe。

# 将字符串 Hello 放入 Windows 剪贴板
echo Hello | clip 

# 将 dir 命令输出（当前目录列表）放入 Windows 剪贴板
dir | clip

# 将 readme.txt 的文本放入 Windows 剪贴板
clip < README.TXT   

# 将一个空行放入 Windows 剪贴板，即清空 Windows 剪贴板
echo | clip 
```

明显，clip只支持剪切板的文本. 如果 使用重定向，`dir > clip`会变成重定向到 clip文件。


## Linux下
使用 xsel 命令。示例：
``` bash
cat README.TXT | xsel

# 如有问题可以试试-b选项

cat README.TXT | xsel -b 

# 将readme.txt的文本放入剪贴板

xsel < README.TXT 

# 清空剪贴板

xsel -c
```