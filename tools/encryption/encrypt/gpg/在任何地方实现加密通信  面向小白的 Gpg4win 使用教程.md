# 在任何地方实现加密通信 | 面向小白的 Gpg4win 使用教程

[![CYWVS](https://pic1.zhimg.com/v2-abed1a8c04700ba7d72b45195223e0ff_l.jpg?source=172ae18b)](https://www.zhihu.com/people/cywvs)

[CYWVS](https://www.zhihu.com/people/cywvs)

这段话并没有含沙射影谁。

15 人赞同了该文章

## 前言

通常情况下，我们想要在网上聊天、传输文件，就必须经过某些平台：社交媒体、即时通讯软件、电邮提供商、网盘等等。有时候我们不希望它们知道通信内容是什么，而 Gpg4win 提供了解决方案：它能非常安全地加密双方的通信信息。

有鉴于此文的受众，这篇文章不会过于细致地讲解 Gpg4win 是怎么工作的，这些内容会另起文章。一些较为复杂的使用方法也不会提及。

此文章以 [CC BY-SA 4.0](https://link.zhihu.com/?target=https%3A//creativecommons.org/licenses/by-sa/4.0/) 协议发表，任何人有权在遵守此协议的前提下使用本作品。

------

## 安装 Gpg4win

通信双方都需要安装 Gpg4win。

Gpg4win 的官网：[Gpg4win - Secure email and file encryption with GnuPG for Windows](https://link.zhihu.com/?target=https%3A//www.gpg4win.org/)

点击 Download 按钮，选择捐助 $0（如果愿意的话，捐助些也行），然后正常下载安装。之后，打开 Gpg4win 的前端 Kleopatra。

![img](https://pic3.zhimg.com/80/v2-c485aeb1a474c3526a3d4f4558899f72_1440w.webp)

Kleopatra 的主界面

------

## 新建密钥对

通信双方都需要创建自己的**密钥对**。密钥对相当于你的身份，它由公钥和私钥组成：

- **公钥**相当于你的名片，可以公开给任何人。拥有你的公钥的人可以给你发送加密信息，以及验证你的签名。
- **私钥**即私人密钥，绝对不可以公开。你可以用私钥解密别人给你的信息，以及签名你发送的信息，以证明它确实是由你发出的，而非其他冒充你的人。

点击界面中间的「新建密钥对」，然后填写你的个人信息，最后点击「新建」。为了防止能接触到这台电脑的人窃取你的密钥，你可以勾选「使用密码句保护生成的密钥」。

![img](https://pic2.zhimg.com/80/v2-bd56f4dd3b557690839cb6c38bb2c1fd_1440w.webp)

![img](https://pic3.zhimg.com/80/v2-ae0660a1ed07ced483267c7489d84cae_1440w.webp)

------

## 交换公钥

这个过程就像双方在交换名片。交换公钥后，双方就能进行加密通信或验证签名了。

首先，你需要导出你的公钥。右键密钥对，然后点击「导出…」。你会得到一个后缀为「.gpg」的公钥文件。

![img](https://pic4.zhimg.com/80/v2-9a9b4fe1d1268bdcd1101b7ebe65b883_1440w.webp)

![img](https://pic4.zhimg.com/80/v2-724ba292d78a98f3cb9e0e486c0ddd03_1440w.webp)

将公钥文件发送给对方。对方打开 Kelopatra，点击上方的「导入…」：

![img](https://pic4.zhimg.com/80/v2-08ac7cac14d48b20e99b55a18dbdf34f_1440w.webp)

导入公钥，然后点击「All Certificates」回到所有证书的页面。

![img](https://pic1.zhimg.com/80/v2-4d7218f6df7e34fb30828f901b803640_1440w.webp)

框中的是已导入的公钥。注意：加粗字体的是自己的密钥对，未加粗的是别人的公钥。

![img](https://pic1.zhimg.com/80/v2-55f1d3188236086bcba3007e6b4975f4_1440w.webp)

PS：如果你只能给对方发送文本，例如在评论区或某些平台的私信中，可以直接用记事本打开导出的公钥文件，复制里面的文本并发送给对方，对方创建一个 TXT 文件并将文本粘贴进去，然后直接导入这个 TXT 文件。

------

## 加密文本内容

点击「记事本」，在文本框中输入欲加密的信息。

![img](https://pic3.zhimg.com/80/v2-6c19e49eb679fdab6e1af5d5dc88c55e_1440w.webp)

点击「收件人」并将对方添加进去，然后开始加密。

![img](https://pic3.zhimg.com/80/v2-fc8ab4b5a3a344eecf0f95334eeb54c2_1440w.webp)

回到「记事本」，就可以看见加密好的信息了。

![img](https://pic4.zhimg.com/80/v2-a9cb945ae9bf7b2bec354781f243841f_1440w.webp)

将加密的信息发送给对方。对方把信息填入文本框中，并解密。

![img](https://pic2.zhimg.com/80/v2-d096b624d31da55af960f4a8a0268ab1_1440w.webp)

------

## 加密文件

点击右上角的「签名/加密…」，选择你需要加密的文件。

![img](https://pic2.zhimg.com/80/v2-284322997d810a95b3f80188df20a835_1440w.webp)

添加收件人，然后加密。

![img](https://pic3.zhimg.com/80/v2-56aa683a529c88678c7a39933b9b42ba_1440w.webp)

你会获得一个后缀为「.gpg」的已加密文件，将它发送给对方。

![img](https://pic4.zhimg.com/80/v2-337987b8b8026f2b90942dc32c8cc96f_1440w.webp)

解密也很简单，点击左上角的「解密/校验…」，选中加密文件，解密完成后点击「Save All」。

![img](https://pic3.zhimg.com/80/v2-d7cc31a8b9f96b97989b1b3c3f72bcaa_1440w.webp)

------

## 验证公钥

有时候，你收到的公钥可能是冒充者伪造的，你需要用一些手段验证，比如在电话中交换密钥 ID。验证完毕后，右键它的公钥，点击「验证」。

------

## 最后聊聊安全性

和其他的玩具加密软件相比，基于 GnuPG 的 Gpg4win 足够安全，目前没有可行的手段破解它。但是并不代表你可以高枕无忧。下面列举了一些可行的攻击方法：

- 伪造公钥：攻击者可以冒充和你通信的人，给你发送虚假的公钥。上面已经提到过你可以通过电话等手段验证公钥的真实性。
- 黑袋密码分析（black-bag cryptanalysis）：攻击者可以闯入你的住所，将你的电脑包在黑色的袋子里并跑路，然后从偷来的设备中分析出密钥。你可以用足够安全的密码语句保护私钥，这样，即使他人窃走了你的设备也无法解密出私钥。
- 橡胶软管密码分析（rubber-hose cryptanalysis）：攻击者可以利用橡胶软管鞭打，或使用其他酷刑折磨你，从你口中得到私钥。如果你遇到了这种攻击手段，那自求多福吧。; P

![img](https://pic1.zhimg.com/80/92c6a7138946479fc7ad02aa28d539a0_1440w.webp)

Actual actual reality: nobody cares about his secrets. (Also, I would be hard-pressed to find that wrench for $5.)

翻译：

> ***【一个密码学菜鸟的想象】\***
> 甲：他的笔计本被加密了。让我们建一个耗费百万美元的计算机集群来破解它。
> 乙：我超，是 4096 位 RSA！
> 甲：淦！我们的邪恶计划完蛋了！
> ***【实际情况】\***
> 甲：他的笔记本被加密了。给他灌药并用这个 5 美元的扳手创他，直到他肯交出密码为止。
> 乙：明白。
> *实际的实际情况：根本没人关心他的秘密。（另外，我很难以 5 刀的价格弄到那个扳手）*

[xkcd: Security (538)](https://link.zhihu.com/?target=https%3A//xkcd.com/538/), [CC BY-NC 2.5](https://link.zhihu.com/?target=https%3A//creativecommons.org/licenses/by-nc/2.5/)

发布于 2022-10-02 18:30



[GPG](https://www.zhihu.com/topic/24384355)

[加密](https://www.zhihu.com/topic/19569234)

[加密/解密](https://www.zhihu.com/topic/19652441)