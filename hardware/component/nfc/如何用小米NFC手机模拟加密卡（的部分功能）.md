# 如何用小米NFC手机模拟加密卡（的部分功能）

[![Comzyh](https://pic1.zhimg.com/6be7bf764_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/Comzyh)

[Comzyh](https://www.zhihu.com/people/Comzyh)

计算机专业续读



660 人赞同了该文章

最近好多人问我怎么模拟校园卡，我先说下方案的局限性。

1. 非加密卡直接使用小米钱包的门卡模拟功能即可，如果能直接模拟的就不是加密卡。
2. NFC手机支持的频段一般为13.56Mhz卡片，如果是**其他门禁卡，手机贴上根本没反应的不可以模拟**。
3. 只能模拟卡片的ID，不支持储值消费等功能。**部分门禁等系统只认证卡片ID**，所以有可能通过模拟ID实现卡片的**部分功能**。

模拟的基本原理是读取加密卡的ID，将ID写入一张空白卡，然后使用小米钱包模拟这张空白卡。

物料准备

- 一张**CUID**卡，淘宝售价1-2元一张，直接搜索就可以
- NFC手机一台
- 加密卡
- MIFARE经典工具（**M**ifare **C**lassic **T**ool，MCT）

**更新**-2019/11/07: MCT 软件本身有了 "Clone UID"功能，推荐直接使用 (

[@smile](https://www.zhihu.com/people/2cc10600f89e33221d096cd8efbf57dc)

)。使用步骤：打开 Clone UID 功能 -> 贴要复制的卡-> 点击 "CALCULATE BLOCK 0 AND CLONE UID" -> 贴白卡.



![img](https://pic1.zhimg.com/80/v2-4ee78748c9e57a62cef6cf70c33b42ec_1440w.jpg)



**更新**-2019/3/23： “NFC卡模拟”软件已经可以完全自动化的实现将UID写入CUID卡的功能，而且更安全，看完文章后明白原理可以直接使用“NFC卡模拟”。

打开读卡器模式，贴要模拟的卡，弹出窗口，点“写白卡”，贴白卡。

![img](https://pic4.zhimg.com/80/v2-221b62d825a1b6a9fa6a30392465b29f_1440w.jpg)







因为CUID卡本身可以反复擦写，而且在模拟过程中仅仅作为媒介作用。所以并不需要准备多张。但是操作失误(比如写入第一扇区的时候改了不该改的字节)，可能会让CUID卡报废，卡反正便宜，也可以多买几张。

MCT的功能就是擦写CUID卡的ID，也有其他软件有此功能，可能还更简单，有机会再补充。MCT下载地址[ikarus23/MifareClassicTool](https://link.zhihu.com/?target=https%3A//github.com/ikarus23/MifareClassicTool)，下面有一个“[Download MIFARE Classic Tool (APK file)](https://link.zhihu.com/?target=http%3A//publications.icaria.de/mct/releases/)**”。**

注意，将ID写入CUID卡之后，有些时候我发现没法直接使用这张卡（刷不开门禁），但是手机模拟后手机的功能反而是正常的（可以刷开门禁），至今也不知道为什么。

步骤：

1. 打开 MCT，将要被模拟的卡片贴近手机NFC区域，可以看到弹出提示，**记下UID**

![img](https://pic3.zhimg.com/80/v2-7250750ee4fbb1733da95b6c9404fe06_1440w.jpg)

\2. 打开上图中的工具，选择BCC计算器（实际就是计算UID各个字节的XOR sum）输入刚才记下的UID，计算，得到两位BCC，**记下BCC**

![img](https://pic1.zhimg.com/80/v2-2c5a3f36cdbdeada783d425276954298_1440w.jpg)

3.退回1的界面，选择读标签，秘钥文件选std.keys(无关紧要的步骤），将**CUID空白卡**靠近NFC区域，选择“启动映射并读取标签”。

![img](https://pic2.zhimg.com/80/v2-037104e26f64deb2b6f5a5f014c26079_1440w.jpg)

注意这次读的是你的空白卡

4.读卡结束此时应该进入的是一个叫“转储编辑器”的界面，编辑扇区0，将前**10**个字符**替换**UID+BCC（UID有8位，BCC有2位），点击右上角的保存按钮，文件名随便输入一个名字（建议用加密卡的UID）点击保存。**注意千万不要乱改后面的6个字符，否则可能导致卡片失效。**

![img](https://pic3.zhimg.com/80/v2-fcccf0a0e8e5f83a662ab09d3e23a912_1440w.jpg)

\5. 退回MCT主界面，选择写标签功能，勾选“显示选项”，**勾选“高级，使能厂商块写入”（重要）**，点击“选择转储”，选择刚才存储的转储文件，点击最下面的选择转储。

![img](https://pic2.zhimg.com/80/v2-9a990b50b20d9c896f02bef908bb9501_1440w.jpg)

在选择你想写的扇区，保证0扇区被勾选，其他的无所谓。**将CUID卡贴在NFC区域**。点击“好的”。此时又会弹出选择秘钥文件的界面，选择std.keys。写入转储

![img](https://pic2.zhimg.com/80/v2-466d025ee42da243da152f2f0babb375_1440w.jpg)



\6. 写卡成功，可以再将卡贴在手机后面，看看提示的UID更改了没有。

\7. 打开小米钱包APP，选择门卡模拟，模拟这张CUID卡

编辑于 2019-11-07 11:07

NFC

小米支付（Mi Pay）

IC卡