# portaudio使用笔记

[C_GO流媒体后台开发](https://www.jianshu.com/u/d71cbb36d1f8)关注

0.0752018.11.02 17:29:56字数 2,201阅读 6,751

> 原文链接：<https://blog.csdn.net/gg_simida/article/details/77185755>

# 介绍

PortAudio是一个免费、跨平台、开源的音频I/O库。看到I/O可能就想到了文件，但是PortAudio操作的I/O不是文件，而是音频设备。它能够简化C/C++的音频程序的设计实现，能够运行在Windows、Macintosh OS X和UNIX之上（Linux的各种版本也不在话下）。使用PortAudio可以在不同的平台上迁移应用程序，比如你可以把你基于PortAudio的应用程序发展一个Android版本啊。

PortAudio的API非常简单，通过一个一个简单的回调函数或者阻塞的读/写接口来录制或者播放声音。PortAudio自带了很多示例程序，比如播放正弦波形的音频信号，处理音频输入，录制回放音频，列举音频设备。

PortAudio的最新版本是V19。本文讨论的就是该版本。

# 范例参考

[范例参考](http://portaudio.com/docs/v19-doxydocs/group__examples__src.html)

# 下载安装

[源码下载路径](http://www.portaudio.com/download.html)
[VS上编译的步骤](http://portaudio.com/docs/v19-doxydocs/compile_windows.html)
ubuntu下直接使用apt-get install portaudio19-dev即可

# 使用流程

编写一个PortAudio应用，只需要掌握回调函数即可：

1. 编写一个回调函数，PortAudio在进行音频处理的时候自动调用。
2. 初始化PA库，并为音频I/O打开一个流（stream）。
3. 启动流，PA会在幕后调用回调函数。
4. 在回调函数中你可以从inputBuffer读取音频数据，或者将音频数据写入到outputBuffer。
5. 回调函数返回1，或者调用相应的函数来停止流。
6. 关闭流，然后终止PA。

除了回调函数，PA还支持阻塞I/O模型，但并不是所有的功能都得到支持。所以推荐使用回调函数。

# 总流程图



![img](https://upload-images.jianshu.io/upload_images/12119754-e542649f1a6ed407.png?imageMogr2/auto-orient/strip|imageView2/2/w/256/format/webp)

总流程图

# API详解

## 第一步：编写回调函数

首先引入PA的头文件：

```cpp
#include "portaudio.h"
```

回调函数会在两种情况下被PA调用：一是PA获取到了音频数据，二是PA需要音频数据作为输出时。

回调函数是一个神奇的地方，因为一些系统在一个特殊的线程中处理回调函数，甚至是通过中断来处理，这不同于程序中的其他代码。如果你想音频能够按时到达Speaker，就得保证回调函数能够快速地执行。不同的平台上，什么 样的操作是安全的，什么样的操作是不安全的，是不一样的。一个通用飞准则就是，不要做内存的分配释放操作、读写文件、printf，或者其他依赖于OS的不能在一定时间内返回的操作，也包括可能导致上下文切换的操作。

回调函数的原型如下：

```cpp
typedef int PaStreamCallback( const void *input, void *output, unsigned long frameCount, const PaStreamCallbackTimeInfo* timeInfo, PaStreamCallbackFlags statusFlags, void *userData ) ;
```

## 第二步：初始化PA

在调用任何PA函数之前，必须先调用Pa_Initialize()。它回扫描当前可用的音频设备，以便随后查询使用。像其他的PA函数一样，如果发生错误，它返回一个错误类型。你可以通过Pa_GetErrorText( err )得到出错信息。

```bash
if( err != paNoError ) printf( "PortAudio error: %s\n", Pa_GetErrorText( err ) );
```

当你使用完PA后，记得终止它：

```bash
err = Pa_Terminate(); if( err != paNoError ) printf( "PortAudio error: %s\n", Pa_GetErrorText( err ) );
```

## 第三步：打开流

随后就是打开一个输入流。跟打开一个文件很类似。可以指定是否需要音频输入/输出、音道数目、音频格式、采样率等。打开缺省的输入流，意味着打开缺省的音频设备，不需要去遍历并选择一个音频设备。

```cpp
#define SAMPLE_RATE (44100) 
static paTestData data; ..... 
PaStream *stream;
PaError err; /* Open an audio I/O stream. */ 
err = Pa_OpenDefaultStream( &stream, 0, /* no input channels */ 
    2, /* stereo output */ 
    paFloat32, /* 32 bit floating point output */ 
    SAMPLE_RATE, 
    256, /* frames per buffer, i.e. the number of sample frames that PortAudio will request from the callback. Many apps may want to use paFramesPerBufferUnspecified, which tells PortAudio to pick the best,possibly changing, buffer size.*/ 
    patestCallback, /* this is your callback function */ 
    &data ); /*This is a pointer that will be passed to your callback*/ 
if( err != paNoError ) 
    goto error;
```

上面的代码打开一个输出流，对于本示例，并不需要有输入的音频流，所以打开一个输出流就足够了。PA当然也支持打开一个输入流来录制，或者同时打开输入流和输出流，同时进行录制和回放，实时地音频处理也可以做到。

同时读/写时，需要注意下面几点：

1. 一些平台只允许在同一个设备上同时进行读写。
2. 虽然可以同时打开多个流，但是很难同步。
3. 一些平台不支持在一个设备上同时打开多个流。
4. PA对多个流的测试不足。
5. PA调用应该在同一个线程中，或者用户负责同步。

## 第四步：启动、停止、终止流

PA在启动流之前是不能播放声音的，只有在调用Pa_StartStream()之后，PA才会调用用户的回调函数进行音频处理。

```cpp
err = Pa_StartStream( stream ); if( err != paNoError ) goto error;
```

可以通过传给回调函数的用户数据块来与回调函数交互，其他交互的方法有：全局变量，IPC。需要注意是是，回调函数可能在中断中调用，与用户代码难以同步。因此要尽量避免一些很容易被破坏的复杂数据结构，比如双向链表，避免使用锁，如果信号量。这些可能导致回调函数被阻塞住，会丢掉音频数据。在一些平台上，还存在死锁的问题。

PA会一直调用回调函数直到停止流，可以通过好几种方式停止流。有的时候我们可能想等待一段时间，PA提供了函数Pa_Sleep()来让调用方睡眠指定毫秒，但它可能会等待超过指定的时间，在时间精度要求很高的场合，不推荐使用。

/* Sleep for several seconds. */ Pa_Sleep(NUM_SECONDS*1000);
最简单停止流的办法是调用Pa_StopStream()：

```cpp
err = Pa_StopStream( stream ); 
if( err != paNoError ) 
    goto error;
```

Pa_StopStream()会保证用户在回调函数中处理的缓冲数据得到播放，这可能导致一些延迟。替代的办法是调用Pa_AbortStream()。在一些平台上，终止一个流要快一些，但是可能导致回调函数已经处理的数据不能被播放。

另一个停止流的办法是回调函数返回paComplete或者paAbort。paComplete保证最后一个缓冲区被播放，paAbort则会尽快停止。如果采用此方法，你需要在再次开始流之前调用Pa_StopStream()。

## 第五步：关闭流和终止PA

当处理完一个流后，应该关闭流，释放资源。

```cpp
err = Pa_CloseStream( stream ); if( err != paNoError ) goto error;
```

如果你忘记了，一定不要忘记终止PA：

```cpp
err = Pa_Terminate( ); if( err != paNoError ) goto error;
```

其它实用函数

PA提供两个函数来得到PA的版本，这在使用动态链接库的时候非常有用：

```cpp
int Pa_GetVersion (void) const char * Pa_GetVersionText (void)
```

根据错误码得到出错信息：

```cpp
const char * Pa_GetErrorText (PaError errorCode)
```

PA流有三个状态：活动的、停止的、回调停止的。如果一个流是回调停止的，应该先停止流然后再重新启动流：

```undefined
PaError Pa_IsStreamStopped (PaStream *stream) PaError Pa_IsStreamActive (PaStream *stream)
```

获取流的信息，比如延迟、采样率：

```cpp
const PaStreamInfo * Pa_GetStreamInfo (PaStream *stream)
```

用以同步的时间戳：

```undefined
PaTime Pa_GetStreamTime (PaStream *stream)
```

回调函数使用的CPU数目：

```cpp
double Pa_GetStreamCpuLoad (PaStream *stream)
```

指定格式的采样大小：

```undefined
PaError Pa_GetSampleSize (PaSampleFormat format)
```

枚举查询音频设备

如果需要显式指定音频设备，我们就需要查询系统的音频设备。查询之前需要先初始化PA库：

```cpp
int numDevices; 
numDevices = Pa_GetDeviceCount(); 
if( numDevices < 0 )
{ 
  printf( "ERROR: Pa_CountDevices returned 0x%x\n", numDevices ); 
  err = numDevices; goto error; 
}
```

如果你想获取每个设备的信息，直接做一个循环即可：

```cpp
const PaDeviceInfo *deviceInfo; for( i=0; i<numDevices; i++ ) 
{
   deviceInfo = Pa_GetDeviceInfo( i ); ... 
}
```

PaDeviceInfo结构体包含了丰富的设备信息，比如设备名、缺省延迟等。它有如下成员：

```cpp
/** A structure providing information and capabilities of PortAudio devices.
 Devices may support input, output or both input and output.
*/
typedef struct PaDeviceInfo
{
    int structVersion;  /* this is struct version 2 */
    const char *name;
    PaHostApiIndex hostApi; /**< note this is a host API index, not a type id*/
    
    int maxInputChannels;
    int maxOutputChannels;

    /** Default latency values for interactive performance. */
    PaTime defaultLowInputLatency;
    PaTime defaultLowOutputLatency;
    /** Default latency values for robust non-interactive applications (eg. playing sound files). */
    PaTime defaultHighInputLatency;
    PaTime defaultHighOutputLatency;

    double defaultSampleRate;
} PaDeviceInfo;
```

但是这些信息中没有设备的采用率，如何才能得到呢？没有采样率的原因在于设备的多样性，音频设备支持的采用率差异很大，有些支持一定返回的采样率，有些只是支持一系列采样点，一些设备支持的采样率，另外的设备不能不支持。因此我们在使用设备之前，可以先测试设备的能力。

```cpp
const PaStreamParameters *inputParameters; 
const PaStreamParameters *outputParameters; 
double desiredSampleRate; 
... 
PaError err; 
err = Pa_IsFormatSupported( inputParameters, outputParameters, desiredSampleRate ); 
if( err == paFormatIsSupported ) 
{ 
   printf( "Hooray!\n"); 
} 
else 
{ 
   printf("Too Bad.\n"); 
}
```

在获得一个设备配置之后，或者你想测试下配置是否被设备支持，可以将信息填到PaStreamParameters结构体中，然后尝试打开流：

# 阻塞式读/写

PA的阻塞式用法，存在性能问题。但它作为V19引入的新特性，与第三方系统的兼容更加自然些，也比较容易理解。有兴趣的可以参考<http://portaudio.com/docs/v19-doxydocs/blocking_read_write.html>。