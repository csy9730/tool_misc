# #!/bin/bash 和 #!/usr/bin/env bash 的区别

十甫寸木南 2020-05-18 01:21:02  2344  收藏 21  原力计划
分类专栏： Shell 文章标签： shell
版权
目录
起因
区别
`#!/bin/bash`
`#!/usr/bin/env bash`
`#!/bin/bash` 和 `#!/usr/bin/env bash` 到底该用哪个
`#!/usr/bin/env bash` 的优缺点
`#!/bin/bash` 的优缺点
到底用哪个
参考资料
## 起因
为什么会想到写 #!/bin/bash 和 #!/usr/bin/env bash 的区别呢？还要从一次装插件的过程说起。
由于刚开始接触 Shell Script 不久，对一些语法用法等还不是很熟悉，所以，当时在 IDE 上装了一些 Shell 的插件，包括 Shellcheck、Shell Process、BashSupport 等一大堆。然后呢，我的 IDE 就多了很多之前没有的功能，于是，满怀激动的我准备尝试一下。
新建一个 Shell 脚本 -> 写 Shebang、 咦？
在写 Shebang 的时候出现了一个奇怪的事，如下图：

IDE 居然给我提示了这么多！
zsh、bash、csh、ksh 这些解释器虽然有些我没用过，但是我知道它们的含义。可是，在我的印象里，Shell 脚本的 Shebang 不是应该这样写吗(以前的认知)？⬇️
#!/bin/bash or #!/bin/sh
为什么 IDE 给我的提示是这样的➡️：#!/usr/bin/env bash
这是个什么写法？我有点疑惑。
但是，虽然很疑惑，可是我当时并没有深究，而是开始试验我新装的插件了，于是，这个疑惑被压箱底了。
再次看到这个问题呢，是前几天在公众号上看到一个文章，对这个问题做出了解释，至此，我才恍然大悟。
而今天，刚好无事，也就想着把这个问题记录一下。

## 区别
`#!/bin/bash`
对于 #!/bin/bash 呢，我想大多数写过脚本的应该都知道，这是一个命令解释器的声明，通常位于脚本的第一行，同时，该行还有个专业的名字，叫做 Shebang 。(不知道 Shebang 的可以去查一下)

作为对命令解释器的声明，#!/bin/bash 声明了 bash 程序所在的位置，如下：⬇️

而有了命令解释器的位置声明，那么，当执行该脚本时，系统就知道该去哪里找这个命令解释器，也就是 Shebang 中指定的 bash 。

同理，#!/bin/sh 也是一样的，包括非 Shell 脚本，如 #!/usr/bin/python 也是同理，都是声明命令解释器的位置。

`#!/usr/bin/env bash`
对于 #!/usr/bin/env bash ，说实话，刚开始我真不知道这是个什么写法，关键是我之前没见过。
而在看了 !/usr/bin/python与#!/usr/bin/env python的区别 这篇文章后，我总算是弄明白了，具体如下：⬇️

首先，来看一下命令 env 的位置

也就是说，#!/usr/bin/env bash 确实是使用了 env 命令做了一些事！
但是，在我通常的用法中，我使用 env 都是用来查看一些环境变量的啊！难道说，env 命令还有别的用法？

查看一下 env 命令的定义及用法
我常用的一个 Linux 命令网站上对 env 是这么解释的：

env 命令用于显示系统中已存在的环境变量，以及在定义的环境中执行指令

那也就是说，env 命令后面确实可以接一些指令！
那么，bash 就是这个所谓的指令？
可是，#!/bin/bash 声明了 bash 所在位置，所以系统知道该去哪里找 bash ！
那 #!/usr/bin/env bash 呢？该语句只声明了 env 的所在位置，并没有声明 bash 的位置啊，那系统去哪里找 bash 呢？

原来，系统是去 $PATH 里找 bash 的位置了！
文章中这样提到：

当你执行 env python 时，它其实会去 env | grep PATH 里（也就是 /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin）这几个路径里去依次查找名为 python 的可执行文件。

那么，我们来看一下 $PATH 吧：⬇️

可以看到，在 $PATH 的内容中有很多的目录位置，而其中，bash 所在的 /bin 赫然在列！
所以说，#!/usr/bin/env bash 就是在 $PATH 中挨个目录依次去找 bash 的。

看到这里，对于 #!/usr/bin/env bash 我就彻底搞明白了。也就是说：⬇️

#!/bin/bash 是直接指定了应该去哪里找 bash
#!/usr/bin/env bash 则是告诉系统去 $PATH 包含的目录中挨个去找吧，先找到哪个，就用哪个
#!/bin/bash 和 #!/usr/bin/env bash 到底该用哪个
文章 !/usr/bin/python与#!/usr/bin/env python的区别 的作者认为，应该优先使用 #!/usr/bin/env bash 这种写法！

但是，我并不确定作者说的到底对不对，于是我又找了几篇文章：

Why is it better to use “#!/usr/bin/env NAME” instead of “#!/path/to/NAME” as my shebang?
What is the difference between “#!/usr/bin/env bash” and “#!/usr/bin/bash”?
这两个问答可以说写的非常全面，不仅解释了 #!/bin/bash 和 #!/usr/bin/env bash 的区别，还同时说明了应该在何种场景下使用哪种写法，并详细阐述了其原因。

下面，就对这两篇问答中提到的内容及原因做一些说明：

#!/usr/bin/env bash 的优缺点
优点

#!/usr/bin/env bash 不必在系统的特定位置查找命令解释器，为多系统间的移植提供了极大的灵活性和便利性（某些系统的一些命令解释器并不在 /bin 或 一些约定的目录下，而是一些比较奇怪的目录）
在不了解主机的环境时，#!/usr/bin/env bash 写法可以使开发工作快速地展开
缺点

#!/usr/bin/env bash 在对安全性比较看重时，该写法会出现安全隐患
#!/usr/bin/env bash 从 $PATH 中查找命令解释器所在的位置并匹配第一个找到的位置，这意味着可以伪造一个假的命令解释器（如自己写一个假的 bash），并将伪造后的命令解释器所在目录写入 PATH 环境变量中并位于靠前位置，这样，就形成了安全隐患
而 /bin 由于一般只有 root 用户才有操作权限，所以，#!/bin/bash 这种写法相对较为安全

#!/usr/bin/env 无法传递多个参数（这是由于 Shebang 解析造成的，并非 env 命令的缘故）
如：
#!/usr/bin/perl -w
#!/bin/csh -f
而如果使用 #!/usr/bin/env perl -w 这种写法的话，perl -w 会被当成一个参数，于是，根本找不到 perl -w 这个命令解释器，就会出错

某些系统 env 命令的位置也比较奇怪，这种写法会找不到 env 命令
#!/bin/bash 的优缺点
优点

准确指出所需命令解释器的位置
安全性相对较高
可以传递多个参数
缺点

移植性相对较差，很多系统的命令解释器位置不一致
一些命令解释器的位置记不住

## 到底用哪个
两个都可以
如果对安全性比较看重，使用 #!/bin/bash
如果对安全性不是很看重，但对移植性（灵活性）比较看重，使用 #!/usr/bin/env bash
看自己的意愿，喜好

## 参考资料
!/usr/bin/python与#!/usr/bin/env python的区别
What is the difference between “#!/usr/bin/env bash” and “#!/usr/bin/bash”?
Why is it better to use “#!/usr/bin/env NAME” instead of “#!/path/to/NAME” as my shebang?

