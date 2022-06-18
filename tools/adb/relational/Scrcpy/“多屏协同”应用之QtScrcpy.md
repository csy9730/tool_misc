# “多屏协同”应用之QtScrcpy

[![img](https://cdn2.jianshu.io/assets/default_avatar/13-394c31a9cb492fcb39c27422ca7d2815.jpg)](https://www.jianshu.com/u/eca8c5f4481e)

[静恒](https://www.jianshu.com/u/eca8c5f4481e)[![  ](https://upload.jianshu.io/user_badge/7220f8ab-64d9-4474-bfbc-a387c4ee5437)](https://www.jianshu.com/mobile/campaign/day_by_day/join?utm_medium=badge)关注

22021.08.07 15:05:23字数 693阅读 1,370

这个软件也是网上推荐得比较多的，但我实际使用下来看这个其实跟Lenovo one Lite很相似，在我的体验来看整体是不如Lenovo one Lite的。

![img](https://upload-images.jianshu.io/upload_images/21377043-831cade5bff75f96.png?imageMogr2/auto-orient/strip|imageView2/2/w/1014/format/webp)

QtScrcpy

我把这两个软件作一个对比：

#### 两者的共同之处：

**1、都不需要在手机端额外安装客户端app。**

**2、都有按键映射的功能，并且都自定义按键映射，可以实现电脑端玩手机游戏。**

**3、都支持有线连接，有线连接延时都是0.04s左右。**

**4、都支持自适应横竖屏，手机视频最大化时，电脑端也会自动横屏。**

#### QtScrcpy优于Lenovo one Lite的地方：

**1、多平台的支持。同时支持Windows、macOs、Linux平台，而Lenovo one Lite仅支持Wndows平台。我要想在macOS平台使用就只能在虚拟机下运行**

![img](https://upload-images.jianshu.io/upload_images/21377043-195375bdc7b32790.png?imageMogr2/auto-orient/strip|imageView2/2/w/612/format/webp)

QtScrcpy支持多平台

**2、连接方式比Lenovo one Lite多了无线方式，并且连接过程更为人性化，不再需要手动在手机上开启USB调试模式。这些工作直接在电脑端的软件就可以完成。**

#### QtScrcpy不如Lenovo one Lite的地方

**1、手机跟电脑端不能互传文件，Lenovo one Lite是可以互传文件的。**

**2、虽然都支持按键映射，但QtScrcpy的按键映射是通过json格式的脚本文件来配置不同游戏的按键映射的，通过在软件页面选择对应游戏脚本，然后点击启动脚本，最后还需要按“～”按键来激活按键映射，退出则再次按下“～”。修改按键需要修改json格式的配置文件，比较繁琐。而Lenovo的自定义配置是画面形式，是通过拖拽、重新输入按键的方式来修改按键的，这个比修改脚本文件直观得多。**

**而且我分别试验了macOS下的按键映射与Windows下的按键映射，macOS下的按键映射无法正常工作，应该是按键映射的坐标点与Windows下的不一致，导致无法正常工作。Windows下的是可以正常工作的，但实际体验效果比Lenovo one Lite差很多，用QtScrcpy的按键映射，我没法完成正常游戏，鼠标时灵时不灵；而使用Lenovo one Lite是可以正常游戏的。**

总的来说，QtScrcpy也只是适合在电脑是刷刷手机，上班摸摸鱼之类的，办公上就帮不上什么忙了。