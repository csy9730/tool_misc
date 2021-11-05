# [Ffmpeg 获取USB Camera 视频流](https://www.cnblogs.com/wanggang123/p/8299397.html)



​       本文讲述的案例是如何通过Ffmpeg实现从USB Camera中获取视频流并将视频流保存到MP4文件。

本文亦适用于从USB Camera 获取视频流并将视频流转发到rtmp服务的案例，二者基本的原理和流程

一样，不同的仅仅是输出上下文。

​        首先撇开Ffmpeg说说基本的原理，一直觉得基本的原理是最重要的，理解了基本的原理即使出现

问题也能快速定位问题。USB Camera 对操作系统来说就是一个USB 设备，应用程序如何获得设备的基本

信息又如何跟设备进行通信呢？答案是通过设备的驱动程序，当然应用程序不会直接调用设备的驱动程序，

因为没有这个权限。一般来说，应用程序会调用操作系统API间接跟设备打交道。说到这里肯定有人会说从

USB设备获取视频流岂不是很麻烦？如果每一步都是我们自己做肯定很麻烦，幸好这个世界有库存在，库

可以解决很多问题。DShow 这个库就实现了对USB Camera设备的封装，对外暴露打开，取流，关闭等接口。

本文讲的是如何通过Ffmpeg实现从USB Camera取流，是不是Ffmpeg调用了DShow封装好的接口？是的，事

实就是这样。说了半天只是从底层描述了Ffmpeg如何获跟USB Camera打交道，下面给出从取流到保存成文

件的基本流程。

![img](https://images2017.cnblogs.com/blog/978507/201801/978507-20180117090018599-1368732976.png)

​                          图1   Ffmpeg取流保存文件基本流程

​     图1 展示了Ffmpeg 获取USB Camera视频流并保存到本地文件的基本流程，如果您看过我之前写的博客应该知道

大的流程基本相同，不同的是之前大多数情况下的视频源输入的是视频流地址，本案例视频源输入的是设备的名称，

具体的名称可以从设备管理器中查看。基本代码如下：

一.打开设备获取设备基本信息。需要注意的是输入的视频格式需要填写dshow，参数rtbufsize用来设置缓冲大小，

如果缓冲小了可能会出现丢帧的情况。

```
`int` `OpenInput(string inputUrl)``{``    ``inputContext = avformat_alloc_context();   ``    ``lastReadPacktTime = av_gettime();``    ``inputContext->interrupt_callback.callback = interrupt_cb;``     ``AVInputFormat *ifmt = av_find_input_format(``"dshow"``);``     ``AVDictionary *format_opts =  ``nullptr``;``     ``av_dict_set_int(&format_opts, ``"rtbufsize"``, 18432000  , 0);` `    ``int` `ret = avformat_open_input(&inputContext, inputUrl.c_str(), ifmt,&format_opts);``    ``if``(ret < 0)``    ``{``        ``av_log(NULL, AV_LOG_ERROR, ``"Input file open input failed\n"``);``        ``return`  `ret;``    ``}``    ``ret = avformat_find_stream_info(inputContext,``nullptr``);``    ``if``(ret < 0)``    ``{``        ``av_log(NULL, AV_LOG_ERROR, ``"Find input file stream inform failed\n"``);``    ``}``    ``else``    ``{``        ``av_log(NULL, AV_LOG_FATAL, ``"Open input file  %s success\n"``,inputUrl.c_str());``    ``}``    ``return` `ret;``}`
```

二.读取视频包。注意这里的视频包是”编码”以后的数据，这里的编码不同于很复杂H264算法，只是名义上编码，

读取视频包的代码如下：

```
`shared_ptr<AVPacket> ReadPacketFromSource()``{``    ``shared_ptr<AVPacket> packet(``static_cast``<AVPacket*>(av_malloc(``sizeof``(AVPacket))), [&](AVPacket *p) { av_packet_free(&p); av_freep(&p);});``    ``av_init_packet(packet.get());``    ``lastReadPacktTime = av_gettime();``    ``int` `ret = av_read_frame(inputContext, packet.get());``    ``if``(ret >= 0)``    ``{``        ``return` `packet;``    ``}``    ``else``    ``{``        ``return` `nullptr``;``    ``}``}`
```

三. 解码视频包，首先创建解码器，接着初始化解码器，最后是调用解码Ffmpeg API进行解码，具体的代码如下：

```
`int` `InitDecodeContext(AVStream *inputStream)``{  ``    ``auto` `codecId = inputStream->codec->codec_id;``    ``auto` `codec = avcodec_find_decoder(codecId);``    ``if` `(!codec)``    ``{``        ``return` `-1;``    ``}` `    ``int` `ret = avcodec_open2(inputStream->codec, codec, NULL);``    ``return` `ret;` `}<br><br>`
```

bool Decode(AVStream* inputStream,AVPacket* packet, AVFrame *frame)
{
　　int gotFrame = 0;
　　auto hr = avcodec_decode_video2(inputStream->codec, frame, &gotFrame, packet);
　　if (hr >= 0 && gotFrame != 0)
　　{
　　　　return true;
　　}
　　return false;
}

　四. 编码 将视频包解码后要再编码的，编码之前同样需要初始化编码器。编码的格式设置为H264，具体的代码如下：

```
`int` `initEncoderCodec(AVStream* inputStream,AVCodecContext **encodeContext)``{<br>　　　　　AVCodec *  picCodec;     ``　　 　　 picCodec = avcodec_find_encoder(AV_CODEC_ID_H264);       ``　　 　　(*encodeContext) = avcodec_alloc_context3(picCodec);  ``　　　　　(*encodeContext)->codec_id = picCodec->id;``    ``(*encodeContext)->has_b_frames = 0;``    ``(*encodeContext)->time_base.num = inputStream->codec->time_base.num;``    ``(*encodeContext)->time_base.den = inputStream->codec->time_base.den;``    ``(*encodeContext)->pix_fmt =  *picCodec->pix_fmts;``    ``(*encodeContext)->width = inputStream->codec->width;``    ``(*encodeContext)->height =inputStream->codec->height;``    ``(*encodeContext)->flags |= AV_CODEC_FLAG_GLOBAL_HEADER;``    ``int` `ret = avcodec_open2((*encodeContext), picCodec, ``nullptr``);``    ``if` `(ret < 0)``    ``{``        ``std::cout<<``"open video codec failed"``<<endl;``        ``return`  `ret;``    ``}``    ``return` `1;``}` `std::shared_ptr<AVPacket> Encode(AVCodecContext *encodeContext,AVFrame * frame)``{``    ``int` `gotOutput = 0;``    ``std::shared_ptr<AVPacket> pkt(``static_cast``<AVPacket*>(av_malloc(``sizeof``(AVPacket))), [&](AVPacket *p) { av_packet_free(&p); av_freep(&p); });``    ``av_init_packet(pkt.get());``    ``pkt->data = NULL;``    ``pkt->size = 0;``    ``int` `ret = avcodec_encode_video2(encodeContext, pkt.get(), frame, &gotOutput);``    ``if` `(ret >= 0 && gotOutput)``    ``{``    ``　　``return` `pkt;``    ``}``    ``else``    ``{``    ``　　``return` `nullptr``;``    ``}``}`
```

　　五 . 封装写文件，编码后的视频数据不能直接写入文件，需要经过封装（打包）成mp4格式。首先我们得创建输出上下文，

并为它指定视频格式。具体的代码如下：

```
`int` `OpenOutput(string outUrl,AVCodecContext *encodeCodec)``{` `    ``int` `ret  = avformat_alloc_output_context2(&outputContext, ``nullptr``, ``"mp4"``, outUrl.c_str());``    ``if``(ret < 0)``    ``{``        ``av_log(NULL, AV_LOG_ERROR, ``"open output context failed\n"``);``        ``goto` `Error;``    ``}` `    ``ret = avio_open2(&outputContext->pb, outUrl.c_str(), AVIO_FLAG_WRITE,``nullptr``, ``nullptr``); ``    ``if``(ret < 0)``    ``{``        ``av_log(NULL, AV_LOG_ERROR, ``"open avio failed"``);``        ``goto` `Error;``    ``}` `    ``for``(``int` `i = 0; i < inputContext->nb_streams; i++)``    ``{``        ``if``(inputContext->streams[i]->codec->codec_type == AVMediaType::AVMEDIA_TYPE_AUDIO)``        ``{``            ``continue``;``        ``}``        ``AVStream * stream = avformat_new_stream(outputContext, encodeCodec->codec);             ``        ``ret = avcodec_copy_context(stream->codec, encodeCodec); ``        ``if``(ret < 0)``        ``{``            ``av_log(NULL, AV_LOG_ERROR, ``"copy coddec context failed"``);``            ``goto` `Error;``        ``}``    ``}` `    ``ret = avformat_write_header(outputContext, ``nullptr``);``    ``if``(ret < 0)``    ``{``        ``av_log(NULL, AV_LOG_ERROR, ``"format write header failed"``);``        ``goto` `Error;``    ``}` `    ``av_log(NULL, AV_LOG_FATAL, ``" Open output file success %s\n"``,outUrl.c_str());           ``    ``return` `ret ;``Error:``    ``if``(outputContext)``    ``{``        ``for``(``int` `i = 0; i < outputContext->nb_streams; i++)``        ``{``            ``avcodec_close(outputContext->streams[i]->codec);``        ``}``        ``avformat_close_input(&outputContext);``    ``}``    ``return` `ret ;``}` `int` `WritePacket(shared_ptr<AVPacket> packet)``{``    ``auto` `inputStream = inputContext->streams[packet->stream_index];``    ``auto` `outputStream = outputContext->streams[packet->stream_index];``    ``packet->pts = packet->dts = packetCount * (outputContext->streams[0]->time_base.den) /``                     ``outputContext->streams[0]->time_base.num / 30 ;``    ``//cout <<"pts:"<<packet->pts<<endl;``    ``packetCount++;``    ``return` `av_interleaved_write_frame(outputContext, packet.get());``}`
```

　六 .调用实例

```
`int` `_tmain(``int` `argc, _TCHAR* argv[])``{``    ` `    ``SwsScaleContext swsScaleContext;``    ``AVFrame *videoFrame = av_frame_alloc();``    ``AVFrame *pSwsVideoFrame = av_frame_alloc();` `    ``Init();``    ``int` `ret = OpenInput(``"video=USB2.0 Camera"``);``    ` `    ``if``(ret <0) ``goto` `Error;``    ` `    ``InitDecodeContext(inputContext->streams[0]);``    `  `    ``ret = initEncoderCodec(inputContext->streams[0],&encodeContext);` `    ``if``(ret >= 0)``    ``{``        ``ret = OpenOutput(``"D:\\usbCamera.mp4"``,encodeContext);``    ``}``    ``if``(ret <0) ``goto` `Error;``    ` `    ` `    ``swsScaleContext.SetSrcResolution(inputContext->streams[0]->codec->width, inputContext->streams[0]->codec->height);` `    ``swsScaleContext.SetDstResolution(encodeContext->width,encodeContext->height);``    ``swsScaleContext.SetFormat(inputContext->streams[0]->codec->pix_fmt, encodeContext->pix_fmt);``    ``initSwsContext(&pSwsContext, &swsScaleContext);``    ``initSwsFrame(pSwsVideoFrame,encodeContext->width, encodeContext->height);``    ``int64_t startTime = av_gettime();``     ``while``(``true``)``     ``{``        ``auto` `packet = ReadPacketFromSource();``        ``if``(av_gettime() - startTime > 30 * 1000 * 1000)``        ``{``            ``break``;``        ``}``        ``if``(packet && packet->stream_index == 0)``        ``{``            ``if``(Decode(inputContext->streams[0],packet.get(),videoFrame))``            ``{``                ``sws_scale(pSwsContext, (``const` `uint8_t *``const` `*)videoFrame->data,``                    ``videoFrame->linesize, 0, inputContext->streams[0]->codec->height, (uint8_t *``const` `*)pSwsVideoFrame->data, pSwsVideoFrame->linesize);``                ``auto` `packetEncode = Encode(encodeContext,pSwsVideoFrame);``                ``if``(packetEncode)``                ``{``                    ``ret = WritePacket(packetEncode);``                    ``//cout <<"ret:" << ret<<endl;``                ``}` `            ``}``                        ` `        ``}``        ` `     ``}``     ``cout <<``"Get Picture End "``<<endl;``     ``av_frame_free(&videoFrame);``     ``avcodec_close(encodeContext);``     ``av_frame_free(&pSwsVideoFrame);``     ` `    ``Error:``    ``CloseInput();``    ``CloseOutput();``    ` `    ``while``(``true``)``    ``{``        ``this_thread::sleep_for(chrono::seconds(100));``    ``}``    ``return` `0;``}`
```

　　

如需交流，可以加QQ群1038388075，766718184，或者QQ：350197870

 视频教程 播放地址： http://www.iqiyi.com/u/1426749687

视频下载地址：<http://www.chungen90.com/?news_33/>



分类: [视频](https://www.cnblogs.com/wanggang123/category/841556.html)

标签: [ffmpeg](https://www.cnblogs.com/wanggang123/tag/ffmpeg/), [USB Camera](https://www.cnblogs.com/wanggang123/tag/USB Camera/), [保存文件](https://www.cnblogs.com/wanggang123/tag/保存文件/)