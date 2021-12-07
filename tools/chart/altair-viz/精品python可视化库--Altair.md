# 精品python可视化库--Altair

[![pythonic生物人](https://pic3.zhimg.com/v2-0192e9950779a8451c258efa54aaf3b6_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/mo-cun-34-45)

[pythonic生物人](https://www.zhihu.com/people/mo-cun-34-45)







33 人赞同了该文章

**往期精彩**：[NGS精进](https://link.zhihu.com/?target=https%3A//mp.weixin.qq.com/mp/appmsgalbum%3Faction%3Dgetalbum%26album_id%3D1387765915319877633%26__biz%3DMzUwOTg0MjczNw%3D%3D%23wechat_redirect)|[统计精进](https://link.zhihu.com/?target=https%3A//mp.weixin.qq.com/mp/appmsgalbum%3F__biz%3DMzUwOTg0MjczNw%3D%3D%26action%3Dgetalbum%26album_id%3D1657541931360370693%23wechat_redirect%26__biz%3DMzUwOTg0MjczNw%3D%3D%23wechat_redirect)|[py基础](https://link.zhihu.com/?target=https%3A//mp.weixin.qq.com/s%3F__biz%3DMzUwOTg0MjczNw%3D%3D%26mid%3D2247488856%26idx%3D1%26sn%3Da31c4f39fc894e6e83cea85efe065fb0%26chksm%3Df90d5106ce7ad8108859c0bff2c54f1b2959ed214cc94ab5beb909b7792748f50e7171fa95fd%26token%3D1852742721%26lang%3Dzh_CN%26scene%3D21%23wechat_redirect)|[py绘图](https://link.zhihu.com/?target=https%3A//mp.weixin.qq.com/s%3F__biz%3DMzUwOTg0MjczNw%3D%3D%26mid%3D2247489108%26idx%3D1%26sn%3D096ec8d8de084197f81268dfeee69361%26chksm%3Df90d520ace7adb1c4a7c13ec0f3da86ccdb88cb5301e4efea4f167c51b48e57b2718aeac78e5%26token%3D1852742721%26lang%3Dzh_CN%26scene%3D21%23wechat_redirect)|[perl基础](https://link.zhihu.com/?target=https%3A//mp.weixin.qq.com/s%3F__biz%3DMzUwOTg0MjczNw%3D%3D%26mid%3D2247488894%26idx%3D1%26sn%3Dd3380ca0f2c3b9567055adae0d59c799%26chksm%3Df90d5120ce7ad8364141b6032880a5131b76d0e0ee1eaac36ee786776afb4fcd9142051da622%26token%3D1852742721%26lang%3Dzh_CN%26scene%3D21%23wechat_redirect)|[R绘图](https://link.zhihu.com/?target=https%3A//mp.weixin.qq.com/s%3F__biz%3DMzUwOTg0MjczNw%3D%3D%26mid%3D2247488834%26idx%3D1%26sn%3D1ed7d57d512e0a6ce39d79a50a682d63%26chksm%3Df90d511cce7ad80a8f760b85e2e9c60068605fbf1ebda0d2adaa946efe428e25e8e53d69fbad%26token%3D1852742721%26lang%3Dzh_CN%26scene%3D21%23wechat_redirect)

------

> 本文再分享一个python交互式可视化工具**「Altair」**，Altair的底层是Vega-Lite （基于一种简洁的**「交互式」**可视化语法，A Grammar of **「Interactive」** Graphics），效果例如：

![img](https://pic3.zhimg.com/v2-fdfa73d07de5a1b810f8aeb04e2b1fa2_b.jpg)



- Altair的作者为**「Jake Vanderplas」**，是一个大佬，之前是[华盛顿大学 eScience 学院](https://www.zhihu.com/search?q=华盛顿大学+eScience+学院&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A360173300})物理科学研究院院长，现为Google的Software Engineer，热衷于Python, Astronomy和Data Science；同时是一位活跃的开源爱好者，历年的 PyData会议都能见到他的talk，除了Altair外，为Scikit-Learn、Scipy、 Matplotlib、IPython 等著名 Python 程序库做了大量贡献；著有两本高stars书籍[Python Data Science Handbook](https://link.zhihu.com/?target=https%3A//mp.weixin.qq.com/s%3F__biz%3DMzUwOTg0MjczNw%3D%3D%26mid%3D2247486870%26idx%3D1%26sn%3D2a492f9b9e11c3b7a936c29f877effcb%26chksm%3Df90d49c8ce7ac0de9e35750421831efd5666dbb7b20c3ef56d0ce86012982f51b5d6abc406a6%26scene%3D178%26cur_album_id%3D1429956252289024000%23rd)和**「A Whirlwind Tour of Python」** 。

![img](https://pic2.zhimg.com/80/v2-900e8fbbeee74ab75a4ad94c97a46069_1440w.jpg)



- 之前介绍的python交互式工具还有[pygal](https://link.zhihu.com/?target=https%3A//mp.weixin.qq.com/s%3F__biz%3DMzUwOTg0MjczNw%3D%3D%26mid%3D2247486832%26idx%3D1%26sn%3Da0d695b4399afeb687cbd3cf5e98c659%26chksm%3Df90d492ece7ac038abcd8b7a45486ae3b3a6ebd27c98af8aa2feaea91cd25814884c5659c271%26scene%3D178%26cur_album_id%3D1393733503522783232%23rd)，[cufflinks](https://link.zhihu.com/?target=https%3A//mp.weixin.qq.com/s%3F__biz%3DMzUwOTg0MjczNw%3D%3D%26mid%3D2247491790%26idx%3D1%26sn%3D9852f1c966c64a1a14420e32fe10e6a6%26chksm%3Df90ea490ce792d86d9e0d7de72c35a7da51b7d7164eb9a0b7beafc2190e025daa0ab98839b60%26token%3D1107703822%26lang%3Dzh_CN%23rd)。

## **本文目录**

```python3
1、Altair基础图形快速入门

  pip安装altair 

  Altair一步一步绘图

  python的Altair脚本转化为JSON

2、Altair复杂图形快速入门

  configure_*()方法个性化图像属性

  selection、condition、binding使得altair图形能和鼠标更好交互

  Layer, HConcat, VConcat, Repeat, Facet助力altair轻松构建复合图形

  Chart.resolve_scale(), Chart.resolve_axis(), and Chart.resolve_legend()个性化复合图形

3、基于Altair的demo分享

  官网关于天气的一个案例

  官网：https://altair-viz.github.io/index.html 
```

------

## **1、Altair基础图形快速入门**

这个小结介绍如何快速的绘制常见的基础图，如“bar”, “circle”, “square”, “tick”, “line”, “area”, “point”, “rule”, “geoshape”, and “text”等。

## **pip安装altair**

```text
pip install altair vega_datasets -i https://pypi.tuna.tsinghua.edu.cn/simple#国内源加速安装
```

## **Altair一步一步绘图**

- 数据准备

依旧使用鸢尾花iris数据集，数据集介绍见：[Python可视化|matplotlib10-绘制散点图scatter](https://link.zhihu.com/?target=https%3A//mp.weixin.qq.com/s%3F__biz%3DMzUwOTg0MjczNw%3D%3D%26mid%3D2247484528%26idx%3D2%26sn%3D48cfeb144ee621ecbbe07a81d0fab220%26chksm%3Df90d402ece7ac93812f70a97e7374e555d38077dfe1fbb9a0506d17133c6aea891ce54a67e91%26scene%3D21%23wechat_redirect)

```text
import seaborn as sns
pd_iris = sns.load_dataset("iris")
pd_iris.head(n=5)
```

![img](https://pic1.zhimg.com/80/v2-b3215894977cd8240122e37992d86cac_1440w.jpg)

- 快速绘图

```text
#快速绘图
import altair as alt
import pandas as pd

alt.Chart(pd_iris).mark_point().encode(x='sepal_length',
                                       y='sepal_width',
                                       color='species')
```

![img](https://pic4.zhimg.com/80/v2-06755dbd27ebc29e28f0a097f369a78f_1440w.jpg)

- 绘图步骤拆分

由上一步代码可知，Altair绘图主要用到**「Chart()方法」**、**「mark_\*()方法」**、和**「encode()方法」**。
**「Chart()方法」**将数据转化为altair.vegalite.v4.api.Chart
对象括号内可设置图像的高度、宽度、背景色等等，详细见：[https://altair-viz.github.io/user_guide/generated/toplevel/altair.Chart.html?highlight=chart](https://link.zhihu.com/?target=https%3A//altair-viz.github.io/user_guide/generated/toplevel/altair.Chart.html%3Fhighlight%3Dchart)

![img](https://pic3.zhimg.com/80/v2-20ac62a8d67721ab9e5a3627f5db64aa_1440w.jpg)

**「mark_\*()方法」**指定要展示的图形，例如绘制散点图mark_point()

![img](https://pic1.zhimg.com/80/v2-59c9ccef3dae747c8ede5e47f7786afc_1440w.jpg)

**「mark_\*()方法」**设置图形属性，如颜色color、大小size等括号内可设置待展示图形的各种属性，以mark_point()设置点颜色为例如下。

![img](https://pic4.zhimg.com/80/v2-56e76968212db2542ed785a00ea0f2ef_1440w.jpg)

其它详细参数见：[https://altair-viz.github.io/user_guide/generated/toplevel/altair.Chart.html?highlight=mark_point#altair.Chart.mark_point](https://link.zhihu.com/?target=https%3A//altair-viz.github.io/user_guide/generated/toplevel/altair.Chart.html%3Fhighlight%3Dmark_point%23altair.Chart.mark_point)

![img](https://pic4.zhimg.com/80/v2-7cc1f977eaa95e8881652ffd995ff56f_1440w.jpg)

**「encode()方法」**设置坐标轴的映射

![img](https://pic1.zhimg.com/80/v2-8350f4fab2e73560ecb9a1b81cdaeb98_1440w.jpg)

详细参数：[https://altair-viz.github.io/user_guide/generated/toplevel/altair.Chart.html?highlight=encode#altair.Chart.encode](https://link.zhihu.com/?target=https%3A//altair-viz.github.io/user_guide/generated/toplevel/altair.Chart.html%3Fhighlight%3Dencode%23altair.Chart.encode)

![img](https://pic4.zhimg.com/80/v2-2169a8356cee69a02d6849df52514a1b_1440w.jpg)



## **「python的Altair脚本转化为JSON」**

python脚本

```text
import altair as alt
import pandas as pd

data = pd.DataFrame({'x': ['A', 'B', 'C', 'D'], 'y': [1, 2, 1, 2]})
alt.Chart(data).mark_bar().encode(
    x='x',
    y='y',
)
```



![img](https://pic3.zhimg.com/80/v2-65becf7417b2ee63dbdf2b42abfd482e_1440w.png)

json脚本点击即可获取

![img](https://pic2.zhimg.com/80/v2-ca04d0be3698fad98e1bf1f240f8d735_1440w.jpg)



```text
{
  "config": {"view": {"continuousWidth": 400, "continuousHeight": 300}},
  "data": {"name": "data-39e740acccd9d827d4364cdbd6d37176"},
  "mark": "bar",
  "encoding": {
    "x": {"type": "nominal", "field": "x"},
    "y": {"type": "quantitative", "field": "y"}
  },
  "$schema": "https://vega.github.io/schema/vega-lite/v4.8.1.json",
  "datasets": {
    "data-39e740acccd9d827d4364cdbd6d37176": [
      {"x": "A", "y": 1},
      {"x": "B", "y": 2},
      {"x": "C", "y": 1},
      {"x": "D", "y": 2}
    ]
  }
}
```

------

## **2、Altair复杂图形快速入门**

这一节简单介绍更复杂的图形，如个性化分面图标题、图例、会用到**「configure_\*()方法」**、**「selection()方法」**、**「condition()方法」**、**「binding_\*()方法」**、

## **configure_\*()方法个性化图像属性**

**「configure_header()方法」**个性化header

```text
import altair as alt
from vega_datasets import data#vega_datasets为altair的一个内置数据集模块

source = data.cars.url

chart = alt.Chart(source).mark_point().encode(x='Horsepower:Q',
                                              y='Miles_per_Gallon:Q',
                                              color='Origin:N',
                                              column='Origin:N').properties(
                                                  width=180, height=180)
chart.configure_header(titleColor='green',
                       titleFontSize=14,
                       labelColor='red',
                       labelFontSize=14)
```



![img](https://pic3.zhimg.com/80/v2-f3f0a188ce22375498f2971723c4d48e_1440w.jpg)

**「configure_legend()方法」**个性化图例

```text
import altair as alt
from vega_datasets import data

source = data.cars.url

chart = alt.Chart(source).mark_point().encode(x='Horsepower:Q',
                                              y='Miles_per_Gallon:Q',
                                              color='Origin:N')

chart.configure_legend(strokeColor='gray',
                       fillColor='#EEEEEE',
                       padding=10,
                       cornerRadius=10,
                       orient='top-right')
```



![img](https://pic2.zhimg.com/80/v2-af58ff35da0980301d86bd30043ba9a5_1440w.jpg)

更多**「configure类方法」**介绍见：[https://altair-viz.github.io/user_guide/configuration.html](https://link.zhihu.com/?target=https%3A//altair-viz.github.io/user_guide/configuration.html)

## **selection、condition、binding使得altair图形能和鼠标更好交互**

这里主要用到**「selection()、condition()、binding()方法」**，简单介绍，详细见：[https://altair-viz.github.io/user_guide/interactions.html](https://link.zhihu.com/?target=https%3A//altair-viz.github.io/user_guide/interactions.html)

- selection()方法

鼠标可以轻捕捉图形某一部分。

![img](https://pic4.zhimg.com/80/v2-281de9eaa66ff89d94722fb08431b24b_1440w.jpg)



- condition()方法

让鼠标捕捉的部分高亮，未捕捉的部分暗淡。

![img](https://pic2.zhimg.com/80/v2-f63ee8b3c96520869d749eac48dba189_1440w.jpg)



- binding_*()方法

效果如下：

![img](https://pic3.zhimg.com/v2-fdfa73d07de5a1b810f8aeb04e2b1fa2_b.jpg)



## **Layer, HConcat, VConcat, Repeat, Facet助力altair轻松构建复合图形**

![img](https://pic1.zhimg.com/80/v2-220416f8c7aff243c1f7879d97b4aa98_1440w.jpg)

- hconcat水平方向拼图

```text
import altair as alt
from vega_datasets import data

iris = data.iris.url

chart1 = alt.Chart(iris).mark_point().encode(x='petalLength:Q',
                                             y='petalWidth:Q',
                                             color='species:N').properties(
                                                 height=300, width=300)

chart2 = alt.Chart(iris).mark_bar().encode(x='count()',
                                           y=alt.Y('petalWidth:Q',
                                                   bin=alt.Bin(maxbins=30)),
                                           color='species:N').properties(
                                               height=300, width=100)

chart1 | chart2
```

![img](https://pic3.zhimg.com/80/v2-5e2fa31209f97ca0d38c10ec2b41e1fe_1440w.jpg)

```text
alt.hconcat(chart1, chart2)
```

![img](https://pic3.zhimg.com/80/v2-5e2fa31209f97ca0d38c10ec2b41e1fe_1440w.jpg)

- vconcat垂直方向拼图

![img](https://pic1.zhimg.com/80/v2-207100f3d331968bdb3b896f8862b5b4_1440w.jpg)

- LayerChart图层叠加



![img](https://pic1.zhimg.com/80/v2-31d778fd36579f3f18b4eed778871458_1440w.jpg)

![img](https://pic3.zhimg.com/80/v2-8a9d692200c5c396997aed26ba94a9be_1440w.jpg)



- RepeatChart绘制类似图形

```text
from vega_datasets import data

iris = data.iris.url

base = alt.Chart().mark_point().encode(color='species:N').properties(
    width=200, height=200).interactive()

chart = alt.vconcat(data=iris)
for y_encoding in ['petalLength:Q', 'petalWidth:Q']:
    row = alt.hconcat()
    for x_encoding in ['sepalLength:Q', 'sepalWidth:Q']:
        row |= base.encode(x=x_encoding, y=y_encoding)
    chart &= row
chart
```

![img](https://pic3.zhimg.com/80/v2-c56cc3be85cb0898c850adbec0575bda_1440w.jpg)

- FacetChart[图形分面](https://www.zhihu.com/search?q=图形分面&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A360173300})

```text
import altair as alt
from altair.expr import datum
from vega_datasets import data

iris = data.iris.url

base = alt.Chart(iris).mark_point().encode(x='petalLength:Q',
                                           y='petalWidth:Q',
                                           color='species:N').properties(
                                               width=160, height=160)

chart = alt.hconcat()
for species in ['setosa', 'versicolor', 'virginica']:
    chart |= base.transform_filter(datum.species == species)
chart
```

![img](https://pic3.zhimg.com/80/v2-16afdc3c1445fb4caf438a94bde645ba_1440w.jpg)

## **Chart.resolve_scale(), Chart.resolve_axis(), and Chart.resolve_legend()个性化复合图形**

例如，使用**resolve_scale()**分别给两个图使用颜色盘。

```text
from vega_datasets import data

source = data.cars()

base = alt.Chart(source).mark_point().encode(
    x='Horsepower:Q', y='Miles_per_Gallon:Q').properties(width=200, height=200)

alt.concat(base.encode(color='Origin:N'),
           base.encode(color='Cylinders:O')).resolve_scale(color='independent')
```

![img](https://pic1.zhimg.com/80/v2-87a6280167d344b9948333c11eada7c4_1440w.jpg)

## **3、基于Altair的demo分享**

## **官网关与天气的一个案例**

```text
from vega_datasets import data

df = data.seattle_weather()
scale = alt.Scale(
    domain=['sun', 'fog', 'drizzle', 'rain', 'snow'],
    range=['#e7ba52', '#c7c7c7', '#aec7e8', '#1f77b4', '#9467bd'])
brush = alt.selection(type='interval')
points = alt.Chart().mark_point().encode(
    alt.X('temp_max:Q', title='Maximum Daily Temperature (C)'),
    alt.Y('temp_range:Q', title='Daily Temperature Range (C)'),
    color=alt.condition(brush,
                        'weather:N',
                        alt.value('lightgray'),
                        scale=scale),
    size=alt.Size('precipitation:Q',
                  scale=alt.Scale(range=[1, 200]))).transform_calculate(
                      "temp_range",
                      "datum.temp_max - datum.temp_min").properties(
                          width=600, height=400).add_selection(brush)

bars = alt.Chart().mark_bar().encode(
    x='count()',
    y='weather:N',
    color=alt.Color('weather:N', scale=scale),
).transform_calculate(
    "temp_range",
    "datum.temp_max - datum.temp_min").transform_filter(brush).properties(
        width=600)

alt.vconcat(points, bars, data=df)
```



![img](https://pic4.zhimg.com/80/v2-ccd5eb561459e7cfd66b7d1f3309603f_1440w.jpg)

其他的案例见官网，不再过多搬运：

## **官网：https://altair-viz.github.io/index.html**

- 简单图

![img](https://pic2.zhimg.com/80/v2-41a4981ae1f600f23e9aecc2de9a46d1_1440w.jpg)

- bar图



![img](https://pic1.zhimg.com/80/v2-4402c1d16e923fec40e7c659e898f9fc_1440w.jpg)

![img](https://pic1.zhimg.com/80/v2-2ae541b16fdbbbc3f8ace0ced0e6e540_1440w.jpg)



- line图

![img](https://pic4.zhimg.com/80/v2-fbb05ac0d2d5c82abd71d7af0701939f_1440w.jpg)

- area图

![img](https://pic4.zhimg.com/80/v2-b7a7c7bf8a873d0fa9106b86927b466b_1440w.jpg)

- scatter图

![img](https://pic4.zhimg.com/80/v2-ad41f4c624a795ccf03662b99b0033f7_1440w.jpg)

- histgogram图

![img](https://pic4.zhimg.com/80/v2-3bfc3e912c12e5d82dc55686d544fc8b_1440w.jpg)

- map图

![img](https://pic3.zhimg.com/80/v2-409428a2ea582e7054617b55238eba6a_1440w.jpg)

- Interactive图

![img](https://pic4.zhimg.com/80/v2-be1c2c02e589c0bc6b378ca749ae9fdb_1440w.jpg)

- Case Studies



![img](https://pic4.zhimg.com/80/v2-390d43fb7b9f8c5096ef240c292ef5cf_1440w.jpg)

![img](https://pic3.zhimg.com/80/v2-56e15921525a55d2a230f6809bc9f196_1440w.jpg)



- Other Charts



![img](https://pic2.zhimg.com/80/v2-dcc61ae1f6d98a0d1cb7d96d26a70cd9_1440w.jpg)

![img](https://pic2.zhimg.com/80/v2-c07cb0979ae741f0d26749200f2228b9_1440w.png)

**往期精彩**：[NGS精进](https://link.zhihu.com/?target=https%3A//mp.weixin.qq.com/mp/appmsgalbum%3Faction%3Dgetalbum%26album_id%3D1387765915319877633%26__biz%3DMzUwOTg0MjczNw%3D%3D%23wechat_redirect)|[统计精进](https://link.zhihu.com/?target=https%3A//mp.weixin.qq.com/mp/appmsgalbum%3F__biz%3DMzUwOTg0MjczNw%3D%3D%26action%3Dgetalbum%26album_id%3D1657541931360370693%23wechat_redirect%26__biz%3DMzUwOTg0MjczNw%3D%3D%23wechat_redirect)|[py基础](https://link.zhihu.com/?target=https%3A//mp.weixin.qq.com/s%3F__biz%3DMzUwOTg0MjczNw%3D%3D%26mid%3D2247488856%26idx%3D1%26sn%3Da31c4f39fc894e6e83cea85efe065fb0%26chksm%3Df90d5106ce7ad8108859c0bff2c54f1b2959ed214cc94ab5beb909b7792748f50e7171fa95fd%26token%3D1852742721%26lang%3Dzh_CN%26scene%3D21%23wechat_redirect)|[py绘图](https://link.zhihu.com/?target=https%3A//mp.weixin.qq.com/s%3F__biz%3DMzUwOTg0MjczNw%3D%3D%26mid%3D2247489108%26idx%3D1%26sn%3D096ec8d8de084197f81268dfeee69361%26chksm%3Df90d520ace7adb1c4a7c13ec0f3da86ccdb88cb5301e4efea4f167c51b48e57b2718aeac78e5%26token%3D1852742721%26lang%3Dzh_CN%26scene%3D21%23wechat_redirect)|[perl基础](https://link.zhihu.com/?target=https%3A//mp.weixin.qq.com/s%3F__biz%3DMzUwOTg0MjczNw%3D%3D%26mid%3D2247488894%26idx%3D1%26sn%3Dd3380ca0f2c3b9567055adae0d59c799%26chksm%3Df90d5120ce7ad8364141b6032880a5131b76d0e0ee1eaac36ee786776afb4fcd9142051da622%26token%3D1852742721%26lang%3Dzh_CN%26scene%3D21%23wechat_redirect)|[R绘图](https://link.zhihu.com/?target=https%3A//mp.weixin.qq.com/s%3F__biz%3DMzUwOTg0MjczNw%3D%3D%26mid%3D2247488834%26idx%3D1%26sn%3D1ed7d57d512e0a6ce39d79a50a682d63%26chksm%3Df90d511cce7ad80a8f760b85e2e9c60068605fbf1ebda0d2adaa946efe428e25e8e53d69fbad%26token%3D1852742721%26lang%3Dzh_CN%26scene%3D21%23wechat_redirect)

编辑于 2021-04-23 09:12

Python

可视化

数据分析