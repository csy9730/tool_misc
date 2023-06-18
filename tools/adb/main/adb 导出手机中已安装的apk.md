# adb 导出手机中已安装的apk

[![img](https://p3-passport.byteimg.com/img/user-avatar/66ba8a6be63641217382abf1d90c4214~100x100.awebp)](https://juejin.cn/user/4486468983602813)

[Ang229![创作等级LV.3](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/922e26916a444513bceddad5bcf437e1~tplv-k3u1fbpfcp-no-mark:0:0:0:0.awebp)](https://juejin.cn/user/4486468983602813)

2021年07月04日 19:46 · 阅读 1042

前提：手机或者运行着Android系统的设备连接到PC端

1，查看手机中已安装的所有apk文件

```bash
adb shell pm list package
```

![img](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/2ba13ec6065e4dc884e9f550ee3bccb0~tplv-k3u1fbpfcp-zoom-in-crop-mark:4536:0:0:0.awebp)

2， 根据要导出的app包名，查看APP安装路径

```bash
# com.DeviceTest 是我要导出的APP包名
adb shell pm path com.DeviceTest
```

![img](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/ce84ba9210ca4a3db38315f287f9f2ad~tplv-k3u1fbpfcp-zoom-in-crop-mark:4536:0:0:0.awebp)

3，根据以上路径导出apk源文件到PC端

```bash
# app在手机中的存放路径： /system/priv-app/DeviceTest/DeviceTest.apk  
# app导出的目标apk在PC端的存放路径  C:\Users\Administrator\Desktop\
adb pull /system/priv-app/DeviceTest/DeviceTest.apk C:\Users\Administrator\Desktop\
```

> 如果对您有所帮助的话
>
> 不妨加个关注，点个赞哈，您的每个小小举动都是对我莫大的支持！

分类：

[Android](https://juejin.cn/android)

标签：

[Android](https://juejin.cn/tag/Android)