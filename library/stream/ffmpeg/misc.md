
## ffprobe

```
ffprobe -show_packets input.flv

ffprobe -show_*data -show_packets input.flv*

*ffprobe -show_format input.flv*

*ffprobe -show_frames input.flv*

*ffprobe -show_streams input.flv*

*格式化：*

*ffprobe -of flat -show_streams input.flv*

*ffprobe -of json -show_packets input.flv*

*ffprobe -show_frames -select_streams v -of xml input.mp4*
```


## FFPlay
```
*eg1. 播放音频文件，将解码后的音频数据以音频波形的形式显示出来，可以通过波形的振幅检查音频的播放情况*

*ffplay -showmode 1 output.mp3*

*eg2.当播放视频时想要体验解码器时如何解码每个宏块*

*ffplay -debug vis_mb_type -window_title "show vis_mb_type" -ss 20 -t 10 -autoexit output.mp4*

*eg3.查看B帧预测与P帧预测信息，将信息在窗口中显示出来*

*ffplay -vismv pf output.mp4*
```



```
解码视频为图片序列 -r 指每秒多少帧

(base) ➜ ffmpeg -i vv.mp4 -r 12 ./tmp2/%03d.png


查看视频信息及帧率

(base) ➜ ffprobe -i vv.mp4 -show_format -show_streams >[vv.info](https://link.zhihu.com/?target=http%3A//vv.info/)

转码视频为h264视频
(base) ➜ ffmpeg -i tt2.mp4 -vcodec h264 vv.mp4


图片序列合成视频
-f image2 指定编码格式
(base) ➜ ffmpeg -f image2 -i ./%03d.png tt2.mp4

```



## 图片处理库magick

[http://www.imagemagick.com.cn/commands.html](https://link.zhihu.com/?target=http%3A//www.imagemagick.com.cn/commands.html)

图片rgb层数据获取
```
magick convert actor05.png -background black -alpha remove actor.jpg
```


图片alpha层数据提取
```
magick convert actor05.png -alpha extract bird_alpha_mask.png
```




两张图像水平拼接
```
tmp magick convert +append actor.jpg bird_alpha_mask.png u.png
```
参考：

[https://blog.csdn.net/qq_24127015/article/details/86525305](https://link.zhihu.com/?target=https%3A//blog.csdn.net/qq_24127015/article/details/86525305)

[https://www.cnblogs.com/mfryf/archive/2012/02/12/2347975.htmlwww.cnblogs.com/mfryf/archive/2012/02/12/2347975.html](https://link.zhihu.com/?target=https%3A//www.cnblogs.com/mfryf/archive/2012/02/12/2347975.html)





```
ffprobe --show_streams output.mp4

ffmpeg -i input.mp4 output.mp4

ffmpeg -i input.mp4 -f avi output.dat
```


MinGW + MSYS环境
```
./configure

./make

./make install
```

```
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
```


```
ffprobe --show_packets input.flv

ffprobe --show_format output.mp4

ffprobe --show_frames input.mp4

ffprobe --show_streams input.mp4



ffprobe -of xml -show_streams input.flv

ffprobe -of ini -show_streams input.flv

ffprobe -of flat -show_streams input.flv
```