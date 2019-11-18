sudo apt install -y git vim zsh wget curl 

`sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"`
`sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"`
1其本质就是下载并执行了github上的install.sh脚本, 该脚本位于oh-my-zsh/tools/install.sh

`ZSH_THEME="random"`
~/.zshrc
disable_auto_update = true

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


$ yum install tigervnc-server -y