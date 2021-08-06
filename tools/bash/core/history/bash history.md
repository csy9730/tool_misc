# bash history



该文档适用于 bash，也适用于git bash_windows，msys，wsl。



bashrc

``` bash
HISTSIZE=2000
HISTFILESIZE=10000

# 显示时间
export HISTTIMEFORMAT='%F %T '

# 命令过滤器
export HISTIGNORE="ls:dir"

```



```bash
sed -i 's/HISTSIZE=1000/HISTSIZE=10000/g' /etc/profile
echo $HISTSIZE

echo "PROMPT_COMMAND='history -a'" >> ~/.bash_profi
echo "PROMPT_COMMAND='history -a'" >> ~/.bashrc
```









## 关键文件

- .bash_history bash历史记录文件
- bashrc 初始化文件？





C:\Program Files\Git\etc\bash.bashrc
~/.bashrc 
D:\greensoftware\Git-2.20.1-64-bit\etc\bash.bashrc
E:\msys64\etc\bash.bashrc
E:\msys64\home\admin\.bashrc

alias gs="git status"
alias gcm="git commit -m"





### my bashrc

``` bash
alias gs="git status"
alias gcm="git commit -m"

PROMPT_COMMAND='history -a'

HISTSIZE=2000
HISTFILESIZE=10000

# 显示时间
export HISTTIMEFORMAT='%F %T '

# 命令过滤器
export HISTIGNORE="ls:dir"
```

