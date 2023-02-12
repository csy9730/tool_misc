# Gpg4win：一款适用于Windows的GPG文件和电子邮件加密软件

### Gpg4win介绍

  Gpg4win（GnuPG for Windows），是官方的GnuPG Windows分支，由GnuPG的开发者维护，支持OpenPGP和X.509加密标准，其源代码以及附带的组件都是自由软件。**Gpg4win项目的创建得到了德国联邦信息安全局的支持。**

### Gpg4win的主要组件

- GnuPG：后端，实际的加密程序
- Kleopatra：前端，GnuPG的证书管理器和GUI
- GpgEX：Windows资源管理器的shell扩展



### 下载安装Gpg4win

  从Gpg4win官网[下载最新安装包](https://www.gpg4win.org/thanks-for-download.html)。下载后打开，保持默认选项，点击下一步直到安装完成。

### 创建密钥对

  依次单击：“文件”-“新建密钥对”-“创建个人OpenPGP密钥对”，此处“名字”和“电子邮件”至少要填写一个，“高级设置”中，可以设置加密方式和密钥长度。密钥对的创建至关重要，如果你还不完全明白OpenPGP的原理，请参考[《OpenPGP（PGP/GPG）深入浅出，完全入门指南》](https://www.rmnof.com/article/openpgp-gnupg-introduction/)，**有四个问题需要格外重视**。

#### 1、使用强主密钥

  建议创建一个4096位RAS的主密钥，这是一种非常安全的做法，因为主密钥非常重要。在Gpg4win中，默认会创建一个主密钥（用于认证[C]和签名[S]）和一个子密钥（用于加密[E]），我们需要将主密钥设置为4096-bit，而用于加密的子密钥可以设置为2048-bit，之所以不使用4096-bit是考虑到对加/解密速度的影响（非常小），这里需要强调一点，2048-bit的RAS加密算法已经足够安全。如果你不用来加密大量大文件，同时又想保持舒适的安全感，那么用于加密的子密钥使用4096-bit完全可以。

[![Gpg4win创建密钥高级设置](https://static.rmnof.com/postimg/2020/05/25/gpg4win-create-openpgp-key-pair.webp)](https://static.rmnof.com/postimg/2020/05/25/gpg4win-create-openpgp-key-pair.webp)

[Gpg4win创建密钥高级设置](https://static.rmnof.com/postimg/2020/05/25/gpg4win-create-openpgp-key-pair.webp)



#### 2、设置公钥证书的有效期低于两年

  新手在创建密钥对时往往会希望密钥永不过期，这里可能存在一些误解，公钥和私钥都不会过期，我们所说的公钥过期实际上是公钥证书过期。当公钥证书过期，我们仍然可以像以前一样正常使用（加密/解密/签名），但这不是一个好主意，公钥证书过期意味着你应该重新索取、验证公钥。公钥证书有效期相当于一个DeadMan-Switch，它会在某个时间自动触发，**你可以随时更改到期时间**。如果你将公钥发布到密钥服务器，在某天你忘记密码口令或丢失私钥，那么你将无法主动从PGP密钥服务器上吊销你的公钥，唯一的补救措施是：你事先生成了**吊销证书**，或等待**公钥证书过期**！

#### 3、备份密钥

  备份密钥无需过多解释，当密钥对创建成功后，会提示你“生成您的密钥对的副本”，或创建成功后，从列表中右键密钥，选择“导出绝密密钥”。

#### 4、生成吊销证书

  生成方法：从列表中双击你的密钥，在弹出的“证书明细”窗口中点击“生成吊销证书”，保存即可。

### Gpg4win使用之“签名”与“加密”

  签名：签名是为了验证发件人的身份，以及内容的一致性（不被篡改），签名通常用于验证邮件发件人的身份，或校验下载文件的一致性（不被中间人篡改）等等。签名后，将得到一个.sig的签名文件。
  加密：加密即使用密钥对中的公钥加密、私钥解密。在邮件通信的过程中，我们使用对方的公钥加密邮件内容，对方使用自己的私钥解密。如果我们需要将自己的文件加密保存，那么就使用自己的公钥加密、自己的私钥解密。加密（或签名并加密）后将得到.gpg文件。
  在Gpg4win中签名、加密：打开Kleopatra，选择“文件”-“签名/加密…”或“签名/加密文件夹…”，也可以直接右键文件或文件夹，选择“sign and encrypt”，加密、签名可以根据需求同时使用、也可以只加密或只签名。操作示意图：

[![Gpg4win中签名与加密](https://static.rmnof.com/postimg/2020/05/25/gpg4win-sign-and-encrypt.webp)](https://static.rmnof.com/postimg/2020/05/25/gpg4win-sign-and-encrypt.webp)

[Gpg4win中签名与加密](https://static.rmnof.com/postimg/2020/05/25/gpg4win-sign-and-encrypt.webp)



  模拟一个场景来使用Gpg4win：Alice需要将一个文件加密发送给Bob，并且需要保证文件中途不被篡改：Alice和Bob首先需要互相交换公钥并导入到Gpg4win中。Alice选择签名并加密（为他人加密，选择Bob的公钥），然后将加密并签名好的.gpg文件发送给Bob。Bob在打开Alice发送的加密文件后，Gpg4win会使用Alice的公钥来验证签名，并用自己的私钥解密文件。

### 参考

- [《OpenPGP（PGP/GPG）深入浅出，完全入门指南》](https://www.rmnof.com/article/openpgp-gnupg-introduction/)
- [《OpenPGP的实践之：Windows下Thunderbird+Gpg4win+Enigmail实现邮件加密、签名》](https://www.rmnof.com/article/windows-thunderbird-gpg4win-enigmail/)
- [Gpg4win官网](https://www.gpg4win.org/index.html)
- [Kleopatra手册](https://docs.kde.org/stable5/en/pim/kleopatra/)

\#[OPENPGP](https://www.rmnof.com/tags/OpenPGP/),[御用软件](https://www.rmnof.com/tags/御用软件/),[数据加密](https://www.rmnof.com/tags/数据加密/)