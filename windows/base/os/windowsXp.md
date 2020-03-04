# windowsXP


版本：
* 功能
  * Home Edition
  * Professional
* 语言
  * en
  * cn
* 版本号
  * origin
  * Service Pack 2
  * Service Pack 3


## 激活
**Q**: 如何选择系统？
**A**: 

**Q**: 如何激活VL系统？
**A**: VL版本的系统可以使用商业版密钥批量激活

**Q**: 如何激活非VL系统？
**A**: 使用网上秘钥后填进去，系统提示30天内激活。一般的方法不行，

1. 打开注册表regedit 
2. 找到主键 `Hkey_Local_Machine\Software\Microsoft\WindowsNT\CurrentVersion\WPAEvents\`
3. 删除子键lastWPAEventLoged 
4. 修改子键OOBETimer键值为：ff d5 71 d6 8b 6a 8d 6f d5 33 93 fd
5. 右击注册表中“WPAEvents”键→“权限”→“高级”→“所有者”→你的用户名→“应用”→“确定” 
6. 回到“安全”标签→“高级”→选择列表中的“system”→“编辑” 
7. 把“拒绝”列下的方框全部打勾即可 
8. “确定”退出 
9. 重启电脑发现已激活成功。

``` ini
Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\WPAEvents]
"OOBETimer"=hex:ff,d5,71,d6,8b,6a,8d,6f,d5,33,93,fd

```
 



**Q**：如何判断系统是否激活？
**A**：
只有第三个方法才是最准确的激活判断方法。
1. 在“开始菜单”→“运行”中或任意文件夹的地址栏输入`winver`,如果出现“授权给XX用户”则为正版
2. 在“我的电脑”右击→“属性”或按点击“控制面板”→“系统”或按快捷键win+Pausebreak，查看“注册到”那里的激活信息，如果显示“注册到XX用户”如下图则已经激活，如果是显示“剩余XX天试用”则为未激活
3. 在“开始菜单”→“运行”中输入“oobe/msoobe /a”（不含引号），如果显示”windows已激活“则已经激活
msoobe.exe是Windows产品激活程序，用于管理在线注册许可密钥。这个程序对你系统的正常运行是非常重要的。

## 联网
**Q**: hyperV中使用xp系统，无法联网？
**A**: 需要安装相应的补丁: vmgues.iso

## misc



**Q**: 实体机中：原生xp系统不支持SSD固态硬盘，很容易对局部磁道重复读写，毁损使用寿命
**A**: 需要安装相应的补丁

xp系统最高使用python的版本号为3.4.4

