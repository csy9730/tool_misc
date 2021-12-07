# Fcitx和ibus输入法



## Fcitx

Fcitx (Flexible Input Method Framework) ──即小企鹅输入法，它是一个以 GPL 方式发布的输入法平台,可以通过安装引擎支持多种输入法，支持简入繁出，是在 Linux 操作系统中常用的中文输入法。它的优点是，短小精悍、跟程序的兼容性比较好。 

在 Fcitx 支持的拼音输入法中，内置拼音响应速度最快。Fcitx 同样支持流行的第三方拼音输入法以提供更好的整句输入效果。

- fcitx-sunpinyin 在输入速度和输入精度之间有较好的平衡。  2016年之后就不支持了，官方已经标记为抛弃
- fcitx-libpinyin 算法比 sunpinyin 先进。
- fcitx-rime, 即著名中文输入法 Rime IME的 Fcitx 版本。但它不支持 Fcitx 本身的 #特殊符号 和 #快速输入 功能，自定义设置请参见官方，
- fcitx-googlepinyin, Google 拼音输入法 for Android。
- fcitx-sogoupinyinAUR, 搜狗输入法for linux—支持全拼、简拼、模糊音、云输入、皮肤、中英混输入。官方网址
- fcitx-cloudpinyin 可以提供云拼音输入的支持，支持 Fcitx 下的所有拼音输入法，Fcitx-rime 除外。
- fcitx-chewing 为 Fcitx 添加 chewing (繁体中文注音) 输入引擎支持。依赖 libchewing。
- fcitx-baidupinyinAUR, 百度拼音输入法的fcitx wrapper。
- fcitx-table-extra Fcitx 的一些额外码表支持，包括仓颉 3, 仓颉 5, 粤拼, 速成, 五笔, 郑码等等。

``` bash
sudo apt-get install fcitx fcitx-pinyin fcitx-googlepinyin 

```

###  ubuntu 13.10下设置使用双拼/谷歌拼音等输入法(安装fcitx)
安装fcitx-pinyin即可。


