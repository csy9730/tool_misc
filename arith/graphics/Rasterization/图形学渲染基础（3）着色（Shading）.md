# 图形学渲染基础（3）着色（Shading）

# 简介

到了这一部分，我们就开始进入到着色（shading）的环节了，简单来说shading就是计算出每个采样像素点的颜色是多少并将结果储存起来（光栅化只是填充像素格，换句话来说是着色之后负责转移颜色到屏幕上的操作）着色计算要考虑的因素通常有：光照、着色频率、纹理。

# 局部光照模型

初中物理知识告诉我们，人们之所以能够看到物体，是由于人眼接收到了从物体表面反射过来的光线。那么为什么一个物体能够有颜色，其实就是它吸收了一定颜色的光，将剩下的光反射出来，也就有了颜色。这其实也就是局部光照模型的基础，可以具体看看究竟有几种类型光线能从物体到人眼呢？![QQ截图20210810193928.png](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/1b0dd4fc050f4b35bad16af63e51371e~tplv-k3u1fbpfcp-watermark.awebp)如上图所示可以先将光线简单的分为3类：环境光（Ambient Lighting）、漫反射（Diffuse reflection）、镜面反射（Specular highlights）。因此也引出了三种简单的光照模型.

## 泛光模型

泛光模型即只考虑环境光，这是最简单的经验模型，只会去考虑环境光的影响，并且不会去精确的描述，而只是用一个简单的式子表示![img](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/841ef9fc03284ca79fcb51403966337e~tplv-k3u1fbpfcp-watermark.awebp)

- Ienv存储结果
- Ka代表物体表面对环境光的反射率
- Ia代表入射环境光的亮度

由于反光模型并没有入射光和反射光的方向等因素，因此物体只会呈现一个2D图形的效果，没有丝毫的体积感，如下图所示。![QQ截图20210810195335.png](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/31cbbc4586154684a54ed666c75070d9~tplv-k3u1fbpfcp-watermark.awebp)那怎么能够有体积感呢，这就要添加漫反射了，即Lambert漫反射模型。

## Lambert漫反射模型

Lambert漫反射模型其实就是在泛光模型的基础之上增加了漫反射项。漫反射便是光从一定角度入射之后从入射点向四面八方均匀反射，且每个不同方向反射的光的强度相等，而产生漫反射的原因是物体表面的粗糙，导致了这种物理现象的发生。![QQ截图20210810200238.png](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/97b8924484c44660b222fd3787ba5cf0~tplv-k3u1fbpfcp-watermark.awebp)对于漫反射而言，由于默认反射出的光线方向均匀强度相同，因此只需考虑考虑物体表面真正接受多少能量。![QQ截图20210810200659.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/89a5814a9f064cc188a9bb3b3985c14d~tplv-k3u1fbpfcp-watermark.awebp)

- Kd: 漫反射系数（记录颜色）
- I/r2: 能量的衰减（能量和与光源距离的平方成反比）
- n·l：入射光线与着色表面法线的点乘（根据朗伯余弦定律**Lambert’s cosine law**所言，当光源照射方向与表面法线夹角越小，物体表面接受的光的能量就会越多）
- max（0，n·l）：避免夹角为负数（0意味着摄像机看不到着色点）

> 如果要给物体加默认纹理颜色，影响的是kd

## Phong反射模型

Phong模型就是在Lambert反射模型上加入了高光，高光现象的产生实际上就是人眼所观察的方向与镜面反射出的光线方向很接近，因此会要考虑反射方向R与观察方向V的夹角α。![QQ截图20210810202132.png](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/080fc27ecb9644a5a186bc47cd0f8ef0~tplv-k3u1fbpfcp-watermark.awebp)![img](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/8daba5b3a1144ce1b9bf3d972f7a83fc~tplv-k3u1fbpfcp-watermark.awebp)这里只需要注意指数p，添加该项的原因很直接，因为离反射光越远就越不应该看见反射光，需要一个指数p加速衰减。

## Blinn-Phong 光照模型

Blinn-Phong光照模型仅仅是对Phong模型进行计算上的优化。Blinn-Phong假设，一个半程向量（观测方向v和入射方向l的中间方向）与表面法线的角度α，近似等于观测方向v与反射方向R的夹角（因为V接近R等价于h接近n，而且偏差也可以通过系数调整）![QQ截图20210810205227.png](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/e93a92fdd5054e5d860d9c892c4cad5d~tplv-k3u1fbpfcp-watermark.awebp)这样的得到的结果其实是与真实计算反射与人眼观察夹角的结果是非常近似的(具体来说该角度是正确角度的一半)，但好处在于大大加速了角度计算的速度，提升了效率！

# 着色频率

在上文中我们讲解完了局部光照模型，其中主要利用了观察方向，入射光线与法线向量的位置关系，但并没有具体说究竟是三角形面的法线向量还是三角形顶点的法线向量，这也就牵扯出了本章内容——着色频率（面着色，顶点着色，像素着色），这3种不同的着色频率其实也就对应了三种不同方法。接下来一一介绍

## 基于面的着色（Flat shading）

面着色，顾名思义以每一个面作为一个着色单位。模型数据大多以很多个三角面进行存储，因此也就记录了每个面的法线向量，利用每个面的法线向量进行一次Blinn-Phong反射光照模型的计算，将该颜色赋予整个面，效果如下：![QQ截图20210811114451.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/daceb2a0597d4333a51948aeef31ea21~tplv-k3u1fbpfcp-watermark.awebp)面着色计算量小，可由多边形两边叉乘得出法向量，但是明显看出面与面之间过渡不流畅，每个面得到的都是同一种颜色。

## 基于顶点的着色（Gouraud shading）

对每个顶点进行一次着色计算，然后三角形内部像素点则通过在三角形的重心坐标插值（Barycentric Interpolation）得到颜色。计算多边形顶点的法线向量,是将所有共享这个点的面的法线向量加起来求均值，最后再标准化就得到了该顶点的法线向量了。![QQ截图20210811115043.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/7a7e362ac3aa49bb9566b669e3afe4c8~tplv-k3u1fbpfcp-watermark.awebp)重心坐标公式如下：![QQ截图20210811115136.png](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/bccbcc68178f4d86807b89a21ed6ac76~tplv-k3u1fbpfcp-watermark.awebp)c0,c1,c2为三个顶点的颜色，α，β，γ是三角形内某点的重心坐标。

> 重心坐标的通常是取原来世界坐标系下的重心坐标，但是在实际处理中通常取屏幕坐标系下的重心坐标，再通过误差校正得到。

## 基于像素的着色（Phong shading）

![QQ截图20210811115748.png](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/bde4df2b24074bb795e9c233d57c1e09~tplv-k3u1fbpfcp-watermark.awebp)使用重心坐标通过顶点法向量得到每个像素的法向量，不过计算量较大，不过效果图明显比顶点着色平滑了不少。![QQ截图20210811115931.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/5ff284e2bf9547ac847187bbb68a9921~tplv-k3u1fbpfcp-watermark.awebp)

# 渲染管线总结

所谓图形渲染管线指的是一系列操作的流程，这个流程具体来说就是将一堆具有三维几何信息的数据点最终转换到二维屏幕空间的像素。其实也就是本系列笔记之前的所有知识连贯起来。我们以如下图作为一个总结，再具体分步骤讲解：![QQ截图20210811121035.png](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/e3dbb5dc17f14fc8be3c6339f70ec565~tplv-k3u1fbpfcp-watermark.awebp)

> - 顶点处理（Vertex Processing）：将世界坐标系下未超出观察空间的顶点进行MVP变化，最终得到投影到二维平面的坐标信息(同时为了Zbuffer保留深度z值)。
> - 三角形处理（Triangle Processing）：将复杂的几何图形划分为一个个三角形，更便于后续的处理。
> - 光栅化（Rasterization）:光栅化此时做的工作只是确定哪些在三角形内的点可以被显示。
> - 片元处理（Fragment Processing）：片元处理是真正给像素点上色的环节，考虑的因素也较多：深度值、着色频率、抗锯齿方法、纹理映射（纹理可代替用光照模型所得到的颜色信息）等等。
> - 帧缓存（Framebuffer Operation）：Framebuffer的处理，就是将所有的像素颜色信息整合在一起，输送给显示设备加以显示。这也就完成了整个图形渲染管线了。

# 参考

- [GAMES101-现代计算机图形学入门-闫令琪_哔哩哔哩_bilibili](https://link.juejin.cn/?target=https%3A%2F%2Fwww.bilibili.com%2Fvideo%2FBV1X7411F744%3Ffrom%3Dsearch%26seid%3D213581913167171352)
- [计算机图形学五：局部光照模型(Blinn-Phong 反射模型)与着色方法 - 知乎 (zhihu.com)](https://link.juejin.cn/?target=https%3A%2F%2Fzhuanlan.zhihu.com%2Fp%2F144331612)
- [图形渲染基础（3）着色（Shading） - KillerAery - 博客园 (cnblogs.com)](https://link.juejin.cn/?target=https%3A%2F%2Fwww.cnblogs.com%2FKillerAery%2Fp%2F14520670.html)