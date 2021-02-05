# vscode不写一行配置，用cmake傻瓜式搭建C++编译调试环境

[![yushulx](https://pic1.zhimg.com/v2-6642e4d180e44763b9e64628df62f5fc_xs.jpg)](https://www.zhihu.com/people/yushulx)

[yushulx](https://www.zhihu.com/people/yushulx)

他强由他强，清风拂山岗；他横任他横，明月照大江



22 人赞同了该文章

网上看了一些用vscode+cmake搭建C++编译调试环境的帖子，基本差不多，都要写一个配置文件。其实根本不用这么麻烦。安装的工具是一样的，但是操作可以更加简单。

## VSCode + CMake超简单用法

首先安装好平台上的C++编译器，这里不多说。 然后安装vscode中的C++，cmake，cmake tools插件。

![img](https://pic4.zhimg.com/80/v2-14b7b1504542e9c82df8c1b6f84d1be7_720w.jpg)

![img](https://pic4.zhimg.com/80/v2-9cb52dcf7b7cde4755f98520f3232b27_720w.jpg)

准备工作完成之后，按F1，选择cmake:Quick Start就可以创建一个cmake工程。

![img](https://pic3.zhimg.com/80/v2-5e4561b7615ff293d394d27d5fc955ca_720w.jpg)

接下来点击左侧栏的CMake工具按钮。

![img](https://pic1.zhimg.com/80/v2-590dbf60a097063661da60912f5e3d40_720w.jpg)

右键可执行文件，选择Debug。

![img](https://pic1.zhimg.com/80/v2-4dd3c950f470d644a7fd2af5dfac52e8_720w.jpg)

进入调试界面。

![img](https://pic1.zhimg.com/80/v2-624d297cb5640df5c2fe4a0bb88ea0fc_720w.jpg)

就这么简单，工程目录下不用手动编写任何配置文件。