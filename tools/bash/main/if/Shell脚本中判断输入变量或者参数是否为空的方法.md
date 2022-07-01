# Shell脚本中判断输入变量或者参数是否为空的方法

![img](https://cdn2.jianshu.io/assets/default_avatar/9-cceda3cf5072bcdd77e8ca4f21c40998.jpg)

[Time哥哥](https://www.jianshu.com/u/485e372c113d)关注

2018.07.15 19:22:03字数 118阅读 3,703

# Shell脚本中判断输入变量或者参数是否为空的方法

这篇文章主要介绍了Shell脚本中判断输入变量或者参数是否为空的方法,本文总结了5种方法

##### **1.判断变量**

```bash
read -p "input a word :" word
if  [ ! -n "$word" ] ;then
    echo "you have not input a word!"
else
    echo "the word you input is $word"
fi
```

##### **2.判断输入参数**

```bash
#!/bin/bash
if [ ! -n "$1" ] ;then
    echo "you have not input a word!"
else
    echo "the word you input is $1"
fi
```

##### **3. 直接通过变量判断**

如下所示:得到的结果为: IS NULL

```bash
#!/bin/sh
para1=
if [ ! $para1 ]; then
  echo "IS NULL"
else
  echo "NOT NULL"
fi 
```

##### **4. 使用test判断**

得到的结果就是: dmin is not set!

```bash
#!/bin/sh
dmin=
if test -z "$dmin"
then
  echo "dmin is not set!"
else  
  echo "dmin is set !"
fi
```

##### **5. 使用""判断**

```bash
#!/bin/sh 
dmin=
if [ "$dmin" = "" ]
then
  echo "dmin is not set!"
else  
  echo "dmin is set !"
fi
```





2人点赞



shell