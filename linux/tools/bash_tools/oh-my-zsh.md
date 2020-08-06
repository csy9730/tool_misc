# oh-my-zsh

[oh-my-zsh](https://ohmyz.sh/#install)
相对于内核来说，Shell是Linux/Unix的一个外壳，它负责外界与Linux内核的交互，接收用户或其他应用程序的命令，然后把这些命令转化成内核能理解的语言，传给内核，内核是真正干活的，干完之后再把结果返回用户或应用程序。
简单的说，shell就是那“黑乎乎”的命令行。
Oh My Zsh只是一个对zsh命令行环境的配置包装框架，但它不提供命令行窗口，更不是一个独立的APP。

1. 安装zsh
2. 下载安装git
3. 下载oh-my-zsh脚本
4. 切换sh
5. 配置.zshrc文件并


``` bash
sudo apt-get install zsh
# sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)" 
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
chsh -s /bin/zsh  # 切换sh
source ~/.zshrc   # 切换当前主题
echo $ZSH_THEME # 查看当前主题
cat /etc/shells # 查看所有shell
```

在.zshrc文件中找到主题的配置项

Copy
``` ini
# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="ys"


```
