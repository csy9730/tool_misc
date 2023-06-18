
### 1
echo enable-ssh-support>>~/.gnupg/gpg-agent.conf
### 2
gpg -K --with-keygrip |grep Keygrip
PEM=304CC6D7C55F86BC3E99F65EB18C164918208F77
echo $PEM >> ~/.gnupg/sshcontrol


### 3
export GPG_TTY=$(tty)
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)



export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent


sudo killall gpg-agent 
gpg-agent --daemon --enable-ssh-support  # --write-env-file ~/.gpg-agent-info 
source ~/.gpg-agent-info


unset SSH_AGENT_PID # 清除 gnome-keyring 设置的环境变量
gpg-agent --daemon &> /dev/null # 启动 gpg-agent，不会重复启动
export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)" # 设置环境变量，指定 gpg-agent 为 SSH 认证代理


### 4
导出 SSH 格式的公钥，并上传到服务器

```
gpg --export-ssh-keys 64810DE8 > ~/.ssh/gpg_subkey.pub

ssh-copy-id -i ~/.ssh/gpg_subkey.pub 
```
server:./ssh server
cat gpg_subkey.pub >> ~/.ssh/authorized_keys
复制代码



关掉 ssh-agent，启动 gpg-agent



echo enable-ssh-support >> $HOME/.gnupg/gpg-agent.conf
cat >> ~/.bashrc << EOF
unset SSH_AGENT_PID

if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then  
	export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi

export GPG_TTY=$(tty)EOF
gpg-connect-agent update startuptty /bye >/dev/null
复制代码



测试登陆 SSH

作者：winkee
链接：https://juejin.cn/post/7075615737015959566
来源：稀土掘金
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。


https://keys.openpgp.org/about/usage

这些存了大约多少公钥？
密钥服务器keys.gnupg.net
密钥服务器HKP：//subkeys.pgp.net
密钥服务器HKP：//pgp.mit.edu
密钥服务器HKP：//pool.sks-keyservers.net
密钥服务器HKP：//zimmermann.mayfirst.org
密钥服务器SKS OpenPGP Public Key ServerSKS OpenPGP Public Key Server