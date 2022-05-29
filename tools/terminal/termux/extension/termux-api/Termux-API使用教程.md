# Termux-API 使用教程

[Android ](https://www.sqlsec.com/tags/Android/)[Termux](https://www.sqlsec.com/tags/Termux/)

 [Others](https://www.sqlsec.com/ggs/Others/)

发布日期: 2018-05-03

更新日期: 2021-06-10

文章字数: 3.9k

阅读时长: 16 分

阅读次数:

------



![img](https://image.3001.net/images/20200420/1587370530651.jpg)



因为之前的文章：[Termux 高级终端安装使用配置教程](https://www.sqlsec.com/2018/05/termux.html) 篇幅太长了，而且手机用户浏览起来已经很卡顿了，所以单独把之前冗长的 Termux API 部分开了一篇文章来记录，提高用户的浏览体验。



# 准备工作

## 安装Termux:API

**下载地址**

- [Termux:API Google Play 下载地址](https://play.google.com/store/apps/details?id=com.termux.api)
- [Termux:API F-Droid 下载地址](https://f-droid.org/packages/com.termux.api/)

> 请勿在Google Play 和 F-Droid 之间混合安装Termux 和 插件。



![img](https://image.3001.net/images/20200420/1587370530651.jpg)



## 给 app 权限

因为 Termux-api 可以直接操作手机底层，所以我们需要到手机的设置里面给 这个 APP 的权限全部开了，这样下面操作的时候就不会提示权限不允许的情况了。



![img](https://image.3001.net/images/20200420/15873722473744.jpg)



## 安装 Termux-api 软件包

手机安装完 Termux-api 的APP后，Termux 终端里面必须安装对应的包后才可以与手机底层硬件进行交互。

Bash





bash

```bash
pkg install termux-api
```

下面只列举一些可能会用到的,想要获取更多关于`Termux-api`的话,那就去参考官方文档.

# 获取设备信息相关

## 电池信息





bash

```bash
termux-battery-status
```

参数无，返回信息是 JSON 格式。 可以看到电池的-健康状况-电量百分比-温度情况等：





bash

``` json
{
  "health": "GOOD",
  "percentage": 100,
  "plugged": "UNPLUGGED",
  "status": "DISCHARGING",
  "temperature": 24.600000381469727
}
```

## 获取相机信息





bash

```bash
termux-camera-info
```

参数无，返回信息是JSON格式。

## 获取通讯录列表

参数无，返回信息是 JSON 格式。





bash

```bash
termux-contact-list  
```



![img](https://image.3001.net/images/20200420/15873737022902.jpg)



## 查看红外载波频率





bash

```bash
termux-infrared-frequencies
```

## 获取无线电信息

无参数，返回格式是JSON 格式





bash

```bash
termux-telephony-cellinfo
```

## 查看手机运营商信息

无参数，返回格式是 JSON 格式





bash

```bash
termux-telephony-deviceinfo
```

国光的实际测试返回值：





json

```json
{
  "data_enabled": "true",
  "data_activity": "dormant",
  "data_state": "disconnected",
  "device_id": null,
  "device_software_version": "00",
  "phone_count": 2,
  "phone_type": "gsm",
  "network_operator": "46001",
  "network_operator_name": "中国联通",
  "network_country_iso": "cn",
  "network_type": "lte",
  "network_roaming": false,
  "sim_country_iso": "cn",
  "sim_operator": "46011",
  "sim_operator_name": "中国联通",
  "sim_serial_number": null,
  "sim_subscriber_id": null,
  "sim_state": "ready"
}
```

## 获取 tts 语音引擎信息





bash

```bash
termux-tts-engines
```

国光的实际演示：





json

```json
[
  {
    "name": "com.google.android.tts",
    "label": "Google 文字转语音引擎",
    "default": false
  },
  {
    "name": "com.xiaomi.mibrain.speech",
    "label": "小爱语音引擎",
    "default": true
  }
]
```

## 获取 USB 设备信息





bash

```bash
termux-usb [-l | [-r] [-e 命令] 设备]
```

选项细节：





properties

```
-l               列出可用设备
-r               如果尚未授予权限，则显示 权限请求对话框
-e command       执行指定的命令
```

Android Termux 下要读取 USB 内容或者 U盘的时候，还需要安装如下依赖包：





bash

```bash
pkg install termux-api libusb clang -y
```

有些包我们上面已经安装过了。下面国光来实际演示一下这个 API 的使用：





bash

```bash
$ termux-usb -l
[
  "/dev/bus/usb/001/002"
]
```

可以看到国光我这个 512GB 的 M.2 SSD 已经显示在列表中了 (装作不经意间说出来的样子，类似于朱一旦不经意间露出自己的劳力士一样 2333)

请求访问权限：





bash

```bash
termux-usb -r /dev/bus/usb/001/002

Access granted.
```

下面级可以尝试写代码去访问这个 USB 设备内容了:





none

```none
usbtest.c
```





c

```c
#include <stdio.h>
#include <assert.h>
#include <libusb-1.0/libusb.h>

int main(int argc, char **argv) {
    libusb_context *context;
    libusb_device_handle *handle;
    libusb_device *device;
    struct libusb_device_descriptor desc;
    unsigned char buffer[256];
    int fd;
    assert((argc > 1) && (sscanf(argv[1], "%d", &fd) == 1));
    assert(!libusb_init(&context));
    assert(!libusb_wrap_sys_device(context, (intptr_t) fd, &handle));
    device = libusb_get_device(handle);
    assert(!libusb_get_device_descriptor(device, &desc));
    printf("Vendor ID: %04x\n", desc.idVendor);
    printf("Product ID: %04x\n", desc.idProduct);
    assert(libusb_get_string_descriptor_ascii(handle, desc.iManufacturer, buffer, 256) >= 0);
    printf("Manufacturer: %s\n", buffer);
    assert(libusb_get_string_descriptor_ascii(handle, desc.iProduct, buffer, 256) >= 0);
    printf("Product: %s\n", buffer);
    assert(libusb_get_string_descriptor_ascii(handle, desc.iSerialNumber, buffer, 256) >= 0);
    printf("Serial No: %s\n", buffer);
    libusb_exit(context);
}
```

代码内容主要是 显示有关USB设备的一些基本信息，参数就是我们的设备信息。让我们编译一下：





bash

```bash
gcc usbtest.c -lusb-1.0 -o usbtest
```

编译完成后会生成可执行的文件 `usbtest` ，接下来通过 这个 API 来执行这个文件：





bash

```bash
termux-usb -e ./usbtest /dev/bus/usb/001/002

Vendor ID: 152d
Product ID: 0576
Manufacturer: Hikvision
Product: Hikvision External Disk
Serial No: 0123456789ABCDEF
```

糟糕 暴露了我的 512GB 的 SSD 居然是最廉价的 海康威视，溜了溜了 逃~

## 获取当前 WiFi 连接信息





bash

```bash
termux-wifi-connectioninfo
{
  "bssid": "xx:xx:00:00:00:00",
  "frequency_mhz": 5785,
  "ip": "192.168.31.124",
  "link_speed_mbps": 130,
  "mac_address": "xx:xx:00:00:00:00",
  "network_id": -1,
  "rssi": -69,
  "ssid": "<unknown ssid>",
  "ssid_hidden": true,
  "supplicant_state": "COMPLETED"
}
```

## 获取 WiFi 扫描信息

国光在 Android 10 上没有成功执行过这个 API， 不过以前的一加5 是可以执行的下面的图 是以前的老图:





bash

```bash
termux-wifi-scaninfo
```



![img](https://image.3001.net/images/20180503/15253138725488.png)



# 调用设置设备相关

## 调整屏幕亮度





none

```none
termux-brightness [亮度]
```

亮度的值在 0 ~ 255 之间，国光这里测试了 255 并达不到手机的最大亮度

## 拍摄照片





bash

```bash
termux-camera-photo [-c camera-id] output-file
```

`camera-id`：相机的 id，默认是 0， 相机 id 可以通过隔壁的命令来获取

下面的命令表示 使用 相机id 为 0 即后置的相机来拍摄(id 1 为前置相机)，保存的文件在当前路径下 名字叫 guoguang.jpg





bash

```bash
termux-camera-photo -c 0 guoguang.jpg
```

国光看了下后置拍摄出来的照片，有点看不下去。前置相机效果还不错，可能是因为现在手机是多个摄像头的原因，Termux 的相机算法上面没有做到足够好的优化。

## 获取与设置剪贴板

**查看当前剪贴板内容**





bash

```bash
termux-clipboard-get
```

**设置新的剪贴板内容**





bash

```bash
termux-clipboard-set PHP是世界上最好的语言
```

**效果演示**



![img](https://image.3001.net/images/20180503/15253126104329.png)



## 调用系统下载器

直接调用系统下载器，不返回任何值。而且国光我现在还没有搞清楚下载的文件到哪里去了：





bash

```bash
termux-download [-d 描述] [-t 标题] 下载的目标地址
```

国光的演示：





bash

```bash
termux-download -d 'Termux下载测试' -t 'QQ.apk' 'https://qd.myapp.com/myapp/qqteam/QQ_JS/qqlite_4.0.0.1025_537062065.apk'
```



![img](https://image.3001.net/images/20200420/1587380032335.jpg)



## 调用指纹传感器

该 API 仅适用于Android 6 及其以上版本，不接受任何参数，返回 JSON 格式。





bash

```bash
termux-fingerprint
```



![img](https://image.3001.net/images/20200420/15873809591596.jpg)



返回内容：





json

```json
{
  "errors": [],
  "failed_attempts": 0,
  "auth_result": "AUTH_RESULT_SUCCESS"
}
```

## 调用红外发射





bash

```bash
termux-infrared-transmit -f 发射频率
```

频率以逗号分隔，例如 `20,50,20,30` ，仅传输短于2秒的码型。

## 调用手机定位

输出格式为 JSON 格式





bash

```bash
termux-location [-p 定位方式] [-r 定位请求]
```

细节参数：





bash

```bash
-p provider [gps/network/passive] (默认: gps)
-r request   [once/last/updates] (默认: once)
```

实际演示：





bash

```bash
termux-location -p network
```

返回内容（关键地方已经打马赛克处理了 防止网友顺着网线打过来）:





json

```json
{
  "latitude": "xx.xxxxxxx",
  "longitude": "xx.xxxxxxx",
  "altitude": 0.0,
  "accuracy": "xx.0",
  "vertical_accuracy": 0.0,
  "bearing": 0.0,
  "speed": 0.0,
  "elapsedMs": 7,
  "provider": "network"
}
```

## 播放媒体文件

使用 Media Player API播放指定的文件。





bash

```bash
termux-media-player [命令] [参数]
```

详细参数：





bash

```bash
info        # 显示当前播放信息
play        # 恢复播放
play <file> # 播放指定文件
pause       # 暂停播放
stop        # 停止退出播放
```

国光的实际演示：





bash

```bash
# 播放 hacker.mp4 视频
$ termux-media-player play hacker.mp4
Now Playing: hacker.mp4

# 查看当前播放信息
$ termux-media-player info
Status: Playing
Track: hacker.mp4
Current Position: 01:28 / 15:13

# 退出播放
$ termux-media-player stop
Stopped playback
Track cleared
```

## 调用麦克风





none

```none
termux-microphone-record [参数]
```

参数细节：





properties

```
-d           使用默认设置录制
-f <file>    录制到特定文件
-l <limit>   使用指定的时间录制（以秒为单位，无限制为0）
-e <encoder> 使用指定的编码器录制（aac， amr_wb，amr_nb）
-b <bitrate> 使用指定的比特率录制（以kbps为单位）
-r <rate>    使用指定的采样率录制（以Hz为单位）
-c <count>   使用指定的通道录制（1， 2，...）- 
-i           获取有关当前录音的信息
-q           退出录音
```

国光的实际演示：





bash

```bash
$ termux-microphone-record -d
Recording started: /storage/emulated/0/TermuxAudioRecording_2020-04-20_19-50-51.m4a
Max Duration: 15:00

$ termux-microphone-record -i
{
  "isRecording": true,
  "outputFile": "\/storage\/emulated\/0\/TermuxAudioRecording_2020-04-20_19-50-51.m4a"
}

$ termux-microphone-record -q
Recording finished: /storage/emulated/0/TermuxAudioRecording_2020-04-20_19-50-51.m4a
```

## 显示系统通知

显示系统通知，通知内容使用 `-c` 或者 `--content` 读取，或者从 `stdin` 读取





bash

```bash
termux-notification [选项]
```

**选项细节**





properties

```
--action action          按下通知时要执行的动作
--alert-once             不会在编辑通知时发出警报
--button1 text           文本将显示在第一个通知按钮上
--button1-action action  动作将在第一个通知按钮上执行
--button2 text           在第二个通知按钮上显示的文本
--button2-action action  在第二个通知按钮上执行的动作
--button3 text           在第三通知按钮上显示的文本
--button3-action action  在第三个通知按钮上执行的动作通知按钮
-c/--content content     内容显示在通知中 将优先于stdin
--group group            通知组（与同一组的通知一起显示）
-h/--help                显示此帮助
--help-actions           显示action的帮助
-i/--id id               通知id（将覆盖以前的任何通知具有相同ID的图像）
--image-path path        路径将在通知中显示的图像的绝对路径
--led-color rrggbb       闪烁的led颜色为RRGGBB（默认值：无）
--led-off milliseconds   毫秒数使指示灯在闪烁时熄灭（默认值：800）
--led-on milliseconds    毫秒指示灯在闪烁时点亮的毫秒数（默认值：800）
--on-delete action       清除通知时要执行的操作
--ongoing                锁定通知
--priority prio          通知优先级（高/低/最大/最小/默认）
--sound                  通知时播放声音
-t/--title title         要显示的通知标题
--vibrate pattern        振动力度 逗号分隔，如500,1000,200
--type type              要使用的通知样式（default/media）
```

**媒体通知参数**

当你要使用 `--type media` 的时候详细参数：





properties

```
--media-next             在媒体 下一个按钮 上执行的操作
--media-pause            在媒体 暂停按钮 上执行的操作
--media-play             在媒体 播放按钮 上执行的操作
--media-previous         在媒体 上一个按钮 上执行的操作
```

国光的演示：





bash

```bash
termux-notification -t '国光的Termu通知测试' -c 'Hello Termux' --type default
```



![img](https://image.3001.net/images/20200420/15873849054713.jpg)



## 拨打电话





bash

```bash
termux-telephony-call [号码]
```

拨打电话给`10001`中国电信，查看下话费有没有欠费?





bash

```bash
termux-telephony-call 10001
```

## 临时窗口通知





bash

```bash
termux-toast [选项] [通知]
```

选项参数：





properties

```
-h  显示帮助信息
-b  设置背景色（默认：gray）
-c  设置文本颜色（默认：white）
-g  设置吐司的位置：[top, middle, or bottom]（默认：middle）
```

颜色可以是标准名称 比如说:red 也可以是十六进制值如`＃FF0000`，无效的颜色将恢复为默认值。

国光的实际演示：





bash

```bash
termux-toast -b white -c black Hello Termux
```



![img](https://image.3001.net/images/20200420/15873858146246.jpg)



## 开关闪光灯





bash

```bash
termux-torch [on | off]
```

## 调用 tts 语音引擎

使用系统文本语音转换（TTS）引擎朗读文本。





bsah

```bsah
termux-tts-speak [-e 引擎] [-l 语言] [-n 区域] [-v 变体] [-p 音调] [-r 速率] [-s ] [要说的话]
```

选项细节：





bash

```bash
-e engine    # 要使用的 tts 语音引擎 (详见 termux-tts-engines 这个命令)
-l language  # 要说的语言类别
-n region    # 语言的地区
-v variant   # 语言的变体
-p pitch     # 语音的语调，1 是默认的正常值
-r rate      # 语音的语速，1 是默认的正常值
-s stream    # 要使用的音频流 (默认是 NOTIFICATION) 还可以选择ALARM, MUSIC, NOTIFICATION, RING, SYSTEM, VOICE_CALL之一
```

国光的实际测试：





bash

```bash
termux-tts-speak -e "com.xiaomi.mibrain.speech" '大家转载文章注意标明文章出处啊'
```

哦豁，是不是被语音引擎的朗读吓一跳，这样可以就可以用 Termux 去调用小爱语音引擎来说一些骚话了。

## 震动手机





bash

```bash
termux-vibrate [选项]
```

选项细节：





bash

```bash
-d duration  #  以毫秒为单位的振动持续时间（默认值：1000）
-f           # 在静默模式下也会强制振动
```

## 更换手机壁纸





none

```none
termux-wallpaper [选项]
```

选项细节：





bash

```bash
-f <file>  # 将 file 文件设为壁纸
-u <url>   # 从 URL 中获取壁纸
-l         # 为锁屏设置壁纸 (Android N 及其以上)
```

国光的测试：





bash

```bash
termux-wallpaper  -u 'https://cn.bing.com/th?id=OHR.BluebellWood_ZH-CN8128422960_1920x1080.jpg'
Wallpaper set successfully!
```

哦豁，那样自动换壁纸的操作 岂不是就很简单了！这个国光下面单独开章节来讲解。

## 开启关闭 WiFi





bash

```bash
termux-wifi-enable [true | false]
```

# 交互对话框部件

这个功能有点强大，可以与用户进行交互，输出格式是 JSON





bash

```bash
termux-dialog  [选项]
```

基本用法：





verilog

```verilog
-l, list   列出所有小部件及其选项
-t, title  标题设置输入对话框的标题（可选）
```

选项说明具体看下面国光的实际演示：

## confirm





properties

```
confirm - 显示确认对话框
    [-i 提示] 文本提示 (可选)
    [-t 标题] 设置对话框标题 (可选)
```

国光的演示：





bash

```bash
termux-dialog confirm -i 'Hello Termux' -t 'confirm测试'
```



![img](https://image.3001.net/images/20200420/15873743704162.jpg)



返回内容：





json

```json
{
  "code": 0,
  "text": "yes"
}
```

## checkbox





properties

```
checkbox - 使用复选框选择多个值
    [-v ",,,"] 多个值用逗号隔开 (必选)
    [-t 标题] 设置对话框的标题 (可选)
```

国光的演示：





bash

```bash
termux-dialog checkbox -v 'Overwatch,GTA5,LOL' -t '平时喜欢玩啥游戏'
```



![img](https://image.3001.net/images/20200420/15873748583525.jpg)



返回内容：





json

```json
{
  "code": -1,
  "text": "[Overwatch]",
  "values": [
    {
      "index": 0,
      "text": "Overwatch"
    }
  ]
}
```

## counter





properties

```
counter - 选择指定范围内的数字
    [-r 最小值,最大值,开始值] 3个值用逗号隔开 (可选l)
    [-t 标题] 设置对话框的标题 (可选)
```

国光的演示：



![哎呀 国光的身高暴露了](https://image.3001.net/images/20200420/15873766335596.jpg)

**哎呀 国光的身高暴露了**



返回内容：





json

```json
{
  "code": -1,
  "text": "181"
}
```

## date





properties

```
date - 选择一个日期e
    [-d "dd-MM-yyyy k:m:s"] 用于日期小部件输出的SimpleDateFormat模式(可选)
    [-t 标题] 设置对话框的标题 (可选)
```

国光的演示：





bash

```bash
termux-dialog date -d 'yyyy-MM-dd' -t '你的出生日期是?'
```



![img](https://image.3001.net/images/20200420/15873771368014.jpg)



返回内容：





json

```json
{
  "code": -1,
  "text": "2020-04-20"
}
```

## radio





properties

```
radio - 从单选按钮中选择一个值
    [-v ",,,"] 多个值用逗号隔开 (必选)
    [-t 标题] 设置对话框的标题 (可选)
```

国光的演示：





bash

```bash
termux-dialog radio -v '小哥哥,小姐姐' -t '你的性别是?'
```



![img](https://image.3001.net/images/20200420/15873781275987.jpg)



返回内容：





json

```json
{
  "code": -1,
  "text": "小哥哥",
  "index": 0
}
```

## sheet





properties

```
sheet - 从底部工作表中选择一个值
    [-v ",,,"] 多个值用逗号隔开 (必选)
    [-t 标题] 设置对话框的标题 (可选)
```

国光的演示：





bash

```bash
termux-dialog sheet -v '菜鸡,国光'
```



![img](https://image.3001.net/images/20200420/15873784445059.jpg)



返回内容：





json

```json
{
  "code": 0,
  "text": "国光",
  "index": 1
}
```

## spinner





properties

```
spinner - 从下拉微调器中选择一个值
    [-v ",,,"] 多个值用逗号隔开 (必选)
    [-t 标题] 设置对话框的标题 (可选)
```

国光的演示：





bash

```bash
termux-dialog spinner -v '国光,光光' -t '你最喜欢的博主是?'
```



![img](https://image.3001.net/images/20200420/15873786619272.jpg)



返回内容：





json

```json
{
  "code": -1,
  "text": "国光",
  "index": 0
}
```

## text





properties

```
text - 输入文本（如果未指定小部件，则为默认值）
    [-i 提示] 文本提示（可选）
    [-m] 多行输入（可选）*
    [-n] 输入数字 （可选）*
    [-p] 输入密码（可选）
    [-t 标题] 设置对话框的标题 (可选)
       *不能将[-m]与[-n]一起使用
```

国光的演示：





bash

```bash
termux-dialog text -i '密码:' -t '请输入核弹爆炸密码'
```



![img](https://image.3001.net/images/20200420/15873791181885.jpg)



返回内容：





json

```json
{
  "code": -1,
  "text": "666666",
  "index": 0
}
```

## time





properties

```
time - 选择一个时间值
     [-t 标题] 设置对话框的标题 (可选)
```

国光的演示：





bash

```bash
termux-dialog time -t '你每天多少点睡觉?'
```



![img](https://image.3001.net/images/20200420/15873792448544.jpg)



返回内容：





json

```json
{
  "code": -1,
  "text": "19:30",
  "index": 0
}
```

# 支持一下

本文可能实际上也没有啥技术含量，但是写起来还是比较浪费时间的，在这个喧嚣浮躁的时代，个人博客越来越没有人看了，写博客感觉一直是用爱发电的状态。如果你恰巧财力雄厚，感觉本文对你有所帮助的话，可以考虑打赏一下本文，用以维持高昂的服务器运营费用（域名费用、服务器费用、CDN费用等）

| 微信![img](https://image.3001.net/images/20200421/1587449920128.jpg) | 支付宝![img](https://image.3001.net/images/20200421/15874503376388.jpg) |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
|                                                              |                                                              |

没想到文章加入打赏列表没几天 就有热心网友打赏了 于是国光我用 Bootstrap 重写了一个页面 用以感谢 支持我的朋友，详情请看 [打赏列表 | 国光](https://www.sqlsec.com/dashang.html)

# 交作业

看到本文的朋友们一定用 Termux API 做了一些比 Geek 的事情吧，欢迎在评论区附上你写的极客脚本，国光会不定期筛选不错的脚本更新到本版块的，欢迎广大网友踊跃留言，23333

------

***文章作者:\*** [国光](https://www.sqlsec.com/about)

***文章链接:\*** https://www.sqlsec.com/2018/05/termuxapi.html

***版权声明:\*** 本博客所有文章除特別声明外，均采用 [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/deed.zh) 许可协议。转载请注明来源 [国光](https://www.sqlsec.com/about) !

[Android ](https://www.sqlsec.com/tags/Android/)[Termux](https://www.sqlsec.com/tags/Termux/)