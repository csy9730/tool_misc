# 利用pdfjs在线预览、打印pdf

![img](https://upload.jianshu.io/users/upload_avatars/17702771/5e68a422-6a29-4e56-82c6-fb0e3d301bed.png?imageMogr2/auto-orient/strip|imageView2/1/w/96/h/96/format/webp)

[中书大令](https://www.jianshu.com/u/2f52fc051a26)关注

2021.04.04 08:50:39字数 502阅读 2,695

## 目录

##### 环境准备

1.在官网下载pdf.js
2.下载源码包
3.构建pdf.js代码
4.pdf.js代码结构图
5.pdf.js放入web容器
6.通过浏览器访问

##### 实际使用

1.打开指定pdf
2.打开指定pdf文件流

# 环境准备

### 1.在官网下载pdf.js

```cpp
  我们可以通过官网直接下载pdf.js
   http://mozilla.github.io/pdf.js/
```



![img](https://upload-images.jianshu.io/upload_images/17702771-1e2fe7870f7a6134.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

官网

### 2.下载源码包

```ruby
  如果选择了步骤一，可以直接看步骤4
  pdf.js 源码包下载地址
  [https://github.com/mozilla/pdf.js/](https://github.com/mozilla/pdf.js/)
  ![git地址](https://upload-images.jianshu.io/upload_images/17702771-43664f936e42189b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
```

*打开链接，如图这里可以获取到源码、和这个工具库的使用方式，当然如果你有好的想法也可以在这里分享出来。*

### 3.构建pdf.js代码

```ruby
 首先安装node.js，再安装gulp软件包
  $ npm install -g gulp-cli


使用以下命令构建js
$ gulp generic


如果需要支持旧的浏览器，使用以下命令
$ gulp generic-legacy
```

### 4.pdf.js代码结构图



![img](https://upload-images.jianshu.io/upload_images/17702771-394ef0ad54a19fe0.png?imageMogr2/auto-orient/strip|imageView2/2/w/968/format/webp)

代码结构

**web/viewer.html 主要渲染pdf阅读器的样式，web/viewer.js 读取我们需要打开的pdf文件例如以下viewer.js中的代码可以看出，我们通过访问viewer.html传入file参数指定我们需要打开的pdf文件，没有传入时默认打开的compressed.tracemonkey-pldi-09.pdf文件。使用file参数时需要使用encodeURIComponent(文件路径)，将文件路径编码，viewer.js会为我们解码。**

```csharp
... 代码块 ...
var DEFAULT_URL = 'compressed.tracemonkey-pldi-09.pdf';
... 代码块 ...
function webViewerInitialized() {
  var queryString = document.location.search.substring(1);
  var params = PDFViewerApplication.parseQueryString(queryString);
  var file = 'file' in params ? params.file : DEFAULT_URL;
  ... 代码块 ...
```

### 5.pdf.js放入web容器

这里使用tomcat，如果你有更好的选择，可以忽略



![img](https://upload-images.jianshu.io/upload_images/17702771-fbe20c7a037f0eda.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

地址

### 6.通过浏览器访问

这里使用tomcat 访问 pdf.js的默认页面
[http://localhost:8080/pdfjs/web/viewer.html](https://links.jianshu.com/go?to=http%3A%2F%2Flocalhost%3A8080%2Fviewer.html)



![img](https://upload-images.jianshu.io/upload_images/17702771-2123eefd7b68936e.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

访问效果



# 实际使用

### 1.打开指定pdf

创建一个中建页面，使用iframe访问viewer.html地址并且传入file参数指定文件路径
file里传入的是[http://localhost:8080/filepath/demo.pdf](https://links.jianshu.com/go?to=http%3A%2F%2Flocalhost%3A8080%2Ffilepath%2Fdemo.pdf)编码后的值
*前端代码*

```xml
<!DOCTYPE html>  
<html>  
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>  
<title>在线预览PDF文档</title>  
<script type="text/javascript" src="/resource/js/jquery.js"></script>  
<script type="text/javascript">
$(function(){
  $("#displayPdfIframe").attr("src",'../pdfjs/web/viewer.html?file=' + encodeURIComponent('/resource/file/demo.pdf'));
});
</script>
</head>
<body>
<div class="ctrlDiv">
  <div class="eleContainer elePaddingBtm">
      <iframe id="displayPdfIframe" style="width:100%;min-height: 1000px;"></iframe>
  </div>
</div>
</body>
</html>
```

*效果图*



![img](https://upload-images.jianshu.io/upload_images/17702771-b2accc75f3016b37.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

效果图



### 2.打开指定pdf文件流

创建一个中建页面，使用iframe访问viewer.html地址并且传入file参数指定文件路径
file里传入的是[http://localhost:8080/dataRest/getFileData?fileId=](https://links.jianshu.com/go?to=http%3A%2F%2Flocalhost%3A8080%2FdataRest%2FgetFileData%3FfileId%3D)文件id编码后的值
*前端页面代码*

```xml
<!DOCTYPE html>  
<html>  
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>  
<title>在线预览PDF文档</title>  
<script type="text/javascript" src="/resource/js/jquery.js"></script>  
<script type="text/javascript">
$(function(){
  $("#displayPdfIframe").attr("src",'../pdfjs/web/viewer.html?file=' + encodeURIComponent('http://localhost:8080/dataRest/getFileData?fileId=文件id'));
});
</script>
</head>
<body>
<div class="ctrlDiv">
  <div class="eleContainer elePaddingBtm">
      <iframe id="displayPdfIframe" style="width:100%;min-height: 1000px;"></iframe>
  </div>
</div>
</body>
</html>
```

*后台代码*

```csharp
String fdId = request.getParameter("fdId");

InputStream in = null;
String open = null;
OutputStream out = response.getOutputStream();
try {

String fileFullPath = "根据id获取文件路径";

//根据路径获取文件流
File convertFile = new File(fileFullPath);
if (convertFile.exists()) {
response.reset();
response.setContentType("application/x-download");
response.setHeader("Content-Disposition", "attachment;filename=\"" + filename + "\"");

in = new FileInputStream(convertFile);
response.setContentLength(in.available());
in = new DecryptionInputStream(in);

try {
    int _bufSize = 1024;
    byte[] buffer = new byte[_bufSize];
    int len;
    while ((len = in.read(buffer)) != -1) {
        out.write(buffer, 0, len);
    }
} finally {
    if(in!=null){
        in.close();
    }
    if(out!=null){
        out.flush();
        out.close();
    }
}
return null;
}


} catch (Exception e) {
try {
if (in != null) {
    in.close();
    in = null;
}
if (out != null) {
    out.close();
    out = null;
}
} catch (Exception e1) {
logger.debug("流关闭错误，错误信息", e1);
}
} finally {
try {
if (in != null) {
    in.close();
    in = null;
}
if (out != null) {
    out.close();
    out = null;
}
} catch (Exception e1) {
logger.debug("流关闭错误，错误信息", e1);
}
}
```

*访问效果如图*



![img](https://upload-images.jianshu.io/upload_images/17702771-6c2ca572b7c822c2.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

效果图



0人点赞

日记本