# centos

[TOC]

* git
* python3
* zsh
* docker
* yum
* curl/wget
* go/php/nodejs/perl

```
`yum list installed`
$ sudo systemctl start docker
$ sudo systemctl enable docker # 启动并加入开机启动
```
## misc
### source

### oh-my-zsh
`sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"`
`sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"`
1其本质就是下载并执行了github上的install.sh脚本, 该脚本位于oh-my-zsh/tools/install.sh

`ZSH_THEME="random"`
~/.zshrc
disable_auto_update = true

### chrome 
``` bash
 yum install -y lsb
 yum install -y libXScrnSaver
 
 rpm -ivh google-chrome-stable_current_x86_64.rpm
 
 yum -y install  redhat-lsb
 
 cd /etc/yum.repos.d/
  vim google-chrome.repo


[google-chrome]
name=google-chrome
baseurl=http://dl.google.com/linux/chrome/rpm/stable/$basearch
enabled=1
gpgcheck=1
gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub

yum -y install google-chrome-stable
yum -y install google-chrome-stable --nogpgcheck

which google-chrome-stable
ln -s xxx /bin/chrome

exec -a "$0" "$HERE/chrome" "$@" --user-data-dir --no-sandbox
exec -a "$0" "$HERE/chrome" "$@" --user-data-dir --no-sandbox
```


### UI
``` bash
yum upgrade -y 
yum groupinstall "X Window System" 　
yum groupinstall "GNOME Desktop" "Graphical Administration Tools"
# 切换到图形界面
ln -sf /lib/systemd/system/graphical.target /etc/systemd/system/default.target #切换到命令界面
ln -sf /lib/systemd/system/multi-user.target /etc/systemd/system/default.target #
systemctl set-default graphical.target # ???

```

**Q**: Transaction check error:   file /boot/efi/EFI/centos from install of fwupdate-efi-12-5.el7.centos.x
**A**: 如何解决？


### vnc

$ yum install tigervnc-server -y