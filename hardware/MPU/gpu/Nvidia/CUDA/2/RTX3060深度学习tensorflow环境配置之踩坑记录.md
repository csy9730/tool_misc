# RTX3060深度学习tensorflow环境配置之踩坑记录

[![dddean](https://pic1.zhimg.com/v2-8ca6e9ad2ab397513daa92f6199fe313_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/zhi-lai-zhi-wang-87)

[dddean](https://www.zhihu.com/people/zhi-lai-zhi-wang-87)





59 人赞同了该文章

说起windows系统的深度学习环境配置，想必大家都是一肚子火，这次换了新设备，配环境也是挺绝望的，RTX 3060作为刚发布的新卡，它不兼容之前的cuda版本！它支持的cuda版本最低是11.1，而tf最高才支持到11.0，这就很难受，内网外网翻各种教程，不过都是3080，3090等其他30系列的，3060的完全没有，不过坑了我两天的时间终于弄好了！环境配置本身不难，主要就是版本要对，所以为了避免其他人也浪费不必要的时间，这里分享下避坑记录。

节约时间，这里直接放出RTX 3060 (不保证3060ti，3070等其他30系显卡)能用的配置:

**CUDA11.1＋cuDNN8.0.5＋tensorflow-gpu2.4.1**

**CUDA11.1＋cuDNN8.0.5＋tensorflow-gpu2.4.1**

**CUDA11.1＋cuDNN8.0.5＋tensorflow-gpu2.4.1**

好了，分享结束，快去直接安装吧！！！

```text
pip install tensorflow-gpu
```

------



以下开始废话和一些经验之谈:

**1.CUDA版本对应**

最近在做一个医学数据集的分类预测问题，用自己的小新pro14(*MX450*)勉强能用，之前配的环境是CUDA10.0＋cuDNN7.6＋tensorflow-gpu1.15，用的是Anaconda＋Pycharm的主流搭配(*因为教程都这么写的*)，根据tensorflow官网给的版本对应表格，选择你要装的tf对应的CUDA和cuDNN装好就行了，其中cuDNN版本要求没那么严格，我的tf1.15本来是对应cuDNN7.4的，但是后来更新了7.6也没事。

![img](https://pic1.zhimg.com/80/v2-f1bcc5c8ab09909107e491b468811e48_1440w.jpg)来源：tensorflow官网

而RTX30系列支持的CUDA从11.1起步，查表我们根本没法装，在网上搜了很多教程，不过幸好3060的老大哥们3080，3090系列发布的早，已经有很多人写了踩坑教程，试出了CUDA11.1搭配cuDNN8.0.5是可行的方案。

**2.环境变量**

建议安装Anaconda时，就把那个加入PATH给勾选，装Pycharm时把右键将文件夹打开为项目勾选。至于CUDA的环境变量，网上教程给了很多。有只用默认的两个的，也有自己添加\lib, \include等一堆的，保险起见我都加了，可能会有多余。装好后测试下:

```python3
import tensorflow as tf
print('GPU',tf.test.is_gpu_available())
```

![img](https://pic3.zhimg.com/80/v2-bf14fa9a2bcac0a06e839f3d90e7e2d6_1440w.jpg)

**3.tf版本**

网上的教程大多在去年10月到今年2月之间，他们说的是2.3和2.4不支持，不止一个人说装tf-nightly-gpu就行了，也就是tf2.5的测试版，问题就在这里，我按照教程装了测试版。然后跑测试程序，cudnn这些都成功加载(*cusolver64_10.dll缺失的问题改名大法可以解决，把cudnn解压出来的文件中cusolver64_11那个文件改名为需要的_10*)，gpu测试也都是True，可就是跑不了程序，会提示栈溢出的结束报错。

```text
Process finished with exit code -1073741571 (0xC00000FD)
```

在网上把rtx3060和这个报错一起搜也搜不出结果，单独找栈溢出的解决方法也没用(大家遇到的问题和解决办法都要因程序而异)，这就是真的绝望，明明按照教程来了，怎么还是不行！

于是开始回头看每一个步骤是不是哪里出了问题，看cuda是否正确安装了所有组件？ cudnn版本下错了没？环境变量设置有问题？虚拟环境没设置好？pycharm里面解释器没设置好？这些环节都可能导致出错

不过，好在这些都没有问题，最后一通乱搞，发现仅仅只是tf版本的问题！偶然看到一个说2.4.0的可以的，于是我就直接试了装 tf-gpu 最新的是2.4.1，神奇的竟然可以run了，栈溢出那个报错没了，一切正常了！！！

不知道是不是2.4.1加入了对30系显卡的支持，还是说只是对3060的特例而已，3070,80,90等高玩用户还是建议你们先按照其他人讲的pip 装tf-nightly-gpu试一试，如果不行，再试这个tensorflow-gpu2.4.1。

**其他:**

1.从旧电脑迁移conda环境到新电脑，把envs里面的文件夹打包复制直接移到新电脑，直接能用，前提是同一操作系统，比如win10到win10，家庭版和专业版啥的不区分

2.conda换清华源，直接改.condarc文件内容为清华源的那一段代码。pip装包，单独换豆瓣源下载很快

```text
pip install tensorflow-gpu -i https://pypi.doubanio.com/simple/
```

3.cuda和cudnn下载慢的话，最好用IDM快很多

4.实在要用1.x的tensorflow的话，nvidia官方有个1.15的包，仅限Linux用户，win用户的话要自己编译，网上也有编好的

------

最后，本文章只是为了记录下踩坑心得，没准备写个完整的教程，写的累，网上也都有大量重复内容，没啥必要

不过掐指一算，RTX3060好像才上市不到一个月，加上矿潮之下溢价太严重，能理解没啥教程出来以及开发者适配的问题，让子弹飞一会儿吧。另外，当初看中的就是3060的12G超大显存，用自己的小新跑模型一下子就MemoryError了，晚上才把环境搞好，希望明天它能跑出好结果，晚安，炼丹人

编辑于 2021-04-04 22:31

深度学习（Deep Learning）

TensorFlow 学习

赞同 59

47 条评论

分享