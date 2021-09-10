# Win10大更新！Windows Sandbox沙盘功能体验

[![太平洋电脑网软件频道](https://pica.zhimg.com/v2-f3e61615c8c8205aa2fbe76632119b82_xs.jpg?source=172ae18b)](https://www.zhihu.com/org/tai-ping-yang-dian-nao-wang-ruan-jian-pin-dao)

[太平洋电脑网软件频道](https://www.zhihu.com/org/tai-ping-yang-dian-nao-wang-ruan-jian-pin-dao)



已认证的官方帐号



492 人赞同了该文章

在Windows 10的18305版本中，加上了一个小编认为最为实用的沙盒（Windows Sandbox）功能，那么这个功能是干什么用的呢？Windows Sandbox怎么用呢？我们一起来了解一下。我们还将Windows Sandbox与Sandboxie做个对比，看看两者有啥不同之处。

![img](https://pic1.zhimg.com/80/v2-a2c1b60a8ff0c73664084ad82ab62b34_720w.png)图1 这张锁屏壁纸不错

## **什么是Windows Sandbox？它有啥用？**

Windows Sandbox属于一个沙盘系统，许多人一提到沙盘，就会想到古代打仗时将领们商议战术时面前的沙盘，只是此沙盘并非彼沙盘，小编这里讲的沙盘，主要是可以帮助用户建立一个隔离的环境，以便用户在里边的所有操作都不会影响到真实系统的沙盘。

在浏览网页的时候，即使安装了杀毒软件还是免不了给某些恶意软件入侵，病毒木马随之而来，不但造成资料的损失，而且还会造成帐号被盗等等你不想发生的事件。

经常安装卸载软件？这喜好往往造成系统臃肿及混乱不堪。可不可以在安装使用这些软件的同时不影响操作系统呢？

安装程序中带有病毒，但是我要用到该程序，该怎么办呢？

破解补丁被杀毒软件报毒，怎么才能安全使用呢？

有了沙盘的帮助，以上问题就可以迎刃而解了，你可以在沙盘中随意安装软件、浏览网页，甚至激活病毒，不必担心因此影响系统稳定性与安全性了。

引用一段话：电脑就像一张纸，程序的运行与改动，就像将字写在纸上。而沙盘就相当于在纸上放了块玻璃，程序的运行与改动就像写在了那块玻璃上，除去玻璃，纸上还是一点改变都没有的。

## **Windows Sandbox如何开启？**

Windows Sandbox虽然内置在Windows 18305中，要使用却需要用户自己手动添加，具体步骤：控制面板→程序和功能→启用或关闭Windows功能→勾选Windows Sandbox，确认后安装需要重启系统。

此外，在硬件上，还需要CPU支持（ Intel 虚拟化技术 (Intel VT) 或 AMD 虚拟化 技术(AMD-V))。

![img](https://pic3.zhimg.com/80/v2-152e61f7269479a96c34b0ac2da9494a_720w.png)图2 勾选Windows Sandbox

## **体验Windows Sandbox 虚拟机类型的沙盒**

成功开启Windows Sandbox功能后，小编迫不及待的体验起来，在开始菜单中可以找到Windows Sandbox，点击后就可以开启Windows Sandbox，不过跟小编想象中不同的是，Windows Sandbox更像是虚拟机而非沙盘的样子，所以叫沙盒。Windows Sandbox的开启需要一段时间，就像虚拟机启动一样。

![img](https://pic4.zhimg.com/80/v2-4d9a2850c9996e8ea6853ea69d360b33_720w.png)图3 Windows Sandbox加载

用过虚拟机的用户都知道，虚拟机的作用可大了，用户用它可以在操作系统中建立另一个独立的系统环境，VMware就是虚拟机软件的佼佼者。Windows Sandbox也采用了虚拟机形式，里边是完全独立的一个操作系统，操作系统同样采用了Windows 10。

在小编的电脑中，Windows Sandbox的运行较为缓慢。

![img](https://pic1.zhimg.com/80/v2-1a71f6a9fb95f6be5eec766406d29f64_720w.png)图4 Windows Sandbox就像虚拟机一样

**·Windows Sandbox能干啥**

进入Windows Sandbox，你可以像日常操作那样，就像在实体系统中那样，在Windows Sandbox进行软件的安装、浏览网页等等的操作，一切就跟在实体机操作一模一样。只是在Windows Sandbox中没有应用商店（Store）无法安装Windows 10 UWP应用。不过Win10 UWP应用本身就运行中类似沙盒的App Container当中，因此不需要Sandbox也可以保证安全，如此设计也是可以理解的。

![img](https://pic3.zhimg.com/80/v2-8432542749ca7eadc3f6f8a6315afdda_720w.png)图5 可以在Windows Sandbox安装软件

![img](https://pic4.zhimg.com/80/v2-cff72ee9b3de8d987d213c0d8021678f_720w.jpg)图6 可以在Windows Sandbox浏览网页

Windows Sandbox支持全屏模式，全屏下就像真实的操作系统一样。

![img](https://pic1.zhimg.com/80/v2-d041964d04dc32ecc0843d700d345104_720w.png)图7 全屏运行Windows Sandbox

**·Windows Sandbox可以做测试**

那么，用户可以在Windows Sandbox干什么？用户可以把怀疑有问题的安装包放在Windows Sandbox里进行测试，以免危及真实系统。还可以在Windows Sandbox中浏览某些网页，避免中招。总之在Windows Sandbox这个隔离的系统中，你可以想干嘛就干嘛。

当然，如果在Windows Sandbox的系统中中了木马，虽然这个木马不会影响到真实系统，但是它能影响到Windows Sandbox的虚拟系统，你就别傻傻的在Windows Sandbox的中输入账号密码了。不过部分病毒木马在虚拟机环境下是拒绝运行的。

Windows Sandbox与实体系统的文件传输

微软的这个Windows Sandbox和真实系统共享剪贴板，用户可以通过在实体系统中复制某文件然后在Windows Sandbox中粘贴的形式来将文件传输到Windows Sandbox中，反之亦然。

**·Windows Sandbox需要特别注意的地方**

最后，最重要的是Windows Sandbox关闭后将自动清除用户的一切使用痕迹，包括所有在Windows Sandbox的资料文件，也就是在下一次开启Windows Sandbox时，是归零开始的，也就是一个全新的Windows Sandbox系统。比如，你在Windows Sandbox中下载到的资料文件，其实它是存储在Windows Sandbox虚拟系统中的，如果你没有将其手动保存出真实系统，那么在你关闭Windows Sandbox时，这些文件将丢失。

Windows Sandbox的模式也就像在VMware中先建立一个快照，然后进行一系列操作，再将系统恢复到刚刚建立的快照。也就是一切归零！

所以你在Windows Sandbox有需要保存的资料，在关闭Windows Sandbox前，需要将它们传输回实体系统中才能得到保留。

![img](https://pic3.zhimg.com/80/v2-f7dbe6685324ea39e5989e4055fa5312_720w.png)图8 温馨提示

小编之所以说Windows Sandbox跟想象的不同，那是因为它和着名的沙盘软件Sandboxie有着不小的差距，接下来我们来看看Sandboxie又是怎么样的。

## **沙盘软件中的佼佼者Sandboxie又是怎么个模样**

Sandboxie允许用户在沙盘环境中运行浏览器或其他程序。因此，在沙盘中运行的程序所产生的变化可以随时删除。可用来保护浏览网页时真实系统的安全，也可以用来清除上网、运行程序的痕迹，还可以用来测试软件，测试病毒等用途。即使在沙盘进程中下载的文件，也可以随着沙盘的清空而删除。

这和虚拟机有点相似，但是却不相同。因为虚拟机是在真实的系统中建立一个完全虚拟的另一个操作系统（比如在windows 中虚拟Linux）。与虚拟机不同之处在于，sangboxie并不需要虚拟整个计算机，它只根据现有系统虚拟一个环境让指定程序运行在其中，因此，若你的真实系统是windows 10的，则在sandboxie中运行的程序也是在windows10环境中运行的，也可以直接访问你硬盘上的现有文件，只是相关的变动是在虚拟环境中进行了。这样，比较节约系统资源，对计算机配置要求较低。这也是Windows Sandbox与Sandboxie不同之处。

![img](https://pic2.zhimg.com/80/v2-74c090110d841814739b755befd11fbd_720w.jpg)图9 官方原理图

安装完毕，Sandboxie会有个引导教程，让用户学会基本操作。在Sandboxie中用户可以建立多个互不影响的沙盘环境。

![img](https://pic2.zhimg.com/80/v2-48ab31f52ae8f053d1fe778beebf1889_720w.jpg)图10 引导教程

![img](https://pic4.zhimg.com/80/v2-5d21b27c19974a02295d014293214773_720w.jpg)图11 引导教程

然后用户就可以在实体系统的任意程序中的右键菜单找到“在沙盘中运行”选项，通过这个功能，用户就可以快速的将指定程序放入沙盘中运行，放入沙盘中运行的程序处于隔离状态，所有操作不会影响到实体系统。

![img](https://pic4.zhimg.com/80/v2-73cff7c3e997396a0ed71af5ae22ae57_720w.jpg)图12 快捷将程序纳入沙盘运行

如果用户要保留沙盘里的文件，比如用户用Sandboxie运行了Chrome浏览器，并且在Chrome中下载了文件，该下载的文件不会保留在实体系统的同一目录下而是保存在沙盘的虚拟系统中，要将它保存到实体系统中需要用户手动进行。

![img](https://pic3.zhimg.com/80/v2-6df8259dcf02955bac35089c17d1759a_720w.jpg)图13 提示用户保存文件到实体系统

使用Sandboxie运行的程序，即使是属于病毒木马，也不会因此而导致实体系统中毒，因为它是属于完全隔离的环境。

在Sandboxie运行的程序，在激活时四周会有黄色描边以及标题栏自动添加[#] [#]，以便用户区分程序是否在Sandboxie中运行。

![img](https://pic2.zhimg.com/80/v2-0b1fd06be1c53c512309402513d7de61_720w.jpg)图14 区分标志

![img](https://pic2.zhimg.com/80/v2-e957e910976a7520a03d7b4fcfbd6891_720w.png)图15 黄色描边


对比Windows Sandbox、Sandboxie两者，我们可以知道：

Sandboxie有着性能较高，运行方便的优势，可是它不是免费的。

Windows Sandbox则有着完全虚拟、免费的优势，可是它的性能较低——起码在小编电脑中有点慢。

## **总结**

Windows Sandbox功能的加入，让用户可以有个独立的隔离系统环境，在该环境下可以完全不用担心病毒木马入侵到真实系统中，有疑问、有危险的操作进Windows Sandbox来进行操作，安全可靠。目前Windows Sandbox在使用便利性和性能方面，和Sandboxie尚有差距，作为一个原生系统功能这似乎不太应该？不知道在下一个Windows 10正式版中Windows Sandbox会不会有所改进并正式加入系统当中呢？　　

发布于 2019-01-02

Windows 10

Microsoft Windows

微软（Microsoft）

赞同 492