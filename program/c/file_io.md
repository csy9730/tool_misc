# file io


文件读写 包括：
* 文件打开和关闭
* 文件指针控制
* 文件读取和写入
    * 单字符读写 fputc/fgetc
    * 多字符（单行）读写 fgets/puts
    * 指定缓冲长度/二进制 读写

``` c
FILE *fopen( const char * filename, const char * mode );
int fclose( FILE *fp );
```

在这里，**filename** 是字符串，用来命名文件，访问模式 **mode** 的值可以是下列值中的一个：

| 模式 | 描述                                                         |
| :--- | :----------------------------------------------------------- |
| r    | 打开一个已有的文本文件，允许读取文件。                       |
| w    | 打开一个文本文件，允许写入文件。如果文件不存在，则会创建一个新文件。在这里，您的程序会从文件的开头写入内容。如果文件存在，则该会被截断为零长度，重新写入。 |
| a    | 打开一个文本文件，以追加模式写入文件。如果文件不存在，则会创建一个新文件。在这里，您的程序会在已有的文件内容中追加内容。 |
| r+   | 打开一个文本文件，允许读写文件。                             |
| w+   | 打开一个文本文件，允许读写文件。如果文件已存在，则文件会被截断为零长度，如果文件不存在，则会创建一个新文件。 |
| a+   | 打开一个文本文件，允许读写文件。如果文件不存在，则会创建一个新文件。读取会从文件的开头开始，写入则只能是追加模式。 |

如果处理的是二进制文件，则需使用下面的访问模式来取代上面的访问模式：

```
"rb", "wb", "ab", "rb+", "r+b", "wb+", "w+b", "ab+", "a+b"
```


``` c
int fputc( int c, FILE *fp );
int fgetc( FILE * fp );

char *fgets( char *buf, int n, FILE *fp );

int fscanf(FILE *fp, const char *format, ...) ;
```

下面两个函数用于二进制输入和输出：
``` c
size_t fread(void *ptr, size_t size_of_elements, 
             size_t number_of_elements, FILE *a_file);
              
size_t fwrite(const void *ptr, size_t size_of_elements, 
             size_t number_of_elements, FILE *a_file);
```


## demo
``` c
#include <stdio.h>
 
int main()
{
   FILE *fp = NULL;
 
   fp = fopen("/tmp/test.txt", "w+");
   fprintf(fp, "This is testing for fprintf...\n");
   fputs("This is testing for fputs...\n", fp);
   fclose(fp);
}
```

``` c

#include "stdlib.h"
#include "stdio.h"
 
int main(int argc, char *argv[])
{
    FILE *in= fopen("D:/in.java", "r");
    char buf[1024];
 
    while (fgets(buf, sizeof(buf), in) != NULL)
    {
        printf("%s", buf);
    }
 
    fclose(text);
 
    return 0;
}
```


