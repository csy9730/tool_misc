# 如何理解 YUV ？

[![陈子兴](https://pic2.zhimg.com/da8e974dc_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/czx-73)

[陈子兴](https://www.zhihu.com/people/czx-73)

十多年音视频实时通信行业从业经验



154 人赞同了该文章

### **前言**

[YUV](https://link.zhihu.com/?target=https%3A//en.wikipedia.org/wiki/YUV) 是一种彩色编码系统，主要用在视频、图形处理流水线中(pipeline)。相对于 RGB 颜色空间，设计 YUV 的目的就是为了编码、传输的方便，减少带宽占用和信息出错。

人眼的视觉特点是对亮度更铭感，对位置、色彩相对来说不铭感。在视频编码系统中为了降低带宽，可以保存更多的亮度信息(luma)，保存较少的色差信息(chroma)。

Y’UV、YUV、YCbCr、YPbPr 几个概念其实是一回事儿。由于历史关系，Y’UV、YUV 主要是用在彩色电视中，用于模拟信号表示。YCbCr 是用在数字视频、图像的压缩和传输，如 MPEG、JPEG。今天大家所讲的 YUV 其实就是指 YCbCr。Y 表示亮度（luma），CbCr 表示色度（chroma）。

luminance 亮度，luma 是在视频编码系统中指**亮度值**；chrominance 色度，chroma 是在视频编码系统中指**色度值**。

Y’UV 设计的初衷是为了使彩色电视能够兼容黑白电视。对于黑白电视信号，没有色度信息也就是(UV)，那么在彩色电视显示的时候指显示亮度信息。

Y’UV 不是 Absolute Color Space，只是一种 RGB 的信息编码，实际的显示还是通过 RGB 来显示。Y’，U，V 叫做不同的 component 。

### **subsamping**

人眼的视觉特点是对亮度更铭感，对位置、色彩相对来说不铭感。在视频编码系统中为了降低带宽，可以保存更多的亮度信息(luma)，保存较少的色差信息(chroma)。这叫做 [chrominance subsamping](https://link.zhihu.com/?target=https%3A//en.wikipedia.org/wiki/Chroma_subsampling), 色度二次采样。原则：在数字图像中，(1) 每一个图形像素都要包含 luma（亮度）值；（2）几个图形像素共用一个 Cb + Cr 值，一般是 2、4、8 个像素。

要想理解本节内容，需要理解一个前提假设就是：对于一个 w 宽、h 高的像素图，在水平方向，一行有 w 个像素；在垂直方向，一列有 h 个像素，整个图形有 w * h 个像素。我们把这个像素叫做**图形像素**。

如果用 YCbCr 像素格式来表示像素图，那么要搞清楚亮度和图形像素的关系，色度和图形像素的关系。

通常对 yuv444，yuv422，yuv420 的解释是后面三个数字分别对应前面三个字母。拿 yuv422 来说，y 对应 4，表示四个图形像素中，每个都有亮度值；u 对应 2，表示四个图形像素中，Cb 只占用两个像素；v 对应 2， 表示四个图形像素中， Cr 占用两个像素。对于 yuv422 模式，这样解释是没有问题。但是对于 yuv420 解释就不对了，不能说四个图形像素中，Cr 占用 0 个像素吧？

现在我们通过下图来理解一下 yuv 各种格式后面数字的含义。图来源于 [Chrominance Subsampling in Digital Images](https://link.zhihu.com/?target=http%3A//dougkerr.net/Pumpkin/articles/Subsampling.pdf)



![img](https://pic3.zhimg.com/80/v2-69e65cf81df6b171d691e6b4f5c31516_720w.jpg)

如上图中所示，左侧一列，每一个小矩形是图形像素表示，黑框矩形是色度像素表示，小黑点是表示色度像素值(Cb+Cr)，表示图形像素和色度像素在水平和垂直方向的比例关系。比如，

4：4：0 水平方向是1/1，垂直方向是1/2，表示一个色度像素对应了两个图形像素。

4：2：2 水平方向是1/2，垂直方向是1/1，表示一个色度像素对应了两个图形像素。

4：2：0 水平方向是1/2，垂直方向是1/2，表示一个色度像素对应了四个图形像素。

右侧一列是**二次采样模式记号**表示, 是 J：a：b 模式，实心黑色圆圈表示包含色度像素(Cb+Cr），空心圆圈表示不包含色度像素。对于 J:a:b 模式，主要是围绕**参考块**的概念定义的，这个**参考块**是一个 J x 2 的矩形，J 通常是 4。这样，此**参考块**就是宽度有 4 个像素、高度有 2 个像素的矩形。a 表示**参考块**的第一行包含的色度像素样本数，b 表示在**参考块**的第二行包含的色度像素样本数。

4：4：0 参考块第一行包含四个色度样本，第二行没有包含色度样本。

4：2：2 参考块第一行包含两个色度样本，第二行也包含两个色度样本，他们是交替出现。

4：2：0 参考块第一行包含两个色度样本，第二行没有包含色度样本。

现在我们发现 yuv444，yuv422，yuv420 yuv 等像素格式的本质是：每个图形像素都会包含亮度值，但是某几个图形像素会共用一个色度值，这个比例关系就是通过 4 x 2 的矩形**参考块**来定的。这样很容易理解类似 yuv440，yuv420 这样的格式了。

### **平面格式（Planar formats）**

[平面格式](https://link.zhihu.com/?target=https%3A//wiki.videolan.org/YUV)是指用三个不同的数组来表示 YCbCr 的三个 Component，每一个 Component 都是通过不同的平面表示。为此，每一个 Component 会对应一个 plane。

yuv420p 也叫 i420 就是 yuv420 planar 表示。yuv420p 一共有三个平面分别是 Y，U，V，每一个平面都是用 8 bit 二进制数字表示，我们把 8 bit 称作位深度。

根据前面的介绍，如果用 yuv420p 来表示分辨率为 1280 * 720 的图片，需要占用多少存储空间呢？

每一个像素都需要一个 luma 值，即 y。那么总共需要 1280 * 720 = 921600 bytes。

每四个像素需要一个 chroma u 值，那么总共需要 1280 * 720 / 4 = 230400 bytes。

每四个像素需要一个 chroma v 值，那么总共需要 1280 * 720 / 4 = 230400 bytes。

把 y、u、v 三个 plane 加起来就是：921600 + 230400 + 230400 = 1382400 bytes。

现在我们找一个 jpeg 图片，通过 ffmpeg 转成 yuv，生成图形的分辨率是 1280 *720 ，具体命令如下：

```text
ffmpeg -i yuv_to_jpeg_0.jpeg -s 1280x720 -pix_fmt yuv420p test-yuv420p.yuv
```

查看生成的 test-yuv420p.yuv 文件属性，系统显示的大小和我们计算的完全吻合。



![img](https://pic2.zhimg.com/80/v2-124a33eed222335529d555f3e5ac23b1_720w.jpg)

### **压缩格式（Packed formats）**

压缩格式是指用一个数组表示 YCbCr，每一个 component 是交替出现的。

### **ffmpeg 中对 yuv420p 像素格式大小计算**

yuv420p 的格式描述在 libavutil/pixdesc.c 的 173 行。

```text
 173 static const AVPixFmtDescriptor av_pix_fmt_descriptors[AV_PIX_FMT_NB] = {
 174     [AV_PIX_FMT_YUV420P] = {
 175         .name = "yuv420p", // 像素格式名称
 176         .nb_components = 3, // 表示有三个 component ，也是三个 plane
 177         .log2_chroma_w = 1, // 表示色度(chroma) 像素和图形像素的水平比例关系 
 178         .log2_chroma_h = 1, // 表示色度(chroma) 像素和图形像素的垂直比例关系
 179         .comp = {
 180             { 0, 1, 0, 0, 8, 0, 7, 1 },        /* Y 平面，step 是 1， 位深度是8 bit */
 181             { 1, 1, 0, 0, 8, 0, 7, 1 },        /* U 平面，step 是 1， 位深度是8 bit */
 182             { 2, 1, 0, 0, 8, 0, 7, 1 },        /* V 平面，step 是 1， 位深度是8 bit */
 183         },
 184         .flags = AV_PIX_FMT_FLAG_PLANAR,
 185     },
```

所有的 YUV 像素格式表示都在 av_pix_fmt_descriptors 表中完成，我可以把这叫做像素格式描述表。

yuv420p 像素格式在水平方向(行)大小计算在 libavutil/imgutils.c 的 54 行。

```text
53 static inline
 54 int image_get_linesize(int width, int plane,
 55                        int max_step, int max_step_comp,
 56                        const AVPixFmtDescriptor *desc)
 57 {
 58     int s, shifted_w, linesize;
 59
 60     if (!desc)
 61         return AVERROR(EINVAL);
 62
 63     if (width < 0)
 64         return AVERROR(EINVAL);
        // max_step_comp 的取值： 0：y，1：u，2：v。对于 y 平面，每一个图形像素需要一个亮度值，
        // 所以这里比例因子是 0；对于 u、v 平面来说，色度像素和图形像素在水平和垂直方向都是 2/1 的关系，
        // 所以计算行的时候，比例因子取像素格式描述表中的 log2_chroma_w。对于 yuv420p 来说，取值是 1 ，
        // 因为是通过移位运算完成的，右移 1 位，相当于是除以 2。
 65     s = (max_step_comp == 1 || max_step_comp == 2) ? desc->log2_chroma_w : 0;
 66     shifted_w = ((width + (1 << s) - 1)) >> s;
 67     if (shifted_w && max_step > INT_MAX / shifted_w)
 68         return AVERROR(EINVAL);
 69     linesize = max_step * shifted_w;
 70
        // 如果像素描述表中的单位是 bit，那么这里转换成 bytes，右移 3 位，就是除以 8。
 71     if (desc->flags & AV_PIX_FMT_FLAG_BITSTREAM)
 72         linesize = (linesize + 7) >> 3;
 73     return linesize;
 74 }
```

yuv420p 像素格式在垂直方向(列)大小计算在 libavutil/imgutils.c 的 111 行。

```text
111 int av_image_fill_pointers(uint8_t *data[4], enum AVPixelFormat pix_fmt, int height,
112                            uint8_t *ptr, const int linesizes[4])
113 {
114     int i, total_size, size[4] = { 0 }, has_plane[4] = { 0 };
115
116     const AVPixFmtDescriptor *desc = av_pix_fmt_desc_get(pix_fmt);
117     memset(data     , 0, sizeof(data[0])*4);
118
119     if (!desc || desc->flags & AV_PIX_FMT_FLAG_HWACCEL)
120         return AVERROR(EINVAL);
121
122     data[0] = ptr;
123     if (linesizes[0] > (INT_MAX - 1024) / height)
124         return AVERROR(EINVAL);
125     size[0] = linesizes[0] * height;
126
127     if (desc->flags & AV_PIX_FMT_FLAG_PAL ||
128         desc->flags & FF_PSEUDOPAL) {
129         data[1] = ptr + size[0]; /* palette is stored here as 256 32 bits words */
130         return size[0] + 256 * 4;
131     }
132
133     for (i = 0; i < 4; i++)
134         has_plane[desc->comp[i].plane] = 1;
135
136     total_size = size[0];
137     for (i = 1; i < 4 && has_plane[i]; i++) {
            // i 的取值： 0：y，1：u，2：v。对于 y 平面，每一个图形像素需要一个亮度值，
            // 所以这里比例因子是 0；对于 u、v 平面来说，色度像素和图形像素在水平和垂直方向都是 2/1 的关系，
            // 所以计算列的时候，比例因子取像素格式描述表中的 log2_chroma_h。对于 yuv420p 来说，取值是 1 ，
            // 因为是通过移位运算完成的，右移 1 位，相当于是除以 2。
138         int h, s = (i == 1 || i == 2) ? desc->log2_chroma_h : 0;
139         data[i] = data[i-1] + size[i-1];
140         h = (height + (1 << s) - 1) >> s;
141         if (linesizes[i] > INT_MAX / h)
142             return AVERROR(EINVAL);
            // 每一平面的行和列做乘法，就是像素总数。
143         size[i] = h * linesizes[i];
144         if (total_size > INT_MAX - size[i])
145             return AVERROR(EINVAL);
            // 每一个平面的像素数相加，就是图片占用的像素总数。
146         total_size += size[i];
147     }
148
149     return total_size;
150 }
```

### **后记**

本人对 YUV，YCbCr 格式早就熟悉，但是没有仔细推敲过，理解上总是感觉差点儿意思。索性找时间仔细阅读了本文引用到的四篇文章，结合 ffmpeg 源码，总算搞清楚 yuv444,yuv420 这几种格式后面数字的含义了。按照自己的理解写了本文，希望对您有所帮助。

### **参考**

[1]: https://en.wikipedia.org/wiki/YUV(https://link.zhihu.com/?target=https%3A//en.wikipedia.org/wiki/YUV)	"YUV"
[2]: https://wiki.videolan.org/YUV(https://link.zhihu.com/?target=https%3A//wiki.videolan.org/YUV)	"YUV"
[3]: https://en.wikipedia.org/wiki/Chroma_subsampling(https://link.zhihu.com/?target=https%3A//en.wikipedia.org/wiki/Chroma_subsampling)	"Chroma_subsampling"
[4]: http://dougkerr.net/Pumpkin/articles/Subsampling.pdf(https://link.zhihu.com/?target=http%3A//dougkerr.net/Pumpkin/articles/Subsampling.pdf)	"Subsampling"





编辑于 2019-10-09

编码