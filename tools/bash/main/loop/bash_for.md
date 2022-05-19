# for

## demo

### 文件夹遍历
文件夹遍历的方法
#### 1
只能遍历一层目录
``` bash
for file in `ls *.md`
do 
  echo -e "file:$file"
done
```
#### 2

该方法遍历时，会对包含空格的文件名错误分割
``` bash
for file in `find .  -name '*.md'`
do 
  echo -e "file:$file"
done
```
#### 3
该方法避免了上面的空格错误

``` bash
find . -type f -exec echo abc_{} \;
```

### range

``` bash
for num in {1..10..1}
do
    echo $num
done
```

``` bash
for num in {10..0..1}
do
    echo $num
done
# 10 9 8 ... 2 1 0
```

### for array
循环读取数组变量
``` bash

#Array Declaration
arr=( "Welcome","to","W3Cschool.cn" )
for i in "${arr[@]}"
do
echo $i
done
```

### for 三表达式
三表达式语法是 for 循环中最常见的语法

``` bash
for ((i=1; i<=10; i++))
do
echo "$i"
done
```

### break
### continue
