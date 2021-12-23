# FFmpeg常用技巧

[![阿凯](https://pica.zhimg.com/v2-3bf8e38b04311da8a768a3b5a4b2f45e_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/ji-qi-ren-zhu-shou)

[阿凯](https://www.zhihu.com/people/ji-qi-ren-zhu-shou)



新浪 音视频开发



7 人赞同了该文章

ffmpeg官方给出的有三个工具，ffmpeg,ffplay,ffprobe，这三个。大家都认识，但具体遇到问题的时候，使用技巧就多了，这里就先介绍下这三工具常用的一些调试输出数据的方法

**no.1**

最简单的一条,查看音频视频文件的基础信息

```text
ffmpeg -i /Users/UxinTest/Downloads/test_5_5.mp3
```

输出如下：

```text
[mp3 @ 0x7ff9b2001400] Estimating duration from bitrate, this may be inaccurate
Input #0, mp3, from '/Users/UxinTest/Downloads/test_5_5.mp3':
  Duration: 00:05:55.11, start: 0.000000, bitrate: 98 kb/s
     Stream #0:0: Audio: mp3, 44100 Hz, stereo, fltp, 98 kb/s
```

备注：mp3编码，时长数据是根据比特率计算的，可能不是那么的准确，确实不太准确

0号输入，mp3，来自***文件

音频时长：00:05:55.11，起始点0.0,比特率：98kb/s

流数据：0号流：mp3,44100Hz，立体音，编码格式fltp,码率98kb/s



视频文件查看的输出示例：

（视频数据里会输出音频视频数据两个流结构，音频流的信息跟单纯的音频一样，只是所在的流索引不一样；视频里面则还会有视频分辨率540*810，帧率30fps,视频编码h264（high）)

```text
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

**No.2** ffmpeg 转换视频格式

```text
1.视频加水印
ffmpeg -i input.mp4 -i logo.png -filter_complex 'overlay=x=10:y=main_h-overlay_h-10' output.mp4

水印居中显示
ffmpeg -i out.mp4 -i sxyx2008@163.com.gif -filter_complex overlay="(main_w/2)-(overlay_w/2):(main_h/2)-(overlay_h)/2" output.mp4


2.转换mp4文件为指定格式
ffmpeg -i /Users/UxinTest/Desktop/ttt/origin_video.mp4 -g 30 -vcodec h264 -r 30 ~/Desktop/ttt/abc20.mp4

可以设置gopSize,frameRate,数据的编码格式（音视频都可以），比特率（音视频都可以）
ffmpeg -i /Users/UxinTest/Desktop/ttt/origin_video.mp4 -g 200 -b:v 272k -vcodec h264 -r 30 ~/Desktop/ttt/abc200.mp4

还有一些高级属性，比如编码动态码率的上下限等关于音视频质量的参数
```



**No.3** gop_size怎么查看

```text
ffprobe -show_frames -select_streams v -of xml VID_20180828_171435454.mp4 >videoframes.info
```

输出结果：

```text
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



**No.4** ffmpeg摄像头录制音频/视频

```text
ffmpeg -f dshow -i audio=”麦克风 (Realtek High Definition Audio)”  -ar 16000 -ac 1 d:\\lib.wav
ffmpeg -f dshow -i video=”USB 2.0 Webcam Device”:audio=”麦克风 (Realtek High Definition Audio)” -vcodec libx264 d:\\001.mkv
//方式二:“-r 5”的意思是把帧率设置成5 
ffmpeg -f dshow -i video="Logitech HD Webcam C310" -r 5 -vcodec libx264 -preset:v ultrafast -tune:v zerolatency d:\\MyDesktop.mkv
```

**No.5** 音视频文件合并成一个视频文件

```text
ffmpeg -i a.wav -i a.avi out.avi
```

**No.6** 视频裁剪

```text
ffmpeg -i test.mp4 -ss 10 -t 15 -codec copy cut.mp4 
//参数说明： 
-i : source 视频源
-ss: start time 起始时间
-t : duration 时长
```

**No.7** 推rtmp视频流到流媒体服务器

```text
ffmpeg -f dshow -i video=”USB 2.0 Webcam Device”:audio=”麦克风 (Realtek High Definition Audio)” -vcodec libx264 -acodec copy -preset:v ultrafast -tune:v zerolatency -f flv rtmp://localhost/live/stream

ffmpeg -re -i <视频文件名> -vcodec copy -f flv <rtmp://服务器地址>
```

**No.8** 查看流信息

```text
ffprobe -show_streams -show_entries format=bit_rate,filename,start_time:stream=duration,width,height,display_aspect_ratio,r_frame_rate,bit_rate -of json -v quiet -i https://pull.topshow.fun/hrs/pull.topshow.fun_1072703310747668512-1577693869397.ts?auth_key=1580285864-0-0-d644b282c0e62d66d345b49c8d35a67f


ffprobe -show_streams -show_entries format=bit_rate,filename,start_time:stream=duration,width,height,display_aspect_ratio,r_frame_rate,bit_rate -of json -v quiet -i http://wswebpull.inke.cn/live/1577672750382668.flv
```

**No.9** 播放音视频

```text
ffplay /Users/UxinTest/Desktop/DreamItPossible.mp3
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



**No.10** 列出本机相关的音视频设备

```text
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

**No.11** 录制本机屏幕画面

```text
ffmpeg -f avfoundation -i "1" -target pal-vcd ./hello.mpg
参考：https://blog.csdn.net/arctan90/article/details/50828771
```

**No.12** 视频拼接

```text
ffmpeg -i 1.mp4 -vcodec copy -acodec copy -vbsf h264_mp4toannexb 1.ts
ffmpeg -i 2.mp4 -vcodec copy -acodec copy -vbsf h264_mp4toannexb 2.ts
ffmpeg -i "concat:1.ts|2.ts" -acodec copy -vcodec copy -absf aac_adtstoasc output.mp4
```

**No.13** 视频数据转换为图片

```text
ffmpeg -i code8.mp4 -r 3 -f image2 code8/%d.png
每间隔1s提取一张图
ffmpeg -i out.mp4 -f image2 -vf fps=fps=1 out%d.png
每间隔20s截取一张图
ffmpeg -i out.mp4 -f image2 -vf fps=fps=1/20 out%d.png
```

**No.14** 指定若干帧画面合成gif

```text
ffmpeg -i input_file -vframes 30 -y -f gif output.gif
```

**No.15** 图片合成视频

```text
ffmpeg -f image2  -r 9 -i 1_cut/%4d.png video.mp4(帧率为9帧／s)
```

**No.16** 从视频文件中分离出单独的音频，视频数据

```text
ffmpeg -i input_file -vcodec copy -an output_file_video    //分离视频流
ffmpeg -i input_file -acodec copy -vn output_file_audio    //分离音频流
```

**No.17** 流数据保存为本地视频文件

```text
ffmpeg -i rtsp://hostname/test -vcoder copy out.avi
```

No.18









新增完整ffprobe

ffprobe -show_packets input.flv

ffprobe -show_*data -show_packets input.flv*

*ffprobe -show_format input.flv*

*ffprobe -show_frames input.flv*

*ffprobe -show_streams input.flv*

*格式化：*

*ffprobe -of flat -show_streams input.flv*

*ffprobe -of json -show_packets input.flv*

*ffprobe -show_frames -select_streams v -of xml input.mp4*



*FFPlay*

*eg1. 播放音频文件，将解码后的音频数据以音频波形的形式显示出来，可以通过波形的振幅检查音频的播放情况*

*ffplay -showmode 1 output.mp3*

*eg2.当播放视频时想要体验解码器时如何解码每个宏块*

*ffplay -debug vis_mb_type -window_title "show vis_mb_type" -ss 20 -t 10 -autoexit output.mp4*

*eg3.查看B帧预测与P帧预测信息，将信息在窗口中显示出来*

*ffplay -vismv pf output.mp4*



*//来补充一截*

解码视频为图片序列 -r 指每秒多少帧

(base) ➜ tmp ffmpeg -i vv.mp4 -r 12 ./tmp2/%03d.png



查看视频信息及帧率

(base) ➜ tmp ffprobe -i vv.mp4 -show_format -show_streams >[vv.info](https://link.zhihu.com/?target=http%3A//vv.info/)



转码视频为h264视频

(base) ➜ tmp ffmpeg -i tt2.mp4 -vcodec h264 vv.mp4



图片序列合成视频

-f image2 指定编码格式

(base) ➜ tmp ffmpeg -f image2 -i ./%03d.png tt2.mp4





图片处理库

[http://www.imagemagick.com.cn/commands.html](https://link.zhihu.com/?target=http%3A//www.imagemagick.com.cn/commands.html)

图片rgb层数据获取

magick convert actor05.png -background black -alpha remove actor.jpg



图片alpha层数据提取

magick convert actor05.png -alpha extract bird_alpha_mask.png





两张图像水平拼接

tmp magick convert +append actor.jpg bird_alpha_mask.png u.png

参考：

[https://blog.csdn.net/qq_24127015/article/details/86525305](https://link.zhihu.com/?target=https%3A//blog.csdn.net/qq_24127015/article/details/86525305)

[https://www.cnblogs.com/mfryf/archive/2012/02/12/2347975.htmlwww.cnblogs.com/mfryf/archive/2012/02/12/2347975.html](https://link.zhihu.com/?target=https%3A//www.cnblogs.com/mfryf/archive/2012/02/12/2347975.html)





*//补充一截*
ffprobe --show_streams output.mp4

ffmpeg -i input.mp4 output.mp4

ffmpeg -i input.mp4 -f avi output.dat



MinGW + MSYS环境

./configure

./make

./make install



ffmpeg --help



ffmpeg --help long



ffmpeg --help full



ffmpeg -formats



ffmpeg -decoders



ffmpeg -encoders



ffmpeg -h muxer=flv



ffmpeg -h demuxer=flv



ffmpeg -h encoder=h264



ffmpeg -h filter=colorkey



ffmpeg -i input.rmvb -vcodec mpeg4 -b:v 200k -r 15 -an output.mp4

将input.rmvb转换为mp4封装格式的视频

音频编码为mpeg4,视频码率为200kbit/s,帧率为14，且去除音频数据



ffprobe --show_packets input.flv

ffprobe --show_format output.mp4

ffprobe --show_frames input.mp4

ffprobe --show_streams input.mp4



ffprobe -of xml -show_streams input.flv

ffprobe -of ini -show_streams input.flv

ffprobe -of flat -show_streams input.flv

json/csv









参考：

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

















编辑于 2021-01-10 23:53

视频解码

FFmpeg

视频处理