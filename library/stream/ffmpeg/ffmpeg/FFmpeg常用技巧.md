# FFmpeg常用技巧

[![阿凯](https://pica.zhimg.com/v2-3bf8e38b04311da8a768a3b5a4b2f45e_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/ji-qi-ren-zhu-shou)

[阿凯](https://www.zhihu.com/people/ji-qi-ren-zhu-shou)



新浪 音视频开发



7 人赞同了该文章

ffmpeg官方给出的有三个工具，ffmpeg,ffplay,ffprobe，这三个。大家都认识，但具体遇到问题的时候，使用技巧就多了，这里就先介绍下这三工具常用的一些调试输出数据的方法


- 音频与视频
  - 合成
  - 分离
- 推拉流
  - 视频推流
  - 视频拉流并保存
  - 视频拉流并播放
- 录制
  - 录制音频/视频
  - 录制本机屏幕画面
- 转换
  - 格式转换
  - 宽高转换
  - 帧率转换
- 视频时序上连接/分离
  - 视频拆分成单帧图片
  - 单帧图片合成视频
  - 单帧图片合成gif
  - 视频切片裁剪
- 视频帧编辑
  - 拼接（九宫格）
  - 抠图
  - 视频加水印
  - 视频加字幕
  


## 查看音频/视频文件
### 查看音频文件
最简单的一条,查看音频视频文件的基础信息

``` bash
ffmpeg -i /Users/UxinTest/Downloads/test_5_5.mp3
```

输出如下：

```
[mp3 @ 0x7ff9b2001400] Estimating duration from bitrate, this may be inaccurate
Input #0, mp3, from '/Users/UxinTest/Downloads/test_5_5.mp3':
  Duration: 00:05:55.11, start: 0.000000, bitrate: 98 kb/s
     Stream #0:0: Audio: mp3, 44100 Hz, stereo, fltp, 98 kb/s
```

备注：mp3编码，时长数据是根据比特率计算的，可能不是那么的准确，确实不太准确

0号输入，mp3，来自***文件

音频时长：00:05:55.11，起始点0.0,比特率：98kb/s

流数据：0号流：mp3,44100Hz，立体音，编码格式fltp,码率98kb/s


### 视频文件查看
视频文件查看的输出示例：

视频数据里会输出音频视频数据两个流结构，音频流的信息跟单纯的音频一样，只是所在的流索引不一样；视频里面则还会有视频分辨率540*810，帧率30fps,视频编码h264（high）

```
Input #0, mov,mp4,m4a,3gp,3g2,mj2, from '/Users/UxinTest/Desktop/abc500.mp4':
  Metadata:
    major_brand     : isom
    minor_version   : 512
    compatible_brands: isomiso2avc1mp41
    encoder         : Lavf58.29.100  (编码器)
    comment         : vid:v0200f8e0000bq2b5sj6j2qr9557fjgg
  Duration: 00:00:37.60, start: 0.000000, bitrate: 324 kb/s
    Stream #0:0(und): Video: h264 (High) (avc1 / 0x31637661), yuv420p, 540x810 [SAR 1:1 DAR 2:3], 197 kb/s, 30 fps, 30 tbr, 15360 tbn, 30720 tbc (default)
    Metadata:
      handler_name    : VideoHandler
    Stream #0:1(und): Audio: aac (LC) (mp4a / 0x6134706D), 44100 Hz, stereo, fltp, 120 kb/s (default)
    Metadata:
      handler_name    : SoundHandler
```



**note:**码率的粗略计算方法：文件大小/时长
## 转换视频格式
ffmpeg 转换视频格式

``` bash
# 转换mp4文件为指定格式
ffmpeg -i /Users/UxinTest/Desktop/ttt/origin_video.mp4 -g 30 -vcodec h264 -r 30 ~/Desktop/ttt/abc20.mp4

# 可以设置gopSize,frameRate,数据的编码格式（音视频都可以），比特率（音视频都可以）
ffmpeg -i /Users/UxinTest/Desktop/ttt/origin_video.mp4 -g 200 -b:v 272k -vcodec h264 -r 30 ~/Desktop/ttt/abc200.mp4

```

``` bash
ffmpeg -i input.rmvb -vcodec mpeg4 -b:v 200k -r 15 -an output.mp4

# -i input.rmvb 将input.rmvb转换为mp4封装格式的视频
# -vcodec mpeg4 音频编码为mpeg4,
# -b:v 200k 视频码率为200kbit/s,
#  -r 15 帧率为14，
# -an 去除音频数据
```

还有一些高级属性，比如编码动态码率的上下限等关于音视频质量的参数

### gop_size怎么查看

``` bash
ffprobe -show_frames -select_streams v -of xml VID_20180828_171435454.mp4 >videoframes.info
```

输出结果：

```xml
<?xml version="1.0" encoding="UTF-8"?>
<ffprobe>
    <frames>
        <frame media_type="video" stream_index="0" key_frame="1" pkt_pts="0" pkt_pts_time="0.000000" pkt_dts="0" pkt_dts_time="0.000000" best_effort_timestamp="0" best_effort_timestamp_time="0.000000" pkt_duration="4706" pkt_duration_time="0.052289" pkt_pos="405185" pkt_size="21464" width="1280" height="720" pix_fmt="yuv420p" sample_aspect_ratio="1:1" pict_type="I" coded_picture_number="0" display_picture_number="0" interlaced_frame="0" top_field_first="0" repeat_pict="0" color_range="tv" color_primaries="bt470bg" chroma_location="left"/>
        <frame media_type="video" stream_index="0" key_frame="0" pkt_pts="4706" pkt_pts_time="0.052289" pkt_dts="4706" pkt_dts_time="0.052289" best_effort_timestamp="4706" best_effort_timestamp_time="0.052289" pkt_duration="4492" pkt_duration_time="0.049911" pkt_pos="426649" pkt_size="25390" width="1280" height="720" pix_fmt="yuv420p" sample_aspect_ratio="1:1" pict_type="P" coded_picture_number="1" display_picture_number="0" interlaced_frame="0" top_field_first="0" repeat_pict="0" color_range="tv" color_primaries="bt470bg" chroma_location="left"/>
        <frame media_type="video" stream_index="0" key_frame="0" pkt_pts="9198" pkt_pts_time="0.102200" pkt_dts="9198" pkt_dts_time="0.102200" best_effort_timestamp="9198" best_effort_timestamp_time="0.102200" pkt_duration="4492" pkt_duration_time="0.049911" pkt_pos="452039" pkt_size="45821" width="1280" height="720" pix_fmt="yuv420p" sample_aspect_ratio="1:1" pict_type="P" coded_picture_number="2" display_picture_number="0" interlaced_frame="0" top_field_first="0" repeat_pict="0" color_range="tv" color_primaries="bt470bg" chroma_location="left"/>
        ...
        ...
    </frames>
</ffprobe>
```

note:pict_type字段为帧类型，IBP。


## 录制
### ffmpeg摄像头录制音频/视频

``` bash
ffmpeg -f dshow -i audio=”麦克风 (Realtek High Definition Audio)”  -ar 16000 -ac 1 d:\\lib.wav
ffmpeg -f dshow -i video=”USB 2.0 Webcam Device”:audio=”麦克风 (Realtek High Definition Audio)” -vcodec libx264 d:\\001.mkv

# 方式二:“-r 5”的意思是把帧率设置成5 
ffmpeg -f dshow -i video="Logitech HD Webcam C310" -r 5 -vcodec libx264 -preset:v ultrafast -tune:v zerolatency d:\\MyDesktop.mkv
```

### 录制本机屏幕画面

``` bash
ffmpeg -f avfoundation -i "1" -target pal-vcd ./hello.mpg
# 参考：https://blog.csdn.net/arctan90/article/details/50828771
```

## 音视频文件
### 音视频文件合并成一个视频文件

``` bash
ffmpeg -i a.wav -i a.avi out.avi
```

### 从视频文件中分离出单独的音频，视频数据

``` bash
ffmpeg -i input_file -vcodec copy -an output_file_video    //分离视频流
ffmpeg -i input_file -acodec copy -vn output_file_audio    //分离音频流
```
## 视频切片，图片提取
###  视频裁剪

``` bash
ffmpeg -i test.mp4 -ss 10 -t 15 -codec copy cut.mp4 
# 参数说明： 
# -i : source 视频源
# -ss: start time 起始时间
#　-t : duration 时长
```


### 视频数据转换为图片

``` bash
ffmpeg -i code8.mp4 -r 3 -f image2 code8/%d.png
# 每间隔1s提取一张图
ffmpeg -i out.mp4 -f image2 -vf fps=fps=1 out%d.png
# 每间隔20s截取一张图
ffmpeg -i out.mp4 -f image2 -vf fps=fps=1/20 out%d.png
```

### 指定若干帧画面合成gif

``` bash
ffmpeg -i input_file -vframes 30 -y -f gif output.gif

ffmpeg -i mot_160602_out.avi -vframes 30 -y -f gif mot_160602_out.gif
```

### 图片合成视频

``` bash
ffmpeg  -r 9 -i 1_cut/%4d.png video.mp4
# -r 9 帧率为9帧／s
# %4d.png 的意思是指0001.png 到9999.png的图片。

ffmpeg -r 8 -i ./RecordTemp/%d.bmp  -vcodec mpeg4 test.mp4
```




### 视频拼接合并
多个视频首尾拼接
```
ffmpeg -f concat -i filelist.txt -c copy 0806-0806-2-merge.mp4
filelist.txt的内容(需要换行)
file 0806.mp4
file 0806-2.mp4
```

[https://trac.ffmpeg.org/wiki/Concatenate](https://trac.ffmpeg.org/wiki/Concatenate)

### 视频拼接合并2

``` bash
ffmpeg -i 1.mp4 -vcodec copy -acodec copy -vbsf h264_mp4toannexb 1.ts
ffmpeg -i 2.mp4 -vcodec copy -acodec copy -vbsf h264_mp4toannexb 2.ts
ffmpeg -i "concat:1.ts|2.ts" -acodec copy -vcodec copy -absf aac_adtstoasc output.mp4
```

``` bash
#-vcodec copy -acodec copy   ==   -c copy
ffmpeg.exe -i 1.f4v -vcodec copy -acodec copy -vbsf h264_mp4toannexb 1.ts      
ffmpeg.exe -i 2.f4v -vcodec copy -acodec copy -vbsf h264_mp4toannexb 2.ts
ffmpeg.exe -i 3.f4v -vcodec copy -acodec copy -vbsf h264_mp4toannexb 3.ts
ffmpeg.exe -i 4.f4v -vcodec copy -acodec copy -vbsf h264_mp4toannexb 4.ts

ffmpeg.exe -i "concat:1.ts|2.ts|3.ts|4.ts" -acodec copy -vcodec copy -absf aac_adtstoasc out.mp4
```
### 视频拼接合并3
```
ffmpeg -i 11.mp4 -i 22.mp4 -filter_complex "[0:v] [0:a] [1:v] [1:a]\
concat=n=2:v=1:a=1 [v] [a]" -map "[v]" -map "[a]" output.mp4
```

## 多路视频空间拼接


### 左右拼接
```
ffmpeg -i 11.mp4 -i 22.mp4 -filter_complex hstack output.mp4
```

### 上下拼接
```
ffmpeg -i 11.mp4 -i 22.mp4 -filter_complex vstack output.mp4
```
### 2×2拼接
ffmpeg命令为：
```
ffmpeg -i out1.mp4 -i out2.mp4 -i out3.mp4 -i out4.mp4 -filter_complex "[0:v]pad=iw*2:ih*2[a];[a][1:v]overlay=w[b];[b][2:v]overlay=0:h[c];[c][3:v]overlay=w:h" out.mp4
```
### 九宫格拼接
### 任意多宫格方式展现
```
ffmpeg -re  -i  1.mp4
  -re  -i  2.mp4
  -re  -i  3.mp4
  -re  -i  4.mp4
 -filter_complex
"nullsrc=size=640x480 [base]; <br>[0:v] setpts=PTS-STARTPTS,scale=320x240 [upperleft];  <br>[1:v] setpts=PTS-STARTPTS, scale=320x240 [upperright];
[2:v] setpts=PTS-STARTPTS, scale=320x240 [lowerleft];
[3:v] setpts=PTS-STARTPTS, scale=320x240 [lowerright];
[base][upperleft] overlay=shortest=1[tmp1];
[tmp1][upperright] overlay=shortest=1:x=320 [tmp2];
[tmp2][lowerleft] overlay=shortest=1:y=240 [tmp3];
[tmp3][lowerright] overlay=shortest=1:x=320:y=240"
 -c:v libx264 out.mp4
 ```
简单明了，1.2.3.4.mp4为文件路径，out.MP4为输出文件路径，通过nullsrc创建overlay画布，画布大小640:480,

使用[0:v][1:v][2:v][3:v]将输入的4个视频流去除，分别进行缩放处理，然后基于nullsrc生成的画布进行视频平铺，

命令中自定义upperleft,upperright,lowerleft,lowerright进行不同位置平铺。

### 视频抠图
```
ffmpeg -i in_1.mp4 -i in_3.mp4 -shortest -filter_complex "[1:v]chromakey=red:0.3:0.9[ckout];[0:v][ckout]overlay[out]" -map "[out]" output.mp4
```

-i：指定输入视频文件名，注意抠图需要两个视频文件

-shortest: 表示在最短输入内编码

-filter_complex: 表示使用复杂滤镜

chromakey=red:0.3:0.9: chromakey是抠图时所使用的核心滤镜，其后参数用于抠图，感兴趣的朋友可以自行多学习chromakey色度滤镜

overlay: 抠图的视频与目的视频使用overlay滤镜结合

关于标签的使用同多宫格的描述
## 视频加水印/字幕
### 视频加水印
```
# 视频加水印, logo.png是水印图片？
ffmpeg -i input.mp4 -i logo.png -filter_complex 'overlay=x=10:y=main_h-overlay_h-10' output.mp4

# 水印居中显示
ffmpeg -i out.mp4 -i sxyx2008@163.com.gif -filter_complex overlay="(main_w/2)-(overlay_w/2):(main_h/2)-(overlay_h)/2" output.mp4
```
### 视频加字幕
todo
## 推拉视频流
### 推视频流到流媒体服务器

``` bash
# 推rtmp视频流到流媒体服务器
ffmpeg -f dshow -i video=”USB 2.0 Webcam Device”:audio=”麦克风 (Realtek High Definition Audio)” -vcodec libx264 -acodec copy -preset:v ultrafast -tune:v zerolatency -f flv rtmp://localhost/live/stream

ffmpeg -re -i <视频文件名> -vcodec copy -f flv <rtmp://服务器地址>
```

``` bash
ffmpeg -i rtsp://192.168.0.189:554/stream/main -codec copy -rtsp_transport tcp -r 15 -s 1366x768 -f rtsp rtsp://x.x.x.x:554/stream/main

# 推流视频
ffmpeg -re -i f:/8.mp4 -vcodec copy -acodec copy -f flv -r 30 -b:v 1000k  rtmp://*.*.*.*/live/vad2

# 循环推流视频
ffmpeg -re -stream_loop -1 -i f:/8.mp4 -vcodec copy -acodec copy -f flv -r 30 -b:v 1000k  rtmp://*.*.*.*/live/vad2

# 推流到流服务器
ffmpeg -f dshow -i video="screen-capture-recorder" -r 15 -s 990x512 -f flv rtmp://203.195.150.231:1935/live/
```

### 流数据保存为本地视频文件

``` bash
ffmpeg -i rtsp://hostname/test -vcoder copy out.avi
```


### 查看流信息

``` bash
ffprobe -show_streams -show_entries format=bit_rate,filename,start_time:stream=duration,width,height,display_aspect_ratio,r_frame_rate,bit_rate -of json -v quiet -i https://pull.topshow.fun/hrs/pull.topshow.fun_1072703310747668512-1577693869397.ts?auth_key=1580285864-0-0-d644b282c0e62d66d345b49c8d35a67f


ffprobe -show_streams -show_entries format=bit_rate,filename,start_time:stream=duration,width,height,display_aspect_ratio,r_frame_rate,bit_rate -of json -v quiet -i http://wswebpull.inke.cn/live/1577672750382668.flv
```

### 播放音视频

``` 
$ ffplay /Users/UxinTest/Desktop/DreamItPossible.mp3
输出：
Input #0, mp3, from '/Users/UxinTest/Desktop/DreamItPossible.mp3':
  Metadata:
    encoder         : Lavf57.71.100
    disc            : 1
    track           : 1
    artist          : Delacey
    comment         : 163 key(Don't modify):L64FU3W4YxX3ZFTmbZ+8/dx5jBNDPdsKv9gAgXYyj0/Z0Vl4ORaCLH5D0oN9v9nBBv6zxpBucgNeE2qqke4ugZs7dxriT5lfUpulX5PYMzSg2pqL6APTHQjtIHw16ZCRTMBBkInrUGSTklA2MwPLGkuDTmWfzjHqDWEK5LLRP6oiOXe0JeI9mLHzL2nm6T3/jIoYF2PvtH3vIz5TzYJolL8Y5UubkAHkkEr3zQfKO
    title           : Dream It Possible
    album           : Dream It Possible
  Duration: 00:03:24.04, start: 0.025056, bitrate: 324 kb/s
    Stream #0:0: Audio: mp3, 44100 Hz, stereo, fltp, 320 kb/s
    Metadata:
      encoder         : Lavc57.89
    Stream #0:1: Video: mjpeg (Baseline), yuvj444p(pc, bt470bg/unknown/unknown), 540x540 [SAR 72:72 DAR 1:1], 90k tbr, 90k tbn, 90k tbc (attached pic)
    Metadata:
      comment         : Other
[swscaler @ 0x10a9ab000] deprecated pixel format used, make sure you did set range correctly
    Last message repeated 1 times
  45.99 A-V:    nan fd=   0 aq=   43KB vq=    0KB sq=    0B f=0/0
```

45.99 是从开始播放到播放当前进度的时长

此处待补充描述


## 列出本机相关的音视频设备

``` bash
ffmpeg -f avfoundation -list_devices true -i ""
输出：
[AVFoundation input device @ 0x7fd901c01a40] AVFoundation video devices:
[AVFoundation input device @ 0x7fd901c01a40] [0] FaceTime HD Camera
[AVFoundation input device @ 0x7fd901c01a40] [1] Capture screen 0
[AVFoundation input device @ 0x7fd901c01a40] [2] Capture screen 1
[AVFoundation input device @ 0x7fd901c01a40] AVFoundation audio devices:
[AVFoundation input device @ 0x7fd901c01a40] [0] Apowersoft Audio Device
[AVFoundation input device @ 0x7fd901c01a40] [1] Built-in Microphone
```




## 参考：

视频清晰度转换相关的参数

[ffmpeg 基本用法www.jianshu.com/p/3c8c4a892f3c![img](https://pic2.zhimg.com/v2-962c0ff27b452effdb6697d4c28fec95_180x120.jpg)](https://link.zhihu.com/?target=https%3A//www.jianshu.com/p/3c8c4a892f3c)

[ffmpeg常用参数一览表 - mao的博客 - 博客园www.cnblogs.com/mwl523/p/10856633.html](https://link.zhihu.com/?target=https%3A//www.cnblogs.com/mwl523/p/10856633.html)



[ffmpeg命令行参数中文详解www.360doc.com/content/19/0317/01/10519289_822112563.shtml![img](https://pic2.zhimg.com/v2-33bf1eabf8e4dfdd918fd722f6efb0cd_ipico.jpg)](https://link.zhihu.com/?target=http%3A//www.360doc.com/content/19/0317/01/10519289_822112563.shtml)

[使用ffprobe获取视频每一帧的信息_ch853199769的博客-CSDN博客_c#获取视频帧blog.csdn.net/ch853199769/article/details/82189171![img](https://pic3.zhimg.com/v2-3d6f0b0cdd7632882b0ca6d20143ea66_ipico.jpg)](https://link.zhihu.com/?target=https%3A//blog.csdn.net/ch853199769/article/details/82189171)

H264压缩算法

[H264视频压缩算法www.mamicode.com/info-detail-2509824.html![img](https://pic2.zhimg.com/v2-1e64064cd0072a8db3a23ddeae992191_180x120.jpg)](https://link.zhihu.com/?target=http%3A//www.mamicode.com/info-detail-2509824.html)

ffmpeg通过参数设置调整画质清晰度

[http://yipeiwu.com/50508.htmyipeiwu.com/50508.htm](https://link.zhihu.com/?target=http%3A//yipeiwu.com/50508.htm)

GOP/ 码流 /码率 / 比特率 / 帧速率 / 分辨率

[GOP/ 码流 /码率 / 比特率 / 帧速率 / 分辨率www.jianshu.com/p/b0abca876832![img](https://pic2.zhimg.com/v2-5fef366881660448dcd27f9cbbdc4b9d_ipico.jpg)](https://link.zhihu.com/?target=https%3A//www.jianshu.com/p/b0abca876832)

GOP设置多大合适

[科普 | 视频直播的GoP Size设置成多少合适？blog.itpub.net/31559352/viewspace-2564571/![img](https://pic2.zhimg.com/v2-9cdad5fa13995037b9c0848815f8e521_180x120.jpg)](https://link.zhihu.com/?target=http%3A//blog.itpub.net/31559352/viewspace-2564571/)

阿里云转码设置文档

[参数详情_附录_API参考_媒体处理-阿里云help.aliyun.com/document_detail/29253.html?spm=a2c4g.11186623.4.2.7aba7cc94COskm![img](https://pic2.zhimg.com/v2-729b85644af08bbcf60c6f448628a501_180x120.jpg)](https://link.zhihu.com/?target=https%3A//help.aliyun.com/document_detail/29253.html%3Fspm%3Da2c4g.11186623.4.2.7aba7cc94COskm)

