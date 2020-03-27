# termux

Termux（一个Android App,仅支持Android 5.0及以上版本 ，可以在Google Play和F-Droid上下载）是一款[开源](https://github.com/termux/termux-app)且不需要root，运行在Android上极其强大的linux模拟器，支持apt管理软件包，支持python,ruby,go,nodejs...甚至可以手机作为反向代理、或Web服务器

安装好打开之后，你将看到这样的界面

![image.png](https://upload-images.jianshu.io/upload_images/16754983-80138bd9f5a91f4f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


### 键盘输入

音量键(-)模拟Ctrl，所以你要中止输入到一半的命令，只好按下音量键(-)+c即可（等效于Ctrl+c）
你也可以使用音量键(+)+q显示扩展键：ESC、CTR、ALT、TAB、-、/、|

### 安装
``` bash
pkg update # (检查更新
pkg upgrade # 更新

pkg install nmap hydra sslscan curl tsu vim wget git unzip unrar sl clang nodejs php cmatrix tree toilet figlet cowsay w3m htop screenfetch aria2 tmux proot nginx nyancat openssh moon-buggy lua -y

pkg install python python-dev python2 python2-dev -y

apt install libxml2 libxml2-dev libxslt libxslt-dev openssl libffi libffi-dev openssl-tool openssl-dev fftw fftw-dev libzmq libzmq-dev freetype freetype-dev libpng libpng-dev pkg-config scrypt -y
pkg install libcrypt libcrypt-dev ccrypt libgcrypt libgcrypt-dev -y

pip install --force-reinstall --no-cache-dir jupyter 

python2 -m pip install --upgrade pip
python -m pip install --upgrade pip

LDFLAGS=" -lm -lcompiler_rt" pip install numpy==1.12.1 &LDFLAGS=" -lm -lcompiler_rt" pip install matplotlib pandas jupyter

pip install BeautifulSoup4 requests &pip install lxml &pip install scrapy &pip install demjson tushare colorama &pip install pillow &pip install future &pip install paramiko
```
 
 ##### bash 
``` bash

sh -c "$(curl -fsSL https://github.com/Cabbagec/termux-ohmyzsh/raw/master/install.sh)"
curl -L https://its-pointless.github.io/setup-pointless-repo.sh | sh

```

#### python

###### scrapy
``` bash
#1.1 下载安装后要首先更新包，命令行输入以下命令
apt update
apt upgrade

#1.2 安装python主程序和必要模块
#默认的python版本是3.6，为了避免安装相关模块失败，python2建议也安装了。
apt install python python-dev python2 python2-dev

#1.3 安装python模块
#1.3.1 爬虫相关模块
1. BeautifulSoup,requests
pip install BeautifulSoup4 requests

#2. lxml模块
apt-get install clang
apt-get install libxml2 libxml2-dev libxslt libxslt-dev
pip install lxml
#3. scrapy模块（必须先安装lxml才行）
apt install libffi libffi-dev
apt install openssl openssl-tool openssl-dev
pip install scrapy
```
##### 科学计算相关模块

numpy；matplotlib；pandas；ipython（有些依赖跟爬虫模块重复，安装会自动跳过）
``` bash
apt install clang python python-dev fftw libzmq libzmq-dev freetype freetype-dev libpng libpng-dev pkg-config
LDFLAGS=" -lm -lcompiler_rt" pip install numpy matplotlib pandas jupyter
```



##### jupyter
``` python
import matplotlib.pyplot as plt
import numpy as np
# Data for plotting
t = np.arange(0.0, 2.0, 0.01)
s = 1 + np.sin(2 * np.pi * t)
fig, ax = plt.subplots()
ax.plot(t, s)
ax.set(xlabel='time (s)', ylabel='voltage (mV)',       title='About as simple as it gets, folks')
ax.grid()
fig.savefig("test.png")
plt.show()
```

### misc

```
apt install coreutils
termux-setup-storage

apt install openssl openssl-tool openssl-dev 
```
vnc远程连接


## termux-api
分为两大类：
* get  instant input : location,camera,microphone
* read/write file : clipboard,sms
* read file: ,call contact
* set instant output （notification,toast，torch,vibrate,wallpaper,mp3,tts）

``` bash
termux-battery-status 获取设备的电池信息.
termux-brightness 设置屏幕亮度, 值域为 [0, 255].
termux-call-log 列出历史通话记录.
termux-camera-info # 获取设备摄像头的信息.
termux-camera-photo -c 0 photo.jpg # 调用相机拍摄照片, 保存为 JPEG 格式.
termux-clipboard-get # 获取系统剪贴板.
termux-clipboard-set # 设置系统剪贴板.
termux-contact-list 列出联系人信息.
termux-dialog 显示文本输入对话框.
termux-download -t baidudl.txt  https://www.baidu.com  # 使用系统下载器下载资源.
termux-fingerprint 在设备上使用指纹传感器验证身份.
termux-infrared-frequencies 查询红外发射器支持的载波频率.
termux-infrared-transmit 传输红外图案.
termux-location ##  获取地理位置信息.
termux-media-player play abc.mp3 # 播放媒体文件.
termux-media-scan MediaScanner 界面, 使 Android 相册可以看到文件更改.
termux-microphone-record 使用设备上的麦克风录制.
termux-notification  -c content -t title  # 显示系统通知.
termux-norification-remove 删除之前使用 termux-notification --id 显示的通知.
termux-sensor 获取有关传感器类型和实时数据的信息.
termux-share 共享参数指定的文件或在 stdin 上接收的文本.
termux-sms-inbox(现已改为termux-sms-list) 列出收到的短信.
termux-sms-send # 将 SMS 信息发送到指定号码.
termux-storage-get 从系统请求文件, 并将其输出到指定的文件.
termux-telephony-call # 拨打电话号码.
termux-telephony-cellinfo 从设备上的所有无线电获取有关所有观察到的小区信息的信息, 包括主要和相邻小区.
termux-telephony-deviceinfo 获取有关设备的信息.
termux-toast --b red -c blue -s message # 显示临时弹出通知.
termux-torch on # 在设备上切换 LED 灯.
termux-tts-engines 获取可用的TTS引擎的相关信息.
termux-tts-speak 使用系统 TTS 转换文本到语音.
termux-vibrate # 振动设备.
termux-volume  # 更改系统音量. 
termux-wallpaper -f abc.png # 更改桌面壁纸.
termux-wifi-connectioninfo 获取当前连接的 WIFI 信息.
termux-wifi-enable 连接/断开 WIFI.
termux-wifi-scaninfo 获取上次 WIFI 扫描信息.


termux-sms-list -o 30 
termux-sms-send  -n 10086 cxll # 发送短信
termux-telephony-call  10086  # 拨打电话
```
## misc

**Q**: 如何访问本地目录？
**A**: 
执行 `ternux-setup-storage`，会在home下生产storage目录，那个就是你的手机别的应用的目录。你可以cp到storage/share/目录下。