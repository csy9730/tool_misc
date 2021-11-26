#                   [     在手机的浏览器上通过连接打开App        ](https://www.cnblogs.com/sexintercourse/p/5898242.html)              



# Android系统中实现

------

 

## 1、在系统系统自带的浏览器中

首先做成HTML的页面，页面内容格式如下：

```
<a href="[scheme]://[host]/[path]?[query]">启动应用程序</a> 
```

这一句就可以了。

各个项目含义如下所示：

scheme：判别启动的App。 ※详细后述

host：适当记述

path：传值时必须的key     ※没有也可以

query：获取值的Key和Value  ※没有也可以

 作为测试好好写了一下，如下：

```
<a href="myapp://jp.app/openwith?name=zhangsan&age=26">启动应用程序</a>  
```

 接下来是Android端。

*首先在AndroidManifest.xml的MAIN Activity下追加以下内容。(启动Activity时给予)*

※必须添加项

```
<intent-filter>  
    <action android:name="android.intent.action.VIEW"/>  
    <category android:name="android.intent.category.DEFAULT" />  
    <category android:name="android.intent.category.BROWSABLE" />  
    <data android:scheme="myapp" android:host="jp.app" android:pathPrefix="/openwith"/>  
</intent-filter>
```

HTML记述的内容加入<data …/>。
其中必须的内容仅scheme，没有其他内容app也能启动。

※注意事项：intent-filter的内容【android.intent.action.MAIN】和 【android.intent.category.LAUNCHER】这2个，不能与这次追加的内容混合。
 所以，如果加入了同一个Activity，请按以下这样做，否则会导致应用图标在桌面消失等问题。

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
<intent-filter>  
    <action android:name="android.intent.action.MAIN"/>  
    <category android:name="android.intent.category.LAUNCHER" />  
</intent-filter>  
<intent-filter>  
    <action android:name="android.intent.action.VIEW"/>  
    <category android:name="android.intent.category.DEFAULT" />  
    <category android:name="android.intent.category.BROWSABLE" />  
    <data android:scheme="myapp" android:host="jp.app" android:pathPrefix="/openwith"/>  
</intent-filter> 
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

这样的话，没有问题。

 接下来在Activity中需要取值的地方添加以下代码，我是直接写在OnCreate函数里的：

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

 

 Intent i_getvalue = getIntent();  

String action = i_getvalue.getAction();  

if(Intent.ACTION_VIEW.equals(action)){  

​    Uri uri = i_getvalue.getData();  

​    if(uri != null){  

​        String name = uri.getQueryParameter("name");  

​        String age= uri.getQueryParameter("age");  

​    }  

}      

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

这样就能获取到URL传递过来的值了。

## 2、在第三方的浏览器中

把一个http服务宿主在本地应用中，本地的服务地址为127.0.0.1:8765中，宿主用于监控服务数据，并打开自身。

## 3、在微信中打开

在微信开放平台登记应用之后，可以获得appid，通过这个appid就可以跳转到你的app。
iOS平台格式如下：appid://openwebview/?ret=0，appid要替换成实际的，后面可以带参数，在你的app可以接收到。
例如：location.href = wx234ad233ae222://openwebview/?ret=0

# IOS系统中实现

------

 

# 1、在系统自带的浏览器

 

经常使用Safari浏览器浏览网页点击url会唤醒该网站的手机版app

 

需要在app的工程中设置

 

1、打开工程中的myapp-Info.plist文件

 

2、打开文件中新增URL TYPES的一项

 

3、在工程中实现如下方法

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    if (url) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"你唤醒了您的应用" delegate:selfcancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
    return YES;
 }
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

 

4、在Safari浏览器输入myapp:// ,就可以启动应用了。

## 2、在自身浏览器上显示Banner，有就显示打开，没有就提示下载

<meta name="apple-itunes-app" content="app-id=432274380">

## 3、在第三方的浏览器中

把一个http服务宿主在本地应用中，本地的服务地址为127.0.0.1:8765中，宿主用于监控服务数据，并打开自身。

## 4、在微信中打开

在微信开放平台登记应用之后，可以获得appid，通过这个appid就可以跳转到你的app。
iOS平台格式如下：appid://openwebview/?ret=0，appid要替换成实际的，后面可以带参数，在你的app可以接收到。
例如：location.href = wx234ad233ae222://openwebview/?ret=0

漫思



​     分类:              [前端开发](https://www.cnblogs.com/sexintercourse/category/848403.html)