# linux v4l2摄像头应用层编程介绍

![img](https://cdn2.jianshu.io/assets/default_avatar/15-a7ac401939dd4df837e3bbf82abaa2a8.jpg)

[为瞬间停留](https://www.jianshu.com/u/e752b8c7abe7)关注

0.8192018.11.01 14:42:08字数 1,151阅读 11,787

### 一.前言

最近项目需要做一个工业条形读码器，在底层应该会适配linux v4l2框架，就自己研究了一下在应用层怎么使用v4l2进行编程，查阅了相关资料，主要是网上的博客资料，有：
<https://www.cnblogs.com/emouse/archive/2013/03/04/2943243.html>
<https://www.jianshu.com/p/fd5730e939e7>
大家可以进行查阅，比较学习，敝人也是参考，在一些地方进行了补充，希望可以共同学习，话不多说，喝杯咖啡，开动。

### 二.简介

百度这么说v4l2

------

百度说，v4l2是Video4linux2的简称，是linux中关于视频设备的内核驱动，在Linux中，视频设备是设备文件，可以像访问普通文件一样对其进行读写，摄像头设备文件位置是/dev/video0。V4L2在设计时，是要支持很多广泛的设备的，它们之中只有一部分在本质上是真正的视频设备。

------

因为我们这篇文章不涉及内核部分摄像头驱动的实现，大致可以简单说下，内核部分的实现分两部分：1.我们要根据摄像头的种类，实现具体的摄像头传感器的驱动，这里可能有一些数据和控制的通信总线的协议。2.然后这个具体的驱动需要适配这个v4l2这个框架，然后向用户层映射成一个字符设备文件。而我们的主题就是对这个设备文件进行操作，这就是应用层该做的事，你可能会说，这能学到什么，而我要说，学习是渐进的，先理解应用层的需求，对内核驱动的实现也会有更深的理解，你说呢？

### 三.使用V4L2的一般步骤

使用V4L2进行视频采集，一般是五个步骤：

- 1.打开设备，进行初始化参数设置
- 2.申请图像帧缓冲，并进行内存映射
- 3.把帧缓冲进行入队操作，开始视频流进行采集
- 4.进行出队，然后对数据进行处理，然后入队，如此往复
- 5.释放资源，停止采集工作

流程如下：



![img](https://upload-images.jianshu.io/upload_images/9897120-a90156d90ad4b446.jpg?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

视频采集流程图

### 四.V4L2编程例子

我这里是使用vmware+ubuntu14.04的环境，笔记本自带一个前置摄像头。
首先先保证你的摄像头可以在虚拟机下使用。
1.windows + r运行services.msc命令，打开服务列表，找到如下所示服务，手动开启



![img](https://upload-images.jianshu.io/upload_images/9897120-776a0d111262e4df.png?imageMogr2/auto-orient/strip|imageView2/2/w/578/format/webp)

image.png

2.开启虚拟机，在 虚拟机->可移动设备 可以看到你的usb摄像头，在虚拟机设置里，usb控制器一栏注意兼容性，可能要设置成兼容3.0，不然有问题。

3.ubuntu下使用cheese命令，查看你的摄像头有没有问题



![img](https://upload-images.jianshu.io/upload_images/9897120-c4e72c8f0f3cbb38.png?imageMogr2/auto-orient/strip|imageView2/2/w/605/format/webp)

image.png

前期工作完成，下面是源码+Makefile

```cpp
/*v4l2_example.c*/
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <sys/ioctl.h>
#include <errno.h>
#include <linux/videodev2.h>
#include <sys/mman.h>
#include <sys/time.h>



#define TRUE            (1)
#define FALSE           (0)

#define FILE_VIDEO      "/dev/video0"
#define IMAGE           "./img/demo"

#define IMAGEWIDTH      640
#define IMAGEHEIGHT     480

#define FRAME_NUM       4

int fd;
struct v4l2_buffer buf;

struct buffer
{
    void * start;
    unsigned int length;
    long long int timestamp;
} *buffers;


int v4l2_init()
{
    struct v4l2_capability cap;
    struct v4l2_fmtdesc fmtdesc;
    struct v4l2_format fmt;
    struct v4l2_streamparm stream_para;

    //打开摄像头设备
    if ((fd = open(FILE_VIDEO, O_RDWR)) == -1) 
    {
        printf("Error opening V4L interface\n");
        return FALSE;
    }

    //查询设备属性
    if (ioctl(fd, VIDIOC_QUERYCAP, &cap) == -1) 
    {
        printf("Error opening device %s: unable to query device.\n",FILE_VIDEO);
        return FALSE;
    }
    else
    {
        printf("driver:\t\t%s\n",cap.driver);
        printf("card:\t\t%s\n",cap.card);
        printf("bus_info:\t%s\n",cap.bus_info);
        printf("version:\t%d\n",cap.version);
        printf("capabilities:\t%x\n",cap.capabilities);
        
        if ((cap.capabilities & V4L2_CAP_VIDEO_CAPTURE) == V4L2_CAP_VIDEO_CAPTURE) 
        {
            printf("Device %s: supports capture.\n",FILE_VIDEO);
        }

        if ((cap.capabilities & V4L2_CAP_STREAMING) == V4L2_CAP_STREAMING) 
        {
            printf("Device %s: supports streaming.\n",FILE_VIDEO);
        }
    }


    //显示所有支持帧格式
    fmtdesc.index=0;
    fmtdesc.type=V4L2_BUF_TYPE_VIDEO_CAPTURE;
    printf("Support format:\n");
    while(ioctl(fd,VIDIOC_ENUM_FMT,&fmtdesc)!=-1)
    {
        printf("\t%d.%s\n",fmtdesc.index+1,fmtdesc.description);
        fmtdesc.index++;
    }

    //检查是否支持某帧格式
    struct v4l2_format fmt_test;
    fmt_test.type=V4L2_BUF_TYPE_VIDEO_CAPTURE;
    fmt_test.fmt.pix.pixelformat=V4L2_PIX_FMT_RGB32;
    if(ioctl(fd,VIDIOC_TRY_FMT,&fmt_test)==-1)
    {
        printf("not support format RGB32!\n");      
    }
    else
    {
        printf("support format RGB32\n");
    }


    //查看及设置当前格式
    printf("set fmt...\n");
    fmt.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
    fmt.fmt.pix.pixelformat = V4L2_PIX_FMT_RGB32; //jpg格式
    //fmt.fmt.pix.pixelformat = V4L2_PIX_FMT_YUYV;//yuv格式

    fmt.fmt.pix.height = IMAGEHEIGHT;
    fmt.fmt.pix.width = IMAGEWIDTH;
    fmt.fmt.pix.field = V4L2_FIELD_INTERLACED;
    printf("fmt.type:\t\t%d\n",fmt.type);
    printf("pix.pixelformat:\t%c%c%c%c\n",fmt.fmt.pix.pixelformat & 0xFF, (fmt.fmt.pix.pixelformat >> 8) & 0xFF,(fmt.fmt.pix.pixelformat >> 16) & 0xFF, (fmt.fmt.pix.pixelformat >> 24) & 0xFF);
    printf("pix.height:\t\t%d\n",fmt.fmt.pix.height);
    printf("pix.width:\t\t%d\n",fmt.fmt.pix.width);
    printf("pix.field:\t\t%d\n",fmt.fmt.pix.field);
    if(ioctl(fd, VIDIOC_S_FMT, &fmt) == -1)
    {
        printf("Unable to set format\n");
        return FALSE;
    }

    printf("get fmt...\n"); 
    if(ioctl(fd, VIDIOC_G_FMT, &fmt) == -1)
    {
        printf("Unable to get format\n");
        return FALSE;
    }
    {
        printf("fmt.type:\t\t%d\n",fmt.type);
        printf("pix.pixelformat:\t%c%c%c%c\n",fmt.fmt.pix.pixelformat & 0xFF, (fmt.fmt.pix.pixelformat >> 8) & 0xFF,(fmt.fmt.pix.pixelformat >> 16) & 0xFF, (fmt.fmt.pix.pixelformat >> 24) & 0xFF);
        printf("pix.height:\t\t%d\n",fmt.fmt.pix.height);
        printf("pix.width:\t\t%d\n",fmt.fmt.pix.width);
        printf("pix.field:\t\t%d\n",fmt.fmt.pix.field);
    }

    //设置及查看帧速率，这里只能是30帧，就是1秒采集30张图
    memset(&stream_para, 0, sizeof(struct v4l2_streamparm));
    stream_para.type = V4L2_BUF_TYPE_VIDEO_CAPTURE; 
    stream_para.parm.capture.timeperframe.denominator = 30;
    stream_para.parm.capture.timeperframe.numerator = 1;

    if(ioctl(fd, VIDIOC_S_PARM, &stream_para) == -1)
    {
        printf("Unable to set frame rate\n");
        return FALSE;
    }
    if(ioctl(fd, VIDIOC_G_PARM, &stream_para) == -1)
    {
        printf("Unable to get frame rate\n");
        return FALSE;       
    }
    {
        printf("numerator:%d\ndenominator:%d\n",stream_para.parm.capture.timeperframe.numerator,stream_para.parm.capture.timeperframe.denominator);
    }
    return TRUE;
}



int v4l2_mem_ops()
{
    unsigned int n_buffers;
    struct v4l2_requestbuffers req;
    
    //申请帧缓冲
    req.count=FRAME_NUM;
    req.type=V4L2_BUF_TYPE_VIDEO_CAPTURE;
    req.memory=V4L2_MEMORY_MMAP;
    if(ioctl(fd,VIDIOC_REQBUFS,&req)==-1)
    {
        printf("request for buffers error\n");
        return FALSE;
    }

    // 申请用户空间的地址列
    buffers = malloc(req.count*sizeof (*buffers));
    if (!buffers) 
    {
        printf ("out of memory!\n");
        return FALSE;
    }
    
    // 进行内存映射
    for (n_buffers = 0; n_buffers < FRAME_NUM; n_buffers++) 
    {
        buf.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
        buf.memory = V4L2_MEMORY_MMAP;
        buf.index = n_buffers;
        //查询
        if (ioctl (fd, VIDIOC_QUERYBUF, &buf) == -1)
        {
            printf("query buffer error\n");
            return FALSE;
        }

        //映射
        buffers[n_buffers].length = buf.length;
        buffers[n_buffers].start = mmap(NULL,buf.length,PROT_READ|PROT_WRITE, MAP_SHARED, fd, buf.m.offset);
        if (buffers[n_buffers].start == MAP_FAILED)
        {
            printf("buffer map error\n");
            return FALSE;
        }
    }
    return TRUE;    
}



int v4l2_frame_process()
{
    unsigned int n_buffers;
    enum v4l2_buf_type type;
    char file_name[100];
    char index_str[10];
    long long int extra_time = 0;
    long long int cur_time = 0;
    long long int last_time = 0;

    //入队和开启采集
    for (n_buffers = 0; n_buffers < FRAME_NUM; n_buffers++)
    {
        buf.index = n_buffers;
        ioctl(fd, VIDIOC_QBUF, &buf);
    }
    type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
    ioctl(fd, VIDIOC_STREAMON, &type);
    


    //出队，处理，写入yuv文件，入队，循环进行
    int loop = 0;
    while(loop < 15)
    {
        for(n_buffers = 0; n_buffers < FRAME_NUM; n_buffers++)
        {
            //出队
            buf.index = n_buffers;
            ioctl(fd, VIDIOC_DQBUF, &buf);

            //查看采集数据的时间戳之差，单位为微妙
            buffers[n_buffers].timestamp = buf.timestamp.tv_sec*1000000+buf.timestamp.tv_usec;
            cur_time = buffers[n_buffers].timestamp;
            extra_time = cur_time - last_time;
            last_time = cur_time;
            printf("time_deta:%lld\n\n",extra_time);
            printf("buf_len:%d\n",buffers[n_buffers].length);

            //处理数据只是简单写入文件，名字以loop的次数和帧缓冲数目有关
            printf("grab image data OK\n");
            memset(file_name,0,sizeof(file_name));
            memset(index_str,0,sizeof(index_str));
            sprintf(index_str,"%d",loop*4+n_buffers);
            strcpy(file_name,IMAGE);
            strcat(file_name,index_str);
            strcat(file_name,".jpg");
            //strcat(file_name,".yuv");
            FILE *fp2 = fopen(file_name, "wb");
            if(!fp2)
            {
                printf("open %s error\n",file_name);
                return(FALSE);
            }
            fwrite(buffers[n_buffers].start, IMAGEHEIGHT*IMAGEWIDTH*2,1,fp2);
            fclose(fp2);
            printf("save %s OK\n",file_name);

            //入队循环
            ioctl(fd, VIDIOC_QBUF, &buf);       
        }

        loop++;
    }
    return TRUE;    
}




int v4l2_release()
{
    unsigned int n_buffers;
    enum v4l2_buf_type type;

    //关闭流
    type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
    ioctl(fd, VIDIOC_STREAMON, &type);
    
    //关闭内存映射
    for(n_buffers=0;n_buffers<FRAME_NUM;n_buffers++)
    {
        munmap(buffers[n_buffers].start,buffers[n_buffers].length);
    }
    
    //释放自己申请的内存
    free(buffers);
    
    //关闭设备
    close(fd);
    return TRUE;
}




/*int v4l2_video_input_output()
{
    struct v4l2_input input;
    struct v4l2_standard standard;

    //首先获得当前输入的index,注意只是index，要获得具体的信息，就的调用列举操作
    memset (&input,0,sizeof(input));
    if (-1 == ioctl (fd, VIDIOC_G_INPUT, &input.index)) {
        printf("VIDIOC_G_INPUT\n");
        return FALSE;
    }
    //调用列举操作，获得 input.index 对应的输入的具体信息
    if (-1 == ioctl (fd, VIDIOC_ENUMINPUT, &input)) {
        printf("VIDIOC_ENUM_INPUT \n");
        return FALSE;
    }
    printf("Current input %s supports:\n", input.name);


    //列举所有的所支持的 standard，如果 standard.id 与当前 input 的 input.std 有共同的
    //bit flag，意味着当前的输入支持这个 standard,这样将所有驱动所支持的 standard 列举一个
    //遍，就可以找到该输入所支持的所有 standard 了。

    memset(&standard,0,sizeof (standard));
    standard.index = 0;
    while(0 == ioctl(fd, VIDIOC_ENUMSTD, &standard)) {
        if (standard.id & input.std){
            printf ("%s\n", standard.name);
        }
        standard.index++;
    }
    // EINVAL indicates the end of the enumeration, which cannot be empty unless this device falls under the USB exception. 

    if (errno != EINVAL || standard.index == 0) {
        printf("VIDIOC_ENUMSTD\n");
        return FALSE;
    }

}*/






int main(int argc, char const *argv[])
{
    printf("begin....\n");
    sleep(10);

    v4l2_init();
    printf("init....\n");
    sleep(10);

    v4l2_mem_ops();
    printf("malloc....\n");
    sleep(10);

    v4l2_frame_process();
    printf("process....\n");
    sleep(10);

    v4l2_release();
    printf("release\n");
    sleep(20);
    
    return TRUE;
}
#Makefile
CC      = gcc
CFLAGS  = -g -Wall -O2
TARGET  = v4l2_example.bin
SRCS    = v4l2_example.c
C_OBJS  = v4l2_example.o

all:$(TARGET)

$(TARGET):$(C_OBJS)
    $(CC) $(CFLAGS) -o $@ $^
%.o:%.c
    $(CC) $(CFLAGS) -c -o $@ $<
.PHONY:clean
clean:
    rm -rf *.o $(TARGET) $(CXX_OBJS) $(C_OBJS)
    rm ./img/*
```

v4l2_example.c，Makefile所在目录新建img目录用于存放图像文件，可以编译运行，如下：

```kotlin
begin....
driver:     uvcvideo
card:       HP Wide Vision HD Camera
bus_info:   usb-0000:03:00.0-2
version:    201480
capabilities:   84200001
Device /dev/video0: supports capture.
Device /dev/video0: supports streaming.
Support format:
    1.MJPEG
    2.YUV 4:2:2 (YUYV)
support format RGB32
set fmt...
fmt.type:       1
pix.pixelformat:    RGB4
pix.height:     480
pix.width:      640
pix.field:      4
get fmt...
fmt.type:       1
pix.pixelformat:    MJPG
pix.height:     480
pix.width:      640
pix.field:      1
numerator:1
denominator:30
init....
malloc....
time_deta:17741459080

buf_len:614400
grab image data OK
save ./img/demo0.jpg OK
time_deta:33239

buf_len:614400
grab image data OK
save ./img/demo1.jpg OK
time_deta:33466

buf_len:614400
grab image data OK
save ./img/demo2.jpg OK
time_deta:33139

buf_len:614400
grab image data OK
save ./img/demo3.jpg OK
time_deta:33239

buf_len:614400
grab image data OK
save ./img/demo4.jpg OK
time_deta:33382

buf_len:614400
grab image data OK
save ./img/demo5.jpg OK
time_deta:33044

buf_len:614400
grab image data OK
save ./img/demo6.jpg OK
time_deta:33225

buf_len:614400
grab image data OK
save ./img/demo7.jpg OK
time_deta:33369

buf_len:614400
grab image data OK
save ./img/demo8.jpg OK
time_deta:33091

buf_len:614400
grab image data OK
save ./img/demo9.jpg OK
time_deta:32418

buf_len:614400
grab image data OK
save ./img/demo10.jpg OK
time_deta:34051

buf_len:614400
grab image data OK
save ./img/demo11.jpg OK
time_deta:33189

buf_len:614400
grab image data OK
save ./img/demo12.jpg OK
time_deta:32841

buf_len:614400
grab image data OK
save ./img/demo13.jpg OK
time_deta:33599

buf_len:614400
grab image data OK
save ./img/demo14.jpg OK
time_deta:32628

buf_len:614400
grab image data OK
save ./img/demo15.jpg OK
time_deta:33783

buf_len:614400
grab image data OK
save ./img/demo16.jpg OK
time_deta:32628

buf_len:614400
grab image data OK
save ./img/demo17.jpg OK
time_deta:33105

buf_len:614400
grab image data OK
save ./img/demo18.jpg OK
time_deta:34140

buf_len:614400
grab image data OK
save ./img/demo19.jpg OK
time_deta:33219

buf_len:614400
grab image data OK
save ./img/demo20.jpg OK
time_deta:33334

buf_len:614400
grab image data OK
save ./img/demo21.jpg OK
time_deta:33245

buf_len:614400
grab image data OK
save ./img/demo22.jpg OK
time_deta:33276

buf_len:614400
grab image data OK
save ./img/demo23.jpg OK
time_deta:33133

buf_len:614400
grab image data OK
save ./img/demo24.jpg OK
time_deta:32533

buf_len:614400
grab image data OK
save ./img/demo25.jpg OK
time_deta:34036

buf_len:614400
grab image data OK
save ./img/demo26.jpg OK
time_deta:33093

buf_len:614400
grab image data OK
save ./img/demo27.jpg OK
time_deta:33374

buf_len:614400
grab image data OK
save ./img/demo28.jpg OK
time_deta:33432

buf_len:614400
grab image data OK
save ./img/demo29.jpg OK
time_deta:32969

buf_len:614400
grab image data OK
save ./img/demo30.jpg OK
time_deta:32412

buf_len:614400
grab image data OK
save ./img/demo31.jpg OK
time_deta:34113

buf_len:614400
grab image data OK
save ./img/demo32.jpg OK
time_deta:33193

buf_len:614400
grab image data OK
save ./img/demo33.jpg OK
time_deta:33654

buf_len:614400
grab image data OK
save ./img/demo34.jpg OK
time_deta:33330

buf_len:614400
grab image data OK
save ./img/demo35.jpg OK
time_deta:32732

buf_len:614400
grab image data OK
save ./img/demo36.jpg OK
time_deta:33140

buf_len:614400
grab image data OK
save ./img/demo37.jpg OK
time_deta:33969

buf_len:614400
grab image data OK
save ./img/demo38.jpg OK
time_deta:33044

buf_len:614400
grab image data OK
save ./img/demo39.jpg OK
time_deta:32326

buf_len:614400
grab image data OK
save ./img/demo40.jpg OK
time_deta:333137

buf_len:614400
grab image data OK
save ./img/demo41.jpg OK
time_deta:31840

buf_len:614400
grab image data OK
save ./img/demo42.jpg OK
time_deta:33712

buf_len:614400
grab image data OK
save ./img/demo43.jpg OK
time_deta:32597

buf_len:614400
grab image data OK
save ./img/demo44.jpg OK
time_deta:67859

buf_len:614400
grab image data OK
save ./img/demo45.jpg OK
time_deta:33813

buf_len:614400
grab image data OK
save ./img/demo46.jpg OK
time_deta:33024

buf_len:614400
grab image data OK
save ./img/demo47.jpg OK
time_deta:33146

buf_len:614400
grab image data OK
save ./img/demo48.jpg OK
time_deta:33227

buf_len:614400
grab image data OK
save ./img/demo49.jpg OK
time_deta:33007

buf_len:614400
grab image data OK
save ./img/demo50.jpg OK
time_deta:33680

buf_len:614400
grab image data OK
save ./img/demo51.jpg OK
time_deta:32909

buf_len:614400
grab image data OK
save ./img/demo52.jpg OK
time_deta:32553

buf_len:614400
grab image data OK
save ./img/demo53.jpg OK
time_deta:33578

buf_len:614400
grab image data OK
save ./img/demo54.jpg OK
time_deta:33308

buf_len:614400
grab image data OK
save ./img/demo55.jpg OK
time_deta:33421

buf_len:614400
grab image data OK
save ./img/demo56.jpg OK
time_deta:32596

buf_len:614400
grab image data OK
save ./img/demo57.jpg OK
time_deta:33463

buf_len:614400
grab image data OK
save ./img/demo58.jpg OK
time_deta:33100

buf_len:614400
grab image data OK
save ./img/demo59.jpg OK
process....
release
```

相关的说明注释已经很明显了，关于被注释的函数`int v4l2_video_input_output()`目前有些问题，你也可以研究一下，其他应该没问题。

通过结果，可以看出，图片大小640*480，格式是MJPG，帧率为30，采集了60张图片，每次缓冲区的时间戳之差为33463us左右，1s/33463us = 29.88，约为30。主函数中设置一些sleep 为了在运行中新开终端去测试此程序所占内存，结果为
begin ->4204Kbyte
init->4204Kbyte
malloc ->6736Kbyte
process->6736Kbyte
release->4336Kbyte
申请的一个缓冲区为614400byte,4个一共是2457.6Kbyte,而6736-4204=2532，还要考虑程序自己申请的堆空间及一些其他情况，可以接受
这边是使用ps -aux | grep 程序名，进行分析的，可能会有更好的工具，更细致的分析，希望你可以评论。

另外你可以把格式改成yuv的，需要专门yuv的查看器，去看采集的图片
，然后还可以把文件打开的方式改成追加方式，把数据写成一个yuv文件，可以进行图像帧的播放，感觉就像是动画。