# [HTTP 304状态码的详细讲解](https://www.cnblogs.com/gxw123/p/13288320.html)



HTTP 304状态码的详细讲解

<https://blog.csdn.net/qq_37960324/article/details/83374855>
304状态码或许不应该认为是一种错误，而是对客户端有缓存情况下服务端的一种响应。
 

整个请求响应过程如下：


客户端在请求一个文件的时候，发现自己缓存的文件有 Last Modified ，那么在请求中会包含 If Modified Since ，这个时间就是缓存文件的 Last Modified 。因此，如果请求中包含 If Modified Since，就说明已经有缓存在客户端。服务端只要判断这个时间和当前请求的文件的修改时间就可以确定是返回 304 还是 200 。
对于静态文件，例如：CSS、图片，服务器会自动完成 Last Modified 和 If Modified Since 的比较，完成缓存或者更新。但是对于动态页面，就是动态产生的页面，往往没有包含 Last Modified 信息，这样浏览器、网关等都不会做缓存，也就是在每次请求的时候都完成一个 200 的请求。
因此，对于动态页面做缓存加速，首先要在 Response 的 HTTP Header 中增加 Last Modified 定义，其次根据 Request 中的 If Modified Since 和被请求内容的更新时间来返回 200 或者 304 。虽然在返回 304 的时候已经做了一次数据库查询，但是可以避免接下来更多的数据库查询，并且没有返回页面内容而只是一个 HTTP Header，从而大大的降低带宽的消耗，对于用户的感觉也是提高。当这些缓存有效的时候，通过 Fiddler 或HttpWatch 查看一个请求会得到这样的结果：


第一次访问 200
按F5刷新（第二次访问） 304
按Ctrl+F5强制刷新 200

下面用Fiddler来查看上面的访问请求过程

第一次(首次)访问 200

![img](https://img-blog.csdn.net/20181025094658258?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzM3OTYwMzI0/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)


 

第二次F5刷新访问 304

![img](https://img-blog.csdn.net/20181025094658292?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzM3OTYwMzI0/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)


请求的头信息里多了 “If-Modified-Since","If-None-Match" 
 


第三次 按Ctrl+F5强制刷新 200同第一次，不贴图了



 

为什么要使用条件请求当用户访问一个网页时,条件请求可以加速网页的打开时间(因为可以省去传输整个响应体的时间),但仍然会有网络延迟,因为浏览器还是得为每个资源生成一条条件请求,并且等到服务器返回HTTP/304响应,才能读取缓存来显示网页.更理想的情况是,服务器在响应上指定Cache-Control或Expires指令,这样客户端就能知道该资源的可用时间为多长,也就能跳过条件请求的步骤,直接使用缓存中的资源了.可是,即使服务器提供了这些信息,在下列情况下仍然需要使用条件请求:



在超过服务器指定的过期时间之后
如果用户执行了刷新操作的话
在上节给出的图片中,请求头中包含了一个Pragma: no-cache.这是由于用户使用F5刷新了网页.如果用户按下了CTRL-F5 (有时称之为“强刷-hard refresh”),你会发现浏览器省略了If-Modified-Since和If-None-Match请求头,也就是无条件的请求页面中的每个资源.

避免条件请求
通常来说,缓存是个好东西.如果你想提高自己网站的访问速度,缓存是必须要考虑的.可是在调试的时候,有时候需要阻止缓存,这样才能确保你所访问到的资源是最新的.

你也许会有个疑问:“如果不改变网站内容,我怎么才能让Fiddler不返回304而返回一个包含响应体的HTTP/200响应呢?”

你可以在Fiddler中的网络会话(Web Sessions)列表中选择一条响应为HTTP/304的会话,然后按下U键.Fiddler将会无条件重发(Unconditionally reissue)这个请求.然后使用命compare命令对比一下两个请求有什么不同,对比结果如下,从中可以得知,Fiddler是通过省略条件请求头来实现无缓存请求的:

Screenshot of Windiff of conditional and unconditional requests

如果你想全局阻止HTTP/304响应,可以这么做:首先清除浏览器的缓存,可以使用Fiddler工具栏上的Clear Cache按钮(仅能清除Internet Explorer缓存),或者在浏览器上按CTRL+SHIFT+DELETE(所有浏览器都支持).在清除浏览器的缓存之后,回到Fiddler中,在菜单中选择Rules > Performance > Disable Caching选项,然后Fiddler就会:删除所有请求中的条件请求相同的请求头以及所有响应中的缓存时间相关的响应头.此外,还会在每个请求中添加Pragma: no-cache请求头,在每个响应中添加Cache-Control: no-cache响应头,阻止浏览器缓存这些资源.
 

动态网页如何设置304

以aspx页面为例，代码如下：

1. var request = context.Request;
2. ​            var response = context.Response;
3. ​            if (request.Headers["If-Modified-Since"].NotNullOrEmpty() || request.Headers["If-None-Match"].NotNullOrEmpty())
4. ​            {
5. ​                response.StatusCode = 304;
6. ​                return;
7. ​            }
8. *//**非**304**情况下的操作* *略*
9. *//**设置缓存选项*
10. ​            response.Clear();
11. ​            response.ClearContent();
12. ​            response.Headers["Last-Modified"] = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
13. ​            response.Headers["ETag"] = id;*//**这里假设的是根据不同的**id*
14. ​            response.CacheControl = "private";
15. ​            response.ExpiresAbsolute = DateTime.Now.AddMonths(6);

ETag是什么意思？HTTP 协议规格说明定义ETag为“被请求变量的实体值” 。 另一种说法是，ETag是一个可以与Web资源关联的记号（token）。典型的Web资源可以一个Web页，但也可能是JSON或XML文档。服务器单独负责判断记号是什么及其含义，并在HTTP响应头中将其传送到客户端



 

asp.net web api的实现代码如下：

1. *// GET /images/001.png*
2. [HttpGet]
3. public HttpResponseMessage Get(string filename)
4. {
5. ​        HttpResponseMessage response = new HttpResponseMessage(); 
6.  
7. ​        .....
8. ​        string etag = string.Format("\"{0}\"", fileInfo.MD5);
9. ​        var tag = Request.Headers.IfNoneMatch.FirstOrDefault();
10. ​        if (Request.Headers.IfModifiedSince.HasValue && tag != null && tag.Tag == etag)
11. ​        {
12. ​               response.StatusCode = HttpStatusCode.NotModified;
13. ​        }
14. ​        else
15. ​        {
16. ​               *//dealcode ......*
17. ​               responseStream.Position = 0;
18. ​               response.StatusCode = fullContent ? HttpStatusCode.OK : HttpStatusCode.PartialContent;
19. ​               response.Content = new StreamContent(responseStream);
20. ​               response.Content.Headers.ContentType = new MediaTypeHeaderValue(fileInfo.ContentType);
21. ​               response.Headers.ETag = new EntityTagHeaderValue(etag);
22. ​               response.Headers.CacheControl = new CacheControlHeaderValue();
23. ​               response.Headers.CacheControl.Public = true;
24. ​               response.Headers.CacheControl.MaxAge = TimeSpan.FromHours(480);
25. ​               response.Content.Headers.Expires = DateTimeOffset.Now.AddDays(20);
26. ​               response.Content.Headers.LastModified = fileInfo.UploadDate;
27. ​        }
28. ​        return response;
29. }

常见状态码：

一些常见的状态码为：

- 200 – 服务器成功返回网页
- 404 – 请求的网页不存在
- 503 – 服务器超时

下面提供 HTTP 状态码的完整列表。点击链接可了解详情。您也可以访问 [HTTP 状态码上的 W3C 页获取更多信息](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html)。

1xx（临时响应）
表示临时响应并需要请求者继续执行操作的状态码。

| 100（继续）     | 请求者应当继续提出请求。服务器返回此代码表示已收到请求的第一部分，正在等待其余部分。 |
| --------------- | ------------------------------------------------------------ |
| 101（切换协议） | 请求者已要求服务器切换协议，服务器已确认并准备切换。         |

2xx （成功）

表示成功处理了请求的状态码。

| 200（成功）       | 服务器已成功处理了请求。通常，这表示服务器提供了请求的网页。如果是对您的 robots.txt 文件显示此状态码，则表示 Googlebot 已成功检索到该文件。 |
| ----------------- | ------------------------------------------------------------ |
| 201（已创建）     | 请求成功并且服务器创建了新的资源。                           |
| 202（已接受）     | 服务器已接受请求，但尚未处理。                               |
| 203（非授权信息） | 服务器已成功处理了请求，但返回的信息可能来自另一来源。       |
| 204（无内容）     | 服务器成功处理了请求，但没有返回任何内容。                   |
| 205（重置内容）   | 服务器成功处理了请求，但没有返回任何内容。与 204 响应不同，此响应要求请求者重置文档视图（例如，清除表单内容以输入新内容）。 |
| 206（部分内容）   | 服务器成功处理了部分 GET 请求。                              |

3xx （重定向）
要完成请求，需要进一步操作。通常，这些状态码用来重定向。Google 建议您在每次请求中使用重定向不要超过 5 次。您可以使用网站管理员工具查看一下 Googlebot 在抓取重定向网页时是否遇到问题。诊断下的[网络抓取](http://www.google.cn/support/webmasters/bin/answer.py?answer=35156)页列出了由于重定向错误导致 Googlebot 无法抓取的网址。

| 300（多种选择）     | 针对请求，服务器可执行多种操作。服务器可根据请求者 (user agent) 选择一项操作，或提供操作列表供请求者选择。 |
| ------------------- | ------------------------------------------------------------ |
| 301（永久移动）     | 请求的网页已永久移动到新位置。服务器返回此响应（对 GET 或 HEAD 请求的响应）时，会自动将请求者转到新位置。您应使用此代码告诉 Googlebot 某个网页或网站已永久移动到新位置。 |
| 302（临时移动）     | 服务器目前从不同位置的网页响应请求，但请求者应继续使用原有位置来响应以后的请求。此代码与响应 GET 和 HEAD 请求的 301 代码类似，会自动将请求者转到不同的位置，但您不应使用此代码来告诉 Googlebot 某个网页或网站已经移动，因为 Googlebot 会继续抓取原有位置并编制索引。 |
| 303（查看其他位置） | 请求者应当对不同的位置使用单独的 GET 请求来检索响应时，服务器返回此代码。对于除 HEAD 之外的所有请求，服务器会自动转到其他位置。 |
| 304（未修改）       | 自从上次请求后，请求的网页未修改过。服务器返回此响应时，不会返回网页内容。如果网页自请求者上次请求后再也没有更改过，您应将服务器配置为返回此响应（称为 If-Modified-Since HTTP 标头）。服务器可以告诉 Googlebot 自从上次抓取后网页没有变更，进而节省带宽和开销。 |
| 305（使用代理）     | 请求者只能使用代理访问请求的网页。如果服务器返回此响应，还表示请求者应使用代理。 |
| 307（临时重定向）   | 服务器目前从不同位置的网页响应请求，但请求者应继续使用原有位置来响应以后的请求。此代码与响应 GET 和 HEAD 请求的 <a href=answer.py?answer=>301</a> 代码类似，会自动将请求者转到不同的位置，但您不应使用此代码来告诉 Googlebot 某个页面或网站已经移动，因为 Googlebot 会继续抓取原有位置并编制索引。 |

4xx（请求错误）
这些状态码表示请求可能出错，妨碍了服务器的处理。

| 400（错误请求）           | 服务器不理解请求的语法。                                     |
| ------------------------- | ------------------------------------------------------------ |
| 401（未授权）             | 请求要求身份验证。对于登录后请求的网页，服务器可能返回此响应。 |
| 403（禁止）               | 服务器拒绝请求。如果您在 Googlebot 尝试抓取您网站上的有效网页时看到此状态码（您可以在 Google 网站管理员工具诊断下的网络抓取页面上看到此信息），可能是您的服务器或主机拒绝了 Googlebot 访问。 |
| 404（未找到）             | 服务器找不到请求的网页。例如，对于服务器上不存在的网页经常会返回此代码。如果您的网站上没有 robots.txt 文件，而您在 Google 网站管理员工具[“诊断”标签的 robots.txt 页](http://www.google.cn/support/webmasters/bin/answer.py?answer=35237)上看到此状态码，则这是正确的状态码。但是，如果您有 robots.txt 文件而又看到此状态码，则说明您的 robots.txt 文件可能命名错误或位于错误的位置（该文件应当位于顶级域，名为 robots.txt）。如果对于 Googlebot 抓取的网址看到此状态码（在”诊断”标签的 [HTTP 错误页面](http://www.google.cn/support/webmasters/bin/answer.py?answer=35122)上），则表示 Googlebot 跟随的可能是另一个页面的无效链接（是旧链接或输入有误的链接）。 |
| 405（方法禁用）           | 禁用请求中指定的方法。                                       |
| 406（不接受）             | 无法使用请求的内容特性响应请求的网页。                       |
| 407（需要代理授权）       | 此状态码与 <a href=answer.py?answer=35128>401（未授权）</a>类似，但指定请求者应当授权使用代理。如果服务器返回此响应，还表示请求者应当使用代理。 |
| 408（请求超时）           | 服务器等候请求时发生超时。                                   |
| 409（冲突）               | 服务器在完成请求时发生冲突。服务器必须在响应中包含有关冲突的信息。服务器在响应与前一个请求相冲突的 PUT 请求时可能会返回此代码，以及两个请求的差异列表。 |
| 410（已删除）             | 如果请求的资源已永久删除，服务器就会返回此响应。该代码与 404（未找到）代码类似，但在资源以前存在而现在不存在的情况下，有时会用来替代 404 代码。如果资源已永久移动，您应使用 301 指定资源的新位置。 |
| 411（需要有效长度）       | 服务器不接受不含有效内容长度标头字段的请求。                 |
| 412（未满足前提条件）     | 服务器未满足请求者在请求中设置的其中一个前提条件。           |
| 413（请求实体过大）       | 服务器无法处理请求，因为请求实体过大，超出服务器的处理能力。 |
| 414（请求的 URI 过长）    | 请求的 URI（通常为网址）过长，服务器无法处理。               |
| 415（不支持的媒体类型）   | 请求的格式不受请求页面的支持。                               |
| 416（请求范围不符合要求） | 如果页面无法提供请求的范围，则服务器会返回此状态码。         |
| 417（未满足期望值）       | 服务器未满足”期望”请求标头字段的要求。                       |

5xx（服务器错误）
这些状态码表示服务器在处理请求时发生内部错误。这些错误可能是服务器本身的错误，而不是请求出错。

| 500（服务器内部错误）    | 服务器遇到错误，无法完成请求。                               |
| ------------------------ | ------------------------------------------------------------ |
| 501（尚未实施）          | 服务器不具备完成请求的功能。例如，服务器无法识别请求方法时可能会返回此代码。 |
| 502（错误网关）          | 服务器作为网关或代理，从上游服务器收到无效响应。             |
| 503（服务不可用）        | 服务器目前无法使用（由于超载或停机维护）。通常，这只是暂时状态。 |
| 504（网关超时）          | 服务器作为网关或代理，但是没有及时从上游服务器收到请求。     |
| 505（HTTP 版本不受支持） | 服务器不支持请求中所用的 HTTP 协议版本。                     |



[好文要顶](javascript:void(0);) [关注我](javascript:void(0);) [收藏该文](javascript:void(0);) [![img](https://common.cnblogs.com/images/icon_weibo_24.png)](javascript:void(0);) [![img](https://common.cnblogs.com/images/wechat.png)](javascript:void(0);)

![img](https://pic.cnblogs.com/face/1185153/20170619093809.png)

[gxw123](https://home.cnblogs.com/u/gxw123/)
[粉丝 - 1](https://home.cnblogs.com/u/gxw123/followers/) [关注 - 0](https://home.cnblogs.com/u/gxw123/followees/)





[+加关注](javascript:void(0);)

0

0







[« ](https://www.cnblogs.com/gxw123/p/13288145.html)上一篇： [浏览器页面加载过程](https://www.cnblogs.com/gxw123/p/13288145.html)