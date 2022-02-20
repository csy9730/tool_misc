# figlet toilet


## figlet

这个命令将普通终端文本转换为大字母

```
sudo apt-get install figlet
```
## toilet
 toilet与figlet兼容，并支持颜色输出。 它具有HTML，SVG和TGA图像以及ANSI等导出选项
```
sudo apt-get install toilet
```

### demo
彩色时钟
``` bash
while true; do echo "$(date '+%D %T' | toilet -f term -F border --gay)"; sleep 1; done
```