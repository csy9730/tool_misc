# 什么是Gstreamer？

Gstreamer是一个支持Windows，Linux，Android， iOS的跨平台的多媒体框架，应用程序可以通过管道（Pipeline）的方式，将多媒体处理的各个步骤串联起来，达到预期的效果。每个步骤通过元素（Element）基于GObject对象系统通过插件（plugins）的方式实现，方便了各项功能的扩展。

下图是对基于Gstreamer框架的应用的简单分层：

![img](https://img2018.cnblogs.com/blog/1647252/201905/1647252-20190530111815110-1437440871.png)

 

## Media Applications

最上面一层为应用，比如gstreamer自带的一些工具（gst-launch，gst-inspect等），以及基于gstreamer封装的库（gst-player，gst-rtsp-server，gst-editing-services等)根据不同场景实现的应用。

## Core Framework

中间一层为Core Framework，主要提供：

- 上层应用所需接口
- Plugin的框架
- Pipline的框架
- 数据在各个Element间的传输及处理机制
- 多个媒体流（Streaming）间的同步（比如音视频同步）
- 其他各种所需的工具库

## Plugins

最下层为各种插件，实现具体的数据处理及音视频输出，应用不需要关注插件的细节，会由Core Framework层负责插件的加载及管理。主要分类为：

- Protocols：负责各种协议的处理，file，http，rtsp等。
- Sources：负责数据源的处理，alsa，v4l2，tcp/udp等。
- Formats：负责媒体容器的处理，avi，mp4，ogg等。
- Codecs：负责媒体的编解码，mp3，vorbis等。
- Filters：负责媒体流的处理，converters，mixers，effects等。
- Sinks：负责媒体流输出到指定设备或目的地，alsa，xvideo，tcp/udp等。

Gstreamer框架根据各个模块的成熟度以及所使用的开源协议，将core及plugins置于不同的源码包中：

- gstreamer: 包含core framework及core elements。
- gst-plugins-base: gstreamer应用所需的必要插件。
- gst-plugins-good: 高质量的采用LGPL授权的插件。
- gst-plugins-ugly: 高质量，但使用了GPL等其他授权方式的库的插件，比如使用GPL的x264，x265。
- gst-plugins-bad: 质量有待提高的插件，成熟后可以移到good插件列表中。
- gst-libav: 对libav封装，使其能在gstreamer框架中使用。

 

# Gstreamer基础概念

在进一步学习Gstreamer前，我们需要掌握一些gstreamer的基础概念。

## Element

Element是Gstreamer中最重要的对象类型之一。一个element实现一个功能（读取文件，解码，输出等），程序需要创建多个element，并按顺序将其串连起来，构成一个完整的pipeline。

## Pad

Pad是一个element的输入/输出接口，分为src pad（生产数据）和sink pad（消费数据）两种。
两个element必须通过pad才能连接起来，pad拥有当前element能处理数据类型的能力（capabilities），会在连接时通过比较src pad和sink pad中所支持的能力，来选择最恰当的数据类型用于传输，如果element不支持，程序会直接退出。在element通过pad连接成功后，数据会从上一个element的src pad传到下一个element的sink pad然后进行处理。
当element支持多种数据处理能力时，我们可以通过Cap来指定数据类型.
例如，下面的命令通过Cap指定了视频的宽高，videotestsrc会根据指定的宽高产生相应数据：

```
gst-launch-1.0 videotestsrc ! "video/x-raw,width=1280,height=720" ! autovideosink
```

## Bin和Pipeline

Bin是一个容器，用于管理多个element，改变bin的状态时，bin会自动去修改所包含的element的状态，也会转发所收到的消息。如果没有bin，我们需要依次操作我们所使用的element。通过bin降低了应用的复杂度。
Pipeline继承自bin，为程序提供一个bus用于传输消息，并且对所有子element进行同步。当将pipeline的状态设置为PLAYING时，pipeline会在一个/多个新的线程中通过element处理数据。

下面我们通过一个文件播放的例子来熟悉上述提及的概念：测试文件[ sintel_trailer-480p.ogv](http://www.freedesktop.org/software/gstreamer-sdk/data/media/sintel_trailer-480p.ogv)

```
gst-launch-1.0 filesrc location=sintel_trailer-480p.ogv ! oggdemux name=demux ! queue ! vorbisdec ! autoaudiosink demux. ! queue ! theoradec ! videoconvert ! autovideosink
```

通过上面的命令播放文件时，会创建如下pipeline：

![img](https://img2018.cnblogs.com/blog/1647252/201905/1647252-20190530112147332-1498662949.png)

可以看到这个pipeline由8个element构成，每个element都实现各自的功能：
filesrc读取文件，oggdemux解析文件，分别提取audio，video数据，queue缓存数据，vorbisdec解码audio，autoaudiosink自动选择音频设备并输出，theoradec解码video，videoconvert转换video数据格式，autovideosink自动选择显示设备并输出。

不同的element拥有不同数量及类型的pad，只有src pad的element被称为source element，只有sink pad的被称为sink element。

element可以同时拥有多个相同的pad，例如oggdemux在解析文件后，会将audio，video通过不同的pad输出。

 

# Gstreamer数据消息交互

在pipeline运行的过程中，各个element以及应用之间不可避免的需要进行数据消息的传输，gstreamer提供了bus系统以及多种数据类型（Buffers、Events、Messages，Queries）来达到此目的：

![img](https://img2018.cnblogs.com/blog/1647252/201905/1647252-20190530112246685-1757556692.png)

## Bus

Bus是gstreamer内部用于将消息从内部不同的streaming线程，传递到bus线程，再由bus所在线程将消息发送到应用程序。应用程序只需要向bus注册消息处理函数，即可接收到pipline中各element所发出的消息，使用bus后，应用程序就不用关心消息是从哪一个线程发出的，避免了处理多个线程同时发出消息的复杂性。

## Buffers

用于从sources到sinks的媒体数据传输。

## Events

用于element之间或者应用到element之间的信息传递，比如播放时的seek操作是通过event实现的。

## Messages

是由element发出的消息，通过bus，以异步的方式被应用程序处理。通常用于传递errors, tags, state changes, buffering state, redirects等消息。消息处理是线程安全的。由于大部分消息是通过异步方式处理，所以会在应用程序里存在一点延迟，如果要及时的相应消息，需要在streaming线程捕获处理。

## Queries

用于应用程序向gstreamer查询总时间，当前时间，文件大小等信息。

 

# gstreamer tools

Gstreamer自带了gst-inspect-1.0和gst-launch-1.0等其他命令行工具，我们可以使用这些工具完成常见的处理任务。
gst-inspect-1.0
查看gstreamer的plugin、element的信息。直接将plugin/element的类型作为参数，会列出其详细信息。如果不跟任何参数，会列出当前系统gstreamer所能查找到的所有插件。

```
$ gst-inspect-1.0 playbin
```

gst-launch-1.0
用于创建及执行一个Pipline，因此通常使用gst-launch先验证相关功能，然后再编写相应应用。
通过上面ogg视频播放的例子，我们已经看到，一个pipeline的多个element之间通过 “!" 分隔，同时可以设置element及Cap的属性。例如：
播放音视频

```
gst-launch-1.0 playbin file:///home/root/test.mp4
```

转码

```
gst-launch-1.0 filesrc location=/videos/sintel_trailer-480p.ogv ! decodebin name=decode ! \
               videoscale ! "video/x-raw,width=320,height=240" ! x264enc ! queue ! \
               mp4mux name=mux ! filesink location=320x240.mp4 decode. ! audioconvert ! \
               avenc_aac ! queue ! mux.
```

Streaming

```
#Server
gst-launch-1.0 -v videotestsrc ! "video/x-raw,framerate=30/1" ! x264enc key-int-max=30 ! rtph264pay ! udpsink host=127.0.0.1 port=1234

#Client
gst-launch-1.0 udpsrc port=1234 ! "application/x-rtp, payload=96" ! rtph264depay ! decodebin ! autovideosink sync=false
```

 

# 引用

<https://gstreamer.freedesktop.org/documentation/application-development/introduction/gstreamer.html>
<https://gstreamer.freedesktop.org/documentation/application-development/introduction/basics.html>
<https://gstreamer.freedesktop.org/documentation/tools/gst-launch.html>

 

作者：[John.Leng](http://www.cnblogs.com/xleng/)

出处：<http://www.cnblogs.com/xleng/>

本文版权归作者所有，欢迎转载。商业转载请联系作者获得授权，非商业转载请在文章页面明显位置给出原文连接.