windows10系统连接xp系统的共享文件和共享打印机时提示： 因为文件共享不安全，所以你不能连接到文件共享。此共享需要过时的SMB1协议，而此协议是不安全的，可能会使你的系统遭受攻击。你的系统需要 SMB2或更高版本。

![win10连xp打印机共享文提示 smb1协议共享不安全](https://exp-picture.cdn.bcebos.com/ce26355fd546059689a6b4633e03c8d247fe2505.jpg?x-bce-process=image%2Fresize%2Cm_lfit%2Cw_500%2Climit_1)

## 工具/原料

- 电脑

## 方法/步骤

1. 1

   点击桌面左下角的 开始菜单，在弹出的菜单中点击 设置 按钮。

   ![win10连xp打印机共享文提示 smb1协议共享不安全](https://exp-picture.cdn.bcebos.com/47bf594ec28333bf025d75fcdbb8b43ea9db1d05.jpg?x-bce-process=image%2Fresize%2Cm_lfit%2Cw_500%2Climit_1)

2. 2

   在打开的界面中点击 应用。

   ![win10连xp打印机共享文提示 smb1协议共享不安全](https://exp-picture.cdn.bcebos.com/92dd32f7dfb2dc198a9e1ba895def4dca1391005.jpg?x-bce-process=image%2Fresize%2Cm_lfit%2Cw_500%2Climit_1)

3. 3

   在打开的界面中点击 程序和功能。（以上也可以通过win10左下角的搜索框搜索 程序和功能  打开。）

   ![win10连xp打印机共享文提示 smb1协议共享不安全](https://exp-picture.cdn.bcebos.com/125ed0ecd3d96975bf76ac2ad243040149fe0905.jpg?x-bce-process=image%2Fresize%2Cm_lfit%2Cw_500%2Climit_1)

4. 4

   在打开的界面中点击 左上角的 启用或关闭windows功能 。

   ![win10连xp打印机共享文提示 smb1协议共享不安全](https://exp-picture.cdn.bcebos.com/059057299a883913b057ac5d26bcbe2f46707c05.jpg?x-bce-process=image%2Fresize%2Cm_lfit%2Cw_500%2Climit_1)

5. 5

   在打开的界面中点击 SMB1.0/CIFS文件共享支持  前面的方框，打上对号，点击确定。

   ![win10连xp打印机共享文提示 smb1协议共享不安全](https://exp-picture.cdn.bcebos.com/4759c1dae43b3b8663930fe4185653bbf9207505.jpg?x-bce-process=image%2Fresize%2Cm_lfit%2Cw_500%2Climit_1)

6. 6

   在打开的下一个界面中点击  立即重新启动（N），即可和xp系统正常共享了。

   ![win10连xp打印机共享文提示 smb1协议共享不安全](https://exp-picture.cdn.bcebos.com/03605157935653bb9d9224481d0b312104617105.jpg?x-bce-process=image%2Fresize%2Cm_lfit%2Cw_500%2Climit_1)

   END

## 注意事项

**Q**: windows各个系统下的局域网文件共享功能是否都是基于SMB，XP、7、10分别用什么版本？

**A**: 

* xp smb1
* win7 smb2
* win10smb2 smb3