# Android导出已安装应用程序apk文件的方案

Android导出已安装应用程序apk文件的两种方案
如果已经在Android手机上安装了App应用程序，那么Android系统会保留应用程序的apk安装副本。如果要导出这些apk文件，有以下方案：

## 命令行模式

先通过

```bash
adb shell pm list packages
```


命令列出当前手机上已经安装的apk：



假设要导出华为的相机apk：com.huawei.camera，那就得知道相机apk的存放路径，通过命令：

```bash
adb shell pm path com.huawei.camera
```


找出来华为相机的存放路径为：/system/priv-app/HwCamera2/HwCamera2.apk

然后使用命令: `adb pull `，将其导出保存到自己电脑桌面上：

```bash
adb pull /system/priv-app/HwCamera2/HwCamera2.apk  C:/Users/fly/Desktop
```




最终导出成功。



## Device File Explorer

第二张方案：通过Android Studio提供的Device File Explorer

如果知道应用程序存放到手机的路径，可以直接通过Android Studio提供的Device File Explorer工具按照adb shell pm path 命令找出的路径导出apk，例如同样的华为相机apk：