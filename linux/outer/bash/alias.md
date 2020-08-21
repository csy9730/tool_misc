##  [10 个实用的 Bash alias](https://linuxtoy.org/archives/10-bash-alias.html)                 


            

[alias](http://linuxtoy.org/archives/alias.html) 即“别名”，为便于理解，你可以将其看成是一个命令的快捷方式。使用 [alias](http://linuxtoy.org/archives/alias.html) 的最大好处是，可以简化输入，从而为你节省时间，并提高效率。定义的 [alias](http://linuxtoy.org/archives/alias.html) 可以保存到 ~/.bashrc 文件中，以后在命令行中就可以直接使用了。

TechRepublic 介绍了 10 个 Bash alias，个人觉得都很实用：

1. **ssh 别名** -     `alias server_name='ssh -v -l USERNAME IP ADDRESS'`，更改     server_name、USERNAME 及 IP 地址以适应你的需要。对于经常要使用 ssh     登录远程 shell 的同学来说，这是一个值得收藏的别名。
2. **ls 别名** - `alias ll='ls -l'`，另一个     `alias la='ls -a'`。意思很明显，在此就不多作解释了。
3. **rm 别名** -     `alias rm='rm -i'`，这个别名让你更加安全地执行删除操作。
4. **df 别名** - `alias df='df -h'`，让你以 MB 或 G     为单位查看磁盘的空间。
5. **Firefox 别名** - `alias ff1='/home/jlwallen/firefox/firefox'` 及     `alias ff2='/home/jlwallen/firefoxb3/firefox'`，适合使用两个 Firefox     版本的朋友，如一个稳定版，另一个为测试版。
6. **书签别名** -     `alias fftr='/home/jlwallen/firefox/firefox http://linuxtoy.org'`，用于打开一个指定的网址。
7. **文件别名** -     `alias emenu='aterm nano -e ~/.e16/menus/user_apps'`，如常常需要编辑的配置文件。
8. **apt-get update 别名** -     `alias update='sudo apt-get update'`，使用其他 Linux     发行版的同学可以换一下其中的 sudo apt-get update。
9. **rpm 批量安装别名** -     `alias brpm='rpm -ivh ~/RPM/*rpm'`，便于同时安装多个 rpm 包。
10. **长路径别名** -     `alias astart='cd ~/GNUstep/Library/AfterStep/start'`，对于需要经常访问的路径特别长的目录也可为其定义别名。
11. `alias gs="git status"` ,
`alias gcm="git commit -m "`



## misc

alias/unalias

调用命令生效的顺序

1. 第一顺位执行绝对路径或者相对路径的命令
2. 第二顺位执行别名
3. 第三顺位执行Bash的内部命令
4. 第四顺位执行按照$PATH环境变量设置定义的目录顺序的第一个命令