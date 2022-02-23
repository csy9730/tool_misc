# 新增Windows 10 休眠选项，最省电的回到原始桌面环境方式

2019/07/03 23:47 by [老猫iqmore](https://iqmore.tw/author/iqmore)





分享本篇文章至社群( Share This )：

[Facebook](https://iqmore.tw/#facebook)[Line](https://iqmore.tw/#line)[Messenger](https://iqmore.tw/#facebook_messenger)[Twitter](https://iqmore.tw/#twitter)[Email](https://iqmore.tw/#email)[WeChat](https://iqmore.tw/#wechat)[Reddit](https://iqmore.tw/#reddit)[WhatsApp](https://iqmore.tw/#whatsapp)[Copy Link](https://iqmore.tw/#copy_link)[分享](https://www.addtoany.com/share#url=https%3A%2F%2Fiqmore.tw%2Fadd-hibernate-to-windows-10-start-menu&title=新增 Windows 10 休眠選項，最省電的回到原始桌面環境方式)

大家使用完电脑后会习惯关机呢？还是睡眠？目前在**Windwows 10**的电源选项中，只有「**睡眠**」、「**关机**」、「**重新启动**」这3项选择，其实预设少了「**休眠**」选项。如果有休眠的需求，可以[手动将休眠功能开启](https://iqmore.tw/add-hibernate-to-windows-10-start-menu)。本篇老猫分享**「关机」、「睡眠」、「休眠」差异性**后，再分享3种开启「**Windows休眠**」选项，提供有需要的使用者使用。

![img](https://i0.wp.com/img.iqmore.com/iqmoreidv_img/Special_Topic/2019/Windows-skill/add_hibernate_to_Windows_10_start_menu/01.JPG?w=810&ssl=1)



**目录Contents** [隐藏hide](https://iqmore.tw/add-hibernate-to-windows-10-start-menu#) 

[1. Windows 电脑睡眠与休眠差别在哪？](https://iqmore.tw/add-hibernate-to-windows-10-start-menu#Windows-電腦-睡眠-與-休眠-差別在哪？)

[2. 方法一：直接右键直接开启电源选项](https://iqmore.tw/add-hibernate-to-windows-10-start-menu#方法一：直接右鍵直接開啟電源選項)

[3. 方法二：从设定右键直接开启电源选项](https://iqmore.tw/add-hibernate-to-windows-10-start-menu#方法二：從設定右鍵直接開啟電源選項)

[4. 方法三：使用命令提示字元](https://iqmore.tw/add-hibernate-to-windows-10-start-menu#方法三：使用命令提示字元)

## **Windows电脑睡眠与休眠差别在哪？**

以下老猫先针对**「关机」、「睡眠」、「休眠」**介绍一下其差异性：

- **关机(Shut Down)**：关机后电力完全中断，在重新开机后，都是全新的状态，不会任储存任何状态。
- **睡眠(Sleep)**：睡眠之后会让电脑以极低的耗电方式，储存当前的所有桌面状态。当下次开机时会用最短的速度，回到使用者睡眠的使用桌面。
- **休眠(Hibernate)**：休眠之后会将桌面所有的状态写入至储存设备内，并完全中断电源。当使用者开启电脑时，会回到使用者先前使用的所有状态，不过在开机的过程中，会比睡眠还慢。

从以上的差异性可以了解，睡眠有点像我们在操作手机时，按下电源键后会关闭萤幕，当我们再按下电源键开启萤幕时，萤幕会回到手机关萤幕前的所有状态。而在关萤幕的过程中，电池会持续输出来保持这些环境状态存在。但若当关机后再开机，所有的程式都是需要重新开启，属于全新的状态。以上这2项用手机来辅助解释，应该会更容易理解。

▼ 如果将滑鼠游标移到这些选项旁，会显示其相关功能。
![img](https://i0.wp.com/img.iqmore.com/iqmoreidv_img/Special_Topic/2019/Windows-skill/add_hibernate_to_Windows_10_start_menu/15.JPG?w=810&ssl=1)

若是**休眠**的话，主要是针对笔记电脑使用，会将所有桌面状态储存起来后，写入到硬碟内再关闭所有电源。因此当开启电源后，会需要一些时间来回到之前状态。不过对于现在多数是以**SSD固态硬碟**设计的电脑来说，速度已经比以往传统硬碟快上许多，因此这部分的时间不会相差太多。只是在实用性来说，对于会同时开启许多视窗的使用者来说，当下一次想要开机后又保留原始状态，不想重新再一一开启这些程式的话，休眠会是最佳选择。或许睡眠也能解决这些问题，但最大的差异性在于耗电量的多寡。像老猫随身都会携带笔电带着走，如果处处都有电源可以充电的话，平常都会是使用睡眠。但有时在外可能电力不够，**若担心下一个地点还是可能没电源的情况下，采用休眠会是最好的方法**。对于有时会出差到处使用电脑的老猫来说，休眠真的是不错的选择！

▼ 在**Windows 10**的预设选项中，已经拿掉休眠选项，但这部分是可以透过手动来开启。
![img](https://i0.wp.com/img.iqmore.com/iqmoreidv_img/Special_Topic/2019/Windows-skill/add_hibernate_to_Windows_10_start_menu/02.JPG?w=810&ssl=1)

不过老猫特别提醒一下，当执行休眠时，会需要一段时间将桌面的设定值写入到硬碟中，因此不会马上关闭硬碟。若你使用的笔记型电脑是传统硬碟的话，还是请他完成休眠后，再将笔电带着走。否则如果移动到正在写入的传统硬碟电脑，很容易造成电脑硬碟坏轨，资料反而容易不见。这部分在使用的习惯来说，要非常小心。以下3种方法，老猫是以**Windows 10**来进行示范分享，基本上可以符合多数使用者进行操作设定。

## **方法一：直接右键直接开启电源选项**

直接将滑鼠游标移到左下角的**Windows符号**上，点选右键开启功能选单，点击「**电源选项**」，就会开启「**电源与睡眠**」；。接下来点选下方「相关设定」的「**其他电源设定**」，就会开启控制台的电源选项。在「电源选项」页面中，左侧有「选择按下电源按钮时的行为」、「选择盖上萤幕时的行为」，随便选一项即可。在该选项之中，先点选上方的「**变更目前无法使用的设定**」后，就会发现下方的「关机设定」选项中就能开放勾选。此时将「**休眠**」打勾后，再按下储存变更。接下来，在关机的页面中，就能顺利出现休眠的选项。



▼ 滑鼠游标移到左下方的Windows符号，点选右键开出选单，再点击「**电源选项**」。
![img](https://i0.wp.com/img.iqmore.com/iqmoreidv_img/Special_Topic/2019/Windows-skill/add_hibernate_to_Windows_10_start_menu/03.JPG?w=810&ssl=1)

▼ 接下来点击下方的「其他电源设定」。
![img](https://i0.wp.com/img.iqmore.com/iqmoreidv_img/Special_Topic/2019/Windows-skill/add_hibernate_to_Windows_10_start_menu/04.JPG?w=810&ssl=1)

▼ 左侧的「选择按下电源按钮时的行为」、「选择盖上萤幕时的行为」，随意选择点入。
![img](https://i0.wp.com/img.iqmore.com/iqmoreidv_img/Special_Topic/2019/Windows-skill/add_hibernate_to_Windows_10_start_menu/05.JPG?w=810&ssl=1)

▼ 以刚刚的第一项为例，可以看到下方的休眠是灰色，无法勾选。此时，请点选上方的「变更目前无法使用的设定」。
![img](https://i0.wp.com/img.iqmore.com/iqmoreidv_img/Special_Topic/2019/Windows-skill/add_hibernate_to_Windows_10_start_menu/06.JPG?w=810&ssl=1)

▼ 现在就可以将下方的休眠勾选起来。
![img](https://i0.wp.com/img.iqmore.com/iqmoreidv_img/Special_Topic/2019/Windows-skill/add_hibernate_to_Windows_10_start_menu/07.JPG?w=810&ssl=1)

▼ 最后在Windows的电源选项中，就有出现休眠的选项，已经顺利设定成功。
![img](https://i0.wp.com/img.iqmore.com/iqmoreidv_img/Special_Topic/2019/Windows-skill/add_hibernate_to_Windows_10_start_menu/08.JPG?w=810&ssl=1)

## **方法二：从设定右键直接开启电源选项**

其实这是方法一的比较详细的路径方法，直接从电脑的「**设定**」选单来操作。由于新版的Windows系统将「**控制台**」的使用率降低，Windows后面这几个版本要开启控制台，已经越来越不方便。完全以「[设定](https://iqmore.tw/tag/設定)」页面操作为主，因此老猫就不以开启控制台为主要动作。如果要开启设定的话，可以用滑鼠左键点选电脑萤幕左下角的Windows选单，点击**齿轮**的「**设定**」。或者点电脑萤幕右下角的通知视窗，当开启侧边栏功能后，点选下方的「**设定**」。当进入设定后，再从 **设定→ 系统→ 电源与睡眠**，就能进入到方法一的页面，接下来请**参考方法一**即可完成。

▼ 这种方式是按照原始的设定路径来进行操作，可以从左下方或者右下方，都能开启「**设定**」页面。
![img](https://i0.wp.com/img.iqmore.com/iqmoreidv_img/Special_Topic/2019/Windows-skill/add_hibernate_to_Windows_10_start_menu/09.JPG?w=810&ssl=1)

![img](https://i0.wp.com/img.iqmore.com/iqmoreidv_img/Special_Topic/2019/Windows-skill/add_hibernate_to_Windows_10_start_menu/10.JPG?w=810&ssl=1)

▼ 在「[Windows](https://iqmore.tw/tag/windows) [设定](https://iqmore.tw/tag/設定)」页面中，点选「系统」。
![img](https://i0.wp.com/img.iqmore.com/iqmoreidv_img/Special_Topic/2019/Windows-skill/add_hibernate_to_Windows_10_start_menu/11.JPG?w=810&ssl=1)

▼ 在「系统」页面中，点选左侧的「电源与睡眠」，之后的操作就与方法一相同。
![img](https://i0.wp.com/img.iqmore.com/iqmoreidv_img/Special_Topic/2019/Windows-skill/add_hibernate_to_Windows_10_start_menu/12.JPG?w=810&ssl=1)

## **方法三：使用命令提示字元**

基本上使用方法一、方法二就能顺利成功，但若有看到微软页面的：[如何在执行Windows 的电脑上停用及重新启用休眠](https://support.microsoft.com/zh-hk/help/920730/how-to-disable-and-re-enable-hibernation-on-a-computer-that-is-running)。会看到是使用以系统管理员身分执行「**命令提示字元**」来进行设定，透过「powercfg.exe /hibernate on」或「powercfg.exe /hibernate off」来进行切换。，但实际上是会遇到问题，若是在关机设定的「休眠」选项没有打勾的话，透过此方法也无法成功显示。但若已经将休眠选项打勾，才可以透过指令方式决定让电源选项要不要显示休眠。但这样的操作反而有点复杂，因此老猫建议还是以方法一、方法二为主即可。

▼ 从「Windows符号」开启程式列，选择W字母下的「Windows系统」→「命令提示字元」，使用滑鼠右键开启选单，再透过滑鼠左键点选「以系统管理员身分执行」。
![img](https://i0.wp.com/img.iqmore.com/iqmoreidv_img/Special_Topic/2019/Windows-skill/add_hibernate_to_Windows_10_start_menu/13.JPG?w=810&ssl=1)

▼ 接下来就能透过「powercfg.exe /hibernate on」或「powercfg.exe /hibernate off」来开启与关闭，不过如同老猫文中所提，主要还是以方法一、方法二的操作设定最佳。
![img](https://i0.wp.com/img.iqmore.com/iqmoreidv_img/Special_Topic/2019/Windows-skill/add_hibernate_to_Windows_10_start_menu/14.JPG?w=810&ssl=1)



分享本篇文章至社群( Share This )