# 图形学渲染基础（4）纹理（Texture）

# 纹理映射

纹理相当于着色物体的"皮肤"，负责提供基础颜色，例如黄种人和黑种人同时光照的情况下是有较大区别的。计算机在处理纹理映射时通常是使用二维数组储存三维物体的纹理信息，具体原理就像下图所示。![QQ截图20210813141005.png](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/c98c9d989dae4da68a98cc43d1fd0cf9~tplv-k3u1fbpfcp-watermark.awebp)通常为了使用纹理，对于每个三角形顶点vertex属性额外需要存储u、v坐标以便映射到纹理空间（由于三角形也是一个平面，因此非常方便映射到平面的纹理空间），三角形内的点则只需要根据三角重心坐标插值也能算出对应的u、v坐标。这样，三角形每个像素点就可以找到纹理中对应位置的颜色。![QQ截图20210813141211.png](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/a882d2668c5c4227b7d3a7fef12fb141~tplv-k3u1fbpfcp-watermark.awebp)

# 纹理映射问题及解决方案

## 纹理过小

纹理过小的问题相对容易理解，想想我们把一张100x100的纹理贴图应用在一500x500的屏幕之上必然会导致走样失真，因为屏幕空间的几个像素点对应在纹理贴图的坐标上都是集中在一个像素大小之内。那么如果仅仅是使用对应(u,v)坐标在texture贴图下最近的那个像素点，往往会造成严重的走样。![QQ截图20210813143629.png](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/65679da105be40f3b7f4d5e5120a580d~tplv-k3u1fbpfcp-watermark.awebp)例如，若经过纹理映射后的坐标位置为红色小圆点，那么它会去选择离他最近的那个橙色框起来的点。看似方法合理，但其实是不可取的，接下来会介绍利用双线性插值的方法缓解这种走样现象。

### 双线性插值（Bilinear Interpolation）

双线性插值的方法很好理解，也比较容易操作，就是通过周围四个点的像素颜色进行两次线性插值计算出该红点颜色。![QQ图片20210813144642.jpg](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/c5ac7f3a86964e2580a56474db440290~tplv-k3u1fbpfcp-watermark.awebp)

- 通过计算出红点的横坐标与周围顶点横坐标比例s，对U00和U10的颜色插值得到p，对U01和U11颜色插值得到q
- 通过计算出红点的纵坐标与周围顶点纵坐标比例t，对p和q的颜色插值得到小红点颜色。

![QQ截图20210813145011.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/fcfb7a84d28b4c3b8d66d5b10cca8d87~tplv-k3u1fbpfcp-watermark.awebp)从上图可以看出通过双线性插值的图片已经可以较好的解决纹理过小的问题了。(还有一种插值方法叫做双三次插值(Bicubic),是利用三次方程来进行两次插值，效果可能更好，但是计算速度很低不在这里具体讨论了)

## 纹理过大

可能对于我们的第一直觉来说，纹理小确实会引发问题，但是纹理大那不是更好吗，为什么会引发问题呢？但事实是纹理过大所引发的走样甚至会更加严重。因为一个屏幕像素点无法映射到一个区域的纹理（想象一下纹理贴图大小500x500，屏幕空间100x100，将屏幕空间的像素点均匀分布在纹理空间之中，那么1个屏幕空间像素点所占的平均大小就是5x5=25个纹理空间像素，因此这就是纹理过大所导致的结果）![QQ截图20210813150241.png](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/95191d869d83408a91d6473c78e73e5b~tplv-k3u1fbpfcp-watermark.awebp)造成此现象的原因大多数是由于透视投影，地板上铺满了重复的方格贴图，根据近大远小，远处的一张完整的贴图可能在屏幕空间中仅仅是几个像素的大小，那么必然屏幕空间的一个像素对应了纹理贴图上的一片范围的点，这其实就是纹理过大所导致的，直观来说想用一个点采样的结果代替纹理空间一片范围的颜色信息，必然会导致严重失真！(从信号的角度来说就是，采样频率过低无法还原信号原貌)![QQ截图20210813150834.png](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/66517a80acca4cc1ad0dadf86d6bc83e~tplv-k3u1fbpfcp-watermark.awebp)从上图可以看出，当采样率较高时一个像素点对应纹理贴图上一个UV坐标，当采样率较低时一个像素点只对应纹理贴图上一片区域。一个屏幕空间的蓝色像素点离相机越远，对应在纹理空间的范围也就越大。其实也就是越来越欠采样，这种现象被形象的称为屏幕像素在纹理空间的footprint。对于这种问题，我们通常不采取Supersampling的方法（计算量太大），而是采用大名鼎鼎的Mimap技术了。

### Mipmap

正如上文所提，一个采样点的颜色信息不足以代表 “footprint”里一个区域的颜色信息，如果可以求出这样一个区域里面所有颜色的均值，是不是就是一种可行的方法呢？没错我们的目标就是从点查询Point Query迈向区域查询Range Query。但依然存在一个问题，从上图不难看出，不同的屏幕像素所对应的footprint size是不一样大小的，看下图这样一个例子：![QQ截图20210813152714.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/3bffede0a9bc44cabe6339c166c7d68b~tplv-k3u1fbpfcp-watermark.awebp)远近两个圆圈内的像素点对应的footprint区域一定大小不同，远处圆圈里的footprint必然比近处的要大，因此必须要准备不同level的区域查询才可以，而这正是Mipmap。![QQ截图20210813152840.png](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/5c3a00f92a074401851963c6b3619ba3~tplv-k3u1fbpfcp-watermark.awebp)level 0代表的是原始texture，也是精度最高的纹理，随着level的提升，每提升一级将4个相邻像素点求均值合为一个像素点，因此越高的level也就代表了更大的footprint的区域查询。接下来要做的就是根据屏幕像素的footprint大小选定不同level的texture，再进行点查询即可，而这其实就相当于在原始texture上进行了区域查询！

那么如何去确定使用哪个level的texture呢？利用屏幕像素的相邻像素点估算footprint大小再确定level D！如下图:![QQ截图20210813152934.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/e77fc2f7ac0f4905bde8bc7c86f35e89~tplv-k3u1fbpfcp-watermark.awebp)在屏幕空间中取当前像素点的右方和上方的两个相邻像素点(4个全取也可以)，分别查询得到这3个点对应在Texture space的坐标，计算出当前像素点与右方像素点和上方像素点在Texture space的距离，二者取最大值，计算公式如图中所示，那么level D就是这个距离的log2值 (D = log2L)

> 这里D值算出来可能并不是一个整数，有两种对应的方法：
>
> - 采用四舍五入的方法选择最近的level
> - 采用三线性插值的方法（下面level自身双线性插值，上面level自身双线性插值，两者之间再次线性插值）

### 各向异性过滤Mipmap

虽然Mipmap折腾了这么大功夫，但还是没法渲染出很好的效果，那是因为Mipmap默认的都是正方形区域的Range Query，而实际情况并不是如此，见下图:![QQ截图20210813153735.png](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/2d5f8ef92427477eaf69013838434526~tplv-k3u1fbpfcp-watermark.awebp)各向异性过滤的原理：在Mipmap的基础上提供横向伸缩和纵向伸缩的纹理层级（以适应横着和竖着的长条形状）；但是这只能减少上述过度模糊现象的发生，因为实际渲染中还有斜向的长条形状或者其它难以近似的形状。![QQ截图20210813153947.png](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/1e35cdb6a637402e91185d8475c17b06~tplv-k3u1fbpfcp-watermark.awebp)虽然采用各向异性过滤技术后效果会好一点，但是它的纹理额外空间开销为原分辨率纹理的3倍。

# 纹理映射的应用

## 法线贴图（Normal Maps）

在Blinn-Phong光照模型中，法线向量扮演着重要的一环，不同的法线向量对光照的计算结果有着很大的影响，打个比方，倘若将一个高精度模型法线信息套用在低精度模型之上，会使低精度模型的渲染效果有着巨大的提升。![QQ截图20210813160606.png](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/6082fe7f9a1e4b48a944229f4aaea220~tplv-k3u1fbpfcp-watermark.awebp)

## 凹凸贴图（Bump Maps）

Bump Maps其实与Normal Maps十分类似，Normal Maps直接存储了法线信息，而Bump Maps存储的是该点**逻辑**上的相对高度(可为负值)，该高度的变化实际上表现了物体表面凹凸不平的特质，利用该高度信息，再计算出该点法线向量，最后再利用该法线计算光照，这就是Bump Maps的过程，只不过比直接的Normal Maps多了一步从height到normal向量。![QQ截图20210813160901.png](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/631d8e8a44474fbe9a5d83fd0cace270~tplv-k3u1fbpfcp-watermark.awebp)

## 位移贴图（Displacement Maps）

Displacement Maps其实又与Bump Maps十分类似了，在第二章作者提到了，Bump Maps是逻辑上的高度改变，而Displacement Maps则是物理上的高度改变，二者的区别就在此处，可以通过物体阴影的边缘发现这点：![QQ截图20210813161005.png](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/b88775df566d431f92019d38c76987ba~tplv-k3u1fbpfcp-watermark.awebp)

## 环境光贴图（Environment Map）

环境光映射，顾名思义就是将环境光存储在一个贴图之上。想象这样一个情形，光照离我们的物体的距离十分遥远，因此对于物体上的各个点光照方向几乎没有区别，那么唯一的变量就是人眼所观察的方向了，因此各个方向的光源就可以用一个球体进行存储,即任意一个3D方向，都标志着一个texel，环境光贴图主要采取下面两钟映射方式

### 球形映射

对于一些复杂空间立体图形，通常使用球形贴图的方法将物体映射到球面上，再球面展开成长方形后，也可得到一一对应的关系。![QQ截图20210813142056.png](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/e67ec973743049d3b3d43cae8fde836e~tplv-k3u1fbpfcp-watermark.awebp)球形贴图映射的思路如下：

- 假设一个单位球包围了物体中心，当物体中心看向物体表面某个位置 (x,y,z) 时，从中心朝这个位置发出一条射线，此时射线会与单位球相交于某点。
- 根据射线与单位球体的交点坐标 (xo,yo,zo)，推算出交点所在的偏航角和俯仰角 (yaw,pitch)，然后来映射成在球形贴图对应的 (u,v)坐标点。

### 立方体映射

使用球形映射贴图展开成长方体后会在某些地方有扭曲现象， 因此可以使用立方体映射贴图，是指利用立方体将物体包裹起来，将球的信息储存在立方体上。![QQ截图20210813161455.png](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/92a4e950c953433ebaa6e8efe95e9792~tplv-k3u1fbpfcp-watermark.awebp)

## 阴影贴图（Shadow Mapping）

之前介绍的光照计算中是不包含阴影的，而阴影映射（Shadow Mapping）则是常见的实现阴影计算的手段。![QQ截图20210813162346.png](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/5eabb640d06943fea7c6c152fc444373~tplv-k3u1fbpfcp-watermark.awebp)阴影贴图基本原理如下所示（红线与人眼黑线交点即是阴影处）：![QQ截图20210813162737.png](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/c5c7ac80677343108bbca86300faddca~tplv-k3u1fbpfcp-watermark.awebp)

- 额外设置一个摄像机在光源位置，并且看向光照方向，并用一张贴图（称之为阴影贴图Shadow Map）来记录看到的像素深度（每个像素位置只记录所见最近深度，而不做Shading）来作为遮挡深度。
- 主摄像机(人眼)需要渲染每个像素时，通过光源摄像机的MVP变换，便能得到该像素点在光源摄像机屏幕空间中对应的位置(x′,y′,z′)；接着深度值 z 和阴影贴图（Shadow Map）用(x′,y′)采样得到的遮挡深度做深度比较,若深度 z大于对应遮挡深度（意味着该像素的光被遮挡），这时就可以对该像素降低明亮度。

> 以上只是Shadow Mapping的基本解决方案，实际上它仍然有很多不足的地方（例如noise问题、Soft Shadow问题），业界往往采用更加高级的Shadow Mapping解决方案（例如Bias、PCF、PCSS）。

# 参考

- [GAMES101-现代计算机图形学入门-闫令琪_哔哩哔哩_bilibili](https://link.juejin.cn/?target=https%3A%2F%2Fwww.bilibili.com%2Fvideo%2FBV1X7411F744%3Fp%3D10)
- [计算机图形学八：纹理映射的应用(法线贴图，凹凸贴图与阴影贴图等相关应用的原理详解) - 知乎 (zhihu.com)](https://link.juejin.cn/?target=https%3A%2F%2Fzhuanlan.zhihu.com%2Fp%2F144357517)
- [图形渲染基础（4）纹理（Texture） - KillerAery - 博客园 (cnblogs.com)](https://link.juejin.cn/?target=https%3A%2F%2Fwww.cnblogs.com%2FKillerAery%2Fp%2F15106770.html%23%E9%98%B4%E5%BD%B1%E6%98%A0%E5%B0%84%EF%BC%88shadow-mapping%EF%BC%89)

文章分类

代码人生

文章标签



计算机图形学

文章被以下专栏收录



计算机图形学

无









![img](https://p9-passport.byteacctimg.com/img/user-avatar/4ae866378ce0557e3b29fcac7d2adb74~300x300.image)

[半只小咸鱼 ![lv-1](https://lf3-cdn-tos.bytescm.com/obj/static/xitu_juejin_web/636691cd590f92898cfcda37357472b8.svg)](https://juejin.cn/user/2955958260612974)

[发布了 9 篇文章 · ](https://juejin.cn/user/2955958260612974/posts)获得点赞 13 · 获得阅读 2,461