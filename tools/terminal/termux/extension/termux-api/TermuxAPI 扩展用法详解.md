# Termux:API 扩展用法详解

[![何方](https://pic3.zhimg.com/v2-0f0577f3cde5d4bb79c2ec4eccf8523c_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/iamhefang)

[何方](https://www.zhihu.com/people/iamhefang)

https://code.iamhefang.cn

关注他

4 人赞同了该文章

## 什么是Termux:API？

Termux:API是Termux的一个扩展包，安装Termux:API以后可以在Termux里面通过命令调用安卓原生的能力，比如调用摄像头拍照、获取定位信息等等。

本文原文来自何方的软件分享站

[Termux:API用法详解 - 何方的软件分享soft.iamhefang.cn/content/termux-api-detail.html](https://link.zhihu.com/?target=https%3A//soft.iamhefang.cn/content/termux-api-detail.html)

Termux介绍请参考下面这个视频

[如何在安卓中使用完整的Linux系统？![img](https://pic2.zhimg.com/v2-0f0577f3cde5d4bb79c2ec4eccf8523c_s.jpg?source=12a79843)何方的视频 · 1914 播放](https://www.zhihu.com/zvideo/1387475378072576000)

## 如何安装Termux:API

1、 安装一个“Termux:API”的apk包。
2、安装完“Termux:API”以后打开termux主程序，执行下面的命令再安装一个“Termux:API”的命令工具。

```text
apt install termux-api
```

## Termux:API用法

下面列出的Termux:API的所有api的用法、入参和出参。需要使用哪个api可以在目录中快速跳转。

## 获取设备电池信息

**命令**：termux-battery-status

**出参**

```json
{
  "health": "GOOD", // 电池健康状态 
  "percentage": 94, // 当前电量百分比
  "plugged": "UNPLUGGED", // 是否已插入电源
  "status": "DISCHARGING", // 是否正在充电
  "temperature": 33.0, // 电池温度
  "current": 252000 // 
}
```

## 设置屏幕亮度。

**命令**：

```text
termux-brightness brightness
```

**权限**：android.permission.WRITE_SETTINGS

**入参**

| 参数       | 说明   | 默认值 | 可选  |
| ---------- | ------ | ------ | ----- |
| brightness | 亮度值 | -      | 0-255 |

## 获取通话记录列表

**命令**

```text
termux-call-log -l limit -o offset
```

**权限**：android.permission.READ_CALL_LOG

**入参**

| 参数      | 说明             | 默认值 | 可选 |
| --------- | ---------------- | ------ | ---- |
| -l limit  | 每次获取条数     | 10     | ✅    |
| -o offset | 从第几条开始获取 | 0      | ✅    |

**出参**

```json
[
  {
    "name":"名称",
    "phone_number":"号码",
    "date":"通话时间",
    "duration":"通话时长"
  }
  ...
]
```

## 获取相机信息

**命令**：termux-camera-info

**出参**

```json
[
  {
    "id": "0",
    "facing": "back",
    "jpeg_output_sizes": [
      {
        "width": 4080,
        "height": 3072
      },
      ...
    ],
    "focal_lengths": [
      7.590000152587891
    ],
    "auto_exposure_modes": [
      "CONTROL_AE_MODE_OFF",
      "CONTROL_AE_MODE_ON",
      "CONTROL_AE_MODE_ON_AUTO_FLASH",
      "CONTROL_AE_MODE_ON_ALWAYS_FLASH"
    ],
    "physical_size": {
      "width": 11.423999786376953,
      "height": 8.60159969329834
    },
    "capabilities": [
      "backward_compatible",
      "constrained_high_speed_video",
      "raw",
      "yuv_reprocessing",
      "private_reprocessing",
      "read_sensor_settings",
      "manual_sensor",
      "burst_capture",
      "manual_post_processing"
    ]
  },
  ...
]
```

## 调用摄像头拍照

**命令**：

```text
termux-camera-photo -c camera-id filename
```

**权限**：android.permission.CAMERA

**入参**

| 参数         | 说明                      | 默认值 | 可选 |
| ------------ | ------------------------- | ------ | ---- |
| -c camera-id | ermux-camera-info输出的id | 0      | ✅    |
| filename     | 文件保存的路径            | -      | ❌    |

## 获取粘贴板数据

**命令**：termux-clipboard-get

**权限**：读取粘贴板权限

**出参**：直接输出粘贴板内容

## 设置粘贴板数据

**命令**

```text
termux-clipboard-set text
```

**入参**

| 参数 | 说明                 | 默认值 | 可选 |
| ---- | -------------------- | ------ | ---- |
| text | 要复制到粘贴板的内容 | -      | ❌    |

## 获取联系人列表

**命令**：termux-contact-list

**权限**：anroid.permission.READ_CONTACTS

**出参**

```json
[
  {
    "name":"名称",
    "nuumber":"号码"
  }
  ...
]
```

## 显示弹窗

**命令**

```bash
termux-dialog confirm -t title -i hint 
termux-dialog checkbox -t title -v ",,," 
termux-dialog counter -t title -r min,max,start 
termux-dialog date -t title -d "dd-MM-yyyy k:m:s"
termux-dialog radio -t title -v ",,,"
termux-dialog sheet -t title -v ",,,"
termux-dialog spinner -t title -i hint 
termux-dialog speech -t title -i hint 
termux-dialog text -t title -i hint -m -n -p
termux-dialog time -t title
```

**入参**

| 参数                  | 说明                                                 | 默认值 | 可选 |
| --------------------- | ---------------------------------------------------- | ------ | ---- |
| -t title              | 弹窗标题                                             | -      | ✅    |
| -i hint               | 弹窗内容                                             | -      | ✅    |
| -v ",,,"              | 以逗号分割的选项列表                                 | -      | ✅    |
| -r min,max,start      | 时数弹窗的数值 min：最小值 max：最大值 start：初始值 | -      | ✅    |
| -d "dd-MM-yyyy k:m:s" | 日期弹窗的输出格式                                   | -      | ✅    |
| -m                    | 输入框弹窗多行输入，不能和-n共用                     | -      | ✅    |
| -n                    | 输入框弹窗输入数字，不能和-m共用                     | -      | ✅    |
| -p                    | 输入框弹窗输入密码                                   | -      | ✅    |

**出参**

```json
{
  "code":-1,
  "text":"值",
  "values":"格式化的值，不同类型的弹窗值不一样"
}
```

## 使用系统下载管理器下载资源。

**命令**

```bash
termux-download -d description -t title -p path url
```

**权限**：无

**入参**

| 参数           | 说明                 | 默认值 | 可选 |
| -------------- | -------------------- | ------ | ---- |
| -d description | 下载通知的描述       | -      | ✅    |
| -t title       | 下载通知的标题       | -      |      |
| -p path        | 下载文件要保存的路径 | -      | ✅    |
| url            | 要下载的url          | -      | ❌    |

## 使用指纹传感器校验身份

**命令**：termux-fingerprint

**出参**

```json
{
  "errors":[],
  "failed_attempts":0,
  "auth_result":"AUTH_RESULT_SUCCESS"
}
```

## 查询红外发射器支持的载波频率。

**命令**：termux-infrared-frequencies

**出参**

```json
[
  {
    "min": 30000,
    "max": 30000
  },
  ...
]
```

## 发送红外信号

**命令**

```bash
termux-infrared-transmit -f frequency
```

**权限**：无

**入参**

| 参数      | 说明                         | 默认值 | 可选 |
| --------- | ---------------------------- | ------ | ---- |
| frequency | 以赫兹为单位的 IR 载波频率。 | -      | ❌    |

## 延迟或定时运行Termux脚本。

**命令**：termux-job-scheduler

**权限**：无

获取当前位置。

**命令**

```bash
termux-location -p gps/network/passive -r once/last/updates
```

**入参**

| 参数                   | 说明                                         | 默认值 | 可选 |
| ---------------------- | -------------------------------------------- | ------ | ---- |
| -p gps/network/passive | 获取位置的方式                               | gps    | ✅    |
| -r once/last/updates   | 获取时机 once：一次 last：上次 updates：更新 | once   | ✅    |

**出参**

```json
{
  "latitude": 33,
  "longitude": 114,
  "altitude": 102,
  "accuracy": 90,
  "vertical_accuracy": 961,
  "bearing": 0.0,
  "speed": 0.0,
  "elapsedMs": 38,
  "provider": "gps"
}
```

## 播放媒体文件

**命令**

```bash
termux-media-player info
termux-media-player play
termux-media-player play <file>
termux-media-player pause
termux-media-player stop
```

**入参**

| 参数          | 说明             | 默认值 | 可选 |
| ------------- | ---------------- | ------ | ---- |
| info          | 查看当前播放信息 | -      | -    |
| play          | 暂停后继续播放   | -      | -    |
| play 文件路径 | 播放指定的文件   | -      | -    |
| pause         | 暂停             | -      | -    |
| stop          | 停止             | -      | -    |

## 媒体扫描

**命令**

```bash
termux-media-scan -r 目录 -v
```

**入参**

| 参数    | 说明         | 默认值 | 可选 |
| ------- | ------------ | ------ | ---- |
| -r 目录 | 要扫描的目录 | -      | ❌    |
| -v      | 详细扫描     | -      | ✅    |

## 录音

**命令**

```text
termux-microphone-record -d -f <file> -l <limit> -e <encoder> -b <bitrate> -r <rate> -c <count> -i -q
```

**权限**：android.permission.RECORD_AUDIO

**入参**

| 参数        | 说明                                | 默认值 | 可选 |
| ----------- | ----------------------------------- | ------ | ---- |
| -d          | 使用默认值录音                      | -      | -    |
| -f 文件     | 录音保存文件                        | -      | -    |
| -l 时长限制 | 录音时长限制，单位：秒，0表示不限制 | 0      | -    |
| -e 格式     | 指定录音格式 (aac, amr_wb, amr_nb)  | -      | -    |
| -b 比特率   | 指定录音比特率 (单位 kbps)          | -      | -    |
| -r 频率     | 指定录音频率 (单位 Hz)              | -      | -    |
| -c 声道数   | 指定录音声道数 (1, 2, ...)          | -      | -    |
| -i          | 获取当前录音信息                    | -      | -    |
| -q          | 退出录音                            | -      | -    |

**出参**

```json
{
  "isRecording":true,
  "outputFile":"录音文件"
}
```

## 发送通知

**命令**

```text
termux-notification
```

**入参**

| 参数                    | 说明                                         | 默认值 | 可选                     |
| ----------------------- | -------------------------------------------- | ------ | ------------------------ |
| --action action         | 点击通知时执行的动作                         | -      | -                        |
| --alert-once            | 通知被编辑时不要再次提醒                     | -      | -                        |
| --button1 text          | 在通知的第一个按钮上显示的文本               | -      | -                        |
| --button1-action action | 点击第一个按钮要执行的动作                   | -      | -                        |
| --button2 text          | 在通知的第二个按钮上显示的文本               | -      | -                        |
| --button2-action action | 点击第二个按钮要执行的动作                   | -      | -                        |
| --button3 text          | 在通知的第三个按钮上显示的文本               |        |                          |
| --button3-action action | 点击第三个按钮要执行的动作                   |        |                          |
| -c/--content content    | 要在通知中显示的内容，优先级高于标准输入     |        |                          |
| --group group           | 通知分组                                     |        |                          |
| -h/--help               | 显示帮助信息                                 |        |                          |
| --help-actions          | 显示动作定义帮助信息                         |        |                          |
| -i/--id id              | 通知id，同一id的通知两次发送时之前的将被替换 |        |                          |
| --image-path path       | 通知中要显示的图片绝对路径                   |        |                          |
| --led-color rrggbb      | 呼吸灯颜色                                   | 无     |                          |
| --led-off milliseconds  | 呼吸灯呼吸时关闭时长                         | 800    |                          |
| --led-on milliseconds   | 呼吸灯呼吸时打开时长                         | 800    |                          |
| --on-delete action      | 通知被清理时执行的动作                       | -      | -                        |
| --ongoing               | 发送持久化通知                               | -      | -                        |
| --priority prio         | 通知优先级                                   | -      | high/low/max/min/default |
| --sound                 | 通知铃声                                     | -      | -                        |
| -t/--title title        | 通知标题                                     | -      | -                        |
| --vibrate pattern       | 通知振动，时长以逗号分割 ，500,800,500,900   | -      | -                        |
| --type type             | 通知类型                                     |        | default/media            |
| --media-next            | 通知类型为media时，显示下一曲按钮            |        |                          |
| --media-pause           | 通知类型为media时，显示暂停按钮              | -      | -                        |
| --media-play            | 通知类型为media时，显示播放按钮              | -      | -                        |
| --media-previous        | 通知类型为media时，显示上一曲按钮            | -      | -                        |

## 移除通知

**命令**

```bash
termux-notification-remove id
```

**入参**

| 参数 | 说明                                                      | 默认值 | 可选 |
| ---- | --------------------------------------------------------- | ------ | ---- |
| id   | 要移除的通知id，使用termux-notification发送通知时定义的id | -      | ❌    |

## 获取传感器信息

**命令**

```bash
termux-sensor -h -a -l -s ",,," -d ms -n num
```

**入参**

| 参数     | 说明                                                   | 默认值     | 可选 |
| -------- | ------------------------------------------------------ | ---------- | ---- |
| -h       | 显示帮助信息                                           | -          | -    |
| -a       | 显示全部传感器信息和实时数据（警告：可能对电池有影响） |            |      |
| -l       | 显示可用的传感器列表                                   |            |      |
| -s ",,," | 要监听的传感器，以逗号分割                             |            |      |
| -d ms    | 接收传感器数据之前延迟，单位：ms                       |            |      |
| -n num   | 接收传感器数据次数，最小值为1。 continuous：续续接收   | continuous |      |
| -c       | 释放被占用的传感器                                     |            |      |

**出参**

```bash
{
  "sensors":[
    "可用的传感器列表",
    ...
  ]
}
```

## 分享

**命令**

```bash
termux-share -a action -c content-type -d -t title file
```

**入参**

| 参数            | 说明                                               | 默认值                                           | 可选           |
| --------------- | -------------------------------------------------- | ------------------------------------------------ | -------------- |
| -a action       | 分享内容要执行的动作类型                           | view                                             | edit/send/view |
| -c content-type | 分享的数据类型                                     | 从文件后缀猜测，如果数据是从标准输入来的，默认为 | ✅              |
| -d              | 如果选择一个则分享到默认的接收器而不显示接收器列表 | -                                                | ✅              |
| -t title        | 分享的标题                                         | 分享的文件名                                     | ✅              |

## 获取短信列表

**命令**

```bash
termux-sms-list -d -l limit -n -o offset -t type
```

**权限**：android.permission.READ_CONTACTS

**入参**

| 参数      | 说明               | 默认值 | 可选                            |
| --------- | ------------------ | ------ | ------------------------------- |
| -d        | 显示创建短信的日期 |        |                                 |
| -l limit  | 每页显示多少条数据 | 10     |                                 |
| -n        | 显示号码           | 0      |                                 |
| -o offset | 从第几个后开始获取 |        |                                 |
| -t type   | 要显示的短信类型   | inbox  | all\|inbox\|sent\|draft\|outbox |

**出参**

```json
[
  {
    "threadid":186,
    "type":"inbox",
    "read":true,
    "number":"号码",
    "received":"接收时间",
    "body":"短信内容"
  }
]
```

### 发送短信

**命令**

```text
termux-sms-send -n ",,," text
```

**权限**：android.permission.SEND_SMS

**入参**

| 参数     | 说明                         | 默认值 | 可选 |
| -------- | ---------------------------- | ------ | ---- |
| -n ",,," | 要接收短信的号码，以逗号分割 |        | ❌    |
| text     | 要发送的短信内容             |        | ❌    |

### 选择文件

**命令**

```text
termux-storage-get filename
```

**入参**

| 参数     | 说明         | 默认值 | 可选 |
| -------- | ------------ | ------ | ---- |
| filename | 要写入的文件 | -      | ❌    |

## 拨打电话

**命令**

```bash
termux-telephony-call number
```

**权限**：andriod.permission.CALL_PHONE

**入参**

| 参数   | 说明         | 默认值 | 可选 |
| ------ | ------------ | ------ | ---- |
| number | 要拨打的号码 | -      | ❌    |

## 获取区域信息

**命令**：termux-telephony-cellinfo

**权限**：定位权限

**出参**

```json
{
  "type":"类型",
  "registered":true,
  "asu":40,
  "dbm":-97,
  "level":2,
  "ci":1936181100,
  "pci":120,
  "tac":61292,
  "mcc":460,
  "mnc":1
}
```

## 获取通讯设备信息

**命令**：termux-telephony-deviceinfo

**出参**

```json
{
  "data_enabled": "true",
  "data_activity": "none",
  "data_state": "connected",
  "device_id": null,
  "device_software_version": null,
  "phone_count": 2,
  "phone_type": "gsm",
  "network_operator": "46001",
  "network_operator_name": "中国联通",
  "network_country_iso": "cn",
  "network_type": "lte",
  "network_roaming": false,
  "sim_country_iso": "cn",
  "sim_operator": "46001",
  "sim_operator_name": "中国联通",
  "sim_serial_number": null,
  "sim_subscriber_id": null,
  "sim_state": "ready"
}
```

## 显示一个Toast

**命令**

```bash
termux-toast -h -b -c -g -s text
```

**入参**

| 参数 | 说明         | 默认值 | 可选                |
| ---- | ------------ | ------ | ------------------- |
| -h   | 显示帮助信息 | -      | -                   |
| -b   | 背景色       | gray   | ✅                   |
| -c   | 前景色       | white  | ✅                   |
| -g   | 位置         | middle | top, middle, bottom |
| -s   | 短时显示     | -      | ✅                   |
| text | 要显示的内容 | -      | ❌                   |

### 打开/关闭手电筒

**命令**

```text
termux-torch status
```

**入参**

| 参数   | 说明 | 默认值 | 可选    |
| ------ | ---- | ------ | ------- |
| status | 状态 | -      | on, off |

## 获取语音引擎信息

**命令**：termux-tts-engines

**出参**

```json
[
  {
    "name":"包名",
    "label":"名称"
    "default":true
  },
  ...
]
```

## 朗读文本

**命令**

```text
termux-tts-speak -e engine -l language -n region -v variant -r rate  -s stream text
```

**入参**

| 参数        | 说明               | 默认值       | 可选                                                 |
| ----------- | ------------------ | ------------ | ---------------------------------------------------- |
| -e engine   | 要使用的语音引擎   | -            | termux-tts-engines输出的引擎                         |
| -l language | 要朗读的语言       | -            | -                                                    |
| -n region   | 要朗读语言所在区域 | -            | -                                                    |
| -v variant  | 要朗读语言的变体   | -            | -                                                    |
| -p pitch    | 朗读的声调         | 1.0          | -                                                    |
| -r rate     | 朗读的语速         | 1.0          | -                                                    |
| -s stream   | 音频流             | NOTIFICATION | ALARM, MUSIC, NOTIFICATION, RING, SYSTEM, VOICE_CALL |
| text        | 要朗读的文本       | -            | ❌                                                    |

## USB设备列表

**命令**

```bash
termux-usb -l -r -e command
```

**依赖包**

要正常使用该功能，需要安装`libusb`和`clang`包，可使用`apt install libusb clang`安装

**权限**：USB权限

**入参**

| 参数       | 说明                                             | 默认值 | 可选 |
| ---------- | ------------------------------------------------ | ------ | ---- |
| -l         | 列表所有可用的USB设备                            | -      | -    |
| -r         | 如果没有权限弹出权限请求弹窗                     | -      | -    |
| -e command | 使用引用设备的文件描述符作为其参数执行指定的命令 | -      | -    |

**-l出参**

```json
[

]
```

## 振动

**命令**

```text
termux-vibrate -d duration -f
```

**入参**

| 参数        | 说明                 | 默认值 | 可选 |
| ----------- | -------------------- | ------ | ---- |
| -d duration | 振动时长             | 1000   | ✅    |
| -f          | 在静音模式下强制振动 | -      | ✅    |

## 获取/设置音量

**命令**

```bash
termux-volume stream volume
```

**入参**

| 参数   | 说明         | 默认值 | 可选                                           |
| ------ | ------------ | ------ | ---------------------------------------------- |
| stream | 要改变的音量 | -      | alarm, music, notification, ring, system, call |
| volume | 音量         | -      | -                                              |

**不加参数出参**

```json
[
  {
    "stream": "call",
    "volume": 11,
    "max_volume": 11
  },
  {
    "stream": "system",
    "volume": 0,
    "max_volume": 15
  },
  {
    "stream": "ring",
    "volume": 10,
    "max_volume": 15
  },
  {
    "stream": "music",
    "volume": 50,
    "max_volume": 150
  },
  {
    "stream": "alarm",
    "volume": 8,
    "max_volume": 15
  },
  {
    "stream": "notification",
    "volume": 10,
    "max_volume": 15
  }
]
```

### 更改桌面壁纸

**命令**

```bash
termux-wallpaper -f file -u url -l
```

**入参**

| 参数    | 说明                     | 默认值 | 可选 |
| ------- | ------------------------ | ------ | ---- |
| -f file | 使用文件设置桌面壁纸     |        |      |
| -u url  | 使用网络资源设置桌面壁纸 |        |      |
| -l      | 设置锁屏壁纸             |        |      |

## 获取当前WiFi连接信息

**命令**：termux-wifi-connectioninfo

**出参**

```json
{
  "bssid": "02:00:00:00:00:00",
  "frequency_mhz": 5745,
  "ip": "192.168.31.251",
  "link_speed_mbps": 260,
  "mac_address": "02:00:00:00:00:00",
  "network_id": -1,
  "rssi": -68,
  "ssid": "<unknown ssid>",
  "ssid_hidden": true,
  "supplicant_state": "COMPLETED"
}
```

## 打开/关闭WiFi

**命令**

```bash
termux-wifi-enable status
```

**入参**

| 参数   | 说明             | 默认值 | 可选        |
| ------ | ---------------- | ------ | ----------- |
| status | 要更改的wifi状态 |        | true, false |

## 扫描可用WiFi

**命令**：termux-wifi-scaninfo

**权限**：定位权限

**出参**

```json
[
  {
    "bssid": "68:8b:0f:f6:6f:96",
    "frequency_mhz": 2412,
    "rssi": -50,
    "ssid": "CMCC-nJtm",
    "timestamp": 584216631835,
    "channel_bandwidth_mhz": "20"
  },
  ...
]
```



发布于 2021-06-16 14:04

「真诚赞赏，手留余香」

赞赏

还没有人赞赏，快来当第一个赞赏的人吧！

[Termux](https://www.zhihu.com/topic/20751796)

[Linux](https://www.zhihu.com/topic/19554300)

[Android](https://www.zhihu.com/topic/19603145)

赞同 4

添加评论

分享

喜欢收藏申请转载