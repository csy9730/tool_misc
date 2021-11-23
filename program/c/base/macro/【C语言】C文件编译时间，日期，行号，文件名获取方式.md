# 【C语言】C文件编译时间，日期，行号，文件名获取方式

[大秦长剑](https://blog.csdn.net/weixin_39420903) 2020-03-28 14:43:05 

分类专栏： [C语言](https://blog.csdn.net/weixin_39420903/category_7629830.html)

版权

C文件编译时间，日期，行号，文件名获取方式

C中获取编译时间/日期/行号/文件名
       ANSIC标准定义了可供C语言使用的预定义宏：
               1、__ LINE__ : 在源代码中插入当前源代码行号
               2、__ FILE __ : 在源代码中插入当前源代码文件名
               3、__ DATE __ : 在源代码中插入当前编译日期〔注意和当前系统日期区别开来〕
               4、__ TIME __ : 在源代码中插入当前编译时间〔注意和当前系统时间区别开来〕

标识符__LINE__和__FILE__通常用来调试程序；
标识符__DATE__和__TIME__通常用来在编译后的程序中加入一个时间标志，以区分程序的不同版本；
这四个都是预编译宏，不是包含在头文件中的
__FILE__是当前编译的文件的文件名 是一个字符串
__TIME__是当前编译的文件的编译时间 格式是hh:mm:ss 是字符串
__DATE__是当前编译的文件的编译日期 格式是Mmm:dd:yyyy 是字符串
__LINE__是调用该宏语句所在的行数，是个十进制数实例

``` cpp
#include "mainwindow.h"
#include <QApplication>
#include <QDebug>
#include <QDateTime>
#include <QString>
#include <stdio.h>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    MainWindow w;
    w.show();
    qDebug(
        "\n\n"
        "+ Release time:     " __DATE__ "  " __TIME__ "\n"
        );
    qDebug(
           "\n"
           "File :  " __FILE__ " \n"
          );
 
    qDebug()<<QString::number(__LINE__);
    return a.exec();
}
```