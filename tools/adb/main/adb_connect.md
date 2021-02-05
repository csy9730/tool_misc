# adb connect

## misc

### 台式电脑可以控制多少台手机
**Q**: 一台台式电脑可以控制多少台手机？
**A**: 
ADB是服务通过扫描奇数端口5555 至5585查找  Android模拟器或设备。而且每个设备占用2个端口，偶数端口Android设备控制台，奇数端口Android与ADB的连接。如下：

 Note that each emulator/device instance acquires a pair of sequential ports — an even-numbered port for console connections and an odd-numbered port for adb connections. For example:

Emulator 1, console: 5554
Emulator 1, adb: 5555
Emulator 2, console: 5556
Emulator 2, adb: 5557 ...

那就是说，一个PC端的ADB最多同时连接 15台 Android设备（包括模拟器），超过15台的Android设备将不连接。

### wifi

也可以通过wifi进行无线连接

#### 手机端配置tcp方式连接

需先连上usb模式, 开启远程调试模式，然后打开监听5555端口
 $ adb tcpip 5555

$ adb shell ip addr 



#### 手机端su wifi

利用IP地址进行的无线连接是官方文档里介绍的方法，需要借助于 USB 数据线来实现无线连接。root 账户可以完成真正意义上的无线连接

1. 在 Android 设备上安装一个终端模拟器。

   已经安装过的设备可以跳过此步。终端模拟器下载地址是：[Terminal Emulator for Android Downloads](https://jackpal.github.io/Android-Terminal-Emulator/)

2. 将 Android 设备与要运行 adb 的电脑连接到同一个局域网，比如连到同一个 WiFi。

3. 打开 Android 设备上的终端模拟器，在里面依次运行命令：

   ```
   su
   setprop service.adb.tcp.port 5555
   1. stop adbd
   2. start adbd
   ```

4. 找到 Android 设备的 IP 地址。

   同上

5. 在电脑上通过 adb 和 IP 地址连接 Android 设备。

   ```
   adb connect <device-ip-address> # 看到 connected to <device-ip-address>:5555 这样的输出则表示连接成功
   ```


####  电脑端使用adb远程连接

``` bash
adb connect ip_address 
adb connect 192.168.1.4:5555 # 例如连接 指定地址
```

####  misc

通过wifi进行远程连接手机进行调试的.
 [https://developer.android.com/studio/command-line/adb.html#wireless](https://link.jianshu.com?t=https://developer.android.com/studio/command-line/adb.html#wireless)



### 以太网共享

一、以太网共享有两个方向的理解：

1、通过以太网给android设备供网，对应设置中的Ethernet选项

2、android设备通过以太网给其它终端供网，对应设置中的便携式热点以太网共享-ethernet tethering

二、实现方法

通过`adb shell settings list global` 来获取设置项，


通过`adb shell settings list global` 来获取设置项，

ethernet_on就是以太网共享的设值，总共包括以下三个值

ethernet_on=1 表示关闭以太网共享。设置中的Ethernet 处于关闭状态，便携式热点的Ethernet tethering 处于关闭状态。此时既不能通过以太网给自己供网，也不能通过以太网给其它终端供网。

ethernet_on=2 表示以太网共享打开。设置中的Ethernet 处于打开状态，便携式热点的Ethernet tethering 处于关闭状态，此时android设备可以通过以太网上网

ethernet_on=3 表示以太网共享打开。设置中的Ethernet 处于关闭状态，便携式热点的Ethernet tethering 处于打开状态，此时上行4G或Wi-Fi可以通过以太网给其它的终端供网。

`adb shell settings put global ethernet_on 2`



### adb unstable
```
lsusb

cd /etc/udev/rules.d/

sudo vim 51-android.rules

# SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", MODE="0666"
```