# Ubuntu18.04安装googlepinyin
alango
0.204
2018.09.01 00:35:15
字数 305阅读 9,840

借鉴于Linux安装搜狗拼音和谷歌拼音输入法
## 安装前准备

在Linux下，谷歌拼音输入法需要基于Fcitx。因此，我们需要首先安装Fcitx。
一般来说，Ubuntu最新版中都默认安装了Fcitx，但是为了确保一下，我们运行如下命令：
```
$ sudo apt install fcitx
```

## 配置Fcitx

输入命令
```
$ im-config
```

im-config是Input Method Configuration的缩写

运行如下命令之后，就会开启 Input Method Configuration 窗口。

在依次出现的窗口中，依次选择OK --> Yes --> fcitx --> OK

然后重启电脑

## 安装谷歌拼音输入法

先安装googlepinyin
```
$ sudo apt install fcitx-googlepinyin
```
然后，运行如下命令
```
$ fcitx-config-gtk3
```
依次进行如下操作

- 打开Input Method Confuguration窗口；
- 点击 + 号；
- 取消勾选「 Only Show Current Language 」这个选框；
- 在搜索栏中输入 google，就会找到我们刚才安装的Google Pinyin这个输入法，选中它，点击「 OK 」，就把谷歌拼音输入法添加到当前输入法列表中了；
- 最后，用快捷键 「 Ctrl+Shift 」 切换输入法。可以看到你已经能用谷歌拼音输入法打字了；
