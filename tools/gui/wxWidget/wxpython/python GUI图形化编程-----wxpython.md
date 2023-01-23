# [python GUI图形化编程-----wxpython](https://www.cnblogs.com/morries123/p/8568666.html)

一、python gui（图形化）模块介绍：**

　　Tkinter :是python最简单的图形化模块，总共只有14种组建

　　Pyqt     :是python最复杂也是使用最广泛的图形化

　　Wx       :是python当中居中的一个图形化，学习结构很清晰

　　Pywin   :是python windows 下的模块，摄像头控制(opencv)，常用于外挂制作

**二、wx模块的安装：**

```
`C:\Users\Administrator> pip install wxpython`
```

**三、图形化介绍**

**![img](https://images2018.cnblogs.com/blog/1346968/201803/1346968-20180314162543626-747274271.png)……**

**![img](https://images2018.cnblogs.com/blog/1346968/201803/1346968-20180314162720572-1363559280.png)**

 

 

**四、wx主要组件介绍**

**1、frame（窗口）**

```
`参数：` `parent ``=` `None` `#父元素，假如为None，代表顶级窗口` `id` `=` `None` `#组件的标识，唯一，假如id为-1代表系统分配id` `title ``=` `None` `#窗口组件的名称` `pos ``=` `None` `#组件的位置，就是组件左上角点距离父组件或者桌面左和上的距离` `size ``=` `None` `#组件的尺寸，宽高` `style ``=` `None` `#组件的样式` `name ``=` `None` `#组件的名称，也是用来标识组件的，但是用于传值`
```

**2、TextCtrl（文本框）**

```
`参数：` `parent ``=` `None` `#父元素，假如为None，代表顶级窗口` `id` `=` `None` `#组件的标识，唯一，假如id为-1代表系统分配id` `value ``=` `None`   `#文本框当中的内容``         ``GetValue ``#获取文本框的值``         ``SetValue ``#设置文本框的值` `pos ``=` `None` `#组件的位置，就是组件左上角点距离父组件或者桌面左和上的距离` `size ``=` `None` `#组件的尺寸，宽高` `style ``=` `None` `#组件的样式` `validator ``=` `None` `#验证` `name ``=` `None` `#组件的名称，也是用来标识组件的，但是用于传值`
```

**3、Button（按钮）**

```
`参数：` `parent ``=` `None` `#父元素，假如为None，代表顶级窗口` `id` `=` `None` `#组件的标识，唯一，假如id为-1代表系统分配id` `lable ``=` `None` `#按钮的标签` `pos ``=` `None` `#组件的位置，就是组件左上角点距离父组件或者桌面左和上的距离` `size ``=` `None` `#组件的尺寸，宽高` `style ``=` `None` `#组件的样式` `validator ``=` `None` `#验证` `name ``=` `None` `#组件的名称，也是用来标识组件的，但是用于传值`
```

其它组件的参数类似

**4、创建窗口基础代码**

```
`基本创建窗口代码说明：<br><br>``import` `wx ``#引入wx模块<br>``app ``=` `wx.App() ``#实例化一个主循环<br>``frame ``=` `wx.Frame(``None``) ``#实例化一个窗口<br>``frame.Show()``#调用窗口展示功能<br>``app.MainLoop()``#启动主循环`
```

效果如下图：　　

![img](https://images2018.cnblogs.com/blog/1346968/201803/1346968-20180314171643250-35417890.png)

**五、Gui编写简单实例**

实现如下一个GUI界面，在上面文本框中输入文本文件地址，点击“打开”按钮后将文本文件内容显示在下面的文本框中。

**![img](https://images2018.cnblogs.com/blog/1346968/201803/1346968-20180314171847342-1907337927.png)**

**1、图形化编写**

```
`import` `wx` `app ``=` `wx.App()``frame ``=` `wx.Frame(``None``,title ``=` `"Gui Test Editor"``,pos ``=` `(``1000``,``200``),size ``=` `(``500``,``400``))` `path_text ``=` `wx.TextCtrl(frame,pos ``=` `(``5``,``5``),size ``=` `(``350``,``24``))``open_button ``=` `wx.Button(frame,label ``=` `"打开"``,pos ``=` `(``370``,``5``),size ``=` `(``50``,``24``))``save_button ``=` `wx.Button(frame,label ``=` `"保存"``,pos ``=` `(``430``,``5``),size ``=` `(``50``,``24``))`
```

**2、事件绑定**

```
`1``、定义事件函数``    ``事件函数有且只有一个参数，叫event``    ` `def` `openfile(event):``    ``path ``=` `path_text.GetValue()``    ``with ``open``(path,``"r"``,encoding``=``"utf-8"``) as f:  ``#encoding 设置文件打开时指定为utf8编码，避免写文件时出现编码错误``        ``content_text.SetValue(f.read())` `2``、绑定出发事件的条件和组件` `open_button.Bind(wx.EVT_BUTTON,openfile)`
```

**3、完整代码**

```
`#coding:utf-8``import` `wx` `def` `openfile(event):     ``# 定义打开文件事件``    ``path ``=` `path_text.GetValue()``    ``with ``open``(path,``"r"``,encoding``=``"utf-8"``) as f:  ``# encoding参数是为了在打开文件时将编码转为utf8``        ``content_text.SetValue(f.read())` `app ``=` `wx.App()``frame ``=` `wx.Frame(``None``,title ``=` `"Gui Test Editor"``,pos ``=` `(``1000``,``200``),size ``=` `(``500``,``400``))` `path_text ``=` `wx.TextCtrl(frame,pos ``=` `(``5``,``5``),size ``=` `(``350``,``24``))``open_button ``=` `wx.Button(frame,label ``=` `"打开"``,pos ``=` `(``370``,``5``),size ``=` `(``50``,``24``))``open_button.Bind(wx.EVT_BUTTON,openfile)    ``# 绑定打开文件事件到open_button按钮上` `save_button ``=` `wx.Button(frame,label ``=` `"保存"``,pos ``=` `(``430``,``5``),size ``=` `(``50``,``24``))` `content_text``=` `wx.TextCtrl(frame,pos ``=` `(``5``,``39``),size ``=` `(``475``,``300``),style ``=` `wx.TE_MULTILINE)``#  wx.TE_MULTILINE可以实现以滚动条方式多行显示文本,若不加此功能文本文档显示为一行` `frame.Show()``app.MainLoop()`
```

　　![img](https://images2018.cnblogs.com/blog/1346968/201803/1346968-20180314180341307-1838660581.png)

  **六、尺寸器**

**按照上面的GUI代码有一个缺陷，由于我们各个组件都固定了大小，因此在框体拉伸时，对应的组件不会对应进行拉伸，比较影响用户体验。**

**![img](https://images2018.cnblogs.com/blog/1346968/201803/1346968-20180314181938931-1449675547.png)**

为了解决上述这个问题，我们可以使用尺寸器进行布局，类似于HTML的CSS样式。

**1、BoxSizer（尺寸器）**

- 尺寸器作用于画布（panel）
- 默认水平布局
- 垂直布局可以调整
- 按照相对比例

**2、步骤**

- 实例化尺寸器（可以是多个）
- 添加组件到不同尺寸器中
- 设置相对比例、填充的样式和方向、边框等参数
- 设置主尺寸器

3、将上面代码通过尺寸器改写

![img](https://images2018.cnblogs.com/blog/1346968/201803/1346968-20180314185025604-1242604057.png)

```
`#coding:utf-8``import` `wx` `def` `openfile(event):     ``# 定义打开文件事件``    ``path ``=` `path_text.GetValue()``    ``with ``open``(path,``"r"``,encoding``=``"utf-8"``) as f:  ``# encoding参数是为了在打开文件时将编码转为utf8``        ``content_text.SetValue(f.read())` `app ``=` `wx.App()``frame ``=` `wx.Frame(``None``,title ``=` `"Gui Test Editor"``,pos ``=` `(``1000``,``200``),size ``=` `(``500``,``400``))` `panel ``=` `wx.Panel(frame)` `path_text ``=` `wx.TextCtrl(panel)``open_button ``=` `wx.Button(panel,label ``=` `"打开"``)``open_button.Bind(wx.EVT_BUTTON,openfile)    ``# 绑定打开文件事件到open_button按钮上` `save_button ``=` `wx.Button(panel,label ``=` `"保存"``)` `content_text``=` `wx.TextCtrl(panel,style ``=` `wx.TE_MULTILINE)``#  wx.TE_MULTILINE可以实现以滚动条方式多行显示文本,若不加此功能文本文档显示为一行` `box ``=` `wx.BoxSizer() ``# 不带参数表示默认实例化一个水平尺寸器``box.Add(path_text,proportion ``=` `5``,flag ``=` `wx.EXPAND|wx.``ALL``,border ``=` `3``) ``# 添加组件``    ``#proportion：相对比例``    ``#flag：填充的样式和方向,wx.EXPAND为完整填充，wx.ALL为填充的方向``    ``#border：边框``box.Add(open_button,proportion ``=` `2``,flag ``=` `wx.EXPAND|wx.``ALL``,border ``=` `3``) ``# 添加组件``box.Add(save_button,proportion ``=` `2``,flag ``=` `wx.EXPAND|wx.``ALL``,border ``=` `3``) ``# 添加组件` `v_box ``=` `wx.BoxSizer(wx.VERTICAL) ``# wx.VERTICAL参数表示实例化一个垂直尺寸器``v_box.Add(box,proportion ``=` `1``,flag ``=` `wx.EXPAND|wx.``ALL``,border ``=` `3``) ``# 添加组件``v_box.Add(content_text,proportion ``=` `5``,flag ``=` `wx.EXPAND|wx.``ALL``,border ``=` `3``) ``# 添加组件` `panel.SetSizer(v_box) ``# 设置主尺寸器` `frame.Show()``app.MainLoop()`
```

　　通过尺寸器进行布局，无论宽体如何拉伸，内部的组件都会按比例进行变化。

![img](https://images2018.cnblogs.com/blog/1346968/201803/1346968-20180314185230491-1572831619.png)        ![img](https://images2018.cnblogs.com/blog/1346968/201803/1346968-20180314185243893-926785561.png)

 



分类: [python之路](https://www.cnblogs.com/morries123/category/1177291.html)

标签: [python](https://www.cnblogs.com/morries123/tag/python/), [gui](https://www.cnblogs.com/morries123/tag/gui/)