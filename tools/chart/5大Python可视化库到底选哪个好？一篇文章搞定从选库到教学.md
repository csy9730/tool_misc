# 5大Python可视化库到底选哪个好？一篇文章搞定从选库到教学

[![一两赘肉无](https://pic2.zhimg.com/v2-a85d003c454ae3882c22f1591cb861c7_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/yi-liang-zhui-rou-wu)

[一两赘肉无](https://www.zhihu.com/people/yi-liang-zhui-rou-wu)





80 人赞同了该文章

最近[和鲸社区](https://link.zhihu.com/?target=https%3A//www.heywhale.com/home/project)的大佬们，竟不约而同地写起了可视化库的教程，开始了掰头

![img](https://pic2.zhimg.com/80/v2-eeedec762464c3e9d8caed4b09c8f331_1440w.jpg)

※完整教程列表在文末附录


虽然对于我们这种吃瓜群众来说是件好事，但

![img](https://pic3.zhimg.com/80/v2-662e35a47f75f8e4e6bf775cdd0ea202_1440w.jpg)

大概大佬的快乐往往就是那么的朴实无华且枯燥吧。害，管他呢，赶紧拿出来给大家瞅瞅。

今天提及的5个Python可视化库分别是 Matplotlib · Seaborn · Bokeh · Plotly · Pyecharts。

其实单独看后4个库，每个都是炫酷的代名词，但既然今天大家都同框了，方小鲸就简单地将他们做个比较，从4个方面看看他们之间的区别，以便大家各取所需的学到适合自己的可视化库。

## Round 1 **简单的折线图**

这一部分使用5个库可视化了同一组数据， 我们同时展示了可视化这组数据时需要的代码，以及可视化之后，默认呈现的一些功能。通过这些，我们可以了解到这些库的语言风格，以及对它出图的效果产生一定的预期。



- Matplotlib

![img](https://pic3.zhimg.com/80/v2-53eb35b49bc29b93910d2446c2bbfbbe_1440w.jpg)

- **Seaborn**

![img](https://pic1.zhimg.com/80/v2-efdef556fdf878dba0a33629cc1b3fe4_1440w.jpg)

- **Bokeh**

![img](https://pic4.zhimg.com/v2-5f5c352c992c38cce2edb9d55bec139b_b.jpg)

- **Plotly**

![img](https://pic2.zhimg.com/v2-431102feaaac71b6373df7378e35b8e1_b.jpg)

- **Pyecharts**

![img](https://pic1.zhimg.com/v2-815cec82b0ba0ad705eb71e515bdeca4_b.jpg)

从以上的结果看来，Seaborn如果不选用样式，那么效果和matplotlib无二；Bokeh好看了那么一丢丢，自带图片的缩放功能；Plotly和Pyecharts的代码复杂程度稍有增加，但是提供的标签效果好看



## Round 2 **功能**

有些同学，诉求可能仅仅是画出高精度的图片，用于撰写论文；而有些同学需要对[地图数据](https://www.zhihu.com/search?q=地图数据&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A148748125})进行操作，故需要特定功能；又有些同学，需要炫酷的交互来展示海量数据。

所以，方小鲸去这几个库的官网gallery逛了一下，针对本鲸比较关注的几个功能做了整理统计。

![img](https://pic4.zhimg.com/80/v2-bd72e0d020a8e2c6a949af0f618c92e3_1440w.jpg)

○支持的不是很好

可以得出的结论是，Seaborn就是个Matplotlib的封装，功能比较有限；Pyecharts虽然动效做的好看，但是控件无法定制；Bokeh控件玩法多样，但输在做3D和动画要装插件；相较之下Plotly在功能上完胜。



## Round 3 **能力边界**

为了让大家更深刻地理解这些库，本鲸找了一些炫酷的作品，希望可以给大家带来视觉上的冲击，从而更有动力地学习这些库。

- **Matplotlib**

![img](https://pic1.zhimg.com/80/v2-8c299a19e39561954eaef29a0551dbec_1440w.jpg)

- **Seaborn**

![img](https://pic2.zhimg.com/80/v2-904c788e3614a36644094c2b30055475_1440w.jpg)

- **Bokeh**

![img](https://pic2.zhimg.com/80/v2-09803e101ef38b22dc45f5d1fa776001_1440w.jpg)

![img](https://pic3.zhimg.com/v2-e43c26795a2a13f265ef5b635362ca72_b.jpg)

![img](https://pic3.zhimg.com/v2-4ca7487a00f7177b99aa9c57c564529e_b.jpg)

- **Plotly**

![img](https://pic2.zhimg.com/80/v2-f500b61c81fb0062a0a42acee2861afd_1440w.jpg)

![img](https://pic4.zhimg.com/v2-60f6ac7c370d520fb9aa5466617e71fb_b.jpg)

![img](https://pic4.zhimg.com/v2-8172e0134d8a61872b30354e5b300ffb_b.jpg)

- **Pyecharts**

![img](https://pic4.zhimg.com/v2-2ecec89583e1bac6f25c3a56b5fed99f_b.jpg)

![img](https://pic4.zhimg.com/v2-64386c1ee3d725cce53c3731969c954f_b.jpg)

![img](https://pic3.zhimg.com/v2-bf198f1406b73fa933260f04f3a2e77e_b.jpg)

## Round 4 **总结陈词 & 教程**

- **Matplotlib**

Matplotlib是Python数据可视化库中的泰斗，它已经成为python中公认的数据可视化工具，通过Matplotlib可以很方便的设计和输出二维以及三维的数据，其提供了常规的[笛卡尔坐标](https://www.zhihu.com/search?q=笛卡尔坐标&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A148748125})，极坐标，球坐标，三维坐标等，其输出的图片质量也达到了科技论文中的印刷质量，日常的基本绘图更不在话下。

[5分钟上手Matplotlibwww.heywhale.com/mw/project/5ed31e64fab96c002cf64acb](https://link.zhihu.com/?target=https%3A//www.heywhale.com/mw/project/5ed31e64fab96c002cf64acb)



- **Seaborn**

Seaborn是基于matplotlib的图形可视化python包，它在matplotlib的基础上进行了更高级的API封装，提供了一种高度交互式界面，从而使得作图更加容易，便于用户能够做出各种有吸引力的统计图表。它能高度兼容numpy与pandas[数据结构](https://www.zhihu.com/search?q=数据结构&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A148748125})以及scipy与statsmodels等统计模式。

Seaborn利用matplotlib的强大功能，几行代码就能创建漂亮的图表。其与matplotlib主要的区别是Seaborn的默认样式以及更美观、更现代的调色板设计。

[Python数据可视化方法之Seabornwww.heywhale.com/mw/project/5ddd2915ca27f8002c4a46cb](https://link.zhihu.com/?target=https%3A//www.heywhale.com/mw/project/5ddd2915ca27f8002c4a46cb)



- **Bokeh**

Bokeh是一个专门针对Web浏览器的呈现功能的交互式可视化Python库,支持现代化web浏览器展示（图表可以输出为JSON对象，HTML文档或者可交互的网络应用）,这是Bokeh与其它可视化库最核心的区别。它提供风格优雅、简洁的D3.js的图形化样式，并将此功能扩展到高性能交互的数据集，数据流上。使用Bokeh可以快速便捷地创建[交互式绘图](https://www.zhihu.com/search?q=交互式绘图&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A148748125})、仪表板和数据应用程序等。

Bokeh能与NumPy，Pandas，Blaze等大部分数组或表格式的数据结构完美结合。

[Bokeh教程学习www.heywhale.com/mw/project/59dd8cbd77da7a4f41ce3299](https://link.zhihu.com/?target=https%3A//www.heywhale.com/mw/project/59dd8cbd77da7a4f41ce3299)



- **Plotly**

Plotly是一个开源，交互式和基于浏览器的Python图形库，可以创建能在仪表板或网站中使用的[交互式图表](https://www.zhihu.com/search?q=交互式图表&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A148748125})（可以将它们保存为html文件或静态图像）。Plotly基于[plotly.js](https://www.zhihu.com/search?q=plotly.js&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A148748125})，而plotly.js又基于D3.js，因此它是一个高级图表库，与Bokeh一样，Plotly的强项是制作交互式图 ，有超过30种图表类型， 提供了一些在大多数库中没有的图表 ，如[等高线图](https://www.zhihu.com/search?q=等高线图&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A148748125})、树状图、科学图表、统计图表、3D图表、金融图表等。plotly绘制的图能直接在jupyter中查看，也能保存为离线网页，或者保存在[http://plot.ly](https://link.zhihu.com/?target=http%3A//plot.ly)云端服务器内，以便在线查看。

[Plotly入门教程www.heywhale.com/mw/project/5d0a0584e727f8002c7cfbf5](https://link.zhihu.com/?target=https%3A//www.heywhale.com/mw/project/5d0a0584e727f8002c7cfbf5)

- **Pyecharts**

Pyecharts是基于 Echarts 开发的，是一个用于生成 Echarts 图表的类库。Echarts 是百度开源的一个数据可视化 JS 库，凭借着良好的交互性，精巧的图表设计，得到了众多开发者的认可。更重要的是，该库的文档全部由中文撰写，对英文不是很好的开发者尤其友好。而Pyecharts，实际上就是 Echarts 与 Python 的对接。

[【pyecharts教程】应该是全网最全的教程了～www.heywhale.com/mw/project/5eb7958f366f4d002d783d4a](https://link.zhihu.com/?target=https%3A//www.heywhale.com/mw/project/5eb7958f366f4d002d783d4a)



## 附录

这里是文中未提及，但是也很神仙的一些可视化相关链接

- **教程**

[【matplotlib】Matplotlib可视化教程～](https://link.zhihu.com/?target=https%3A//www.heywhale.com/mw/project/5e6e2053dd480d002c22953c)

[python--matplotlib数据可视化](https://link.zhihu.com/?target=https%3A//www.heywhale.com/mw/project/5d227bf2688d36002c54a54c)

[50题matplotlib从入门到精通](https://link.zhihu.com/?target=https%3A//www.heywhale.com/mw/project/5de9f0a0953ca8002c95d2a9)

[【美人图】5分钟上手Matplotlib](https://link.zhihu.com/?target=https%3A//www.heywhale.com/mw/project/5ed31e64fab96c002cf64acb)

[Python数据可视化方法之matplotlib](https://link.zhihu.com/?target=https%3A//www.heywhale.com/mw/project/5ddd1cccca27f8002c4a412c)

[matplotlib数据可视化](https://link.zhihu.com/?target=https%3A//www.heywhale.com/mw/project/5c35a9f6e691ba002c3a40df)



[plotly教程【持续更新中】](https://link.zhihu.com/?target=https%3A//www.heywhale.com/mw/project/5ed49ab6946a0e002cb60d76)

[是时候用plotly代替matplotlib](https://link.zhihu.com/?target=https%3A//www.heywhale.com/mw/project/5eda1570b772f5002d6e67b7)

[Plotly入门教程](https://link.zhihu.com/?target=https%3A//www.heywhale.com/mw/project/5d0a0584e727f8002c7cfbf5)



[seaborn可视化学习之 categorial visualization](https://link.zhihu.com/?target=https%3A//www.heywhale.com/mw/project/59c3851c2110010662398bfc)

[seaborn可视化学习之distribution visualization](https://link.zhihu.com/?target=https%3A//www.heywhale.com/mw/project/59c8b06421100106623db531)

[seaborn可视化之time series & regression & heatmap](https://link.zhihu.com/?target=https%3A//www.heywhale.com/mw/project/59c9e95d21100106623ecf58)

[【Seaborn可视化】一文掌握Seaborn可视化](https://link.zhihu.com/?target=https%3A//www.heywhale.com/mw/project/5ed62eb5946a0e002cb73d0a)



[【pyecharts教程】应该是全网最全的教程了～](https://link.zhihu.com/?target=https%3A//www.heywhale.com/mw/project/5eb7958f366f4d002d783d4a)

[【Pyecharts教程1】让你的图表动起来～](https://link.zhihu.com/?target=https%3A//www.heywhale.com/mw/project/5e4bd73f80da780037be6b61)

[【Pyecharts教程2】如何让你的图表不那么单调～](https://link.zhihu.com/?target=https%3A//www.heywhale.com/mw/project/5e9b2f78ebb37f002c6111ca)

[【可视化系列2】pyecharts交互式可视化巩固训练](https://link.zhihu.com/?target=https%3A//www.heywhale.com/mw/project/5c8363987ea30f002b26020c)



[炫酷的可视化工具包----cufflinks](https://link.zhihu.com/?target=https%3A//www.heywhale.com/mw/project/5ece0bc312fba90036cf2dc0)

[嗨～介绍一款地理数据可视化神器—keplergl](https://link.zhihu.com/?target=https%3A//www.heywhale.com/mw/project/5edcb648b772f5002d70228d)

[台风数据分析-高德地图/Geopandas](https://link.zhihu.com/?target=https%3A//www.heywhale.com/mw/project/5d99b81f037db3002d3c9c2e)

[python分析--可视化地图folium库使用示例](https://link.zhihu.com/?target=https%3A//www.heywhale.com/mw/project/5e48c87317aec8002dc6b373)

[Sigma.js网络图标Demo](https://link.zhihu.com/?target=https%3A//www.heywhale.com/mw/project/58b6e889b7f5e40072f8c583)





编辑于 2021-04-02 14:13

Python

可视化

数据可视化

赞同 80

7 条评论

分享