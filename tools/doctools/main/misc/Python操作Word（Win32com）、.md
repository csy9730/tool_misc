# Python操作Word（Win32com）、

[![雾色](https://pic3.zhimg.com/804c16642_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/yunlongyun)

[雾色](https://www.zhihu.com/people/yunlongyun)





252 人赞同了该文章

（2020年4月1日更新）

*本文主要讲解python中操作word的思路。如果只是简单的常用操作，python-docx这个模块可能更方便点。*

*很多人在评论区问的问题，我自己也不会，但是遵循下面的步骤，那么90%的问题是能解决的。本文是授人以渔，是关于你自己发现如何使用python操作word的知识。*

*目录结构*

*一、概述：如何实现某功能*

*二、入门：hello world！*

*三、*印象：对Word对象模型的简单理解

四、展示：格式化word文件为公文2012年国家标准

五、详解：如何实现某功能（对第一部分的手把手教学）

六、探索：少部分宏无法实现的功能

七、总结

## 一、概述：如何实现某功能

如果以前没使用python的win32com操作过word，请从第二部分看起，看完后再回头来看这一部分。

因为有很多功能，在文档中难以直接找到，需要使用如下步骤解决。**这些步骤是本文的核心，任何一个人都可以通过这些步骤实现word中的任何功能。**

1. 使用word的视图选项卡中的宏 -> 录制宏，把想实现的步骤手动操作录制成宏后 -> 停止录制，在宏编辑器里查看VBA代码，从而了解大概使用什么方法。
2. 如果不知道从哪获得实现该功能的对象，则可以使用word宏编辑器的对象浏览器（Alt+F8 -> 点击编辑 -> 按下F2）
3. [使用在线的 .NET](https://link.zhihu.com/?target=http%3A//xn--2rqq0qj80a2gb81v.net/) API，从而了解详细的语法

[.NET API 浏览器（Word）docs.microsoft.com/zh-cn/dotnet/api/microsoft.office.interop.word?view=word-pia%EF%BC%8C%E8%8B%B1%E6%96%87%E5%A5%BD%E7%9A%84%E7%9C%8B%E8%8B%B1%E6%96%87%EF%BC%8C%E6%8A%8A%E7%BD%91%E5%9D%80%E4%B8%AD%E7%9A%84zh-cn%E6%94%B9%E6%88%90en%E5%8D%B3%E5%8F%AF%EF%BC%8C%E6%B1%89%E8%AF%AD%E6%98%AF%E6%9C%BA%E5%99%A8%E7%BF%BB%E8%AF%91%E7%9A%84%EF%BC%8C%E6%9C%89%E8%AE%B8%E5%A4%9A%E9%94%99%E8%AF%AF](https://link.zhihu.com/?target=https%3A//docs.microsoft.com/zh-cn/dotnet/api/microsoft.office.interop.word%3Fview%3Dword-pia%25EF%25BC%258C%25E8%258B%25B1%25E6%2596%2587%25E5%25A5%25BD%25E7%259A%2584%25E7%259C%258B%25E8%258B%25B1%25E6%2596%2587%25EF%25BC%258C%25E6%258A%258A%25E7%25BD%2591%25E5%259D%2580%25E4%25B8%25AD%25E7%259A%2584zh-cn%25E6%2594%25B9%25E6%2588%2590en%25E5%258D%25B3%25E5%258F%25AF%25EF%25BC%258C%25E6%25B1%2589%25E8%25AF%25AD%25E6%2598%25AF%25E6%259C%25BA%25E5%2599%25A8%25E7%25BF%25BB%25E8%25AF%2591%25E7%259A%2584%25EF%25BC%258C%25E6%259C%2589%25E8%25AE%25B8%25E5%25A4%259A%25E9%2594%2599%25E8%25AF%25AF)

\4. 使用Python的IDLE进行实时交互并快速调整

然后输入自己想尝试的对象属性或方法。

> 有些新功能宏可能不支持，但通过.NET API的文档还是能解决

## 二、入门：Hello，world！

这一部分主要是为了实践第一部分打基础

## 使用win32com需要安装pypiwin32

```python3
pip install pypiwin32
```

推荐使用python的IDLE，交互方便

1. 如何新建文档

```python3
from win32com.client import Dispatch


app = Dispatch('Word.Application')
# 新建word文档
doc = app.Documents.Add()
```

按F5运行，发现什么效果都没有， 这是因为Word被隐藏了。

\2. 如何显示Word

```text
app.Visible = True
```

运行后，熟悉的Word界面出现。现在来输入文字。

![img](https://pic3.zhimg.com/80/v2-a55e6d538b95bde79420a2d2b9d1d7de_720w.jpg)

\3. 如何输入

我们在Word中输入文字时，一般会先使用鼠标点击需要输入文字的位置，这个过程是获得了光标焦点。

当我们需要替换某些文字时，首先会选中某些文字，然后再输入、被选择的文字呈现出灰色的背景，表示被选中了。

光标焦点和选择范围在Word中，都是Selection。什么都没选择的光标焦点，和选择了整片文章的选择范围，代表了Selection的最小和最大范围。

这也是为什么整个Word中只能有一个Selection的原因。因为光标或者选择范围就只能有一个。

```python3
# 运行下句代码后，s获得新建文档的光标焦点，也就是图中的回车符前
s = app.Selection
# 用“Hello, World!“替换s代表的范围的文本
s.Text = 'Hello, world!'
```

此时，s的范围为'Hello, world!'这句话的选择区域。

![img](https://pic1.zhimg.com/80/v2-5806956c48f09a4245977a2f1bd35518_720w.jpg)

能如此方便的调用Word，得益于其底层的COM（组件对象模型）可以被任意语言调用。

Selection是Word对象模型中的类，此处的s是它的对象（实例）。

\4. 如何查看选择区域是什么

s.Text可以查看或者设置s选择区域的文本。Word对象模型中很多对象都有默认属性，Text就是Selection的默认属性，类似python的__str__方法。运行s()调用s的默认属性，此处等于于运行了s.Text。

```python3
s()
```

控制台显示，s的范围为'Hello, world!'这句话的选择区域。

![img](https://pic4.zhimg.com/80/v2-024c6c83accfbb5e0f3414f94ec8bddb_720w.jpg)

## 三、印象：对Word对象模型的简单理解

这一部分是为了对word编程时的几个主要对象（类）进行大致了解，形成初步印象。无需理解，请快速扫读。

Word中最重要的类（对象）有以下几个。

**1. Application对象：Word应用。**Application包含了菜单栏、工具栏、命令以及所有文档等。

```text
# 如何获得
app = win32com.client.Dispatch('Word.Application')
```

**2. Document对象：文档。**可以有多个Document，就像Word可以打开多个文档。

使用下列代码新建文档或者打开文档

```text
# 如何获得

# 新建文档
doc = app.Documents.Add()
# 打开已有文档
doc = app.Documents.Open('你的Word文件路径')
```

**3. Selection对象：选区：**代表当前窗口的选区。它可以是文档中的选择（高亮）区域，也可以是插入点（如果没有什么被选中）。同一时间只能激活一个Selection。

- 如何获得

```text
s = app.Selection
```

在Word中，按下Alt+F11打开宏编辑器

![img](https://pic1.zhimg.com/80/v2-bbc5ce8084fda038472c69b8848e61ac_720w.jpg)

然后按下F2打开对象浏览器

![img](https://pic4.zhimg.com/80/v2-3f146abf8520d0514fe7a84b6de4c98b_720w.jpg)

输入selection并回车，发现成员一列中完全匹配Selection的只有4个类，这表示只有这些类的Selection属性可以返回Selection对象（如图）。

![img](https://pic2.zhimg.com/80/v2-1973d4bb7ccf6a27a484cf85addc49e5_720w.jpg)

Application我们前面介绍过，其它的类可以用同样的方法查询如何获得。

- 如何使用Selection输入

```python3
# 替换当前选择
s.Text = 'Hello, world!'
# 输入
s.TypeText('Hello, world!')
# 把当前选择复制到剪贴板
s.Copy()
# 粘贴剪贴板中的内容
s.Paste()
```

Text和TypeText的不同在于完成后的选区：

Text：输入的文本（前例中选区为'Hello, world!'）；

TypeText：文本后的插入点（前例中选区为!后的插入点）。

- 如何变更Selection

```python3
# 使用Start，End指定字符范围
s.Start = 0
s.End = n
# s从第0个字符（第1个字符前的插入点）到第n个字符。
# 汉字是每字为1字符

# 相当于按下Delete键
s.Delete() 
# 相当于按下Ctrl+A
s.WholeStory() 
# 向左移动
s.MoveLeft()
# 向右移动2个字符，第1个参数是移动单位WdUnits（具体见文档），1代表字符
s.MoveRight(1, 2)
```

**4. Range对象：连续区域。**Range表示一个连续区域。Range由Start和End位置定义，用来区分文档的不同部分。Range是独立于Selection的。不管Selection是否改变，都可以定义和操作Range。文档中可以定义多个Range。这个连续区域同样可以小到一个插入点，大到整个文档。Selection有Range属性，而Range没有Selection属性。

当使用Range（Start, End）方法来指定文档的特定范围时。文档的第一个字符位置为0，最后一个字符的位置和文档的字符总数相等。不提供参数时代表选择所有范围。

- 如何获得

```python3
r = doc.Range()
# 或
r = s.Range()
```

Word中有很多对象的Range属性都能返回Range对象，请在Word-宏编辑器-对象浏览器中自己查询。

- 如何使用

Range的很多属性和方法和Selection是类似的，具体看文档。

**5. Font对象：字体。**包含对象的字体属性（字体名称、字号、颜色等）。

- 如何获得

```text
font = s.Font
# 或
font = r.Font
```

同样，其余获得方法可在Word-宏编辑器-对象浏览器中查询。

- 如何使用

```python3
# 字体设置为仿宋，电脑上必须安装有该字体
font.Name = '仿宋'
# 字号设置为三号
font.Size = 16
```

**6. ParagraphFormat对象：段落格式。**用来设置段落格式，包括对齐、缩进、行距、边框底纹等。

- 如何获得

```text
pf = s.ParagraphFormat
# 或
pf = r.ParagraphFormat
```

同样，其余获得方法可在Word-宏编辑器-对象浏览器中查询。

- 如何使用

```text
# 左、中、右 对齐分别为0, 1, 2，其他对齐方式见.NET 文档中的ParagraphFormat
pf.Alignment = 0
# 单倍、1.5倍、双倍行距分别为0, 1, 2，其他见ParagraphFormat文档
pf.LineSpacingRule = 0
# 指定段落的左缩进值为21磅。
pf.LeftIndent = 21
```

**7. PageSetup对象：页面设置。**代表所有的页面设置属性，包括左边距，底边距，纸张大小等等。

- 如何获得

```text
ps = doc.PageSetup
# 或
ps = s.PageSetup
# 或
ps = r.PageSetup
```

同样，其余获得方法可在Word-宏编辑器-对象浏览器中查询。

- 如何使用

```text
# 上边距79磅 
ps.TopMargin = 79
# 页面大小，A3、A4分别为6，7
ps.PageSize = 7
```

**8. Styles对象：样式集。**Styles包含指定文档中内置和用户定义的所有样式，它返回一个样式集。其中的每个样式的属性包括字体、 字形、 段落间距等。如常见的正文、页眉、标题1样式。

- 如何获得

```text
# 只能通过文档获得
styles = doc.Styles
```

- 如何使用

```text
# 返回正文样式
normal = styles(-1)

# 修改正文样式的字体字号
normal.Font.Name = '仿宋'
normal.Font.Size = 16
```

Styles的返回参数，标题1、标题2、标题3分别为-2、-3、-4，页眉为-32，标题为-63，其他见Styles文档

> 注意(-1)的语法，在与word交互中，获取集合（列表）中的元素并不是python中的[1]，而是(1)。
> 而且括号中可能包含-127之类的，python中不会用到的序号，具体请看文档

## 四、展示：格式化word文件为公文2012年国家标准

这部分主要是展示通过这种方法能做什么功能，原理上，手动实现的一切，通过编程都可以实现

只进行两个部分的设置，一是页面设置、二是页码设置

```python3
from win32com.client import Dispatch #需要安装的是pypiwin32模块


app=Dispatch('Word.Application')
doc = app.Documents.Open('你的word文档路径')

# 页面设置
cm_to_points = 28.35 # 1厘米为28.35磅
# 国家公文格式标准要求是上边距版心3.7cm
# 但是如果简单的把上边距设置为3.7cm
# 则因为文本的第一行本身有行距
# 会导致实际版心离上边缘较远，上下边距设置为3.3cm
# 是经过实验的，可以看看公文标准的图示
# 版心指的是文字与边缘距离
doc.PageSetup.TopMargin = 3.3*cm_to_points  
# 上边距3.3厘米
doc.PageSetup.BottomMargin = 3.3*cm_to_points  
# 下边距3.3厘米
doc.PageSetup.LeftMargin = 2.8*cm_to_points  
# 左边距2.8厘米
doc.PageSetup.RightMargin = 2.6*cm_to_points  
# 右边距2.6厘米

# 设置正常样式的字体
# 是为了后面指定行和字符网格时
# 按照这个字体标准进行
doc.Styles(-1).Font.Name = '仿宋' 
# word中的“正常”样式字体为仿宋
doc.Styles(-1).Font.NameFarEast = '仿宋' 
# word中的“正常”样式字体为仿宋
doc.Styles(-1).Font.NameAscii = '仿宋'
# word中的“正常”样式字体为仿宋
doc.Styles(-1).Font.NameOther = '仿宋' 
# word中的“正常”样式字体为仿宋
doc.Styles(-1).Font.Size = 16 
# word中的“正常”样式字号为三号

doc.PageSetup.LayoutMode = 1 
# 指定行和字符网格
doc.PageSetup.CharsLine = 28 
# 每行28个字
doc.PageSetup.LinesPage = 22 
# 每页22行，会自动设置行间距

# 页码设置
doc.PageSetup.FooterDistance = 2.8*cm_to_points  
# 页码距下边缘2.8厘米
doc.PageSetup.DifferentFirstPageHeaderFooter = 0 
# 首页页码相同
doc.PageSetup.OddAndEvenPagesHeaderFooter = 0 
# 页脚奇偶页相同
w = doc.windows(1)  
# 获得文档的第一个窗口
w.view.seekview = 4 
# 获得页眉页脚视图
s = w.selection  
# 获取窗口的选择对象
s.headerfooter.pagenumbers.startingnumber = startingnumber  
# 设置起始页码
s.headerfooter.pagenumbers.NumberStyle = 0  
# 设置页码样式为单纯的阿拉伯数字
s.WholeStory() 
# 扩选到整个部分（会选中整个页眉页脚）
s.Delete() 
#按下删除键，这两句是为了清除原来的页码
s.headerfooter.pagenumbers.Add(4)  
# 添加页面外侧页码
s.MoveLeft(1, 2)  
# 移动到页码左边，移动了两个字符距离
s.TypeText('— ')  
# 给页码左边加上一字线，注意不是减号
s.MoveRight() 
#移动到页码末尾，移动了一个字符距离
# 默认参数是1（字符）
s.TypeText(' —') 
s.WholeStory() 
# 扩选到整个页眉页脚部分，此处是必要的
# 否则s只是在输入一字线后的一个光标，没有选择区域
s.Font.Name = '宋体'
s.Font.Size = 14 
#页码字号为四号
s.paragraphformat.rightindent = 21 
#页码向左缩进1字符（21磅）
s.paragraphformat.leftindent = 21 
# 页码向右缩进1字符（21磅）
doc.Styles('页眉').ParagraphFormat.Borders(-3).LineStyle = 0 
# 页眉无底边框横线
```

## 五、详解：如何实现某功能（对第一部分的手把手教学）

这部分主要是对第一部分的详解，看完后再复习第一部分即可。

我们以评论中的修改背景颜色为例。

**1、通过宏录制，了解编程实现的大体步骤和方法**

首先我们得知道手动如何实现该功能。

我们首先在网上查找如何在word2016中修改背景颜色，查得需要通过设计选项卡中的背景颜色。如果需要打印出这种颜色，还需要勾选word选项中的打印背景颜色。

![img](https://pic2.zhimg.com/80/v2-6b0df41f594e24b506ea27335f3495e1_720w.jpg)

![img](https://pic1.zhimg.com/80/v2-44e613f0a86ef354b88a137e739186c4_720w.jpg)

接着我们手动操作，并录制宏

在word中的开发工具选项卡，点击录制宏，弹出录制宏窗口如下

![img](https://pic3.zhimg.com/80/v2-8f86c189b38720661d1fb0338eeaa58a_720w.jpg)

我们点击确定，依次在设计选项卡修改页面颜色为绿色，点击开发工具选项卡中的停止录制宏。

现在宏就录制好了，我们去看看都有什么内容。

按下Alt+F8，打开宏窗口，选择刚才录制的宏，点击编辑按钮。

在宏编辑器中可以看到我们所做的修改。

```text
Sub 宏1()
'
' 宏1 宏
'
'
    ActiveDocument.Background.Fill.ForeColor.RGB = RGB(146, 208, 80)
    ActiveDocument.Background.Fill.Visible = msoTrue
    ActiveDocument.Background.Fill.Solid
    Options.PrintBackgrounds = True
End Sub
```

这里的ActiveDocument实际上就是第三部分中介绍的Document，实际上大多数的对象都是由第三部分中介绍的几个基本顶级对象延伸出来的。

**2. 如果不知道从哪获得实现该功能的对象，则可以使用word宏编辑器的对象浏览器（F2键），具体见前文Selection部分**

如果实在不知道的话，可以在打开的宏编辑器中，按下F2，弹出对象浏览器如下。

![img](https://pic4.zhimg.com/80/v2-3fa0ff1d5537805bc9e8139d34ab1563_720w.jpg)

我们在左上角的搜索栏中，输入Background，查找Background的顶级类是什么

![img](https://pic1.zhimg.com/80/v2-4522aae4973ff3b3238cfd2fd7da4284_720w.jpg)

如图所示，只有Document和ChartFont。

因为宏录制出的是VBA，而.NET文档又是C#，我们想使用的又是python，所以可能存在一定的转换。但幸运地是win32com在设计之初，就考虑到多语言的应用，所以win32com在多个语言下所用的接口几乎一样，都是类型。这样我们就能很轻松地从VBA转换到C#，再到python。

**3.** [使用在线的 .NET](https://link.zhihu.com/?target=http%3A//xn--2rqq0qj80a2gb81v.net/) **API，从而了解详细的语法**

我们去在线.NET查看Document的方法。

![img](https://pic2.zhimg.com/80/v2-205222604a7a464773f3262bc6edd6a5_720w.jpg)

我们在搜索处，输入document，

![img](https://pic3.zhimg.com/80/v2-b02b447dfe7ebb83f0bd8549f1290062_720w.jpg)

第一个就是我们想要的类。实际上最常用的几个类，都是以下划线开头的这几个，已经列在列表的最前面了。本例中使用_Document类（同Document）即可。

![img](https://pic3.zhimg.com/80/v2-4649059ba7ce5bf024e2bb1c8a67d8de_720w.jpg)

在Document类中找到Background属性

![img](https://pic4.zhimg.com/80/v2-d83b8aae2de4ad2e41e3c78264662253_720w.jpg)

可以看到Shape是一个页面链接，我们点击Shape

![img](https://pic4.zhimg.com/80/v2-a54fbbf6d1d9e76dd7dbd61b505dba33_720w.jpg)

在Shape属性中我们看到Fill会返回一个FillFormat对象，同样我们点击FillFormat的页面链接。

![img](https://pic4.zhimg.com/80/v2-1b45e7041835ba955dc64fd6c5a2a92b_720w.jpg)

在属性中我们找到ForeColor和Visible

![img](https://pic2.zhimg.com/80/v2-f013bd6188bb60d5ab491d6e88a6718d_720w.png)

![img](https://pic2.zhimg.com/80/v2-5606ba2d7071a1dd12aa7e14f08bbe3d_720w.png)

在方法中我们找到Solid

![img](https://pic3.zhimg.com/80/v2-0803704d0d8c328a7c75ddb0b27aba22_720w.png)

值得一提的是在VBA中的一行

```text
ActiveDocument.Background.Fill.Visible = msoTrue
```

这个msoTrue是什么呢？

我们点击找到的属性Visible的页面链接，进入Visible

![img](https://pic3.zhimg.com/80/v2-d12795ecf0008f38a6c530fffdd2e326_720w.jpg)

可以看到属性值是MsoTriState，我们再点击这个页面链接

![img](https://pic4.zhimg.com/80/v2-929edde0829dc2143b6a30b7e39f4057_720w.jpg)

可以看到是Enum类型，也就是枚举。

在python中通过win32com修改Visible，以及类似的以Enum（枚举值）为值的属性时，不能直接使用msoTrue，也不能使用python中的True和False，而是应该查询该枚举值的具体情况，如上图中使用-1、0这些值，而1是暂不支持的。

但是属性值是Boolean（布尔值），则可以直接使用python的True和False，甚至1、0这些值

所以在python中，这句代码应该为

```text
Document.Background.Fill.Visible = -1
```

options也可以在宏编辑器的对象浏览器里找到，是属于Word的属性，Word对象即Application对象。

有时候发现录制的宏中有Array类型，这实际就是Python的list类型

\4. 使用Python的IDLE进行实时交互

这部分交给读者自己研究，可以查看第二部分入门，看如何获得Document对象，以及如何通过IDLE与python交互。



## 六、探索：少部分宏无法实现的功能

有一些新功能，宏无法实现。表现为录制的宏比较简单，执行这些宏时，文档不会改变，达不到自己想要的效果。比如

- **修改简单文本框中文字的字体**

![img](https://pic3.zhimg.com/80/v2-3f413d95a3d110c90d3d0ecaf46f0526_720w.jpg)

这个文本框中文字的字体为仿宋，我们想把它变成黑体。手动实现很简单，但我们来录制一个宏，使它能够批量操作。

我们省略录制的过程，只把录制完的宏展示出来。

```vb.net
Sub 宏7()
'
' 宏7 宏
'
'
    ActiveDocument.Shapes.Range(Array("Text Box 24")).Select
    Selection.Font.Name = "黑体"
End Sub
```

主体第一行中Shapes是形状，Range可以选择多个形状，这里是选择了其中一个Text Box 24。

第二行是把字体改为黑体。这段程序用python写出来，就是

```python
from win32com.client import Dispatch


app = Dispatch("Word.Application")
doc = app.Documents.Open("你的文档路径.docx")
app.visible = True
# 文本框和Text Box是中英文的表达，不影响程序运行
doc.Shapes.Range(["文本框 24"]).Select()
app.Selection.Font.Name = "黑体"
```

让我们手动把字体改回仿宋，运行这个python程序试试，结果并没有改成黑体。我们运行录制的宏，也无法改变字体。

别慌，所有手动能实现的功能，必然在底层是通过程序实现的。

这里的原因就是对于某些新功能，宏本身是不完善的，需要通过查文档的方式自己解决。

我们仔细观察一下，在IDLE中分步运行程序时，可以成功的选择文本框，但就是无法改变字体。

> 其实过程中我做出了多个猜想：
> 是不是没有安装黑体？
> 是不是文本框中没有选择到文字，只是选择了文字前的光标之类的？
> 是不是方法的大小写没有写对？
> 是不是文本框的名字是错的？
> 最后发现，我把前2个字修改成黑体，和把全部的字改成黑体，录制的宏是一样的。这就意味着宏有缺陷。

既然最后定位到了Shapes.Range，那么我去查查文档。

通过几分钟的文档查询，在ShapeRange接口的文档中，找到这么一个方法，可能与文本框的文字有关

> [TextFrame](https://link.zhihu.com/?target=https%3A//docs.microsoft.com/zh-cn/dotnet/api/microsoft.office.interop.word.shaperange.textframe%3Fview%3Dword-pia%23Microsoft_Office_Interop_Word_ShapeRange_TextFrame)
> 返回一个[TextFrame](https://link.zhihu.com/?target=https%3A//docs.microsoft.com/zh-cn/dotnet/api/microsoft.office.interop.word.textframe%3Fview%3Dword-pia)对象, 该对象包含指定形状的文本。

![img](https://pic4.zhimg.com/80/v2-8396a5b8e71ab30fa234f03efa917e4b_720w.png)

在TextFrame中又找到一个属性[TextRange](https://link.zhihu.com/?target=https%3A//docs.microsoft.com/zh-cn/dotnet/api/microsoft.office.interop.word.textframe.textrange%3Fview%3Dword-pia%23Microsoft_Office_Interop_Word_TextFrame_TextRange)

> [TextRange](https://link.zhihu.com/?target=https%3A//docs.microsoft.com/zh-cn/dotnet/api/microsoft.office.interop.word.textframe.textrange%3Fview%3Dword-pia%23Microsoft_Office_Interop_Word_TextFrame_TextRange)
> 返回一个[Range](https://link.zhihu.com/?target=https%3A//docs.microsoft.com/zh-cn/dotnet/api/microsoft.office.interop.word.range%3Fview%3Dword-pia)对象, 表示指定的文本框架中的文本。

![img](https://pic4.zhimg.com/80/v2-2e90464413f25b51f350a3626ac6ad6f_720w.png)

返回的是Word中比较常用的Range对象。

最后我们把前面的python程序修改成

```python
from win32com.client import Dispatch


app = Dispatch("Word.Application")
doc = app.Documents.Open("你的文档路径.docx")
app.visible = True
# 文本框和Text Box是中英文的表达，不影响程序运行
doc.Shapes.Range(["文本框 24"]).TextFrame.TextRange.Font.Name = "黑体"
```

运行后成功的修改成了黑体。

![img](https://pic3.zhimg.com/80/v2-64bc810414611818fc77e57eabd7b832_720w.jpg)

- **修改所有文本框中文字的字体**

> 实际中遇到的问题，需要遍历包含了Group（组）以及Canvas的多个文本框，但通过和另一个小伙伴的努力，都逐一顺利解决了。
> 完整代码为：

```python
from win32com.client import Dispatch


app = Dispatch("Word.Application")
doc = app.Documents.Open(r"C:\Users\drago\Desktop\1.docx")
# app.visible = True
CHINESE_FONT = "微软雅黑"
ENGLISH_AND_NUM_FONT = "Times New Roman"
# seen = set()

# 去掉名称后的数字
# def split_num(string):
#     for i, ch in enumerate(string):
#         if ch.isdigit():
#             return string[: i - 1]


for shape in doc.Shapes:
    name = shape.Name
    if name.startswith("组") or name.startswith("Group"):
        items = shape.GroupItems
        for item in items:
            if item.Name.startswith("文本框") or item.Name.startswith("Text Box"):
                # print(item.Name)
                item.TextFrame.TextRange.Font.Name = CHINESE_FONT
                item.TextFrame.TextRange.Font.Name = ENGLISH_AND_NUM_FONT
            # print(f"group_item: {item.Name}")
            # seen.add(split_num(item.Name))
    elif name.startswith("文本框") or name.startswith("Text Box"):
        # print(name)
        shape.TextFrame.TextRange.Font.Name = CHINESE_FONT
        shape.TextFrame.TextRange.Font.Name = ENGLISH_AND_NUM_FONT
    elif name.startswith("Canvas"):
        canvas_items = shape.CanvasItems
        for item in canvas_items:
            if item.Name.startswith("文本框") or item.Name.startswith("Text Box"):
                # print(item.Name)
                item.TextFrame.TextRange.Font.Name = CHINESE_FONT
                item.TextFrame.TextRange.Font.Name = ENGLISH_AND_NUM_FONT
            # print(f"canvas_item: {item.Name}")
            # seen.add(split_num(item.Name))
    else:
        # seen.add(split_num(name))
        pass
```



关键是遇到宏不能解决的问题，要细致的查询文档，尝试解决问题。当然也可以咨询有经验的人。

你自己做的python程序，可以使用pyinstaller打包成exe给别人使用。

对C#了解的人，也可以在Visual Stuido中创建vsto工程，用python快速迭代测试，用C#写出程序，发布成Word插件的形式，更方便使用。

- **替换所有引号的字体：**（可以用来替换其他格式）

```python
from win32com.client import Dispatch


app = Dispatch("Word.Application")
doc = app.Documents.Open("你的word文件路径")
s = app.Selection
s.WholeStory()
while s.Find.Execute(FindText='"'):
    s.Font.Name = "宋体"
```

- **替换所有[]【】为〔〕（可以用来全局替换字符，这种方法不能替换格式）**

```python
from win32com.client import Dispatch


app = Dispatch("Word.Application")
doc = app.Documents.Open("你的word文件路径")
app.visible = True


# 替换正文中所有匹配的oldstr为newstr
def replace_all(oldstr, newstr):
    app.Selection.Find.Execute(
        oldstr, False, False, False, False, False, True, 1, False, newstr, 2
    )


replace_all("[", "〔")
replace_all("【", "〔")
replace_all("]", "〕")
replace_all("】", "〕")
```

> Tip: 按下Alt键，小键盘输入41394，松开就会输出〔，41395为〕

## 七、总结

好，我们再总结一下

1. **宏录制 （了解大致方法）**
2. **宏编辑器的对象浏览器（查看方法和属性的类是什么）**
3. **.NET文档（查看具体语法）**
4. **python IDLE（实时互动，快速调整）**

## **如果您觉得有用，请点赞后收藏！**

## 参考文章：

[尘世中人：Python通过win32实现office自动化 - Wordblog.csdn.net/lzl001/article/details/8435048](https://link.zhihu.com/?target=https%3A//blog.csdn.net/lzl001/article/details/8435048)

[艾晓明、周定康：引用Microsoft Word 对象的技术及实现www.docin.com/p-1333941826.html](https://link.zhihu.com/?target=https%3A//www.docin.com/p-1333941826.html)

[Tianyu-liu（转载）：Word组件对象模型blog.csdn.net/wishfly/article/details/39959349](https://link.zhihu.com/?target=https%3A//blog.csdn.net/wishfly/article/details/39959349)

[党政机关公文格式国家标准（2012年最新版)rsj.zgcy.gov.cn/zgcy_rsj/zcfg/20180625/004_3ee8c610-a3c7-46f5-ace6-7af6d9d5a6f4.htm![img](https://pic1.zhimg.com/v2-d979249d1b1d9446f3a3403365fb2148_120x160.jpg)](https://link.zhihu.com/?target=http%3A//rsj.zgcy.gov.cn/zgcy_rsj/zcfg/20180625/004_3ee8c610-a3c7-46f5-ace6-7af6d9d5a6f4.htm)

[.NET API 浏览器（Word）docs.microsoft.com/zh-cn/dotnet/api/microsoft.office.interop.word?view=word-pia&viewFallbackFrom=word-pia%EF%BC%8C%E8%8B%B1%E6%96%87%E5%A5%BD%E7%9A%84%E7%9C%8B%E8%8B%B1%E6%96%87%EF%BC%8C%E6%8A%8A%E7%BD%91%E5%9D%80%E4%B8%AD%E7%9A%84zh-cn%E6%94%B9%E6%88%90en%E5%8D%B3%E5%8F%AF%EF%BC%8C%E6%B1%89%E8%AF%AD%E6%98%AF%E6%9C%BA%E5%99%A8%E7%BF%BB%E8%AF%91%E7%9A%84%EF%BC%8C%E6%9C%89%E8%AE%B8%E5%A4%9A%E9%94%99%E8%AF%AF](https://link.zhihu.com/?target=https%3A//docs.microsoft.com/zh-cn/dotnet/api/microsoft.office.interop.word%3Fview%3Dword-pia%26viewFallbackFrom%3Dword-pia%25EF%25BC%258C%25E8%258B%25B1%25E6%2596%2587%25E5%25A5%25BD%25E7%259A%2584%25E7%259C%258B%25E8%258B%25B1%25E6%2596%2587%25EF%25BC%258C%25E6%258A%258A%25E7%25BD%2591%25E5%259D%2580%25E4%25B8%25AD%25E7%259A%2584zh-cn%25E6%2594%25B9%25E6%2588%2590en%25E5%258D%25B3%25E5%258F%25AF%25EF%25BC%258C%25E6%25B1%2589%25E8%25AF%25AD%25E6%2598%25AF%25E6%259C%25BA%25E5%2599%25A8%25E7%25BF%25BB%25E8%25AF%2591%25E7%259A%2584%25EF%25BC%258C%25E6%259C%2589%25E8%25AE%25B8%25E5%25A4%259A%25E9%2594%2599%25E8%25AF%25AF)



编辑于 01-27

Microsoft Word

Python

Win32 API

赞同 252