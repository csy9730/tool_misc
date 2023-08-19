# date

在 Bash 中，您可以使用date命令对系统的当前日期和时间值进行更改或其他操作。

## main

#### 打印系统当前的日期和时间
`$ date`
注：当您不附带其他选项，单独使用date命令时，它只会执行打印系统当前的日期和时间值。

#### 格式化打印日期和时间
``` bash

date "+%Y/%m/%d_%H:%M:%S"
```


``` bash
mdy=`date +%m-%d-%Y`
echo "Date in format Month-Date-Year"
echo $mdy
```

#### 配置时间

``` bash
$ date -s "2023-08-19 13:20:20"
Sat Aug 19 13:20:20 UTC 2023
```

## help
您可以参考选项列表，选择选项与date命令一同使用以生成格式输出。

```
选项	作用
-d	用于显示以字符串设置的时间
-s	用于设置以字符串设置的时间
-f	用于处理多个日期
-i	用于生成符合ISO 8601的日期、时间，以字符串输出
-r	用于打印文件的最后修改日期
-u	用于打印或设置世界标准时间
-help	用于获取此命令的帮助
-version	用于获取版本信息
您如果想要格式化日期，可以使用以下方法：
```

#### demo


同步本地时间到远程设备
```bash
cur_time=`date "+%Y-%m-%d %H:%M:%S"`

# cur_time="2023-08-19 11:25:34"
# ssh my_dev -- "date -s '2023-08-19 11:25:34'"
# ssh my_dev -- "echo $cur_time"
ssh my_dev -- "date -s '$cur_time'"

# 同步时间
ssh my_dev -- "date -s '`date "+%Y-%m-%d %H:%M:%S"`'"

```