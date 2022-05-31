# iptables


iptables命令是linux系统中在用户空间中运行的运来配置内核防火墙的工具。它可以设置，维护和检查linux内核中的ipv4包过滤规则和管理网络地址转换（NAT）。

ipatbles命令仅仅是用户空间的linux内核防火墙管理工具，真正的功能实现是由linux内核模块实现的。在配置服务器策略前必须加载相应的内核模块。在linux的2.6内核中仅支持ipatbles。

ipatbles命令仅支持ipv4，如果使用的IP协议是ipv6则需要使用专门的管理工具ip6tables。


iptables 可以管理防火墙，通过增删查改防火墙规则。
- -A 追加规则，最后适用 
- -I 插入规则，优先适用 
- -D 删除规则，规则必须完全匹配
- -L 查看所有规则 


## useage

**语法格式:**   iptables [参数]

**常用参数：**

| -t<表>       | 指定要操纵的表                                         |
| ------------ | ------------------------------------------------------ |
| -A           | 向规则链中追加条目                                     |
| -D           | 从规则链中删除条目                                     |
| -I           | 向规则链中插入条目                                     |
| -R           | 替换规则链中的相应条目                                 |
| -L           | 显示规则链中的已有条目                                 |
| -F           | 清除规则链中的现有条目。不改变规则链的默认目标策略     |
| -Z           | 清空规则链中的数据包计数器和字节计数器                 |
| -N           | 创建新的用户自定义规则链                               |
| -P           | 定义规则链中的默认目标（策略）                         |
| -h           | 显示帮助信息                                           |
| -p<协议>     | 指定要匹配的数据包的协议类型                           |
| -s<源地址>   | 指定要匹配的数据包的源IP地址                           |
| -j<目标>     | 指定要跳转的目标                                       |
| -i<网络接口> | 指定数据包进入本机的网络接口                           |
| -o<网络接口> | 指定数据包离开本机做使用的网络接口                     |
| -c<包计数>   | 在执行插入、追加和替换操作时初始化包计数器和字节计数器 |

### rule
iptables 是个包含多个规则的有序列表，单个规则可以描述 ip地址端口 是否放行。
多个规则可能相互冲突，~~排在前面的规则优先适用?~~


## demo
``` bash
# 显示内核当前的filter表：
iptables -L

iptables -L -t nat

# 显示filter表的OUTPUT链：
iptables -L OUTPUT -t filter


# 开放80，22，8080 端口
iptables -I INPUT -p tcp --dport 80 -j ACCEPT
iptables -I INPUT -p tcp --dport 22 -j ACCEPT
iptables -I INPUT -p tcp --dport 8080 -j ACCEPT

iptables -D INPUT -p tcp --dport 22 -j DROP
```


### 端口配置
 1、连续端口配置

`iptables -A INPUT -p tcp –dport 21:25 -j DROP`

注：这里是英文状态下的冒号。

2、使用multiport参数配置不连续端口

`iptables -A INPUT -p tcp -m multiport –dport 21:25,135:139 -j DROP`


## help
```
iptables --help
iptables v1.6.1

Usage: iptables -[ACD] chain rule-specification [options]
       iptables -I chain [rulenum] rule-specification [options]
       iptables -R chain rulenum rule-specification [options]
       iptables -D chain rulenum [options]
       iptables -[LS] [chain [rulenum]] [options]
       iptables -[FZ] [chain] [options]
       iptables -[NX] chain
       iptables -E old-chain-name new-chain-name
       iptables -P chain target [options]
       iptables -h (print this help information)

Commands:
Either long or short options are allowed.
  --append  -A chain		Append to chain
  --check   -C chain		Check for the existence of a rule
  --delete  -D chain		Delete matching rule from chain
  --delete  -D chain rulenum
				Delete rule rulenum (1 = first) from chain
  --insert  -I chain [rulenum]
				Insert in chain as rulenum (default 1=first)
  --replace -R chain rulenum
				Replace rule rulenum (1 = first) in chain
  --list    -L [chain [rulenum]]
				List the rules in a chain or all chains
  --list-rules -S [chain [rulenum]]
				Print the rules in a chain or all chains
  --flush   -F [chain]		Delete all rules in  chain or all chains
  --zero    -Z [chain [rulenum]]
				Zero counters in chain or all chains
  --new     -N chain		Create a new user-defined chain
  --delete-chain
            -X [chain]		Delete a user-defined chain
  --policy  -P chain target
				Change policy on chain to target
  --rename-chain
            -E old-chain new-chain
				Change chain name, (moving any references)
Options:
    --ipv4	-4		Nothing (line is ignored by ip6tables-restore)
    --ipv6	-6		Error (line is ignored by iptables-restore)
[!] --protocol	-p proto	protocol: by number or name, eg. `tcp'
[!] --source	-s address[/mask][...]
				source specification
[!] --destination -d address[/mask][...]
				destination specification
[!] --in-interface -i input name[+]
				network interface name ([+] for wildcard)
 --jump	-j target
				target for rule (may load target extension)
  --goto      -g chain
                              jump to chain with no return
  --match	-m match
				extended match (may load extension)
  --numeric	-n		numeric output of addresses and ports
[!] --out-interface -o output name[+]
				network interface name ([+] for wildcard)
  --table	-t table	table to manipulate (default: `filter')
  --verbose	-v		verbose mode
  --wait	-w [seconds]	maximum wait to acquire xtables lock before give up
  --wait-interval -W [usecs]	wait time to try to acquire xtables lock
				default is 1 second
  --line-numbers		print line numbers when listing
  --exact	-x		expand numbers (display exact values)
[!] --fragment	-f		match second or further fragments only
  --modprobe=<command>		try to insert modules using this command
  --set-counters PKTS BYTES	set the counter during insert/append
[!] --version	-V		print package version.
```


### depreciated

服务管理 


``` bash
# 保存
/etc/rc.d/init.d/iptables save

# 查看打开的端口
/etc/init.d/iptables status

# 关闭防火墙 
# 永久性生效，重启后不会复原
chkconfig iptables on # 开启
chkconfig iptables off # 关闭

# 即时生效，重启后复原
service iptables start # 开启
service iptables stop # 关闭
/etc/init.d/iptables stop 

vi /etc/sysconfig/iptables
```
