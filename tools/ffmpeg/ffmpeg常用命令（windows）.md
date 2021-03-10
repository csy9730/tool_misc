# [ffmpeg常用命令（windows）](https://www.cnblogs.com/dch0/p/11149266.html)

本文内容来自互联网

### FFMPEG，windows相关命令

一款强大的音视频处理开源库。

#### 相关概念

- 音/视频流

  在音视频领域，一路音/视频成为一路流。

- 容器

  一般把mp4、flv、mov等文件格式称之为容器。在这些常用格式文件中可以存放多路音视频文件。以mp4为例，可以存放一路视频流，多路音频流，多路字幕流。

- channel

  channel是音频中的概念，称之为声道，在一路音频流中可以有单声道、双声道和立体声。

#### ffmpeg命令

- 基本命令格式

```cmd
ffmpeg [global_options] {[input_file_options] -i input_url}... {[output_file_options] output_url}...
```

#### windows下查看音视频设备

```
ffmpeg -list_devices true -f dshow -i dummy
```

#### 音视频录制

- screen-capture-recorder

```
下载地址https://github.com/rdp/screen-capture-recorder-to-video-windows-free/releases
桌面采集工具，可以用来录制桌面
自带虚拟音频捕获器，录制桌面的音频
需要安装javajre
它还包括一个免费的、通用的、开源的DirectShow桌面/屏幕源捕获过滤器。
配合ffmpeg录屏
ffmpeg -f dshow  -i video="screen-capture-recorder"  -r 20 -t 10 screen-capture.mp4 
# -t 10 for 10 seconds recording
```

- 录屏

```
#列出设备列表
ffmpeg -list_devices true -f dshow -i dummy
#全屏录像
ffmpeg -f dshow -i video="screen-capture-recorder" -f dshow -i audio="virtual-audio-capturer" -vcodec libx264 -acodec libmp3lame -s 1280x720 -r 15 e:/temp/temp.mkv
-f指定使用dshow采集数据
-i指定从哪里采集数据
-r指定帧率（-framerate用来限制输入，-r用来限制输出），桌面的输入对帧率没有要求，所以不用限制桌面的帧率，其实限制了也没用。
-s设置窗口大小 -s 100x200 将桌面画布压缩为100x200
#gdigrab录屏，h264编码
ffmpeg -f gdigrab -i desktop -f dshow -i audio="virtual-audio-capturer" -vcodec libx264 -acodec libmp3lame -s 1280x720 -r 15 G:\ffmpeg\testout\temp.mkv
```

- 音视频录制

```
#调用本地麦克风录制音频，保存到文件
ffmpeg -f dshow -i audio="麦克风（Conexant SmartAudio HD）"  G:/testout/1.mp3
#调用摄像头录制视频，并保存到文件
ffmpeg -f dshow -i video="Lenvo EasyCamera" G:/testout/1.flv
#调用摄像头和麦克风录制音视频，保存到文件
ffmpeg -f dshow -i video="" -f dshow -i audio="" G:/testout/2.flv
```

#### 直播推流

- 推流摄像头

```
ffmpeg -f dshow -i video="Lenovo EasyCamera":audio="麦克风 (Conexant SmartAudio HD)" -acodec aac -strict experimental -ar 44100 -b:a 200k -b:v 1500k  -preset:v veryfast -f flv  rtmp://203.195.150.231:1935/live/
```

- 推流桌面

```
ffmpeg -f dshow -i video="screen-capture-recorder":audio="virtual-audio-capturer" -acodec aac -strict experimental -ar 44100 -b:a 150k -b:v 2500k  -preset:v veryfast -f flv  rtmp://*.*.*.*/live/vad
```

- 推流桌面音频

```
ffmpeg -f dshow -i audio="virtual-audio-capturer" -vcodec libx264 -acodec aac -strict experimental -ar 44100 -b:a 200k -b:v 2500k  -preset:v ultrafast -f flv  rtmp://*.*.*.*/live/vad
```

-推流rtsp-rtsp

```
ffmpeg -i rtsp://192.168.0.189:554/stream/main -codec copy -rtsp_transport tcp -r 15 -s 1366x768 -f rtsp rtsp://x.x.x.x:554/stream/main
```

待分析

```
ffmpeg -f dshow -i video="Logitech QuickCam Pro 9000":audio="麦克风 (Pro 9000)" -vcodec libx264  -ar 44100 -b:a 160k -b:v 1000k -s 640*360 -g 1 -keyint_min 2  -acodec  copy -preset:v veryfast -f flv rtmp://*.*.*.*/live/vad
ffmpeg -f dshow -i video="Logitech QuickCam Pro 9000":audio="麦克风 (Pro 9000)" -vcodec libx264 -acodec  copy -preset:v ultrafast  -f flv rtmp://*.*.*.*/live/vad -ar 44100  -g 1 -keyint_min 1
ffmpeg -f dshow -i video="Logitech QuickCam Pro 9000":audio="麦克风 (Pro 9000)" -vcodec libx264  -b:a 160k -r 30 -b:v 500k -s 640*360 -acodec  copy -preset:v veryfast -tune:v zerolatency  -f flv rtmp://*.*.*.*/live/vad
ffmpeg -f dshow -i video="USB Video Device":audio="麦克风 (USB Audio Device)" -vcodec libx264 -acodec copy -preset:v ultrafast -tune:v zerolatency -f flv "rtmp://push.syocn.com/live/vad"
ffmpeg -f dshow -i video="USB Video Device":audio="麦克风 (USB Audio Device)" -vcodec libx264 -ar 44100 -s 720*480 -acodec copy -preset:v ultrafast -tune:v zerolatency -f flv "rtmp://push.syocn.com/live/vad"

ffmpeg -f dshow -i video="Logitech QuickCam Pro 9000":audio="麦克风 (Pro 9000)" -vcodec libx264  -ac 2 -b:a 160k -r 30 -b:v 500k -s 640*360 -acodec  copy -preset:v veryfast   "rtmp://push.syocn.com/live/vad"
ffmpeg -f dshow -i video="Logitech QuickCam Pro 9000":audio="麦克风 (Pro 9000)" -vcodec libx264 -ar 44100 -s 350*300 -b:v 100k -acodec copy -preset:v ultrafast -tune:v zerolatency -f flv "rtmp://push.syocn.com/live/vad"

rtmp://*.*.*.*/live/vad
-s 720*480
```

- 推流视频

```
ffmpeg -re -i f:/8.mp4 -vcodec copy -acodec copy -f flv -r 30 -b:v 1000k  rtmp://*.*.*.*/live/vad2
```

- 循环推流视频

```
ffmpeg -re -stream_loop -1 -i f:/8.mp4 -vcodec copy -acodec copy -f flv -r 30 -b:v 1000k  rtmp://*.*.*.*/live/vad2
```

- rtmp流

```
#推流到流服务器
ffmpeg -f dshow -i video="screen-capture-recorder" -r 15 -s 990x512 -f flv rtmp://203.195.150.231:1935/live/

#使用ffplay拉流播放
ffplay "rtmp://203.195.150.231:1935/live/ live=1"

#读取流音频，保存到本地
ffmpeg –i rtsp://192.168.3.205:5555/test –vcodec copy out.avi
```

- cmd中文乱码问题

  在命令行下执行命令“ chcp 65001” 将windows命令行窗口的编码改为了utf-8编码

- rtmp流播放

```
ffplay "rtmp://192.168.134.130:1936/live/dc live=1"
```

- rtmp流

```
#推流到流服务器
ffmpeg -f dshow -i video="screen-capture-recorder" -r 15 -s 990x512 -f flv rtmp://203.195.150.231:1935/live/

#使用ffplay拉流播放
ffplay "rtmp://203.195.150.231:1935/live/ live=1"

#读取流音频，保存到本地
ffmpeg –i rtsp://192.168.3.205:5555/test –vcodec copy out.avi
ffmpeg -re -i out.mp4 -c copy -f flv rtmp://server/live/streamName
```

#### 格式转换

- 将0806.mp4由mp4转换为flv

```
ffmpeg -i 0806.mp4 0806f.flv
```

#### 视频截取

```
ffmpeg  -i 0806.mp4 -vcodec copy -acodec copy -ss 00:00:00 -to 00:00:30 cutout.mp4 -y      （不精确，会有几秒的误差）
ffmpeg -accurate_seek -i I:/8.mp4 -codec copy -y -ss 00:00:10 -to 00:00:30 I:/8-cut.mp4	(更精确)
```

#### 添加字幕

```
1)嵌入到视频(嵌入到视频流)
ffmpeg -i 0806.mp4 -vf subtitles=a.srt srtout.mp4 
2)嵌入到视频(嵌入到字幕流)
ffmpeg -i 0806.mp4 -i a.srt -c:s mov_text -c:v copy -c:a copy srtout3.mp4

ffmpeg -i video.avi -vf subtitles=subtitle.srt out.avi
ffmpeg -filter_complex "subtitles='a.srt File - 1 srtout.mp4'"
```

#### 添加LOGO水印

```
ffmpeg -i I:/8.mp4 -i I:/logo.png -filter_complex overlay I:/8-logo.mp4
ffmpeg -i /mnt/hgfs/shared/resource/shenghua.avi -i /mnt/hgfs/shared/resource/my_logo.png -filter_complex overlay /mnt/hgfs/shared/resource/shenghua_die.mp4
```

#### 视频合并

```
ffmpeg -f concat -i filelist.txt -c copy 0806-0806-2-merge.mp4
filelist.txt的内容(需要换行)
file 0806.mp4
file 0806-2.mp4
```

## . 视频转换

比如一个avi文件，想转为mp4，或者一个mp4想转为ts。
`ffmpeg -i input.avi output.mp4`
`ffmpeg -i input.mp4 output.ts`

## 2. 提取音频

```
ffmpeg -i test.mp4 -acodec copy -vn output.aac` 
上面的命令，默认mp4的audio codec是aac,如果不是，可以都转为最常见的aac。 
`ffmpeg -i test.mp4 -acodec aac -vn output.aac
```

## 3. 提取视频

```
ffmpeg -i input.mp4 -vcodec copy -an output.mp4
```

## 4. 视频剪切

下面的命令，可以从时间为00:00:15开始，截取5秒钟的视频。
`ffmpeg -ss 00:00:15 -t 00:00:05 -i input.mp4 -vcodec copy -acodec copy output.mp4`
-ss表示开始切割的时间，-t表示要切多少。上面就是从15秒开始，切5秒钟出来。

## 5. 码率控制

码率控制对于在线视频比较重要。因为在线视频需要考虑其能提供的带宽。

那么，什么是码率？很简单：
bitrate = file size / duration
比如一个文件20.8M，时长1分钟，那么，码率就是：
biterate = 20.8M bit/60s = 20.8*1024*1024*8 bit/60s= 2831Kbps
一般音频的码率只有固定几种，比如是128Kbps，
那么，video的就是
video biterate = 2831Kbps -128Kbps = 2703Kbps。

那么ffmpeg如何控制码率。
ffmpg控制码率有3种选择，-minrate -b:v -maxrate
-b:v主要是控制平均码率。
比如一个视频源的码率太高了，有10Mbps，文件太大，想把文件弄小一点，但是又不破坏分辨率。
`ffmpeg -i input.mp4 -b:v 2000k output.mp4`
上面把码率从原码率转成2Mbps码率，这样其实也间接让文件变小了。目测接近一半。
不过，ffmpeg官方wiki比较建议，设置b:v时，同时加上 -bufsize
-bufsize 用于设置码率控制缓冲器的大小，设置的好处是，让整体的码率更趋近于希望的值，减少波动。（简单来说，比如1 2的平均值是1.5， 1.49 1.51 也是1.5, 当然是第二种比较好）
`ffmpeg -i input.mp4 -b:v 2000k -bufsize 2000k output.mp4`

-minrate -maxrate就简单了，在线视频有时候，希望码率波动，不要超过一个阈值，可以设置maxrate。
`ffmpeg -i input.mp4 -b:v 2000k -bufsize 2000k -maxrate 2500k output.mp4`

## 6. 视频编码格式转换

比如一个视频的编码是MPEG4，想用H264编码，咋办？
`ffmpeg -i input.mp4 -vcodec h264 output.mp4`
相反也一样
`ffmpeg -i input.mp4 -vcodec mpeg4 output.mp4`

当然了，如果ffmpeg当时编译时，添加了外部的x265或者X264，那也可以用外部的编码器来编码。（不知道什么是X265，可以 Google一下，简单的说，就是她不包含在ffmpeg的源码里，是独立的一个开源代码，用于编码HEVC，ffmpeg编码时可以调用它。当然 了，ffmpeg自己也有编码器）
`ffmpeg -i input.mp4 -c:v libx265 output.mp4`
`ffmpeg -i input.mp4 -c:v libx264 output.mp4`

## 7. 只提取视频ES数据

```
ffmpeg –i input.mp4 –vcodec copy –an –f m4v output.h264
```

## 8. 过滤器的使用

### 8.1 将输入的1920x1080缩小到960x540输出:

`ffmpeg -i input.mp4 -vf scale=960:540 output.mp4`
//ps: 如果540不写，写成-1，即scale=960:-1, 那也是可以的，ffmpeg会通知缩放滤镜在输出时保持原始的宽高比。

### 8.2 为视频添加logo

比如，我有这么一个图片
![iqiyi logo](http://img.blog.csdn.net/20160512155254687)
想要贴到一个视频上，那可以用如下命令：
./ffmpeg -i input.mp4 -i iQIYI_logo.png -filter_complex overlay output.mp4
结果如下所示：
![add logo left](http://img.blog.csdn.net/20160512155411797)
要贴到其他地方？看下面：
右上角：
./ffmpeg -i input.mp4 -i logo.png -filter_complex overlay=W-w output.mp4
左下角：
./ffmpeg -i input.mp4 -i logo.png -filter_complex overlay=0:H-h output.mp4
右下角：
./ffmpeg -i input.mp4 -i logo.png -filter_complex overlay=W-w:H-h output.mp4

### 8.3 去掉视频的logo

语法：-vf delogo=x:y:w:h[:t[:show]]
x:y 离左上角的坐标
w:h logo的宽和高
t: 矩形边缘的厚度默认值4
show：若设置为1有一个绿色的矩形，默认值0。

`ffmpeg -i input.mp4 -vf delogo=0:0:220:90:100:1 output.mp4`
结果如下所示：
![de logo](http://img.blog.csdn.net/20160512155451204)

## 9. 截取视频图像

`ffmpeg -i input.mp4 -r 1 -q:v 2 -f image2 pic-%03d.jpeg`
-r 表示每一秒几帧
-q:v表示存储jpeg的图像质量，一般2是高质量。
如此，ffmpeg会把input.mp4，每隔一秒，存一张图片下来。假设有60s，那会有60张。

可以设置开始的时间，和你想要截取的时间。
`ffmpeg -i input.mp4 -ss 00:00:20 -t 10 -r 1 -q:v 2 -f image2 pic-%03d.jpeg`
-ss 表示开始时间
-t 表示共要多少时间。
如此，ffmpeg会从input.mp4的第20s时间开始，往下10s，即20~30s这10秒钟之间，每隔1s就抓一帧，总共会抓10帧。

## 10. 序列帧与视频的相互转换

把darkdoor.[001-100].jpg序列帧和001.mp3音频文件利用mpeg4编码方式合成视频文件darkdoor.avi：
**$ ffmpeg -i 001.mp3 -i darkdoor.%3d.jpg -s 1024x768 -author fy -vcodec mpeg4 darkdoor.avi**

还可以把视频文件导出成jpg序列帧：
$ **ffmpeg -i bc-cinematic-en.avi example.%d.jpg**

**1.分离视频音频流**

```
ffmpeg -i input_file -vcodec copy -an output_file_video　　//分离视频流
ffmpeg -i input_file -acodec copy -vn output_file_audio　　//分离音频流
```

**2.视频解复用**

```
ffmpeg –i test.mp4 –vcodec copy –an –f m4v test.264
ffmpeg –i test.avi –vcodec copy –an –f m4v test.264
```

**3.视频转码**

```
ffmpeg –i test.mp4 –vcodec h264 –s 352*278 –an –f m4v test.264              //转码为码流原始文件
ffmpeg –i test.mp4 –vcodec h264 –bf 0 –g 25 –s 352*278 –an –f m4v test.264  //转码为码流原始文件
ffmpeg –i test.avi -vcodec mpeg4 –vtag xvid –qsame test_xvid.avi            //转码为封装文件
//-bf B帧数目控制，-g 关键帧间隔控制，-s 分辨率控制
```

**4.视频封装**

```
ffmpeg –i video_file –i audio_file –vcodec copy –acodec copy output_file
```

**5.视频剪切**

```
ffmpeg –i test.avi –r 1 –f image2 image-%3d.jpeg        //提取图片
ffmpeg -ss 0:1:30 -t 0:0:20 -i input.avi -vcodec copy -acodec copy output.avi    //剪切视频
//-r 提取图像的频率，-ss 开始时间，-t 持续时间
```

**6.视频录制**

```
ffmpeg –i rtsp://192.168.3.205:5555/test –vcodec copy out.avi
```

**7.YUV序列播放**

```
ffplay -f rawvideo -video_size 1920x1080 input.yuv
```

**8.YUV序列转AVI**

```
ffmpeg –s w*h –pix_fmt yuv420p –i input.yuv –vcodec mpeg4 output.avi
```

**常用参数说明：**

**主要参数：**
-i 设定输入流
-f 设定输出格式
-ss 开始时间
**视频参数：**
-b 设定视频流量，默认为200Kbit/s
-r 设定帧速率，默认为25
-s 设定画面的宽与高
-aspect 设定画面的比例
-vn 不处理视频
-vcodec 设定视频编解码器，未设定时则使用与输入流相同的编解码器
**音频参数：**
-ar 设定采样率
-ac 设定声音的Channel数
-acodec 设定声音编解码器，未设定时则使用与输入流相同的编解码器
-an 不处理音频

分类: [多媒体处理](https://www.cnblogs.com/dwdxdy/category/477517.html)