# ffmpeg

## demo

``` bash
# push流
ffmpeg -i H:\Dataset\segment\mov\1.mp4  -t 5 rtsp://localhost:8554/6 

# 指定udp，push流
ffmpeg -rtsp_transport udp -i rtsp://localhost:8554/6 -t 5 H:\Dataset\segment\mov\湘AE0959.mp4

# 指定tcp，push流
ffmpeg -rtsp_transport tcp -i rtsp://localhost:554/stream/main -codec copy  -r 15 -s 1366x768 -f rtsp rtsp://localhost:554/stream/main

# pull & dump to file
ffmpeg -i rtsp://localhost/test -c copy shifu.avi


```


- -stream_loop -1   循环读取视频源的次数，-1为无限循环
- -f fmt              force format 默认是(rtsp),可选rtp
- -c codec            codec name
- -codec codec        codec name
- -vcodec             video codec name （libx264）
- -acodec             audio codec name :(copy)
- -rtsp_transport         tcp or udp           
- -i                  指定输入源，可以是url或本地文件
- -ac channels        set number of audio channels
- outfile             指定输出源，可以是url或本地文件
- -ar rate            set audio sampling rate (in Hz)

#### easyEdawin
``` bash
# tcp，h264编码， 推流
ffmpeg -re -i H:\Dataset\segment\mov\1.mp4 -rtsp_transport tcp -vcodec h264 -f rtsp rtsp://localhost/test 

ffmpeg -re -i H:\Dataset\misc\SDRSample.mkv  -vcodec copy -acodec copy -f rtsp rtsp://localhost:554/live.sdp

```

```
D:\Program Files\ImageMagick-7.0.10-Q16>
D:\Program Files\ImageMagick-7.0.10-Q16>ffmpeg -re -i H:\Dataset\misc\SDRSample.mkv -rtsp_transport tcp -vcodec h264 -f rtsp rtsp://localhost/test
ffmpeg version 4.2 Copyright (c) 2000-2019 the FFmpeg developers
  built with gcc 9.1.1 (GCC) 20190807
  configuration: --enable-gpl --enable-version3 --enable-sdl2 --enable-fontconfig --enable-gnutls --enable-iconv --enabl
e-libass --enable-libdav1d --enable-libbluray --enable-libfreetype --enable-libmp3lame --enable-libopencore-amrnb --enab
le-libopencore-amrwb --enable-libopenjpeg --enable-libopus --enable-libshine --enable-libsnappy --enable-libsoxr --enabl
e-libtheora --enable-libtwolame --enable-libvpx --enable-libwavpack --enable-libwebp --enable-libx264 --enable-libx265 -
-enable-libxml2 --enable-libzimg --enable-lzma --enable-zlib --enable-gmp --enable-libvidstab --enable-libvorbis --enabl
e-libvo-amrwbenc --enable-libmysofa --enable-libspeex --enable-libxvid --enable-libaom --enable-libmfx --enable-amf --en
able-ffnvcodec --enable-cuvid --enable-d3d11va --enable-nvenc --enable-nvdec --enable-dxva2 --enable-avisynth --enable-l
ibopenmpt
  libavutil      56. 31.100 / 56. 31.100
  libavcodec     58. 54.100 / 58. 54.100
  libavformat    58. 29.100 / 58. 29.100
  libavdevice    58.  8.100 / 58.  8.100
  libavfilter     7. 57.100 /  7. 57.100
  libswscale      5.  5.100 /  5.  5.100
  libswresample   3.  5.100 /  3.  5.100
  libpostproc    55.  5.100 / 55.  5.100
Input #0, matroska,webm, from 'H:\Dataset\misc\SDRSample.mkv':
  Metadata:
    encoder         : libwebm-0.2.1.0
  Duration: 00:00:11.85, start: 0.000000, bitrate: 1224 kb/s
    Stream #0:0(eng): Video: vp9 (Profile 0), yuv420p(tv), 1920x1080, SAR 1:1 DAR 16:9, 23.98 fps, 23.98 tbr, 1k tbn, 1k
 tbc (default)
Stream mapping:
  Stream #0:0 -> #0:0 (vp9 (native) -> h264 (libx264))
Press [q] to stop, [?] for help
[libx264 @ 000001f87f0eff40] using SAR=1/1
[libx264 @ 000001f87f0eff40] using cpu capabilities: MMX2 SSE2Fast SSSE3 SSE4.2 AVX FMA3 BMI2 AVX2
[libx264 @ 000001f87f0eff40] profile High, level 4.0, 4:2:0, 8-bit
[libx264 @ 000001f87f0eff40] 264 - core 158 r2984 3759fcb - H.264/MPEG-4 AVC codec - Copyleft 2003-2019 - http://www.vid
eolan.org/x264.html - options: cabac=1 ref=3 deblock=1:0:0 analyse=0x3:0x113 me=hex subme=7 psy=1 psy_rd=1.00:0.00 mixed
_ref=1 me_range=16 chroma_me=1 trellis=1 8x8dct=1 cqm=0 deadzone=21,11 fast_pskip=1 chroma_qp_offset=-2 threads=9 lookah
ead_threads=1 sliced_threads=0 nr=0 decimate=1 interlaced=0 bluray_compat=0 constrained_intra=0 bframes=3 b_pyramid=2 b_
adapt=1 b_bias=0 direct=1 weightb=1 open_gop=0 weightp=2 keyint=250 keyint_min=23 scenecut=40 intra_refresh=0 rc_lookahe
ad=40 rc=crf mbtree=1 crf=23.0 qcomp=0.60 qpmin=0 qpmax=69 qpstep=4 ip_ratio=1.40 aq=1:1.00
Output #0, rtsp, to 'rtsp://localhost/test':
  Metadata:
    encoder         : Lavf58.29.100
    Stream #0:0(eng): Video: h264 (libx264), yuv420p, 1920x1080 [SAR 1:1 DAR 16:9], q=-1--1, 23.98 fps, 90k tbn, 23.98 t
bc (default)
    Metadata:
      encoder         : Lavc58.54.100 libx264
    Side data:
      cpb: bitrate max/min/avg: 0/0/0 buffer size: 0 vbv_delay: -1
frame=  285 fps= 22 q=-1.0 Lsize=N/A time=00:00:11.76 bitrate=N/A speed=0.908x
video:4826kB audio:0kB subtitle:0kB other streams:0kB global headers:0kB muxing overhead: unknown
[libx264 @ 000001f87f0eff40] frame I:2     Avg QP:19.02  size:112014
[libx264 @ 000001f87f0eff40] frame P:72    Avg QP:20.73  size: 40680
[libx264 @ 000001f87f0eff40] frame B:211   Avg QP:24.14  size:  8474
[libx264 @ 000001f87f0eff40] consecutive B-frames:  0.7%  1.4%  1.1% 96.8%
[libx264 @ 000001f87f0eff40] mb I  I16..4: 21.3% 67.6% 11.1%
[libx264 @ 000001f87f0eff40] mb P  I16..4:  6.5%  8.9%  0.5%  P16..4: 43.5% 14.0%  5.7%  0.0%  0.0%    skip:21.0%
[libx264 @ 000001f87f0eff40] mb B  I16..4:  0.4%  0.3%  0.0%  B16..8: 43.7%  2.7%  0.4%  direct: 1.0%  skip:51.6%  L0:46.4% L1:48.9% BI: 4.6%
[libx264 @ 000001f87f0eff40] 8x8 transform intra:56.9% inter:82.8%
[libx264 @ 000001f87f0eff40] coded y,uvDC,uvAC intra: 26.1% 38.1% 11.0% inter: 8.9% 12.6% 1.7%
[libx264 @ 000001f87f0eff40] i16 v,h,dc,p: 18% 46%  8% 28%
[libx264 @ 000001f87f0eff40] i8 v,h,dc,ddl,ddr,vr,hd,vl,hu: 20% 26% 33%  3%  3%  2%  6%  3%  5%
[libx264 @ 000001f87f0eff40] i4 v,h,dc,ddl,ddr,vr,hd,vl,hu: 26% 25% 19%  4%  6%  4%  9%  4%  4%
[libx264 @ 000001f87f0eff40] i8c dc,h,v,p: 54% 26% 15%  5%
[libx264 @ 000001f87f0eff40] Weighted P-Frames: Y:0.0% UV:0.0%
[libx264 @ 000001f87f0eff40] ref P L0: 55.1% 24.3% 14.5%  6.1%
[libx264 @ 000001f87f0eff40] ref B L0: 91.8%  6.8%  1.4%
[libx264 @ 000001f87f0eff40] ref B L1: 96.7%  3.3%
[libx264 @ 000001f87f0eff40] kb/s:3325.38

```

## help
```
Hyper fast Audio and Video encoder
usage: ffmpeg [options] [[infile options] -i infile]... {[outfile options] outfile}...

Getting help:
    -h      -- print basic options
    -h long -- print more options
    -h full -- print all options (including all format and codec specific options, very long)
    -h type=name -- print all options for the named decoder/encoder/demuxer/muxer/filter/bsf
    See man ffmpeg for detailed description of the options.

Print help / information / capabilities:
-L                  show license
-h topic            show help
-? topic            show help
-help topic         show help
--help topic        show help
-version            show version
-buildconf          show build configuration
-formats            show available formats
-muxers             show available muxers
-demuxers           show available demuxers
-devices            show available devices
-codecs             show available codecs
-decoders           show available decoders
-encoders           show available encoders
-bsfs               show available bit stream filters
-protocols          show available protocols
-filters            show available filters
-pix_fmts           show available pixel formats
-layouts            show standard channel layouts
-sample_fmts        show available audio sample formats
-colors             show available color names
-sources device     list sources of the input device
-sinks device       list sinks of the output device
-hwaccels           show available HW acceleration methods

Global options (affect whole program instead of just one file:
-loglevel loglevel  set logging level
-v loglevel         set logging level
-report             generate a report
-max_alloc bytes    set maximum size of a single allocated block
-y                  overwrite output files
-n                  never overwrite output files
-ignore_unknown     Ignore unknown stream types
-filter_threads     number of non-complex filter threads
-filter_complex_threads  number of threads for -filter_complex
-stats              print progress report during encoding
-max_error_rate maximum error rate  ratio of errors (0.0: no errors, 1.0: 100% errors) above which ffmpeg returns an error instead of success.
-bits_per_raw_sample number  set the number of bits per raw sample
-vol volume         change audio volume (256=normal)

Per-file main options:
-f fmt              force format
-c codec            codec name
-codec codec        codec name
-pre preset         preset name
-map_metadata outfile[,metadata]:infile[,metadata]  set metadata information of outfile from infile
-t duration         record or transcode "duration" seconds of audio/video
-to time_stop       record or transcode stop time
-fs limit_size      set the limit file size in bytes
-ss time_off        set the start time offset
-sseof time_off     set the start time offset relative to EOF
-seek_timestamp     enable/disable seeking by timestamp with -ss
-timestamp time     set the recording timestamp ('now' to set the current time)
-metadata string=string  add metadata
-program title=string:st=number...  add program with specified streams
-target type        specify target file type ("vcd", "svcd", "dvd", "dv" or "dv50" with optional prefixes "pal-", "ntsc-" or "film-")
-apad               audio pad
-frames number      set the number of frames to output
-filter filter_graph  set stream filtergraph
-filter_script filename  read stream filtergraph description from a file
-reinit_filter      reinit filtergraph on input parameter changes
-discard            discard
-disposition        disposition

Video options:
-vframes number     set the number of video frames to output
-r rate             set frame rate (Hz value, fraction or abbreviation)
-s size             set frame size (WxH or abbreviation)
-aspect aspect      set aspect ratio (4:3, 16:9 or 1.3333, 1.7777)
-bits_per_raw_sample number  set the number of bits per raw sample
-vn                 disable video
-vcodec codec       force video codec ('copy' to copy stream)
-timecode hh:mm:ss[:;.]ff  set initial TimeCode value.
-pass n             select the pass number (1 to 3)
-vf filter_graph    set video filters
-ab bitrate         audio bitrate (please use -b:a)
-b bitrate          video bitrate (please use -b:v)
-dn                 disable data

Audio options:
-aframes number     set the number of audio frames to output
-aq quality         set audio quality (codec-specific)
-ar rate            set audio sampling rate (in Hz)
-ac channels        set number of audio channels
-an                 disable audio
-acodec codec       force audio codec ('copy' to copy stream)
-vol volume         change audio volume (256=normal)
-af filter_graph    set audio filters

Subtitle options:
-s size             set frame size (WxH or abbreviation)
-sn                 disable subtitle
-scodec codec       force subtitle codec ('copy' to copy stream)
-stag fourcc/tag    force subtitle tag/fourcc
-fix_sub_duration   fix subtitles duration
-canvas_size size   set canvas size (WxH or abbreviation)
-spre preset        set the subtitle options to the indicated preset


```