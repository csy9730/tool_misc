# VScode调试第三方库

VScode调试时默认只能进入用户自己编写的文件中，而如果想要进一步了解API内发生的数据变化细节，这项设置就不可或缺了。
上解决方法：
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191025150809910.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2c1MzQ0NDE5MjE=,size_16,color_FFFFFF,t_70)
需要在launch.json中添加justMyCode设置项并将其置为false，注意逗号的位置。
参考：[stackoverflow](https://stackoverflow.com/questions/52980448/how-to-disable-just-my-code-setting-in-vscode-debugger)