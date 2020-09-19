# git proxy

### 设置
下载不动可以设置代理：
``` bash
git config --global http.proxy http://127.0.0.1:1080
git config --global https.proxy https://127.0.0.1:1080
git config --global http.SSLVERIFY false

# 删除git config项目：
git config --global http.proxy ""
git config --global https.proxy ""
```

### 通过设置环境变量
windows命令行代理：
`set http_proxy=http://127.0.0.1:1080`

linux命令行代理：
`export http_proxy=192.168.8.25:1080`


 pip快速git项目安装
```
pip install git+https://github.com/xx/yy.git
pip install git+ssh://git@github.com/matherbk/django-messages.git

```