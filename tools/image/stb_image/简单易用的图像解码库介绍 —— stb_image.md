# 简单易用的图像解码库介绍 —— stb_image

[glumes](https://www.jianshu.com/u/be00a3041da5)关注

0.1222019.05.13 10:31:59字数 1,128阅读 3,534

> 原文链接：[简单易用的图像解码库介绍 —— stb_image](https://links.jianshu.com/go?to=https%3A%2F%2Fmp.weixin.qq.com%2Fs%2FMh_cLQeRy5J5AufeaGaOmA)

说到图像解码库，最容易想起的就是 `libpng` 和 `libjpeg` 这两个老牌图像解码库了。

`libpng` 和 `libjpeg` 分别各自对应 `png` 和 `jpeg` 两种图像格式。这两种格式的区别如下：

`png` 支持透明度，无损压缩的图片格式，能在保证不失真的情况下尽可能压缩图像文件的大小，因此图像质量高，在一些贴纸应用中也大部分用的是 png 图片。

`jpg` 不支持透明度，有损压缩的图片格式，有损压缩会使得原始图片数据质量下载，也因此它占用的内存小，在网页应用中加速速度快。

要想在工程中同时解码 `png` 和 `jpeg` 格式图片，就必须同时引用这两种库，而且还得经过一系列编译步骤才行。

在这里，介绍一个简单易用的图像库：`stb_image` 。Github 地址为：[https://github.com/nothings/stb](https://github.com/nothings/stb) ，目前已经有了 9600+ Star 。它的使用非常简单，看看 README 可能你就会了。

看看它的源码，你会发现全是 `.h` 头文件。这就是它的强大之处了，仅需在工程中加入头文件就可以解析图像了（实际上是函数实现等内容都放在头文件了而已）。

重点关注如下三个头文件：

- stb_image.h
  - 用于图像加载
- stb_image_write.h
  - 用于写入图像文件
- stb_image_resize.h
  - 用于改变图像尺寸

下面就开始实践吧，先给出一个完整的例子：

```cpp
#include <iostream>

#define STB_IMAGE_IMPLEMENTATION
#include "stb_image.h"
#define STB_IMAGE_WRITE_IMPLEMENTATION
#include "stb_image_write.h"
#define STB_IMAGE_RESIZE_IMPLEMENTATION
#include "stb_image_resize.h"
#include <string>
#include <stdio.h>
#include <stdlib.h>
#include <vector>

using namespace std;

int main() {
    std::cout << "Hello, STB_Image" << std::endl;

    string inputPath = "/Users/glumes/Pictures/input.png";
    int iw, ih, n;
    
    // 加载图片获取宽、高、颜色通道信息
    unsigned char *idata = stbi_load(inputPath.c_str(), &iw, &ih, &n, 0);

    int ow = iw / 2;
    int oh = ih / 2;
    auto *odata = (unsigned char *) malloc(ow * oh * n);
    
    // 改变图片尺寸
    stbir_resize(idata, iw, ih, 0, odata, ow, oh, 0, STBIR_TYPE_UINT8, n, STBIR_ALPHA_CHANNEL_NONE, 0,
                 STBIR_EDGE_CLAMP, STBIR_EDGE_CLAMP,
                 STBIR_FILTER_BOX, STBIR_FILTER_BOX,
                 STBIR_COLORSPACE_SRGB, nullptr
    );

    string outputPath = "/Users/glumes/Pictures/output.png";
    // 写入图片
    stbi_write_png(outputPath.c_str(), ow, oh, n, odata, 0);

    stbi_image_free(idata);
    stbi_image_free(odata);
    return 0;
}
```

这个例子很简单也很全面，主要就是加载了一张图片，并将它的宽高都缩小一倍，并保存缩小后图片。

## stb_image

首先是调用 `stbi_load` 方法去加载图像数据，并获取相关信息。传入的参数除了图片文件地址，还有宽、高、颜色通道信息的引用。

变量 `n` 就代表图片的颜色通道值，通常有如下的情况：

- 1 ： 灰度图
- 2 ： 灰度图加透明度
- 3 ： 红绿蓝 RGB 三色图
- 4 ： 红绿蓝加透明度 RGBA 图

返回的结果就是图片像素数据的指针了。

`stbi_load` 不仅仅支持 `png` 格式，把上面例子中的图片改成 `jpg` 格式后缀的依旧可行。

它支持的所有格式如下：

- png
- jpg
- tga
- bmp
- psd
- gif
- hdr
- pic

格式虽多，不过一般用到 png 和 jpg 就好了。

除了从文件加载图片，stb_image 还支持从内存中加载图片，通过该方法 `stbi_load_from_memory` ，在后续文章中会用到它的。

加载完图片之后，stb_image 还提供了相应的释放方法 `stbi_image_free`，实际上就是把 `free` 封装了一下而已。

## sbt_image_resize

加载完图片像素数据之后，就可以通过 `stbir_resize` 方法改变图片的尺寸。

`stbir_resize` 方法参数有很多：

```cpp
STBIRDEF int stbir_resize(const void *input_pixels , int input_w , int input_h , int input_stride_in_bytes,
                             void *output_pixels, int output_w, int output_h, int output_stride_in_bytes,
                             stbir_datatype datatype,
                             int num_channels, int alpha_channel, int flags,
                             // stb 中提供了多种模式，但是修改后并没有见很明显的效果
                             stbir_edge edge_mode_horizontal, stbir_edge edge_mode_vertical, 
                             stbir_filter filter_horizontal,  stbir_filter filter_vertical,
                             stbir_colorspace space, void *alloc_context)
```

`stbir_edge` 和 `stbir_filter` 类型的参数，stb_image_resize 提供了多种类型:

```cpp
typedef enum
{
    STBIR_EDGE_CLAMP   = 1,
    STBIR_EDGE_REFLECT = 2,
    STBIR_EDGE_WRAP    = 3,
    STBIR_EDGE_ZERO    = 4,
} stbir_edge;

typedef enum
{
    STBIR_FILTER_DEFAULT      = 0,  // use same filter type that easy-to-use API chooses
    STBIR_FILTER_BOX          = 1,  // A trapezoid w/1-pixel wide ramps, same result as box for integer scale ratios
    STBIR_FILTER_TRIANGLE     = 2,  // On upsampling, produces same results as bilinear texture filtering
    STBIR_FILTER_CUBICBSPLINE = 3,  // The cubic b-spline (aka Mitchell-Netrevalli with B=1,C=0), gaussian-esque
    STBIR_FILTER_CATMULLROM   = 4,  // An interpolating cubic spline
    STBIR_FILTER_MITCHELL     = 5,  // Mitchell-Netrevalli filter with B=1/3, C=1/3
} stbir_filter;
```

但实际上调整不同类型组合得到的图片并没有太多的变化 ┑(￣Д ￣)┍。

真正有用的可能还是前面那几个参数，指定了要将图片缩放后的宽高数据。

## stb_image_write

最后就是调用 `stbi_write_png` 方法将像素数据写入文件中，除此之外，stb_image_write 还提供了 `stbi_write_jpg` 方法来保存 jpg 格式图片。

根据两者格式的不同，方法调用的参数也是不一样的。

```cpp
int stbi_write_jpg(char const *filename, int x, int y, int comp, const void *data, int quality)

int stbi_write_png(char const *filename, int x, int y, int comp, const void *data, int stride_bytes)
```

## 总结

以上就是关于 stb_image 图像解码库的小介绍。

总的来说，它还是挺简单易用的，在平常做一些 Demo 以及需要快速实现、验证功能的情况下都可以考虑考虑。

但是在一些大型的项目中，还是要深思熟虑一些，从性能方面考虑，它肯定不如老牌的图像解码库了，像 `libjpeg-turbo` 解码用到了 `NEON` 这样 SIMD （单指令流多数据流）的操作，才是大型项目的首选了。

## 参考

关于 stb_image 在 Android 中的使用实践，可以参考我的项目：

> [https://github.com/glumes/InstantGLSL](https://github.com/glumes/InstantGLSL)





1人点赞



纸上浅谈