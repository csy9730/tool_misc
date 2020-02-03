# windows10系统

## 分类

* 功能区分：
  * Home  
  * Professional
  * Enterprise
  * Education
  * 其他功能
    * IoT
    * mobile
    * workstations
* 批量区分：
  * consumer
  * business
* 32位和64位区分
  * x86
  * x64
* 语言区分
  * en
  * cn


* windows 10 business editions
* windows 10 Home editions      
* windows 10 Professional editions 
* windows 10 education editions  
* windows 10 mobile editions    
* windows 10 IoT editions 
* windows 10 Pro for workstations   

### 功能划分
Home editions  是入门级版本，细分多种语言版本（如英文版/ 中文版）。
专业版，比家庭版有更多功能。
企业版，比专业版更多功能。
教育版：功能相当于企业版，但是多了屏幕水印？
☆LTSB版：相当于官方精简版。

Windows 10 各版本区别：
家庭版(Home)：供家庭用户使用，无法加入Active Directory和Azure AD，不允许远程链接
专业版(Professional)：供小型企业使用 在家庭版基础上增加了域账号加入、bitlocker、企业商店等功能
企业版(Enterprise)：供中大型企业使用 在专业版基础上增加了DirectAccess，AppLocker等高级企业功能
教育版(Education)：供学校使用 (学校职员, 管理人员, 老师和学生) 其功能基本和企业版的一样
LTSB版：无Edge浏览器、小娜，无磁贴，可选是否下载和安装补丁，其它版都不能自选补丁
N版：带“N”的版本相当于阉割版，移除了Windows Media Player，几乎用不到N版。
Windows 10 企业版（和教育版功能一样，功能最完整版本）

一、核心功能
①熟悉，更好用：自定义开始菜单，Windows Defender 与Windows防火墙，Hiberboot与InstantGo，系统启动更快速，TPM支持，节电模式，Windows更新
②Cortana小娜：更自然的语音和按键输入，主动、个性化建议，提醒，从网络、本地以及云中搜索，无需动手，直接喊出“你好，小娜”即可激活
③Windows Hello：指纹识别，面部和虹膜识别，企业级安全
④多任务操作：虚拟桌面，Snap协同（同一屏幕最多支持显示4个应用），跨不同显示器的Snap功能支持
⑤Microsoft Edge：阅读视图，内置墨水书写支持，整合Cortana小娜

二、企业特性
①基础功能：设备加密，加入域功能，组策略管理器，Bitlocker加密，企业模式Internet Explorer浏览器（EMIE），Assigned Access 8.1（访问分配），远程桌面，Direct Access（直接访问），Windows To Go创建工具，Applocker（应用程序锁定），BranchCache（分支缓存），可通过组策略控制的开始屏幕，
②管理部署功能：企业应用旁加载功能，移动设备管理，可加入到Azure活动目录，单点登录到云托管应用，Win10企业商店，粒度UX控制，可轻松从专业版升级到企业版
③安全：Microsoft Passport登录，企业数据保护，凭据保护，设备保护
④Windows即服务：Windows更新，Windows Update for Business，Current Branch for Business（用于企业的当前更新分支）

Windows 10 教育版

与企业板功能一致，授权方式不同，可轻松从家庭版升级到教育版，（经过测试专业版也可以通过输入教育版key升级到教育版）

Windows 10 专业版

与企业版对比【无】以下功能：
①基础功能：Direct Access（直接访问），Windows To Go创建工具，Applocker（应用程序锁定），BranchCache（分支缓存），可通过组策略控制的开始屏幕，
②管理部署功能：粒度UX控制
③安全：凭据保护，设备保护

Windows 10 家庭版
与专业版对比【无】以下功能：
①基础功能：加入域功能，组策略管理器，Bitlocker加密，企业模式Internet Explorer浏览器（EMIE），Assigned Access 8.1（访问分配），远程桌面，Direct Access（直接访问），Windows To Go创建工具，Applocker（应用程序锁定），BranchCache（分支缓存），可通过组策略控制的开始屏幕，

②管理部署功能：可加入到Azure活动目录，单点登录到云托管应用，Win10企业商店，粒度UX控制，可轻松从专业版升级到企业版

③安全：企业数据保护，凭据保护，设备保护

④Windows即服务：Windows Update for Business，Current Branch for Business（用于企业的当前更新分支）

Windows 10 企业版长期服务分支2015 LTSB

与企业版功能一致，可手动设置更新服务，无Edge浏览器，无商店


#### consumer&business

vol是 volume licensing for organizations 的简称，中文即“团体批量许可证”。根据这个许可，当企业或者政府需要大量购买一软件时可以获得优惠。这种产品的光盘的卷标都带有"vol"字样，就取"volume"前3个字母，以表明是批量。
consumer editions是 零售版本，business editions是 VOL 版本。
Consumer editions包括：家庭版、教育版、专业版；
Business editions包括：企业版、教育版、专业版
零售版系统中包含了：Home,Education,Pro（家庭版、专业版、家庭单语言、教育版、专业工作站版、专业教育版），其实就是就是之前家庭版专业版的合集
VOL版系统中包含了：Education ,Enterprise,Pro（专业版、企业版、教育版、专业工作站版、专业教育版）

* consumer editions 1909 (x86)
* consumer editions 1909 (x64)
* business editions 1909 (x64)
* business editions 1909 (x86)

business可以kms激活，consumer通过换key也能kms

这种版本根据购买数量等又细分为“开放式许可证”(open license)、“选择式许可证(select license)”、“企业协议(enterprise agreement)”、“学术教育许可证(academic volume licensing)”等5种版本，我们说的上海政府 vol 版xp就是这种批量购买的版本。而根据 vol 计划规定， vol 产品是不需要激活的(无论升级到sp1，sp2还是sp3)。

很简单的说VL就是大客户版！非VL的就是零售版。

零售版与大客户版的区别在于：
1、VL为批量授权版本，不能升级成其他版本，也就是说VL版没有windows Anytime Upgrade
2、零售版与大客户版激活方式：
mak应该不能用于激活零售版。
是永久激活，激活成功后记得备份激活信息，以备重装使用。（MAK是有激活次数限制滴）

若想用KMS方式激活，请用business_editions！！！
用大白话说，consumer可以用tb10块的key激活

VOL可以用MAK用激活或者KMS激活（180天循环一次）。。。
软件内容，功能无任何差别。授权不一样罢了。VL版可以通过KMS激活，非VL版需要密钥
以上就是Windows系统和Office的VL版本的区别了，功能上都是一样的了，就是授权方式不一样，同时用户使用时激活方法也是不同的了。
## 激活

首先用用户管理员权限打开cmd工具或powershell工具
``` bash
# 激活系统提示非核心版本的计算机上解决方法
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform]
"SkipRearm"=dword:00000001
# 重置计算机授权状态
SLMGR -REARM 

# 家庭版
slmgr.vbs -ipk PVMJN-6DFY6-9CCP6-7BKTT-D3WVR
# 安装Win10专业版激活码
slmgr.vbs -ipk NKJFK-GPHP7-G8C3J-P6JXR-HQRJR 
# 安装Win10企业版激活码
slmgr.vbs -ipk PBHCJ-Q2NYD-2PX34-T2TD6-233P  
# 激活产品密钥
slmgr.vbs -ato
# 显示许可证截止日期
slmgr /xpr
# 清空原有密钥
slmgr -upk  
# 查看slmgr帮助信息
slmgr
# 打开激活码输入对话框
slue.exe
```

0xC004F213
0xC004F069
0x803f7001
slmgr /ipk W269N-WFGWX-YVC9B-4J6C9-T83GX

### 激活码
win10系统永久激活码：

1、win10家庭版永久密钥

Win 10 Home (Core) Edition OEM版

OEM NON SLP:

[Key]：KCYRD-QNR4K-6RY36-MPQMM-F9CHG

[Key]：YNG79-9PXTP-4RDWY-67P9V-CYT3T

 

Win 10 Home(Core) Retail零售版

[Key]：2RKXW-PFNVQ-4R49T-TCQBT-3V63V

[Key]：4THMG-NFHRJ-WWQGD-CK8PM-X4R7H

 

2、win10专业版永久激活密钥

Win 10 Professional Volume:MAK批量授权版

[Key]：BXW2K-N7JJT-TK3PJ-QYY3Y-FGDGY

[Key]：TNBWH-T4GVX-QQ2VD-GWXYF-VMH3B

 

Win 10 Professional Retail零售版

[Key]：28YMN-RMKKW-4PKDK-MHVB2-XTPKG

[Key]：28TWN-9VDVQ-CKQ4M-J8BJM-XBT6T

 

3、win10企业版产品密钥

Win 10 Enterprise Volume:MAK批量授权版

[Key]：N4KHC-23X7Y-FHCDH-6F2Q4-YTDF4

[Key]：PN9QD-8RKPX-9Q2T9-WKG37-4C2JR

 

Win 10 EnterpriseS 2016 Volume:MAK ( Enterprise LTSB )长期服务分支

[Key]：JFVW7-XNC3Y-TD2M6-HFCD2-GQ8WQ

[Key]：PGDVN-GKX6K-MGJDR-CRVDV-HXPJQ

 

4、win10教育版序列号

Win 10 Education Volume:MAK批量授权版

[Key]：WQX7T-XN7BH-GY44W-BTM32-9QBM3

[Key]：QYYHN-DJB2P-7XWGC-D9BHT-WXCJD


Win 10 Education N Volume:MAK批量授权版

[Key]：VJGPC-QNQWQ-TD22C-J26V8-MTDFX

5、win10专业教育版秘钥
Win 10 Pro Education Volume:MAK批量授权版
[Key]：NHJ23-Q3MBT-9TW8K-R39KV-94T4D
Win 10 Pro Education N Volume:MAK批量授权版
[Key]：T9NFD-3RDH8-GF4RT-Q2K6F-KBVYR

