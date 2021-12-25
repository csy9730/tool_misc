# 修复群晖Moments 1.3.x无法识别人脸和主题的问题

 2019年10月12日 0条评论 6.32k次阅读 6人点赞 博主

​    有部分黑群晖，系统升级到6.22-24922以后，Moments（版本1.3.X）的人物及主题经常识别不出来，经查发现是插件有bug引导的，目前该插件已经修复，替换后则可以识别了，如果你的Moments也有这个问题，可以按照以下方法修复：

1、进群晖套件中心-已安装，找到moments，停用；
2、在Win系统运行 winscp ，以root用户登录（如果你的群晖没开启root的，需要先开启root，DSM6.2X开启root的教程：https://wp.gxnas.com/1385.html），进入 /var/packages/SynologyMoments/target/usr/lib 文件夹，找到libsynophoto-plugin-detection.so 这个文件，把它改名为 libsynophoto-plugin-detection.so.bak （备份原文件）；
3、把下载的flibsynophoto-plugin-detection.so 上传/var/packages/SynologyMoments/target/usr/lib 文件夹下（覆盖原文件），在flibsynophoto-plugin-detection.so上点右键属性，将组和拥有者都改为SynologyMoments，权限下面的八进制表修改为0755，确定；

[![img](https://wp.gxnas.com/wp-content/uploads/2019/10/QQ_Jie_Tu_20191012093536.png)](https://wp.gxnas.com/wp-content/uploads/2019/10/QQ_Jie_Tu_20191012093536.png)

4、群晖套件中心-已安装，找到moments，启动；
5、进moments，在左下角菜单进去，点：重建索引，等待索引的时间根据你的相片和视频的多少以及你的机器硬件性能决定（图片和视频少的可能几分钟就完成，图片和视频多的可能需要几天才能完成），请耐心等待就是了，等全部索引完成后就全部显示正常了。

 

修复的文件在这：[下载](https://wp.gxnas.com/wp-content/uploads/2019/10/libsynophoto-plugin-detection.so)