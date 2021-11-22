# 图形学渲染基础（1）变换（Transformation）

# 模型变换（Modle Transformation）

模型变换：3D空间中的物体，通过伸缩、旋转和平移等操作来变化该物体大小及位置等信息，使其符合设计创造的需求。在实际的操作要求中，通常按照伸缩->旋转->平移的顺序进行，这样的操作顺序更方便矩阵的构建与计算的处理。

## 2D变换（2D transformations）

- 伸缩（Scale）

![QQ截图20210809130408.png](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/2d076dc8ce38449f827e4b69c82ec139~tplv-k3u1fbpfcp-watermark.awebp)

- 剪切（Shear）

![QQ图片20210809130814.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/e8f85c9c74d4474cbd9c7c2289878d02~tplv-k3u1fbpfcp-watermark.awebp)

- 旋转（Rotate）

![QQ截图20210809131348.png](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/0e7aa2ffb29a4d2c9c6bf6ac8dae7a84~tplv-k3u1fbpfcp-watermark.awebp)所有的旋转矩阵是正交矩阵，因此它的逆矩阵即为转置矩阵，几何上可以这样理解：一个向量饶原点逆时针旋转30度的转置便是顺时针旋转30度。

- 仿射（Affine）

![QQ截图20210809131732.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/21152faaa7ee4fa58d9a4c6b6a30f50a~tplv-k3u1fbpfcp-watermark.awebp)仿射变换=线性变化+平移操作，这里可以看出仿射操作并不是线性变换，因此引出了齐次坐标系的概念，让所有的变换操作都可以用一个矩阵表示。

## 齐次坐标系（Homogeneous Coordinates）

- 3Dpoint=(x,y,z,1)T ：齐次坐标的w分量为1时，该向量视为点(x,y,z)
- 3Dvector=(x,y,z,0)T ：齐次坐标的w分量为0时，该向量视为向量(x,y,z)
- 3Dpoint=(xw,yw,zw,w)T ：齐次坐标的w分量不为0时，该向量视为向量(xw/w,yw/w,zw/w)
- point - point =vector
- vector + vecotr =vector
- point + vetor = point
- point + point = mid point（中点）

在齐次坐标系下，可以将对向量的变换矩阵相乘表示：Acompose=A1A2A3...,并且仿射变换也可以用一个矩阵表示![QQ截图20210809134101.png](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/eaa21c5609274fa68c53be0eb0417d8c~tplv-k3u1fbpfcp-watermark.awebp)

## 3D变化（3D transformations）

- 伸缩（Scale）

![QQ截图20210809134741.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/607f99324c904b2fbd29fac5dbcfdc43~tplv-k3u1fbpfcp-watermark.awebp)

- 旋转（Rotate）

![QQ截图20210809134801.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/ac70e4de64454d6f984ec9186b8cc821~tplv-k3u1fbpfcp-watermark.awebp)

```
绕向量n旋转α弧度角，
R（n,α）：n为起点在原点的向量，α为旋转角度
I：单位矩阵
复制代码
```

- 平移（Translate）

![QQ截图20210809134749.png](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/09baaa46b61a4adea3933da64b0a6b91~tplv-k3u1fbpfcp-watermark.awebp)

# 摄像机变换（Camera Transformation）

世界空间坐标可经过视图变换得到观察空间坐标。视图变换可理解为将物体的世界坐标系位置（包括角度）转换成在摄像机坐标系的位置（包括角度），换句话说就是求物体相对于摄像机的位置（包括角度）。得到相对位置后就会更加容易的获得物体的深度关系方便后期的渲染。![1409576-20210304085657132-1232717643.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/1de4ff45f4a84bf890f4852a81ad2375~tplv-k3u1fbpfcp-watermark.awebp)我们只需要首先将相机平移到原坐标原点，然后进行旋转操作。对于这两个变换的矩阵求解我们可以利用逆矩阵，简化了大量操作。

# 投影变换（Projection Transformation）

观察空间的坐标通过投影变换得到裁剪空间（Clip Space）的坐标。投影变化则可理解成将3D空间中的坐标转换成在投影面上的坐标，即将三维空间上的东西投影在我们最终呈现画面的投影面。![QQ截图20210809150029.png](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/48faf1dda23d4771aad9320a551ca957~tplv-k3u1fbpfcp-watermark.awebp)

## 正交投影（Orthographic Projection）

正交投影可以理解成平行投影，可以将物体等大小投影到屏幕上，实际操作通常是将摄像机所照射的长方体映射到规范立方体上面，实际操作可简化为两个步骤：![QQ截图20210809152553.png](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/21fc80e2ff5a4ed780da04e40c94c14c~tplv-k3u1fbpfcp-watermark.awebp)

- 将长方体中心移动到原点
- 将长方体拉伸成规范立方体[-1,1]³

![QQ截图20210809152711.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/677bacb470ac45f78a9e1d7bb696922f~tplv-k3u1fbpfcp-watermark.awebp)其中l、r为视景体在x轴上的最大值、最小值，t、b为在y轴上的最大值、最小值，f、n为在z轴上的最大最小值

## 透视投影（Perspective Projection）

投射投影符合现实人眼的投影方式，典型特征就是近大远小，大部分3D游戏使用的都是透视投影方式。透视投影的实际操作也只有两个步骤![QQ截图20210809153107.png](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/f131323ae19344c9979f0b11dc97c19f~tplv-k3u1fbpfcp-watermark.awebp)

- 将截锥体压缩成长方体
- 进行正交投影

![QQ截图20210809153502.png](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/e784969774c94a55a6b3d8e0903e3163~tplv-k3u1fbpfcp-watermark.awebp)可以根据三角形相似原理以及远近面z值不变，得到变换矩阵![QQ图片20210809153655.png](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/ae0e3b9708364838a814fcb188705c43~tplv-k3u1fbpfcp-watermark.awebp)由于上述的正交变换矩阵是已知的，Mpersep=MorthoMpersp−>ortho，最终的透视变换矩阵如下![QQ截图20210809153858.png](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/0ff6a32068bb47e1836dc2f5cf4ffb68~tplv-k3u1fbpfcp-watermark.awebp)

# 视口变换（viewport transformation）

视口变换负责把裁剪空间上的坐标（范围[-1,1]，范围[-1,1]）映射到屏幕坐标（范围[0,width]，范围[0,height]），这就需要先定义屏幕分辨率的大小（例如：width=1200，height=1080）

```
裁剪空间坐标的x和y也被称为 标准化设备坐标（NDC）
这是因为其值范围均为[-1,1]，可以消除对屏幕纵横比的依赖，之后只需要通过视口变换便可以拉伸到合适的屏幕分辨率
复制代码
```

![QQ截图20210809154339.png](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/7214f5662b0649688253aca23c39178f~tplv-k3u1fbpfcp-watermark.awebp)

# 总结

```
MVP变换： 
    模型变换（Model Transformation）：模型空间坐标->世界空间坐标 
    摄像机变换（Camera Transformation）：世界空间坐标->观察空间坐标 
    投影变换（Projection Transformation）：观察空间坐标->裁剪空间坐标 
视口变换（Viewport Transformation）：裁剪空间坐标->屏幕空间坐标 
V′=Mviewport * Mpersepctive * Mview * Mmodel * V
有了以上变换之后，我们可以任意将一个3D模型坐标映射在最终呈现画面的屏幕上，即得到屏幕空间坐标。
复制代码
```

# 参考

- [图形渲染基础（1）变换（Transformation） - KillerAery - 博客园 (cnblogs.com)](https://link.juejin.cn/?target=https%3A%2F%2Fwww.cnblogs.com%2FKillerAery%2Fp%2F14494430.html)
- [计算机图形学二：视图变换(坐标系转化，正交投影，透视投影，视口变换) - 知乎 (zhihu.com)](https://link.juejin.cn/?target=https%3A%2F%2Fzhuanlan.zhihu.com%2Fp%2F144329075)
- [GAMES101-现代计算机图形学入门-闫令琪_哔哩哔哩_bilibili](https://link.juejin.cn/?target=https%3A%2F%2Fwww.bilibili.com%2Fvideo%2FBV1X7411F744)

文章分类

代码人生

文章标签



计算机图形学

文章被以下专栏收录



计算机图形学

无









![img](https://p9-passport.byteacctimg.com/img/user-avatar/4ae866378ce0557e3b29fcac7d2adb74~300x300.image)

[半只小咸鱼 ![lv-1](https://lf3-cdn-tos.bytescm.com/obj/static/xitu_juejin_web/636691cd590f92898cfcda37357472b8.svg)](https://juejin.cn/user/2955958260612974)

[发布了 9 篇文章 · ](https://juejin.cn/user/2955958260612974/posts)获得点赞 13 · 获得阅读 2,459




  