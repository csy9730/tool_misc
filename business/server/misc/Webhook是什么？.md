# [Webhook是什么？](https://www.cnblogs.com/wqbin/p/13150805.html)

## 1.学习背景

最近因为想实时使用branch归因投放的渠道数据，对客群进行实时分类，所以之前export daily data的T-2的数据不再满足业务的需求。

![img](https://img2020.cnblogs.com/blog/1353331/202006/1353331-20200617100921121-1969244483.png)

 

 

[ 原具体方案](https://help.branch.io/developers-hub/docs/daily-exports)

## webhook概述

webhook 究竟是什么呢？　　

Webhook是一个API概念,webhoo是一种web回调或者http的push API.Webhook作为一个轻量的事件处理应用，正变得越来越有用。

具体的说,webhook 是应用给其它应用提供实时信息的一种方式。信息一产生，Webhook在数据产生时立即发送数据和把它发送给已经注册的应用这就意味着你能实时得到数据。

不像传统的 APIs 方式，你需要用轮询的方式来获得尽可能实时的数据。这一点使得 webhook 不管是在发送端还是接收端都非常高效。

由于大部分服务提供商对 API 的访问有一定限制，所以要么采用 webhook 方式，要么采用传统的轮询方式，不过这样客户端数据会有一些（或者比较多的）滞后。

这无论是对生产还是对消费者都是高效的，唯一的缺点是初始建立困难。

Webhook有时也被称为反向API，因为他提供了API规则，你需要设计要使用的API。Webhook将向你的应用发起http请求，典型的是post请求，应用程序由请求驱动。

**项目A需要实时获取到项目B的最新数据：**

传统做法:项目A需要不停轮询去拉取项目B的最新数据

webhook机制:项目A提供一个webhook url,每次项目B创建新数据时,便会向项目A的hook地址进行请求,项目A收到项目B的请求,然后对数据进行处理

![img](https://img2020.cnblogs.com/blog/1353331/202006/1353331-20200617135512464-1320756712.png)

 

 

## 2.使用webhook

消费一个webhook是为webhook准备一个URL，用于webhook发送请求。这些通常由后台页面和或者API完成。这就意味你的应用要设置一个通过公网可以访问的URL。

多数webhook以两种数据格式发布数据：JSON或者XML，这需要解释。另一种数据格式是application/x-www-form-urlencoded or multipart/form-data。这两种方式都很容易解析，并且多数的Web应用架构都可以做这部分工作。

**实际案例branch**

**1.Go to RequestBin and click + Create a RequestBin:**

> Branch’s new webhook system for People-Based Attribution allows you to export install and down-funnel event data as it occurs.
> You can import this data into your internal systems for analysis. You simply need to specify a URL for the POST or GET requests.

![img](https://img2020.cnblogs.com/blog/1353331/202006/1353331-20200617102630730-206215999.png)

 

**配置方法**

As you fill out the configuration, you'll see the following options:

- Send a webhook to: Enter the URL where you would like the events to be sent. This URL can be written with Freemarker syntax to dynamically populate parameters and execute simple, logical expressions. There is more information on Freemarker support below.
- using a GET/POST: Events can be sent either via POST or GET. POST events will be created with a default POST body. There is more information on POST bodies below.
- users trigger event: When the selected event occurs, a webhook will fire:

![img](https://img2020.cnblogs.com/blog/1353331/202006/1353331-20200617103314319-1556606290.png)

 

 

**2.Copy the Bin URL AND Paste this into the URL field of your Branch webhook's configuration screen:**

![img](https://img2020.cnblogs.com/blog/1353331/202006/1353331-20200617102656092-1881399166.png)

 

 3.Now whenever your webhook is triggered, you will see a full report on RequestBin:

我么可以看到客户每次下载触发这个事件，都会在我们这个请求中看到相应的数据。

 ![img](https://img2020.cnblogs.com/blog/1353331/202006/1353331-20200617110847119-755149536.png)

##  

## Webhook调试

调试webhook有时很复杂，因为webhook原则来说是异步的。你首先要解发他，然后等待，接着检查是否有响应。这是枯燥并且相当低效。幸运的是还有其他方法：

1、明白webhook能提供什么，使用如RequestBin之类的工具收集webhook的请求；

2、用cURL或者Postman来模拟请求；

3、用ngrok这样的工具测试你的代码；

4、用Runscope工具来查看整个流程。

## webhook安全

因为webhook发送数据到应用上公开的URL，这就给其他人找到这个URL并且发送错误数据的机会。你可采用技术手段，防止这样的事情发生。最简单的方法是采用https（TLS connection）。除了使用https外，还可以采用以下的方法进一步提高安全性：

1、首先增加Token，这个大多数webhook都支持；

2、增加认证；

3、数据签名。

## 重要的问题

当作为webhook的消费者时有两件事需要铭记于心：

1、webhook通过请求发送数据到你的应用后，就不再关注这些数据。也就是说如果你的应用存在问题，数据会丢失。许多webhook会处理回应，如果程序出现错误会重传数据。如果你的应用处理这个请求并且依然返回一个错误，你的应用就会收到重复数据。

2、webhook会发出大量的请求，这样会造成你的应用阻塞。确保你的应用能处理这些请求。

大多数人都以为是才智成就了科学家，他们错了，是品格。---爱因斯坦