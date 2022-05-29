# LaTeX：导数相关符号

![img](https://upload.jianshu.io/users/upload_avatars/13795760/5803fbd0-7263-49db-964e-da97b2742fbd.jpg?imageMogr2/auto-orient/strip|imageView2/1/w/96/h/96/format/webp)

[胜负55开](https://www.jianshu.com/u/6f36f0c99dac)关注

0.9192019.04.23 12:22:40字数 119阅读 69,361

日常编写公式用到太多各类导数符号了！必须要总结在这里：

**（1）偏导符号：\partial x**

```latex
$ \frac{\partial f}{\partial x} $  # 一阶
$ \frac{\partial ^{n} f}{\partial x^{n}} $  # n阶
```

效果：![\frac{\partial f}{\partial x}](https://math.jianshu.com/math?formula=%5Cfrac%7B%5Cpartial%20f%7D%7B%5Cpartial%20x%7D) 和 ![\frac{\partial ^{n} f}{\partial x^{n}}](https://math.jianshu.com/math?formula=%5Cfrac%7B%5Cpartial%20%5E%7Bn%7D%20f%7D%7B%5Cpartial%20x%5E%7Bn%7D%7D)

**（2）求导符号：\mathrm{d} x**

```latex
$ \frac{\mathrm{d} y }{\mathrm{d} x} $  # 一阶
$ \frac{\mathrm{d}^{n} y }{\mathrm{d} x^{n}} $  # n阶
```

效果：![\frac{\mathrm{d} y }{\mathrm{d} x}](https://math.jianshu.com/math?formula=%5Cfrac%7B%5Cmathrm%7Bd%7D%20y%20%7D%7B%5Cmathrm%7Bd%7D%20x%7D) 和 ![\frac{\mathrm{d}^{n} y }{\mathrm{d} x^{n}}](https://math.jianshu.com/math?formula=%5Cfrac%7B%5Cmathrm%7Bd%7D%5E%7Bn%7D%20y%20%7D%7B%5Cmathrm%7Bd%7D%20x%5E%7Bn%7D%7D)

**（3）撇形式的求导符号：x^{'}**

```latex
$ \frac{ y^{'} }{ x^{'} } $
```

效果：![\frac{ y^{'} }{ x^{'} }](https://math.jianshu.com/math?formula=%5Cfrac%7B%20y%5E%7B%27%7D%20%7D%7B%20x%5E%7B%27%7D%20%7D)

**（4）点形式的求导符号：\dot x 和 \ddot y**

```latex
$ \frac{ \dot y }{ \dot x } $  # 一个点
$ \frac{ \ddot y }{ \ddot x } $  # 两个点
$ $ \frac{ \dddot y }{ \dddot x } $  # 几个点就是几个d
```

效果：![\frac{ \dot y }{ \dot x }](https://math.jianshu.com/math?formula=%5Cfrac%7B%20%5Cdot%20y%20%7D%7B%20%5Cdot%20x%20%7D) 和 ![\frac{ \ddot y }{ \ddot x }](https://math.jianshu.com/math?formula=%5Cfrac%7B%20%5Cddot%20y%20%7D%7B%20%5Cddot%20x%20%7D) 和 ![\frac{ \dddot y }{ \dddot x }](https://math.jianshu.com/math?formula=%5Cfrac%7B%20%5Cdddot%20y%20%7D%7B%20%5Cdddot%20x%20%7D)

**（5）全微分算子：\nabla f**

```latex
$ \nabla f $
```

效果：![\nabla f](https://math.jianshu.com/math?formula=%5Cnabla%20f)

------

[这篇博客不错，将符号按用法分类！](https://links.jianshu.com/go?to=https%3A%2F%2Fblog.csdn.net%2Fgsww404%2Farticle%2Fdetails%2F78684278%3Ffps%3D1%26locationNum%3D9)