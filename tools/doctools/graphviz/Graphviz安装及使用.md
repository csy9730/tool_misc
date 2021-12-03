# Graphviz安装及使用

![img](https://upload.jianshu.io/users/upload_avatars/2354823/53f9a93e-87d9-48b7-a968-d3e8e142c6a8.png?imageMogr2/auto-orient/strip|imageView2/1/w/96/h/96/format/webp)

[合肥黑](https://www.jianshu.com/u/50e1d98d51ac)关注

0.7642019.04.02 10:46:44字数 278阅读 18,881

##### 一、安装

参考
[Graphviz安装及简单使用](https://links.jianshu.com/go?to=https%3A%2F%2Fwww.cnblogs.com%2Fshuodehaoa%2Fp%2F8667045.html)
[利用Graphviz 画结构图](https://links.jianshu.com/go?to=https%3A%2F%2Fwww.cnblogs.com%2Fsld666666%2Farchive%2F2010%2F06%2F25%2F1765510.html)

1.在[官网下载地址](https://links.jianshu.com/go?to=https%3A%2F%2Fgraphviz.gitlab.io%2F_pages%2FDownload%2FDownload_windows.html)下载msi，一路next安装即可。





![img](https://upload-images.jianshu.io/upload_images/2354823-74a9312e83d829d4.png?imageMogr2/auto-orient/strip|imageView2/2/w/732/format/webp)

image.png

2.安装目录\bin文件夹\：找到gvedit.exe文件右键 发送到桌面快捷方式

3.将graphviz安装目录下的bin文件夹添加到Path环境变量中

4.进入windows命令行界面，输入dot -version，然后按回车，如果显示graphviz的相关版本信息，则安装配置成功。

5.在桌面上找到刚刚创建的快捷方式gvedit，打开新建一个文件，内容如下：

```
digraph G{ { a b c} -> { 一 二 三 } }
```

，然后保存为1.gv。使用命令即可生成图片：



```css
C:\Users\lenovo>e:

E:\>cd golang

E:\golang>cd graphviz

E:\golang\graphviz>dot 1.gv -o image.png

E:\golang\graphviz>dot 1.gv -Tpng -o image.png

E:\golang\graphviz>
```

但是这样中文是乱码的
6.解决中文乱码

```xml
<!-- Font directory list -->

    <dir>#FONTDIR#</dir>
    <dir>~/.fonts</dir>
```

改为

```xml
<!-- Font directory list -->

    <dir>C:\Windows\Fonts</dir>
    <dir>~/.fonts</dir>
```

把1.gv改成这样：

```rust
digraph G{ 
node[fontname="SimSun"]
{ a b c} -> { 五 六 七}
}
```

现在可以正常输出图片了，但是重新使用gvedit打开1.gv这个文件，会发现乱码了，这是因为保存格式问题。可以使用记事本之类的软件打开，然后另存为，覆盖一下，注意编码格式选utf8。这里保存为dot扩展名更方便。
7.可以不用命令，直接使用IDE带的功能导出图片



![img](https://upload-images.jianshu.io/upload_images/2354823-723e4453257ab345.png?imageMogr2/auto-orient/strip|imageView2/2/w/710/format/webp)

红色字体1，是新建一个脚本，红色字体2是在编辑完脚本后执行脚本。

```rust
digraph G{

    size = "5, 5";//图片大小
    main[shape=box];/*形状*/

    main->parse;
    parse->execute;

    main->init[style = dotted];//虚线

    main->cleanup;
    edge[color = green]; // 连接线的颜色

    execute->{make_string; printf}//连接两个

    init->make_string;
    main->printf[style=bold, label="100 times"];//线的 label

    make_string[label = "make a\nstring"]// \n, 这个node的label，注意和上一行的区别

    node[shape = box, style = filled, color = ".7.3 1.0"];//一个node的属性

    execute->compare;
}
```



![img](https://upload-images.jianshu.io/upload_images/2354823-7a2b78ddc0588804.png?imageMogr2/auto-orient/strip|imageView2/2/w/730/format/webp)

image.png

##### 二、[graphviz dot语言学习笔记](https://www.jianshu.com/p/e44885a777f0)

Graphviz是大名鼎鼎的贝尔实验室的几位牛人开发的一个画图工具。它的理念和一般的“所见即所得”的画图工具不一样，是“所想即所得”。 Graphviz提供了dot语言来编写绘图脚本。

##### 三、[Graphviz绘制百家争鸣图](https://links.jianshu.com/go?to=https%3A%2F%2Fwww.cnblogs.com%2Fme-sa%2Fp%2Fjust_for_fun.html)

```rust
digraph show {

// node
//rankdir = LR;

node[shape="box" , fontname="DFKai-SB" fontsize=16 size="5,5" color="gray" distortion=.7]
edge[ fontname="DFKai-SB" fontsize=15 fontcolor="black" color="brown" style="filled"]

儒家[shape="egg"]
道家[shape="egg"]
法家[shape="egg"]
墨家[shape="egg"]
救世[shape="doubleoctagon"]
中庸[shape="Mdiamond"]
百家争鸣->儒家->克己复礼 
百家争鸣->墨家->兼爱非攻 
百家争鸣->法家
法家->"不别亲疏，不殊贵贱，一断于法"
百家争鸣->道家
儒家->孔子->孟子->荀子
墨家->墨子
墨家->为天下谋
儒家->仁爱
道家->杨朱->老子->庄子
老子->善利万物而不争->示弱
老子->无政府主义
庄子->无政府主义
庄子->己所不欲勿施于人->自由
庄子->己所甚欲勿施于人->自由
自由->逍遥游
庄子->人生观->关你何事
人生观->关我何事
庄子->做人开心最重要->TVB
杨朱->一毛不拔
杨朱->且趣当生奚遑死后
法家->韩非
法家->两面三刀->奖惩
两面三刀->势
两面三刀->术
两面三刀->法
孔子->中庸
孔子->礼乐
孔子->鬼神[label="敬鬼神而远之"]
孔子->天命->使命
孟子->义
孟子->浩然大丈夫
孟子->民权
荀子->天道人性
荀子->君子自强
法家->君权
儒家->救世[arrowhead="vee" color ="steelblue"]
墨家->救世[arrowhead="vee" color ="steelblue"]
法家->救世[arrowhead="vee" color ="steelblue"]
墨家->鬼神
墨家->义士
道家->儒家[arrowhead="vee" color ="gold" label="天下大骇儒墨皆起"]
道家->孔子[arrowhead="vee" color ="gold" label="圣人不死大盗不止"]
道家->墨家[arrowhead="vee" color ="gold"  ]
道家->不爱
道家->先存诸己而后存诸人
法家->仁爱[arrowhead="vee" color ="gold" label="这玩意没用"]
法家->礼乐[arrowhead="vee" color ="gold" label="这玩意没用"]
法家->兼爱非攻[arrowhead="vee" color ="gold" label="这玩意没用"]
仁爱->兼爱非攻[arrowhead="vee" color ="gold"  dir="both"]
仁爱->不爱[arrowhead="vee" color ="gold"  dir="both"]
}
```





8人点赞



开发工具