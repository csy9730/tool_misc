# [利用Python实现高度定制专属RSS](https://www.cnblogs.com/liujiangblog/articles/12131027.html)



### 前言

本文转载自[Jianger's Blog](https://jianger.space/take-advantage-of-python-to-custom-highly-rss/)，欢迎来访订阅。本篇属于`定制RSS`系列终极一弹，是三种方式中自由度最高、定制化最强的，也需要一定的编程能力。附上前两篇链接：1、[利用Feed43为网站自制RSS源](https://jianger.space/take-advantage-of-feed43-to-custom-rss/)；2、[如何优雅快速地利用Huginn制作专属RSS](https://jianger.space/take-advantage-of-huginn-to-make-rss/)。开始之前先对比一下以上三种方式：

| 方法   | 优势                   | 不足                              | 复杂性 | 稳定性 | 定制性 |
| :----- | ---------------------- | --------------------------------- | ------ | ------ | ------ |
| Feed43 | 快速、便捷、免费       | 免费版需间隔6小时，部分网站不可用 | 简单   | 一般   | 中     |
| Huginn | 快速、安装后可便捷添加 | 专业化程度偏高，需要服务器        | 高     | 高     | 高     |
| Python | 高度定制、占用内存小   | 专业化程度偏高，不可随意改正      | 一般   | 高     | 极高   |

看个人需要进行选择，Huginn虽安装麻烦点，但是一个自动化神器，妙用不仅局限于此。

### 前排提示

> Python脚本需要放置在云主机/云服务器上使用，如果你还没有，赶快购置一台吧
>
> 需要了解：CSS基础；Python基础；Linux基础命令；利用浏览器开发者工具找到对应内容代码
>
> 我的使用环境：腾讯云主机centos7.5，Python2.7(服务器默认已安装的)

### 开始定制

------

先上代码，以下代码仅供参考，重要的是学会利用其中的代码和方法。

> 以下所有操作基于江西师范大学大学教务在线网站

```python
# -*- coding: utf-8 -*-
import datetime
import time  
import PyRSS2Gen
from bs4 import BeautifulSoup
import requests
import re
import sys
reload(sys)			
sys.setdefaultencoding('utf8')	//防止中文乱码
xmlpath='/local/myrss/jxnu.xml' //RSS文件放置地址，需要放置在HTTP服务开启的文件夹下
now_time=time.strftime('%Y/%m/%d %H:%M:%S',time.localtime(time.time()))
//请求头，有些页面需要登录后才能抓取，cookie长期有效的可以设置cookie
headers = {
    'User-Agent': 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36\
    (KHTML, like Gecko) Chrome/75.0.3770.142 Mobile Safari/537.36',
    'Accept-Encoding': 'gzip, deflate, br',
    'Accept-Language': 'zh-CN,zh;q=0.9',
    'Content-Type': 'text/html; charset=utf-8',
    'Host': 'jwc.jxnu.edu.cn',
    'Cookie': ''

}
def setrss():
	rssitems=[]
	html = requests.get('https://jwc.jxnu.edu.cn/Portal/Index.aspx') //获得网站html代码
	bs = BeautifulSoup(html.text,'html.parser')
	contents = bs.select('.long_item > a')			//BeautifulSoup获得通知的标题和对应链接
	for content in contents:
		title=content.text
		href='https://jwc.jxnu.edu.cn/Portal/'+content.get('href')
		detile=requests.get(url=href,headers=headers)
		bs_0 = BeautifulSoup(detile.text,'html.parser')
		article = bs_0.select('#main-content')
		b=re.search(r"该文档需要登录后再查看",article[0].text)
		if b is None:
			descriptions=str(article[0])
		else:
			descriptions=content.get('title')
		item=PyRSS2Gen.RSSItem(				//item即为一项内容
		title=title,	//每一项内容的标题
		link=href,		//每一项内容的链接
		description = descriptions,	//每一项内容的描述/内容
		pubDate =datetime.datetime.now()	//更新时间
		)
		rssitems.append(item)				//rssitems即为所有内容
	rss = PyRSS2Gen.RSS2(
	title = "江西师范大学教务在线",  //rss源的名称
	link = "https://jwc.jxnu.edu.cn/Portal/Index.aspx",  //rss源的原地址
	description = "江西师范大学教务在线",  //rss源的描述
	lastBuildDate = datetime.datetime.now(),
	items = rssitems)
	rss.write_xml(open(xmlpath, "w"),encoding='utf-8') //生成RSS格式的xml文件
if __name__ == '__main__':
	setrss()
```

> 说明：PyRSS2Gen、BeautifulSoup两个模块是需要安装的，安装过忽略，代码基于Python2.7

```mipsasm
pip install BeautifulSoup
pip install PyRSS2Gen
```

RSS的本质就是一个固定格式的文件，所以本方法按照以下三步进行，定时执行脚本生成xml文件放置在云服务器上。

#### 抓取特定内容

有的页面可以直接抓取，有的页面需要登录后才能看到，并且有的网站有反爬虫措施，看抓取的网站采取不同方法。本示例先通过BeautifulSoup模块获取教务在线通知的标题和链接，然后再逐一访问链接下的全文内容。

```python
	html = requests.get('https://jwc.jxnu.edu.cn/Portal/Index.aspx') //获得网站html代码
	bs = BeautifulSoup(html.text,'html.parser')
	contents = bs.select('.long_item > a')		//BeautifulSoup获得通知的标题和链接
	for content in contents:
		title=content.text
		href='https://jwc.jxnu.edu.cn/Portal/'+content.get('href')
		detile=requests.get(url=href,headers=headers)
		bs_0 = BeautifulSoup(detile.text,'html.parser')
		article = bs_0.select('#main-content')
		b=re.search(r"该文档需要登录后再查看",article[0].text)
		if b is None:
			descriptions=str(article[0])
		else:
			descriptions=content.get('title')
```

### 构造RSS格式并输出

获得内容后将内容构造成相关格式，主要利用PyRSS2Gen模块构造

```python
item=PyRSS2Gen.RSSItem(				//构造一个item
		title=title,	//每一项内容的标题
		link=href,		//每一项内容的链接
		description = descriptions,	//每一项内容的描述/内容
		pubDate =datetime.datetime.now()	//更新时间
		)
		rssitems.append(item)				//rssitems即为所有内容
	rss = PyRSS2Gen.RSS2(			//构造RSS2.0格式的对象
	title = "江西师范大学教务在线",  //rss源的名称
	link = "https://jwc.jxnu.edu.cn/Portal/Index.aspx",  //rss源的原地址
	description = "江西师范大学教务在线",  //rss源的描述
	lastBuildDate = datetime.datetime.now(),
	items = rssitems)
	rss.write_xml(open(xmlpath, "w"),encoding='utf-8') //生成RSS格式的xml文件
```

### 云服务器设置

------

利用crontab定时执行该脚本并运行生成文件，然后再开启公网可访问的相关服务，一个RSS源就生成了！

#### crontab设置

连接云服务器后，输入以下命令，设置定时任务

```bash
vi /etc/crontab
```

添加如下内容，表示每半小时root用户使用python执行一次位于/local/myrss的jxnu-rss.py脚本，酌情更改。

```javascript
*/30 * * * * root python /local/myrss/jxnu-rss.py
```

#### 搭建Http服务

方法有很多，这里使用Python下的SimpleHTTPServer。

**SimpleHTTPServer**

在 Linux 服务器上或安装了 Python 的机器上，Python自带了一个WEB服务器 SimpleHTTPServer。进入到生成的xml文件所在文件夹，输入如下命令回车

```bash
nohup python -m SimpleHTTPServer 8080 &
```

在命令开头加一个nohup，忽略所有的挂断信号，如果当前bash关闭，则当前进程会挂载到init进程下，成为子进程，这样退出关闭服务器连接服务仍旧在运行。以上内容酌情修改，然后浏览器输入http://你的服务器IP:8080/jxnu.xml回车看到RSS内容即表示成功，可以将其添加到RSS阅读器上去了。

#### 可能遇到的问题

- SimpleHTTPServer服务不是很稳定，有时候会访问不了RSS源，重启时好时不好；



标签: [RSS](https://www.cnblogs.com/liujiangblog/tag/RSS/), [Python](https://www.cnblogs.com/liujiangblog/tag/Python/)