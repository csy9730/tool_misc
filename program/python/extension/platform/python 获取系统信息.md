# python 获取系统信息

[![艺赛旗RPA](https://pic4.zhimg.com/v2-a71302d12a77327a461240871fba90ae_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/sai-an-ji-yin-cheng)

[艺赛旗RPA](https://www.zhihu.com/people/sai-an-ji-yin-cheng)

拥有自主知识产权的RPA厂商

1 人赞同了该文章

学Python,用RPA

艺赛旗RPA2020.1版本 正在免费下载使用中，欢迎下载使用

[艺赛旗-RPA机器人免费下载|提供流程自动化解决方案www.i-search.com.cn/index.html?from=line1![img](https://pic3.zhimg.com/v2-2ca909238136d5436e0408bff6a3d53a_180x120.jpg)](https://link.zhihu.com/?target=http%3A//www.i-search.com.cn/index.html%3Ffrom%3Dline1)

python 是跨平台语言，有时候我们的程序需要运行在不同系统上，例如：linux、MacOs、 Windows，为了使程序有更好通用性，需要根据不同系统使用不同操作方式。我们可以使用 platform 模块来获取系统信息。platform 是 python 自带模块，我们可以直接使用，下面来介绍这个模块：

### 首先导入模块：

```text
import platform
```

### 常用方法如下：

> platform.platform() 获取操作系统及版本信息platform.version() 获取系统版本号platform.system() 获取系统名称platform.architecture()系统位数 ( 例如：32Bit, 64bit)platform.machine() 计算机类型，例如：x86, AMD64platform.node() 计算机名称，例如：xxx-PCplatform.processor() 处理器类型platform.uname() 以上所有信息

### 下面我们实际看下在 window 下获取信息：

```text
def showinfo(tip, info):
    print("{}:{}".format(tip,info))


showinfo("操作系统及版本信息",platform.platform())
showinfo('获取系统版本号',platform.version())
showinfo('获取系统名称', platform.system())
showinfo('系统位数', platform.architecture())
showinfo('计算机类型', platform.machine())
showinfo('计算机名称', platform.node())
showinfo('处理器类型', platform.processor())
showinfo('计算机相关信息', platform.uname())
```

输出结果如下：

```text
操作系统及版本信息:Windows-10-10.0.17134-SP0
获取系统版本号:10.0.17134
获取系统名称:Windows
系统位数:('64bit', 'WindowsPE')
计算机类型:AMD64
计算机名称:DESKTOP-83IAUFP
处理器类型:Intel64 Family 6 Model 142 Stepping 10, GenuineIntel
计算机相关信息:uname_result(system='Windows', node='DESKTOP-83IAUFP', release='10', version='10.0.17134', machine='AMD64', processor='Intel64 Family 6 Model 142 Stepping 10, GenuineIntel')
```

### 我们再换 Ubuntu 执行，输出结果如下：

```text
操作系统及版本信息:Linux-4.13.0-39-generic-x86_64-with-debian-stretch-sid
获取系统版本号:#44~16.04.1-Ubuntu SMP Thu Apr 5 16:43:10 UTC 2018
获取系统名称:Linux
系统位数:('64bit', '')
计算机类型:x86_64
计算机名称:ubuntu
处理器类型:x86_64
计算机相关信息:uname_result(system='Linux', node='ubuntu', release='4.13.0-39-generic', version='#44~16.04.1-Ubuntu SMP Thu Apr 5 16:43:10 UTC 2018', machine='x86_64', processor='x86_64')
```

不仅可以使用 platform.system() 获取系统类型，而且还可以获取 Python 版本相关信息，主要方法如下：

> platform.python_build() Python 编译信息platform.python_version() 获取 Python 版本信息

我们来看下当前使用 Python 相关信息：

```text
def showinfo(tip, info):
    print("{}:{}".format(tip,info))


showinfo('编译信息:', platform.python_build())
showinfo('版本信息:', platform.python_version())
```

输出结果：

```text
编译信息::('default', 'Oct 28 2018 19:44:12')
版本信息::3.6.7
```



发布于 2020-05-25 17:01

[Python](https://www.zhihu.com/topic/19552832)

[Python 开发](https://www.zhihu.com/topic/19710602)

[RPA（机器人流程自动化）](https://www.zhihu.com/topic/20115225)

赞同 1

添加评论

分享

喜欢收藏申请转载



### 文章被以下专栏收录