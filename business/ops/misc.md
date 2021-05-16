# misc

## info
### getOperateSystem
``` bash

uname
```
### isCentos
``` bash
# 如果是centos系统， 修改配置 
isCentos=$(lsb_release -a |grep -i Centos)
if [ "$isCentos" != ""  ] ;then
    echo "Your system is Centos"
    sed -i 's/var\/log\/auth.log/var\/log\/secure/g'  /etc/denyhosts.conf
else
    echo "Your system is ubuntu"
fi
```

## operate

### install

### apt update


### 