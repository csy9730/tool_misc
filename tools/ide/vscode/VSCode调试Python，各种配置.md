# VSCode调试Python，各种配置

[![亚东](https://pica.zhimg.com/v2-40f603ff627e81c5a333202d425a15a1_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/yd1234567)

[亚东](https://www.zhihu.com/people/yd1234567)

![img](https://pica.zhimg.com/v2-4812630bc27d642f7cafcd6cdeca3d7a.jpg?source=88ceefae)

硅基带路党



6 人赞同了该文章

使用VSCode有一段时间了，可能有好多人也是在用它的，因为真的方便啊。一个轻便的IDE或者说轻量级的代码编写与调试工具，应该已经能满足大部分开发工作了。为什么不用呢，这个可比几十个G的XCode、VS好多了。

但是在调试的过程中，你就会发现，它还是有几种方式的。我的版本里有至少8种配置。

![img](https://pic1.zhimg.com/80/v2-7a21b9d6653cf87d0ce91beb14723dec_720w.jpg)

下面就分别解说一下吧。

首先这些配置都是在当前项目目录下的".vscode"这个子目录下的，通常是由配置文件“launch.json”来控制。

> 可以创建一个空白目录，然后增加一个test.py文件，再按最左边的下面的图标“Run adn Debug”按钮，下边有一个“create a launch.json file” ， 可以任意编辑它了。

![img](https://pic3.zhimg.com/80/v2-ec5c3ca45ed69d5458b39141f83c496a_720w.jpg)按这个按钮也能得到这个画面

![img](https://pic3.zhimg.com/80/v2-009e0a098cb0601d84bf431fdb3d14de_720w.jpg)

**选择不同的模式，就能开始不同的配置文件编辑了。**

## Python文件模式

这个是最简单的模式了，只是把当前文件做为入口文件开始调试。只要这个文件能够调用到的其它文件中，你是可以随意打断点，同时查看调用栈及一些全局信息的。

启动它的方式很简单，直接在"Run"这个菜单下选择 “Start Debuging”就可以了，熟悉了还可以直接按“F5”这一个快捷键。

当然了，如果你愿意为此写一个配置文件“launch.json”是最好的，因为这样你能控制更多的信息，也能把它固化下来。

```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Python: 当前文件",
            "type": "python",
            "request": "launch",
            "program": "${file}",
            "console": "integratedTerminal"
        }
    ]
}
```

## 模块模式

这个模式通常是用来做一些框架开发的基础模式。比如用scrapy，就要这样写一个配置。掌握它，差不多是掌握了大部分你需要的Debug配置了。

```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Python: 模块",
            "type": "python",
            "request": "launch",
            "module": "scrapy",
            "cwd": "${workspaceFolder}",
            "args": ["crawl","zhihu"],
        }
    ]
}
```

## 远程连接模式

这个也不能说远程吧，就是服务调试模式，通常是用来Attach的。

```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Python: 远程连接",
            "type": "python",
            "request": "attach",
            "connect": {
                "host": "localhost",
                "port": 5678
            },
            "pathMappings": [
                {
                    "localRoot": "${workspaceFolder}",
                    "remoteRoot": "."
                }
            ]
        }
    ]
}
```

## 使用PID连接模式

这个跟上一个差不多吧，只不过是本机的。

```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Python: 使用 PID 连接",
            "type": "python",
            "request": "attach",
            "processId": "${command:pickProcess}"
        }
    ]
}
```

## Django模式

这个名字看了就应该很熟嘛，Django相关的配置文件。可以在args里，增加你想要的端口啥的。

```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Python: Django",
            "type": "python",
            "request": "launch",
            "program": "${workspaceFolder}/manage.py",
            "args": [
                "runserver"
            ],
            "django": true
        }
    ]
}
```

## FastAPI模式

这个模式我真没有用过，不太清楚怎么玩。从介绍上看，依然是一个Web框架。难道大Python都用来开发Web了？下次我要介绍一下怎么用Environment，开发人工智能吧。

```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Python: FastAPI",
            "type": "python",
            "request": "launch",
            "module": "uvicorn",
            "args": [
                "main:app"
            ],
            "jinja": true
        }
    ]
}
```

## Flask模式

跟Django差不多，有人喜欢它，有人喜欢Django

```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Python: Flask",
            "type": "python",
            "request": "launch",
            "module": "flask",
            "env": {
                "FLASK_APP": "app.py",
                "FLASK_ENV": "development"
            },
            "args": [
                "run",
                "--no-debugger"
            ],
            "jinja": true
        }
    ]
}
```

## Pyramid模式

这也是一个Web开发框架，看来程序员的世界从来不缺乏轮子。但是这个轮子我真的没有学过啊。

```json
{
   "version": "0.2.0",
    "configurations": [
        {
            "name": "Python: Pyramid 应用",
            "type": "python",
            "request": "launch",
            "module": "pyramid.scripts.pserve",
            "args": [
                "${workspaceFolder}/development.ini"
            ],
            "pyramid": true,
            "jinja": true
        }
    ]
}
```

参考

[Debugging in Visual Studio Code](https://link.zhihu.com/?target=https%3A//code.visualstudio.com/docs/editor/debugging)

[Debugging in Visual Studio Code](https://link.zhihu.com/?target=https%3A//code.visualstudio.com/docs/editor/debugging%23_launch-configurations)

[Using Python Environments in Visual Studio Code](https://link.zhihu.com/?target=https%3A//code.visualstudio.com/docs/python/environments)

[Get Started Tutorial for Python in Visual Studio Code](https://link.zhihu.com/?target=https%3A//code.visualstudio.com/docs/python/python-tutorial%23_configure-and-run-the-debugger)

编辑于 2021-05-27 09:39

集成开发环境

Visual Studio Code

Python