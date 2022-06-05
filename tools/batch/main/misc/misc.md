## path
``` bat
dir ../..
dir .
if not exist bak (mkdir bak & echo 1 >bak\bakCount.txt  ) 
```
## var
```
echo "%date%%time%"
set /p var=<bTemp.txt 
```
### demos

文件合并
静默安装
文件夹备份，文件备份，后缀名文件批量备份。
字符串处理：路径分割



### misc

使用赋值语句时，防止后接空格产生歧义。set a="abc"  

路径包含空格，使用双引包含路径。
转义符：
1. 一般通过转义符^
2. 双引号通过""" 实现,
3. 单引号和双引号嵌套使用


转义回车 ，直接即可
转义双引号 通过""" 实现。