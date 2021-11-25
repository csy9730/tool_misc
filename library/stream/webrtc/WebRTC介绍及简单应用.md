[WebRTC介绍及简单应用 ](https://www.cnblogs.com/SingleCat/p/11315349.html)

转自：https://www.cnblogs.com/vipzhou/p/7994927.html

# WebRTC介绍及简单应用

------

**WebRTC**，即**Web Real-Time Communication**，web实时通信技术。简单地说就是在web浏览器里面引入实时通信，包括音视频通话等。

> - WebRTC实时通信技术介绍
> - 如何使用
> - 媒体介绍
> - 信令
> - STUN和TURN介绍
> - 对等连接和提议/应答协商
> - 数据通道
> - NAT和防火墙穿透
> - 简单应用
> - 其它

------

## WebRTC实时通信技术介绍

WebRTC实现了基于网页的语音对话或视频通话，目的是无插件实现web端的实时通信的能力。

WebRTC提供了视频会议的核心技术，包括音视频的采集、编解码、网络传输、展示等功能，并且还支持跨平台，包括linux、windows、mac、android等。

### 1. WebRTC三角形

![image](https://upload-images.jianshu.io/upload_images/62302-955e9f0c12c1f907.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 2. WebRTC梯形

![image](https://upload-images.jianshu.io/upload_images/62302-2102650167dfc9b5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 3. WebRTC的多方会话

WebRTC支持多个浏览器参与的多方会话或会议会话，要建立这类会话有如下两种模式：

![image](https://upload-images.jianshu.io/upload_images/62302-d7447a919e85b580.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![image](https://upload-images.jianshu.io/upload_images/62302-354bdfb8128a2ad1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 4. WebRTC新功能特性

![image](https://upload-images.jianshu.io/upload_images/62302-21804ac9ab6ca021.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

------

## 如何使用WebRTC

WebRTC易于使用，只需极少步骤便可建立媒体会话。有些消息在浏览器和服务器之间流动，有些则直接在两个浏览器（成为对等端）之间流动。

### 1、建立WebRTC会话

建立WebRTC连接需要如下几个步骤：

> - 获取本地媒体（`getUserMedia()`，*MediaStream API*）
> - 在浏览器和对等端（其它浏览器或终端）之间建立对等连接（*RTCPeerConnection API*）
> - 将媒体和数据通道关联至该连接
> - 交换会话描述（*RTCSessionDescription*）

![image](https://upload-images.jianshu.io/upload_images/62302-d71ee80e3193c9d7.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

> - 浏览器M从Web服务器请求网页
> - Web服务器向M返回带有WebRTC js的网页
> - 浏览器L从Web服务器请求网页
> - Web服务器向L返回带有WebRTC js的网页
> - M决定与L通信，通过M自身的js将M的会话描述对象（offer，提议）发送至Web服务器
> - Web服务器将M的会话描述对象发送至L上的js
> - L上的js将L的会话描述对象（answer，应答）发送至Web服务器
> - Web服务器转发应答至M上的js
> - M和L开始交互，确定访问对方的最佳方式
> - 完成后，M和L开始协商通信密钥
> - M和L开始交换语音、视频或数据

WebRTC三角形会话具体的调用流程：

![image](https://upload-images.jianshu.io/upload_images/62302-a7ba108759459bcb.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

```
说明：
    SDP对象的传输可能是一个来回反复的过程，并且该过程采用的协议并未标准化
```

WebRTC梯形会话方式具体的调用流程：

![image](https://upload-images.jianshu.io/upload_images/62302-e2f3794e43793917.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

```
说明：
    此场景中，浏览器M和L直接交换媒体，只是它们运行的Web服务器不用而已。每个浏览器的会话描述对象都会映射至Jingle[XEP-0166]session-initiate消息和session-accept方法。
    
```

------

## 媒体介绍

先来看下WebRTC中的本地媒体：

### 1、WebRTC中的媒体

> - 轨道（*MediaStreamTrack*，代表设备或录制内容可返回的单一类型的媒体，唯一关联一个“源”，WebRTC不能直接访问或控制“源”，对“源”的一切控制都通过轨道实施；一个“源”可能对应多个轨道对象）
> - 流（*MediaStream*，轨道对象的集合）

轨道和流的示意如下：

![image](https://upload-images.jianshu.io/upload_images/62302-26e01489f5de238e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 2、捕获本地媒体

如下代码展示了本地媒体的简单获取，并展示：

```
// 注意getUserMedia()在各浏览器中的区别  
// Opera --> getUserMedia  
// Chrome --> webkitGetUserMedia  
// Firefox --> mozGetUserMedia  
navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia;  
  
// 只获取video:  
var constraints = {audio: false, video: true};  
var video = document.querySelector("video");  
  
function successCallback(stream) {  
    // Note: make the returned stream available to console for inspection  
    window.stream = stream;  
      
if (window.URL) {  
        // Chrome浏览器
        video.srcObject = stream;  
    } else {  
        // Firefox和Opera: 可以直接把视频源设置为stream  
        video.src = stream;  
    }  
    // 播放  
    video.play();  
}  
  
function errorCallback(error){  
    console.log("navigator.getUserMedia error: ", error);  
}  
  
navigator.getUserMedia(constraints, successCallback, errorCallback);
```

运行效果如下：

![image](https://upload-images.jianshu.io/upload_images/62302-87db0c197efb6eb0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

完整代码查看：<https://github.com/caiya/webrtc-demo.git>



分类: [视频播放相关知识](https://www.cnblogs.com/SingleCat/category/332324.html)