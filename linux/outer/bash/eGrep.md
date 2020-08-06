# grep


grep是Linux命令行下常用于查找过滤文本文件内容的命令。最简单的用法是：
``` bash
grep apple fruitlist.txt
# 如果想忽略大小写，可以用-i参数：
grep -i apple fruitlist.txt
# 如果想搜索目录里所有文件，包括子目录的话，并且在结果中显示行号，可以用以下命令：
grep -nr apple *


-i, --ignore-case: 忽略大小写
-n, --line-number: 显示行号
-R, -r, --recursive: 递归搜索子目录
-v, --invert-match: 输出没有匹配的行
```

## 管道
`grep -r "import sys" . |less` #翻页
`conda list|grep numpy`  # 对命令通过管道来过滤捕抓关键词
`conda list |grep "qt" -n | grep "py36h"` # 管道多重搜索
`ls -R|grep  -i grep`  # 目录下搜索
`tasklist |grep python`
`find . -name '*.py' |xargs grep main`

**Q**: xargs原理，管道可以把stdout作为stdin传给下一个命令，命令有些可以接受stdin有些可以接收argument，
有些命令不能接收stdin，例如ls。xargs可以把stdin转成argument，所以可以使用  `cmd |xargs ls`
grep 可以接收stdin，也可以接受argument，两者有区别，stdin中直接搜索word，argument中会当成文件遍历内容然后搜索word。


## help
``` bash
-A num, --after-context=num: 在结果中同时输出匹配行之后的num行
-B num, --before-context=num: 在结果中同时输出匹配行之前的num行，有时候我们需要显示几行上下文。
```

seg 和awk命令相似，可以对文件进行正则字符串操作