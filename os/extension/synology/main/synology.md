# synology


[synology](https://www.synology.cn/zh-cn)
群晖科技股份有限公司



1. 安装系统
2. 硬盘配置
3. 


## extension

常见app

* 服务
    * DSM   用户管理入口
    * file station 文件管理（提供类似windows下explorer的功能）
    * Synology Drive 自动同步、无缝衔接云办公、文件有多版本保护（防止误删误改）、团队实时编辑表格与文档等功能。
    * photo Station
    * video station
    * download station
    * moments
    * USB COPY套件
    * Synology Drive
* 应用 
    * office
    * pdf

部分服务app有对应 android/ios app。

### file station

#### 用户读写权限配置

#### 网盘挂载

### Synology Drive
下面説下Synology Drive ，他是整合原本的 File Station、Cloud Station、Synology Office的也就是說Driver類似網盤客戶端，可以在移動設備與計算機上管理所有文件，如百度雲盤，google drivemoment是Driver裏面的一個專門用來存放照片的文件夾，就好比你打開我的電腦（Drive）>D盤>照片文件夾（moment）。如google photos，百度云裏面的照片管家同時，google photos，百度云裏面的照片管家裏所上載的照片是可以在google drive與百度雲盤裏面找到的。

注意： Drive需要用Drive控制台app配置


Synology Drive 应用需要在 Drive控制台app中开启共享文件夹，团队才能使用共享文件夹。

### photo station
基础照片管理

### moments

可以 通过 ai 识别 地点和场景。
### USB COPY套件
使用USB COPY 套件将NAS中的照片备份到移动存储介质。

### Video Station
Video Station: 视频管理
### Cloud Sync
Cloud Sync: 将本地文件同步到公有云/云盘
媒体服务器: 实现视频串流
### tools
存储空间分析器
Docker

### port
群晖的常用套件端口如下：

管理页面（DSM）：5000、5001

Drive、Moments：6690

photo station：58378

视频套件Video Station：9025 至 9040

下载管理套件 Ds Get：16881

## misc


**Q**: 群晖显示硬盘已毁损如何处理？
**A**: 
自动修复试下。成功了赶紧换硬盘
重启解决，
大概率可能只是检测到硬盘上多了几个坏扇区，其实家用的话数据不重要可以忽略这个提示，数据重要就做好备份重新格式化或者屏蔽一下坏扇区，群晖是有任何一丁点的毛病就会提示硬盘损毁的


群晖 使用 brtfs还是ext4，brtfs 是否要开启 文件快速 克隆 ?
硬盘是否要 组 raid5/raid1？还是 手动 rsync 同步硬盘内容。

是否需要经常关机？

是否要配置 停电续航设备？



moment 和driver 和 file station什么关系？

file station相当于Windows的资源管理器，可以查看nas的任何非系统文件（随便删也不会把nas搞宕机）。
driver 是file station裏面的一個資料夾/文件夾。上传到drive的文件会放在`/homes/用户名/drive`的文件夹下，
moment是driver裏面的一個資料夾/文件夾，單獨存放照片的並通過此軟體管理。



群晖的gitlab 内存 占用过高，空载都占用2GB内存。官方建议最少 2 核 8G 或者 2 核 4G+4G 的 swap。
可以考虑使用 gitea/gogs + Drone

阿里云，纯 Docker 环境跑单 Gitlab，2C 4G 就够了，CPU 峰值不过 40%，内存占用稳定 80%

 Jira 和 Jenkins。