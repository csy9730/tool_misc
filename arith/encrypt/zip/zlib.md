# zlib

官方网址:[http://www.zlib.net/](http://www.zlib.net/)


zlib能使用一个gzip数据头，zlib数据头或者不使用数据头压缩数据。


zlib仅支持一个LZ77的变种算法，DEFLATE的算法。


#### 应用
今天，zlib是一种事实上的业界标准，以至于在标准文档中，zlib和DEFLATE常常互换使用。数以千计的应用程序直接或间接依靠zlib压缩函式库，包括：

* Linux核心：使用zlib以实作网络协定的压缩、档案系统的压缩以及开机时解压缩自身的核心。
* libpng，用于PNG图形格式的一个实现，对bitmap数据规定了DEFLATE作为流压缩方法。
* Apache ：使用zlib实作http 1.1。
* OpenSSH、OpenSSL：以zlib达到最佳化加密网络传输。

因为其代码的可移植性，宽松的许可以及较小的内存占用，zlib在许多嵌入式设备中也有应用。
### Zlib的功能测试

 写一个简单的例子测试一下，注意编译的时候要加入 -lz 这个库

zlib.c

`gcc  -o zlib zlib.c -lz`

./zlib
``` cpp
#include <stdio.h>
#include <zlib.h>
int main(int argc,char **args)
{
    /*原始数据*/
    unsigned char strsrc[]="这些是测试数据。123456789 abcdefghigklmnopqrstuvwxyz\n\t\0abcdefghijklmnopqrstuvwxyz\n"; //包含\0字符
    unsigned char buf[1024]={0};
    unsigned char strdst[1024]={0};
    unsigned long srclen=sizeof(strsrc);
    unsigned long buflen=sizeof(buf);
    unsigned long dstlen=sizeof(strdst);
    int i;
    FILE * fp;
    printf("源串:");
    for(i=0;i<srclen;++i)
    {
        printf("%c",strsrc[i]);
    }
    printf("原串长度为:%ld\n",srclen);
    printf("字符串预计算长度为:%ld\n",compressBound(srclen));
    //压缩
    compress(buf,&buflen,strsrc,srclen);
    printf("压缩后实际长度为:%ld\n",buflen);
    //解压缩
    uncompress(strdst,&dstlen,buf,buflen);
    printf("目的串:");
    for(i=0;i<dstlen;++i)
    {
        printf("%c",strdst[i]);
    }
    return 0;
}
```

### python zlib
提供了函数
- adler32 计算校验码
- compress 压缩
- compressobj 压缩
- crc32 计算校验码
- decompress 解压缩
- decompressobj 解压缩