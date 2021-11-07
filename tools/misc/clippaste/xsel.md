# xsel
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