# MIME （多用途互联网邮件扩展类型）


MIME(Multipurpose Internet Mail Extensions)多用途互联网邮件扩展类型。是设定某种扩展名的文件用一种应用程序来打开的方式类型，当该扩展名文件被访问的时候，浏览器会自动使用指定应用程序来打开。多用于指定一些客户端自定义的文件名，以及一些媒体文件打开方式。
它是一个互联网标准，扩展了电子邮件标准，使其能够支持：
非ASCII字符文本；非文本格式附件（二进制、声音、图像等）；由多部分（multiple parts）组成的消息体；包含非ASCII字符的头信息（Header information）。
这个标准被定义在RFC 2045、RFC 2046、RFC 2047、RFC 2048、RFC 2049等RFC中。 MIME改善了由RFC 822转变而来的RFC 2822，这些旧标准规定电子邮件标准并不允许在邮件消息中使用7位ASCII字符集以外的字符。正因如此，一些非英语字符消息和二进制文件，图像，声音等非文字消息原本都不能在电子邮件中传输(MIME可以)。MIME规定了用于表示各种各样的数据类型的符号化方法。 此外，在万维网中使用的HTTP协议中也使用了MIME的框架，标准被扩展为互联网媒体类型。


最早的HTTP协议中，并没有附加的数据类型信息，所有传送的数据都被客户程序解释为超文本标记语言HTML 文档，而为了支持多媒体数据类型，HTTP协议中就使用了附加在文档之前的MIME数据类型信息来标识数据类型。
MIME意为多功能Internet邮件扩展，它设计的最初目的是为了在发送电子邮件时附加多媒体数据，让邮件客户程序能根据其类型进行处理。然而当它被HTTP协议支持之后，它的意义就更为显著了。它使得HTTP传输的不仅是普通的文本，而变得丰富多彩。
每个MIME类型由两部分组成，前面是数据的大类别，例如声音audio、图象image等，后面定义具体的种类。

七种大类别：
- video
- image
- application
- text
- audio
- multipart
- message

常见的MIME类型(通用型)：
- 超文本标记语言文本 .html text/html
- xml文档 .xml text/xml
- XHTML文档 .xhtml application/xhtml+xml
- 普通文本 .txt text/plain
- RTF文本 .rtf application/rtf
- PDF文档 .pdf application/pdf
- Microsoft Word文件 .word application/msword
- PNG图像 .png image/png
- GIF图形 .gif image/gif
- JPEG图形 .jpeg,.jpg image/jpeg
- au声音文件 .au audio/basic
- MIDI音乐文件 mid,.midi audio/midi,audio/x-midi
- RealAudio音乐文件 .ra, .ram audio/x-pn-realaudio
- MPEG文件 .mpg,.mpeg video/mpeg
- AVI文件 .avi video/x-msvideo
- GZIP文件 .gz application/x-gzip
- TAR文件 .tar application/x-tar
- 任意的二进制数据 application/octet-stream