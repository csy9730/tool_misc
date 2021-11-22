# 图形学渲染基础（2）光栅化（Rasterization）

[https://juejin.cn/post/6994671344025600007](https://juejin.cn/post/6994671344025600007)

## 简介

光栅化可以简单理解成如何将图像或者物体所蕴含的几何信息呈现在屏幕，比如：对于一个三角形来说需要用屏幕空间上哪些点的集合来表示它（用离散的点集来表示连续的线条或图像）![QQ截图20210810094451.png](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/e87c48e085d2437287fe4deeac6a04d3~tplv-k3u1fbpfcp-watermark.awebp)

- 屏幕空间像素的坐标范围从（0，0）到（width-1，height-1）
- 每个像素的表示用像素的中心点（x+0.5，y+0.5）表示

# 直线的光栅化

## DDA数值微分算法

DDA是依据直线的斜率对直线进行绘制的算法。在已知直线的方程y=kx+b的情况下，若|k|小于0，则可以想象直线是偏向x轴的，因此X轴的变化是要比y轴的要快；若|k|大于0，则可以想象直线是偏向y轴的，因此y轴的变化是要比x轴的要快，两种情况光栅化效果图如下所示，算法也较为简单。![QQ截图20210810095630.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/494f81d5ef32456a81a6a4a1bd23420b~tplv-k3u1fbpfcp-watermark.awebp)

- 当|k|<1时，从起点开始画起每次x = x+1， y = y+k, 并将y四舍五入，得到新的x，y就是像素点应该画的地方
- 当|k|>1时，从起点开始画起每次y = y+1， x = x+1/k, 并将x四舍五入，得到新的x，y就是像素点应该画的地方

## 中点Bresenham算法

Bresenham算法的思想是将像素中心构造成虚拟网格线，按照直线起点到终点的顺序，计算直线与各垂直网格线的交点，然后根据误差项的符号确定该列像素中与此交点最近的像素。这里拿0<k<1的情况举例说明。![QQ截图20210810100931.png](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/391b356365a54f64a85bdb4ae9fb6b25~tplv-k3u1fbpfcp-watermark.awebp)当0<k<1时，每次取像素点只会考虑右边或者右上，因此会取右边和右上格子的中心（如黄色格子的中心圆圈所示）， 判断中心在直线的哪一边，若直线在两格中心的上侧则取上方的格子，若直线在两格中心的下侧则取下方的格子。

# 三角形的光栅化

三角形是图形学学习中最为基础的图像，大多数的模型都是用一个个三角形面表示，且任意的其它多边形其实都可以转化成多个三角形的形式。![QQ截图20210810101959.png](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/8a2bb549ba5744d8b5b69b73969f61e6~tplv-k3u1fbpfcp-watermark.awebp)三角形的光栅化主要是判断某个像素点是否被包含在三角形内，如果被包含在内则被渲染，未被包含则未被渲染。那么如何判断某个点是否在三角形内部呢？这里我们采用向量叉乘的方法（叉乘的正负可判断向量之间相对的左右位置）![QQ截图20210810102413.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/35e002637604487089b33abdb3b73f03~tplv-k3u1fbpfcp-watermark.awebp)如图所示，我们事先知道想要光栅化的三角形的三个顶点P0，P1，P2，以及检测点Q。 只要分别计算P0P1 *P0q，P1P2 *P1q，P2P0 *P2q，如果三者同号则代表点P在三条线段的同一边，那么必然处于三角形内部，如果不同号则代表该点一定在三角形外部。可如果屏幕空间所有的像素点都要进行这样的操作明显是多余的，因此我们可以采用用矩形包围盒进行优化，只对包围盒内部的点进行判断。![QQ截图20210810103329.png](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/913a70e626ce4480a1269c8a87b5ec1b~tplv-k3u1fbpfcp-watermark.awebp)

# 抗锯齿

在使用上述的三角形光栅化算法后会生成如下的像素点集合，可以明显看到三角形边缘过于”坎坷“。![QQ截图20210810121346.png](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/afa92f9e7456480899449d56ac07fa0a~tplv-k3u1fbpfcp-watermark.awebp)这是由于我们用有限离散的像素点去逼近连续的三角形，那么自然会出现这种锯齿走样的现象，因为这种近似是不准确的，从的角度去看这个问题是由于我们采样的频率低于信号的频率，造成了失真的现象。

## SSAA（超采样抗锯齿）

SSAA**Super Sampling AA**的想法其实是非常直观的，如果有限离散像素点逼近结果不好，那么我们用更多的采样点去逼近不就会得到更好的结果了吗？所以根据这个思想我们可以把原来的每个像素点进行细分，比如下例中，我们讲每个像素点细分成了4个采样点：![QQ截图20210810123738.png](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/d73016390dad4a5193cf6e5edc663f7d~tplv-k3u1fbpfcp-watermark.awebp)![QQ截图20210810123746.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/b92a8897571846cb8e2903069f0be5ef~tplv-k3u1fbpfcp-watermark.awebp)我们根据每个采样点来进行shading（该概念还未提及，可以理解为计算每个像素点的颜色的过程，当然这里是一个纯红色的三角形，如果该点在三角形内，它的颜色值可以直接得到为（1，0，0）），这样得到了每个采样点的颜色之后，我们讲每个像素点内部所细分的采样点的颜色值全部加起来再求均值，作为该像素点的抗走样之后的颜色值。

> 例如，在4xSSAA算法中，假设最终屏幕输出的分辨率是800x600, 4x SSAA就会先光栅化到一个分辨率1600x1200的buffer上并逐个像素着色，然后再直接把这个放大4倍的buffer下采样至800x600的画面

SSAA 是一种最原始的抗锯齿方法，虽然得到的图片锯齿感少了很多，代价是：例如4x SSAA，光栅化和着色的计算负荷都比原来多了4倍，buffer存储空间的大小也比目标分辨率多了4倍。

## MSAA（多重采样抗锯齿）

MSAA **MultiSampling Anti-Aliasing** 其实是对SSAA的一个改进，显然SSAA的计算量是非常大的，每个像素点分成4个采样点，我们就要进行4次的shading来计算颜色，额外多了4倍的计算量，如何降低它呢？

MSAA的做法也很容易理解，我们依然同样会分采样点，但是只会去计算究竟有几个采样点会被三角形cover，计算颜色的时候只会利用像素中心坐标计算一次颜色(即所有的信息都会被插值到像素中心然后取计算颜色)，如下图：![QQ截图20210810124546.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/3b39511ffc214ec091613bfd7915cf78~tplv-k3u1fbpfcp-watermark.awebp)可以看到，4x MSAA在光栅化计算负荷比原来多了4倍，但是到了像素着色（pixel shading）阶段的时候，每个目标像素只着色1次（4x SSAA对应一个目标像素则需要计算4个高分辨率像素，即4次着色），而且也不需要更大的buffer存储（4x SSAA需要4倍的buffer存储）

## FXAA（快速近似抗锯齿）

FXAA **Fast Approximate Anti-Aliasing**  是一种图像后处理技术。它先直接采样得到目标图像，然后通过像素颜色检测边缘。这种方法使得颜色变化剧烈的像素会被认为是边缘，精度可能不好，但是处理速度非常快，这只能算是处理锯齿问题的一个小技巧。

## TAA（帧间抗锯齿）

TAA**Temporal Anti-Aliasing**是最常用的图像后处理技术。解决shading的aliasing，可以通过增加采样次数的方法，然而直接做多次采样的开销是非常大的，而TAA的做法是，把多次采样的过程分布到每一帧中去，也就是每一帧都利用前面几帧保存下来的数据（当前的像素信息混合上一帧同位置像素信息），也就是所谓的“temporal”所指的意思了，如下图所示。![QQ截图20210810125620.png](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/3b032bc1e2604499ae7595596edeca3a~tplv-k3u1fbpfcp-watermark.awebp)当然了，这么做的前提是时间里的每一帧在不同的局部位置采样，也就是说每一帧我们采样的位置就不能像以前一样都在正中心采样了，还需要进行抖动操作（即每帧采样的位置有一定随机偏移），这是避免画面静止时导致重复对相同的位置采样从而导致整个图像相当于采样次数没有增加，造成抗锯齿失效。

> TAA 的缺点：由于每一帧图像的像素颜色实际上是根据以前的帧来进行混合的，因此容易产生画面延迟感；而且当物体运动过快时，会出现物体的残影现象。

# 可见性/遮挡（Visibility/Occlusion）

解决了走样问题之后，还有一个仍需解决的问题，我们如何判断物体先后关系？更具体的说每个像素点所对应的可能不止一个三角形面上的点，我们该选择哪个三角形面上的点来显示呢？答案显然易见，离摄像头最近的像素点显示。这里便要利用到我们之前做变换之后所得到的深度值z了，这里定义z越大离摄像机越远。

## 画家算法（Painter's Algorithm）

画家算法是最原始的算法，就是简单地将三角形进行排序，根据z值（离摄像机的前后距离）的顺序，将三角形逐个进行光栅化，并且当光栅化遇到冲突时（以前有三角形光栅化占据了这个像素）强制覆盖之。![QQ截图20210810131214.png](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/b0b8777ba586413a946ad45a2d8fd1a6~tplv-k3u1fbpfcp-watermark.awebp)画家算法十分的简单，比较容易理解，不过有着明显缺点：

- 以三角形的z距离进行排序，需要一定开销，时间复杂度为O(nlogn)O(nlogn)，n为三角形个数
- 以三角形为单位可能会发生不准确的z值排序，如画家算法无法渲染出下图

## Z-Buffer

Z-Buffer则是一种主流且被硬件支持的遮挡剔除技术，其原理是提供一个额外存储最小z值的buffer（经过变换后的坐标z值越小，实际上就是越接近摄像机），这样实际有两个buffer

- frame buffer：负责存储像素颜色，也就是存储图像用的
- z-buffer(depth buffer)：负责存储深度值（z值）

这里的buffer都是针对屏幕空间的像素信息而言，每个三角形光栅化且像素着色（Pixel/Fragment Shader）后里的每个像素z值先和z-buffer的对应像素深度进行比较，若更小（意味着离摄像机更近），则像素颜色写入frame buffer对应位置且z值覆盖写入z-buffer对应位置；若更大，则抛弃（discard）像素。![QQ截图20210810132130.png](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/32fd50c92af844728133ec22af8c6ccd~tplv-k3u1fbpfcp-watermark.awebp)

> - Z-buffer的时间复杂度是O(n)O(n)，n为三角形个数
> - 绝大部分GPU硬件都实现了Z-Buffer算法，可以较快执行

## Early-Z

Z-Buffer的一个缺点是，当花费了较多的像素着色计算（Pixel/Fragment Shader 负责光照和纹理采样等大量计算）后得到的像素点有可能被抛弃，这就造成了计算性能的浪费。而 **Early-Z** 的原理就是把Z-Buffer的操作提前到光栅化之后和像素着色之前，这样就避免了本就该被抛弃的像素进行额外的像素着色计算。

然而有一些情况是不适用于Early-Z技术的：像素着色计算可能会修改z深度值、Alpha Test等。这时候用Early-Z技术是不准确的，必须老老实实用Z-test，即等到光栅化和着色后才决定是否抛弃像素。

> **Z-prepass 改进**：使用额外一个pass（理解成跑多一次管线流程），每个三角形光栅化后仅写入深度而不做任何像素着色计算（不输出任何颜色），这样所有三角形通过第一个pass后，我们可以得到记录最小z值的屏幕深度图（实际就是z-buffer）；而第二个pass则作为正常渲染流程，只是每个三角形光栅化后需要关闭深度写入并通过比较深度 **比较该三角形的像素的深度与z-buffer里的深度是否相等** 来决定是否进行该像素的着色计算，这样就能保证屏幕每个像素只可能对应有最多一次像素着色计算。

# 总结

- 计算机图形学真的不简单！
- 闫老师的课讲的真不错！
- 何总的笔记是记得真不错！

# 参考

- [DX12渲染管线(2) - 时间性抗锯齿(TAA) - 知乎 (zhihu.com)](https://link.juejin.cn/?target=https%3A%2F%2Fzhuanlan.zhihu.com%2Fp%2F64993622)
- [计算机图形学四：抗锯齿SSAA及MSAA算法和遮挡剔除Z-Buffer算法 - 知乎 (zhihu.com)](https://link.juejin.cn/?target=https%3A%2F%2Fzhuanlan.zhihu.com%2Fp%2F144331249)
- [图形渲染基础（2）光栅化（Rasterization） - KillerAery - 博客园 (cnblogs.com)](https://link.juejin.cn/?target=https%3A%2F%2Fwww.cnblogs.com%2FKillerAery%2Fp%2F14518859.html%23fxaa%EF%BC%88%E5%BF%AB%E9%80%9F%E8%BF%91%E4%BC%BC%E6%8A%97%E9%94%AF%E9%BD%BF%EF%BC%89)
- [GAMES101-现代计算机图形学入门-闫令琪_哔哩哔哩_bilibili](https://link.juejin.cn/?target=https%3A%2F%2Fwww.bilibili.com%2Fvideo%2FBV1X7411F744)

文章分类

代码人生

文章标签



计算机图形学