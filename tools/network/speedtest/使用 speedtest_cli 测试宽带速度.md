# 使用 speedtest_cli 测试宽带速度

[l蓝色梦幻](https://www.jianshu.com/u/abd3db9d23a6)关注

0.1322018.10.22 16:47:29字数 400阅读 4,155

speedtest_cli 是一个使用 speedtest.net 来测试因特网带宽的命令行界面。通过这种方式，你也可以在没有浏览器或者图形化界面的服务器上做带宽测试。

## 1. 安装

- pip 安装

``` bash
pip install speedtest_cli
```
- easy_install 安装

``` bash
easy_install speedtest_cli
```
- Github 安装
``` bash
git clone https://github.com/sivel/speedtest-cli.git
python speedtest-cli/setup.py install
```
或者
``` bash
pip install git+https://github.com/sivel/speedtest-cli.git
```

1. 使用
- 基本用法. 这样你会在终端中活得带宽报告

```csharp
# speedtest-cli 
Retrieving speedtest.net configuration...
Testing from China Telecom JILIN (123.172.16.158)...
Retrieving speedtest.net server list...
Selecting best server based on ping...
Hosted by China Unicom Heilongjiang Branch (Harbin) [232.20 km]: 92.151 ms
Testing download speed................................................................................
Download: 8.37 Mbit/s
Testing upload speed................................................................................................
Upload: 84.01 Mbit/s
```

- 分享你的宽带速度,那么在命令后面加上 `--share` 即可



```csharp
# speedtest-cli --share
Retrieving speedtest.net configuration...
Testing from China Telecom JILIN (123.172.16.158)...
Retrieving speedtest.net server list...
Selecting best server based on ping...
Hosted by China Unicom Heilongjiang Branch (Harbin) [232.20 km]: 88.509 ms
Testing download speed................................................................................
Download: 6.41 Mbit/s
Testing upload speed................................................................................................
Upload: 41.37 Mbit/s
Share results: http://www.speedtest.net/result/7736883263.png
```

生成的图像是:

![img](https://upload-images.jianshu.io/upload_images/2159939-8b3f65b6215fa649.png?imageMogr2/auto-orient/strip|imageView2/2/w/350/format/webp)

image

   - 列出所有speedtest.net服务器

     

     ```css
     # speedtest-cli --list
     Retrieving speedtest.net configuration...
     1)    China Unicom (Changchun, China) [0.00 km]
     2)     China Mobile,Jilin (Changchun, China) [0.00 km]
     3)    China Unicom Heilongjiang Branch (Harbin, China) [232.20 km]
     4)     China Mobile Heilongjiang branch (Harbin, China) [234.29 km]
     ....
     ```

   - 使用特定的服务器

     

     ```csharp
     speedtest-cli --server 9484
     Retrieving speedtest.net configuration...
     Testing from China Telecom JILIN (123.172.16.158)...
     Retrieving speedtest.net server list...
     Retrieving information for the selected server...
     Hosted by China Unicom (Changchun) [0.00 km]: 96.466 ms
     Testing download speed................................................................................
     Download: 9.27 Mbit/s
     Testing upload speed................................................................................................
     Upload: 68.49 Mbit/s
     ```

# 错误集合
