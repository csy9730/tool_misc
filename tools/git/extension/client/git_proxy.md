# git proxy

### 设置

git下载不动, 可以设置http代理：
``` bash
git config --global http.proxy http://127.0.0.1:1080
git config --global https.proxy https://127.0.0.1:1080

# ?
git config --global http.SSLVERIFY false

# 删除git config项目：
git config --global http.proxy ""
git config --global https.proxy ""
```

git bash 中配置socks5
``` bash
# 设置代理

git config --global http.proxy 'socks5://127.0.0.1:1080'
git config --global https.proxy 'socks5://127.0.0.1:1080'
 

# 取消代理

git config --global --unset http.proxy
git config --global --unset https.proxy
```

还有针对 github.com 的单独配置：
``` bash
# 只对github.com
git config --global http.https://github.com.proxy socks5://127.0.0.1:1080

# 取消代理
git config --global --unset http.https://github.com.proxy
```


### 通过设置环境变量

linux命令行代理：
`export http_proxy=192.168.8.25:1080`

linux命令行设置 socks5代理：
```
export http_proxy="socks5://127.0.0.1:1086"
export https_proxy="socks5://127.0.0.1:1086"
```

设置快捷开启 proxy的自定义命令，在 .bashrc 或 .zshrc 中设置如下内容：
```
alias setproxy="export ALL_PROXY=socks5://127.0.0.1:1080"
alias unsetproxy="unset ALL_PROXY"
```


curl 支持 socks5，wget(v1.20 mingw32) 不支持 socks5.


windows命令行代理：
`set http_proxy=http://127.0.0.1:1080`

### misc
 pip快速git项目安装
```
pip install git+https://github.com/xx/yy.git
pip install git+ssh://git@github.com/matherbk/django-messages.git

```