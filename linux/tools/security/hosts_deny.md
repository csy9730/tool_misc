# linux: hosts.deny+hosts.allow

/etc/hosts.allow控制可以访问本机的IP地址，/etc/hosts.deny控制禁止访问本机的IP。如果两个文件的配置有冲突，以/etc/hosts.deny为准。



1.限制所有的ssh ,除非从218.64.87.0——127上来。 
```
hosts.deny: 
sshd:ALL 
```

```
hosts.allow: 

sshd:218.64.87.0/255.255.255.128 
```

2.封掉218.64.87.0——127的telnet 
```
# hosts.deny 
sshd:218.64.87.0/255.255.255.128 
```

3.限制所有人的TCP连接，除非从218.64.87.0——127访问 

hosts.deny 
```
ALL:ALL 
```

hosts.allow 
```
ALL:218.64.87.0/255.255.255.128 
```
4.限制218.64.87.0——127对所有服务的访问 

hosts.deny 
```
ALL:218.64.87.0/255.255.255.128 
```