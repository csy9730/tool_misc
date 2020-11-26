# GPG入门指南（加密/签名）

![img](https://cdn2.jianshu.io/assets/default_avatar/4-3397163ecdb3855a0a4139c34a695885.jpg)

[老马的春天](https://www.jianshu.com/u/54029d1084e2)关注

0.282016.10.08 16:56:47字数 2,021阅读 24,933

> 我们平时都听过非对称加密，公钥和私钥，签名验证，但这些证书都是怎么得到的呢？本篇文章会解答这些问题。

## 背景介绍

加密的一个简单但又实用的任务就是发送加密电子邮件。多年来，为电子邮件进行加密的标准一直是PGP（Pretty Good Privacy）。程序员Phil Zimmermann特别为电子邮件的保密编写的PGP。

这个软件非常好用，迅速流传开来，成了许多程序员的必备工具。但是，它是商业软件，不能自由使用。

作为PGP的替代，如今已经有一个开放源代码的类似产品可供使用。GPG（Gnu Privacy Guard），它不包含专利算法，能够无限制的用于商业应用。

**本文将会介绍文件加密，至于GPG的其他用途，比如邮件加密，请参考这个网站https://help.ubuntu.com**

## 安装

**本人使用mac电脑，因此使用brew安装的**，很简单，打开终端，输入`brew install gpg`就行了，至于其他的平台，可以自行搜索。

```php
bogon:~ XXXX$ brew install gpg
==> Downloading https://homebrew.bintray.com/bottles/gnupg-1.4.20.el_capitan.bot
######################################################################## 100.0%
==> Pouring gnupg-1.4.20.el_capitan.bottle.tar.gz
🍺  /usr/local/Cellar/gnupg/1.4.20: 53 files, 5.4M
```

安装完成后，键入命令`gpg --help`:

```dart
bogon:~ XXXX$ gpg --help
gpg (GnuPG) 1.4.20
Copyright (C) 2015 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Home: ~/.gnupg
支持的算法：
公钥：RSA, RSA-E, RSA-S, ELG-E, DSA
对称加密：IDEA, 3DES, CAST5, BLOWFISH, AES, AES192, AES256,
               TWOFISH, CAMELLIA128, CAMELLIA192, CAMELLIA256
散列：MD5, SHA1, RIPEMD160, SHA256, SHA384, SHA512, SHA224
压缩：不压缩, ZIP, ZLIB, BZIP2

语法：gpg [选项] [文件名]
签名、检查、加密或解密
默认的操作依输入数据而定

指令：
 
 -s, --sign [文件名]        生成一份签名
     --clearsign [文件名]   生成一份明文签名
 -b, --detach-sign             生成一份分离的签名
 -e, --encrypt                 加密数据
 -c, --symmetric               仅使用对称加密
 -d, --decrypt                 解密数据(默认)
     --verify                  验证签名
     --list-keys               列出密钥
     --list-sigs               列出密钥和签名
     --check-sigs              列出并检查密钥签名
     --fingerprint             列出密钥和指纹
 -K, --list-secret-keys        列出私钥
     --gen-key                 生成一副新的密钥对
     --delete-keys             从公钥钥匙环里删除密钥
     --delete-secret-keys      从私钥钥匙环里删除密钥
     --sign-key                为某把密钥添加签名
     --lsign-key               为某把密钥添加本地签名
     --edit-key                编辑某把密钥或为其添加签名
     --gen-revoke              生成一份吊销证书
     --export                  导出密钥
     --send-keys               把密钥导出到某个公钥服务器上
     --recv-keys               从公钥服务器上导入密钥
     --search-keys             在公钥服务器上搜寻密钥
     --refresh-keys            从公钥服务器更新所有的本地密钥
     --import                  导入/合并密钥
     --card-status             打印智能卡状态
     --card-edit               更改智能卡上的数据
     --change-pin              更改智能卡的 PIN
     --update-trustdb          更新信任度数据库
     --print-md 算法 [文件]   
                               使用指定的散列算法打印报文散列值

选项：
 
 -a, --armor                   输出经 ASCII 封装
 -r, --recipient 某甲        为收件者“某甲”加密
 -u, --local-user              使用这个用户标识来签名或解密
 -z N                          设定压缩等级为 N (0 表示不压缩)
     --textmode                使用标准的文本模式
 -o, --output                  指定输出文件
 -v, --verbose                 详细模式
 -n, --dry-run                 不做任何改变
 -i, --interactive             覆盖前先询问
     --openpgp                 行为严格遵循 OpenPGP 定义
     --pgp2                    生成与 PGP 2.x 兼容的报文

(请参考在线说明以获得所有命令和选项的完整清单)

范例：

 -se -r Bob [文件名]          为 Bob 这个收件人签名及加密
 --clearsign [文件名]         做出明文签名
 --detach-sign [文件名]       做出分离式签名
 --list-keys [某甲]           显示密钥
 --fingerprint [某甲]         显示指纹

请向 <gnupg-bugs@gnu.org> 报告程序缺陷。
请向 <i18n-zh@googlegroups.com> 反映简体中文翻译的问题。
```

这些帮助信息非常有用，下边演示的很多功能也是基于上边这些参数的。这里把他们列出来，方便在使用的时候查询。

**如果能够显示上边的信息，说明GPG安装成功了**

## 生成密钥

利用上边的帮助信息中`--gen-key 生成一副新的密钥对` 可以生成密钥。
安装成功后，使用gen-ken参数生成自己的密钥。在终端中输入：

```undefined
gpg --gen-key
```

回车后，会看到：

```csharp
gpg (GnuPG) 1.4.20; Copyright (C) 2015 Free Software Foundation, Inc.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

gpg: 已创建目录‘/Users/machao/.gnupg’
gpg: 新的配置文件‘/Users/machao/.gnupg/gpg.conf’已建立
gpg: 警告：在‘/Users/machao/.gnupg/gpg.conf’里的选项于此次运行期间未被使用
gpg: 钥匙环‘/Users/machao/.gnupg/secring.gpg’已建立
gpg: 钥匙环‘/Users/machao/.gnupg/pubring.gpg’已建立
请选择您要使用的密钥种类：
   (1) RSA and RSA (default)
   (2) DSA and Elgamal
   (3) DSA (仅用于签名)
   (4) RSA (仅用于签名)
您的选择？
```

第一段是版权声明，然后让用户自己选择加密算法。默认选择第一个选项，表示加密和签名都使用RSA算法。我们输入`1`,然后回车

```undefined
RSA 密钥长度应在 1024 位与 4096 位之间。
您想要用多大的密钥尺寸？
```

这一步要让我们输入密钥长度，**长度越长越安全,默认为2048**。我们输入`2048`回车

```xml
您所要求的密钥尺寸是 2048 位              
请设定这把密钥的有效期限。
         0 = 密钥永不过期
      <n>  = 密钥在 n 天后过期
      <n>w = 密钥在 n 周后过期
      <n>m = 密钥在 n 月后过期
      <n>y = 密钥在 n 年后过期
密钥的有效期限是？(0)
```

如果密钥只是个人使用，并且你很确定可以有效保管私钥，建议选择第一个选项，即永不过期。**注意，如果想设置在2年后过期，那么应该输入2y,然后回车** 回答完上面三个问题以后，系统让你确认。

```undefined
密钥于 日 10/ 8 11:20:32 2017 CST 过期
以上正确吗？(y/n)y
```

到这里，我们对要生成的密钥的配置已经完成了，然后我们还需要一个标识，

```css
您需要一个用户标识来辨识您的密钥；本软件会用真实姓名、注释和电子邮件地址组合
成用户标识，如下所示：
    “Heinrich Heine (Der Dichter) <heinrichh@duesseldorf.de>”
```

按照要求依次输入就行了

```undefined
真实姓名：
电子邮件地址：
注释：
```

我们这里假设输入的信息为：

```css
真实姓名：Zhang San
电子邮件地址：zhangsan@163.com
注释：
```

回车后：

```css
您选定了这个用户标识：
    “Zhang San <zhangsan@163.com>”

更改姓名(N)、注释(C)、电子邮件地址(E)或确定(O)/退出(Q)？
```

我们输入`o`,回车后

```undefined
您需要一个密码来保护您的私钥。
```

然后输入密码，再次确认密码后，

```jsx
我们需要生成大量的随机字节。这个时候您可以多做些琐事(像是敲打键盘、移动
鼠标、读写硬盘之类的)，这会让随机数字发生器有更好的机会获得足够的熵数。
.+++++
...+++++
我们需要生成大量的随机字节。这个时候您可以多做些琐事(像是敲打键盘、移动
鼠标、读写硬盘之类的)，这会让随机数字发生器有更好的机会获得足够的熵数。
....................+++++
...........+++++
gpg: /Users/XXXX/.gnupg/trustdb.gpg：建立了信任度数据库
gpg: 密钥 74A64469 被标记为绝对信任
公钥和私钥已经生成并经签名。

gpg: 正在检查信任度数据库
gpg: 需要 3 份勉强信任和 1 份完全信任，PGP 信任模型
gpg: 深度：0 有效性：  1 已签名：  0 信任度：0-，0q，0n，0m，0f，1u
gpg: 下次信任度数据库检查将于 2017-10-08 进行
pub   2048R/74A64469 2016-10-08 [有效至：2017-10-08]
密钥指纹 = 2187 78CA 2E78 83C2 039C  E47B D94A 622A 74A6 5569
uid                  Zhang San <zhangsan@163.com>
sub   2048R/490E5BC8 2016-10-08 [有效至：2017-10-08]
```

请注意上面的字符串"74A64469"，这是"用户ID"的Hash字符串，可以用来替代"用户ID"。**到此为止，我们已经完成了生成公钥和私钥的任务了**,文件在`/Users/XXXX/.gnupg/pubring.gpg`。

这时，最好再生成一张"撤销证书"，以备以后密钥作废时，可以请求外部的公钥服务器撤销你的公钥。

```undefined
gpg --gen-revoke 74A64469
```

然后按照下边的步骤依次执行就行了

```ruby
sec  2048R/74A64469 2016-10-08 Zhang San <zhangsan@163.com>

要为这把密钥建立一份吊销证书吗？(y/N)y
请选择吊销的原因：                                    
  0 = 未指定原因
  1 = 密钥已泄漏
  2 = 密钥被替换
  3 = 密钥不再使用
  Q = 取消
(也许您会想要在这里选择 1)
您的决定是什么？0
请输入描述(可选)；以空白行结束：
>  
吊销原因：未指定原因
(不给定描述)
这样可以吗？ (y/N)y
                         
您需要输入密码，才能解开这个用户的私钥：“Zhang San <zhangsan@163.com>”
2048 位的 RSA 密钥，钥匙号 74A64469，建立于 2016-10-08

已强行使用 ASCII 封装过的输出。
已建立吊销证书。

请把这个文件转移到一个可隐藏起来的介质(如软盘)上；如果坏人能够取得这
份证书的话，那么他就能让您的密钥无法继续使用。把这份凭证打印出来再藏
到安全的地方也是很好的方法，以免您的保存媒体损毁而无法读取。但是千万
小心：您的机器上的打印系统可能会在打印过程中把这些数据临时在某个其他
人也能够看得到的地方！
-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v1
Comment: A revocation certificate should follow

iQEfBCABAgAJBQJX+GqQAh0AAAoJENlKYip0plVp0q8H/jDfnm8ElhgN+5dgn7uu
wrbgDMBrtFzuxqGPPlTTJLHprUQUuQBG3uMPjQCCh52fMY8DUAjlcsAcynpMYLll
2mdHPdWC7SDK/qPhZ2AGO+iJ333I3Ir4vYfjEdNetyD6ZfBpk7m1rqz3BYtBey5N
6FSrLXyaNu88ftwozqxBqRZE2b09boafX5y/UrgHpco13a8DdredSN49D0d3EwxZ
e78reDEpE4kwh4E0xAEXnX4ILDCSnTz4S8wGFV8uddB4Snyh8m+HiuDlp7h9kYw+
c5BMSgSG/DxFAdIpetfdMMVtsAMTTy+nfMvIXWNFjARSEErW5Fz0TqkFhyT3Ntxu
glE=
=ee65
-----END PGP PUBLIC KEY BLOCK-----
```

## 查看密钥列表

list-keys参数列出系统中已有的密钥

```cpp
gpg --list-keys
```

回车后：

```kotlin
/Users/XXXX/.gnupg/pubring.gpg
--------------------------------
pub   2048R/74A64469 2016-10-08 [有效至：2017-10-08]
uid                  Zhang San <zhangsan@163.com>
sub   2048R/490E5BC8 2016-10-08 [有效至：2017-10-08]
```

第一行显示公钥文件名（pubring.gpg），第二行显示公钥特征（4096位，Hash字符串和生成时间），第三行显示"用户ID"，第四行显示私钥特征。

如果你要从密钥列表中删除某个密钥，可以使用delete-key参数。

```cpp
gpg --delete-key [用户ID]
```

## 输出密钥

公钥文件（.gnupg/pubring.gpg）以二进制形式储存，armor参数可以将其转换为ASCII码显示。

```cpp
gpg --armor --output public-key.txt --export [用户ID]
```

"用户ID"指定哪个用户的公钥，output参数指定输出文件名（public-key.txt）。

类似地，export-secret-keys参数可以转换私钥。

```cpp
gpg --armor --output private-key.txt --export-secret-keys
```

打开`public-key.txt` `private-key.txt` 就能看到公钥和私钥了。

## 上传公钥

公钥服务器是网络上专门储存用户公钥的服务器。send-keys参数可以将公钥上传到服务器

```cpp
gpg --send-keys [用户ID] --keyserver hkp://subkeys.pgp.net
```

使用上面的命令，你的公钥就被传到了服务器subkeys.pgp.net，然后通过交换机制，所有的公钥服务器最终都会包含你的公钥。

由于公钥服务器没有检查机制，任何人都可以用你的名义上传公钥，所以没有办法保证服务器上的公钥的可靠性。通常，你可以在网站上公布一个公钥指纹，让其他人核对下载到的公钥是否为真。fingerprint参数生成公钥指纹。

```css
gpg --fingerprint [用户ID]
```

## 输入密钥

除了生成自己的密钥，还需要将他人的公钥或者你的其他密钥输入系统。这时可以使用import参数。

```swift
gpg --import [密钥文件]
```

为了获得他人的公钥，可以让对方直接发给你，或者到公钥服务器上寻找。

```cpp
gpg --keyserver hkp://subkeys.pgp.net --search-keys [用户ID]
```

正如前面提到的，我们无法保证服务器上的公钥是否可靠，下载后还需要用其他机制验证．

## 加密和解密

我们演示加密和解密的过程，**这个过程是对文件进行的**。假如我们有一个`test.txt`文件。这个文件中的内容为：

```undefined
张飞，我爱你，今晚约吗？

床前明月光，疑是地上霜。
举头望明月，低头思故乡。
```

encrypt参数用于加密。我们使用下边的命令对这个文件进行加密。

```css
gpg --recipient 74A64469 --output test_en.txt --encrypt test.txt
```

然后我们在`test.txt`的同一目录下得到了`test_en.txt`。我们打开后可以看到加密后的数据为：

```undefined
8501 0c03 50c4 def5 490e 5bc8 0107 f901
58c7 1221 33ee cc6c 4b43 8d5d a1f5 1a14
a5ac d406 7f24 a6bf 342c 3ba1 6f95 6d1b
8aae c45a 9a25 dece 7973 f5e0 44a0 7d43
7701 bd7b 02cc 3287 b65e 5915 3a67 2046
2d96 42c0 98fa d468 3187 f340 674a 772c
a280 7ab9 73d1 5feb 28c7 bc64 f102 e978
0ca5 ff7e ff1f a0f8 ba6a ea43 cc68 cf15
acff dfe9 fba3 7576 5c78 fc4a 8ed6 232b
6313 8246 ee38 70c2 1b0c 46fb 2064 662e
2977 79a7 64d8 81dd e55f 5b77 edb8 0a0c
caa0 9df0 4db2 a1e5 fe5f e16f 7be5 03b4
f741 d1a9 e429 d909 b94b a539 b0cc cc08
70b7 8d1f 4212 ba89 00ed fce4 ba97 6b51
8546 8bfa 1129 9862 d779 0382 bab0 ae0f
4855 bf75 82bf 743d 6b9e 4072 b47f 551d
143a 9355 67b9 dc7a 1511 4d0d 79bc d8d2
b001 f69c af7c 5cd2 6f2c 7d68 8ebc 80d8
07fb d120 fd2b 4a76 774c 8b82 e5e3 3414
de28 f947 16ff be94 ee01 ae40 8deb 6786
bf4f c602 5efb 8ae0 55f6 6cc2 55dc a6de
a8e0 0239 7de4 43b5 3344 f5fb 5e8d 9e26
0961 ddae 4f57 be79 6a1b b7fd 1f0b d510
e7ad 9c0c cc7e c75f 06d1 4da7 2ae5 a7d2
02b6 d93c 729b bf94 31dd a627 1423 1f08
db2b e6a3 a9f2 8165 bc16 8641 3430 dbaf
0885 4df6 e5cc f542 d3e6 60e2 91ae c0e7
69d7 8507 9d54 c25d 3a3d 4e63 79dd 8eaf
84
```

哈哈，如果给你一串这玩意，谁能看懂？ 这也就是为什么编译别的软件的文件的时候显示这内容了，都是进行加密过的文件，只有进行解密后才能读出数据。

recipient参数指定接收者的公钥，output参数指定加密后的文件名，encrypt参数指定源文件。运行上面的命令后，`test_en.txt`就是已加密的文件，可以把它发给对方。

使用下边的命令进行解密

```css
gpg test_en.txt
```

依次完成下边的命令：

```ruby
bogon:Desktop XXXX$ gpg test_en.txt

您需要输入密码，才能解开这个用户的私钥：“Zhang San <zhangsan@163.com>”
2048 位的 RSA 密钥，钥匙号 490E5BC8，建立于 2016-10-08 (主钥匙号 74A64469)

gpg: 由 2048 位的 RSA 密钥加密，钥匙号为 490E5BC8、生成于 2016-10-08
      “Zhang San <zhangsan@163.com>”
gpg: test_en.txt：未知的后缀名
请输入新的文件名 [test.txt]: test2.txt
```

然后在`test2.txt`中就看到了解密后的数据。

## 签名

有时，我们不需要加密文件，只需要对文件签名，表示这个文件确实是我本人发出的。sign参数用来签名。

```css
gpg --sign test.txt
```

然后生成了一个`test.txt.gpg`文件，我们打开这个文件后，发现这也是一个二进制的数据，**这并不是加密后的数据，与上边的二进制数据不一样**。如果想生成ASCII码的签名文件，可以使用clearsign参数

```css
gpg --clearsign test.txt
```

然后生成了一个`test.txt.asc`文件，打开后可以看出：

```ruby
-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


张飞，我爱你，今晚约吗？

床前明月光，疑是地上霜。
举头望明月，低头思故乡。
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJX+Jl5AAoJENlKYip0plVpDIMIAJscuAXq/+g+kBVqSAhL59jr
Lbu04uBdyYYbdqokjzSzuQm0ybw5fURQZs7HC5X2A2SgwP5vs/ekWOnS7G2SxBI4
vnrHef3+cFiEbkj4OAySNbUeY3ftbg333JFkAbyA5bD7DHlEHrUvWRWVzLEWGCJ7
FgfbpqtiyFbLbkimXgVP4GhMA+TaP3XCDa1GgI2sJY9+q0GpX7mz6CBbTz7C/ORk
GgoUFVx5tyVO8E7PHqGOcLTwwpJtsq0geGMn4QaG5qUY9j851zkVOXSVeUo3y7nY
AqRaLqHBBN7xOKs0IQLAJz/5vCEvBEjqAR59NtwA1h9JAUx20VkVO2eu+YaepjU=
=vkVW
-----END PGP SIGNATURE-----
```

如果想生成单独的签名文件，与文件内容分开存放，可以使用detach-sign参数。

```css
gpg --detach-sign test.txt
```

是一个二进制的数据，如果想采用ASCII码形式，要加上armor参数

```css
gpg --armor --detach-sign test.txt
```

## 签名+加密

上一节的参数，都是只签名不加密。如果想同时签名和加密，可以使用下面的命令。

```css
gpg --local-user [发信者ID] --recipient [接收者ID] --armor --sign --encrypt test.txt
```

local-user参数指定用发信者的私钥签名，recipient参数指定用接收者的公钥加密，armor参数表示采用ASCII码形式显示，sign参数表示需要签名，encrypt参数表示指定源文件。

## 验证签名

我们收到别人签名后的文件，需要用对方的公钥验证签名是否为真。verify参数用来验证

```css
gpg --verify test.txt.asc test.txt
```

## 说明

如果错误之处，还请给予指出。谢谢