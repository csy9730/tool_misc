
# adb input


## input

模拟按键/输入:`adb shell input keyevent keycode `

不同的 keycode有不同的功能：



| keycode | 含义                           |
| ------- | ------------------------------ |
| 3       | HOME 键                        |
| 4       | 返回键                         |
| 5       | 打开拨号应用                   |
| 6       | 挂断电话                       |
| 26      | 电源键                         |
| 27      | 拍照（需要在相机应用里）       |
| 61      | Tab键                          |
| 64      | 打开浏览器                     |
| 67      | 退格键                         |
| 80      | 拍照对焦键                     |
| 82      | 菜单键                         |
| 85      | 播放/暂停                      |
| 86      | 停止播放                       |
| 92      | 向上翻页键                     |
| 93      | 向下翻页键                     |
| 111     | ESC键                          |
| 112     | 删除键                         |
| 122     | 移动光标到行首或列表顶部       |
| 123     | 移动光标到行末或列表底部       |
| 124     | 插入键                         |
| 164     | 静音                           |
| 176     | 打开系统设置                   |
| 207     | 打开联系人                     |
| 208     | 打开日历                       |
| 209     | 打开音乐                       |
| 220     | 降低屏幕亮度                   |
| 221     | 提高屏幕亮度                   |
| 223     | 系统休眠                       |
| 224     | 点亮屏幕                       |
| 224     | 点亮屏幕                       |
| 224     | 点亮屏幕                       |
| 231     | 打开语音助手                   |
| 276     | 如果没有 wakelock 则让系统休眠 |

0 --> "KEYCODE_UNKNOWN"
1 --> "KEYCODE_MENU"
2 --> "KEYCODE_SOFT_RIGHT"
3 --> "KEYCODE_HOME"
4 --> "KEYCODE_BACK"
5 --> "KEYCODE_CALL"
6 --> "KEYCODE_ENDCALL"
7 --> "KEYCODE_0"
8 --> "KEYCODE_1"
9 --> "KEYCODE_2"
10 --> "KEYCODE_3"
11 --> "KEYCODE_4"
12 --> "KEYCODE_5"
13 --> "KEYCODE_6"
14 --> "KEYCODE_7"
15 --> "KEYCODE_8"
16 --> "KEYCODE_9"
17 --> "KEYCODE_STAR"
18 --> "KEYCODE_POUND"
19 --> "KEYCODE_DPAD_UP"
20 --> "KEYCODE_DPAD_DOWN"
21 --> "KEYCODE_DPAD_LEFT"
22 --> "KEYCODE_DPAD_RIGHT"
23 --> "KEYCODE_DPAD_CENTER"
24 --> "KEYCODE_VOLUME_UP"
25 --> "KEYCODE_VOLUME_DOWN"
26 --> "KEYCODE_POWER"
27 --> "KEYCODE_CAMERA"
28 --> "KEYCODE_CLEAR"
29 --> "KEYCODE_A"
30 --> "KEYCODE_B"
31 --> "KEYCODE_C"
32 --> "KEYCODE_D"
33 --> "KEYCODE_E"
34 --> "KEYCODE_F"
35 --> "KEYCODE_G"
36 --> "KEYCODE_H"
37 --> "KEYCODE_I"
38 --> "KEYCODE_J"
39 --> "KEYCODE_K"
40 --> "KEYCODE_L"
41 --> "KEYCODE_M"
42 --> "KEYCODE_N"
43 --> "KEYCODE_O"
44 --> "KEYCODE_P"
45 --> "KEYCODE_Q"
46 --> "KEYCODE_R"
47 --> "KEYCODE_S"
48 --> "KEYCODE_T"
49 --> "KEYCODE_U"
50 --> "KEYCODE_V"
51 --> "KEYCODE_W"
52 --> "KEYCODE_X"
53 --> "KEYCODE_Y"
54 --> "KEYCODE_Z"
55 --> "KEYCODE_COMMA"
56 --> "KEYCODE_PERIOD"
57 --> "KEYCODE_ALT_LEFT"
58 --> "KEYCODE_ALT_RIGHT"
59 --> "KEYCODE_SHIFT_LEFT"
60 --> "KEYCODE_SHIFT_RIGHT"
61 --> "KEYCODE_TAB"
62 --> "KEYCODE_SPACE"
63 --> "KEYCODE_SYM"
64 --> "KEYCODE_EXPLORER"
65 --> "KEYCODE_ENVELOPE"
66 --> "KEYCODE_ENTER"
67 --> "KEYCODE_DEL"
68 --> "KEYCODE_GRAVE"
69 --> "KEYCODE_MINUS"
70 --> "KEYCODE_EQUALS"
71 --> "KEYCODE_LEFT_BRACKET"
72 --> "KEYCODE_RIGHT_BRACKET"
73 --> "KEYCODE_BACKSLASH"
74 --> "KEYCODE_SEMICOLON"
75 --> "KEYCODE_APOSTROPHE"
76 --> "KEYCODE_SLASH"
77 --> "KEYCODE_AT"
78 --> "KEYCODE_NUM"
79 --> "KEYCODE_HEADSETHOOK"
80 --> "KEYCODE_FOCUS"
81 --> "KEYCODE_PLUS"
82 --> "KEYCODE_MENU"
83 --> "KEYCODE_NOTIFICATION"
84 --> "KEYCODE_SEARCH"
85 --> "TAG_LAST_KEYCODE"

KEYCODE_BREAK
Break/Pause键
121

KEYCODE_SCROLL_LOCK
滚动锁定键
116

KEYCODE_ZOOM_IN
放大键
168

KEYCODE_ZOOM_OUT
缩小键
169



滑动解锁：如果锁屏没有密码，是通过滑动手势解锁，那么可以通过 input swipe 来解锁。
命令:

adb shell input swipe 300 1000 300 500
(其中参数 300 1000 300 500 分别表示起始点x坐标 起始点y坐标 结束点x坐标 结束点y坐标。)
输入文本:在焦点处于某文本框时，可以通过 input 命令来输入文本。
命令：adb shell input text *** (***即为输入内容)

### 点击

adb shell input tap x y

使用 Monkey 进行压力测试：Monkey 可以生成伪随机用户事件来模拟单击、触摸、手势等操作，可以对正在开发中的程序进行随机压力测试。
简单用法：adb shell monkey -p < packagename > -v 500 表示向 指定的应用程序发送 500 个伪随机事件。



异常现象： 使用vivo手机时发现通过inputManager发送按键、执行屏幕滑动等动作失效，相关API并没有任何异常抛出，继续跟踪发现shell控制台执行input进行屏幕滑动、发送文本、模拟按键等动作时命令返回Killed
解决方案：1、打开开发者设置；2、开启 “USB安全权限”


**Q**: 拨打电话
**A**: 
adb shell service call phone 2 s16 10001
adb shell am start -a android.intent.action.CALL tel:10086


**Q**: 发送短信
**A**: 
1. adb shell am start -a android.intent.action.SENDTO -d sms:10086 --es sms_body  hello  打开了短信应用程序，当前焦点在文本框
2. adb shell input keyevent 22  焦点去到发送按键
3. adb shell input keyevent 66  回车，就是按下发送键

## file transfer

``` bash
file transfer:
 push [--sync] LOCAL... REMOTE
     copy local files/directories to device
     --sync: only push files that are newer on the host than the device
 pull [-a] REMOTE... LOCAL
     copy files/dirs from device
     -a: preserve file timestamp and mode
 sync [all|data|odm|oem|product_services|product|system|vendor]
     sync a local build from $ANDROID_PRODUCT_OUT to the device (default all)
     -l: list but don't copy

```
##  output

实用功能：
截图保存到电脑：adb exec-out screencap -p > sc.png
然后将 png 文件导出到电脑：adb pull /sdcard/sc.png
录制屏幕：录制屏幕以 mp4 格式保存到 /sdcard：

`adb shell screenrecord /sdcard/filename.mp4`

 需要停止时按 Ctrl-C，默认录制时间和最长录制时间都是 180 秒。
如果需要导出到电脑：adb pull /sdcard/filename.mp4

挂载、查看连接过的 WiFi 密码、开启/关闭 WiFi、设置系统日期和时间都需要root权限，不做多说。


