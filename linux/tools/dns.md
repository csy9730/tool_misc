# Dns


DNS协议运行在UDP协议之上，使用端口号53。在传输层TCP提供端到端可靠的服务,在UDP端提供尽力交付的服务。其控制端口作用于UDP端口53。

114.114.114.114是国内移动、电信和联通通用的DNS，解析成功率相对来说更高，国内用户使用的比较多，速度相对快、稳定，是国内用户上网常用的DNS。
8.8.8.8是GOOGLE公司提供的DNS，该地址是全球通用的，相对来说，更适合国外以及访问国外网站的用户使用。
常见的如百度提供的180.76.76.76、阿里提供的223.5.5.5和223.6.6.6

## tool

### nslookup

```
nslookup www.baidu.com


dig @8.8.8.8 http://www.cam.ac.uk A +dnssec
dig -x 123.45.67.89

```
### dig

```
root@DESKTOP-PGE4SMB:~/gd_cs# dig @8.8.4.4  www.google.com

; <<>> DiG 9.11.3-1ubuntu1.7-Ubuntu <<>> @8.8.4.4 www.google.com
; (1 server found)
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 27436
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 4, ADDITIONAL: 8

;; QUESTION SECTION:
;www.google.com.                        IN      A

;; ANSWER SECTION:
www.google.com.         600     IN      A       69.63.189.16

;; AUTHORITY SECTION:
google.com.             41794   IN      NS      ns4.google.com.
google.com.             41794   IN      NS      ns3.google.com.
google.com.             41794   IN      NS      ns2.google.com.
google.com.             41794   IN      NS      ns1.google.com.

;; ADDITIONAL SECTION:
ns3.google.com.         248334  IN      A       216.239.36.10
ns4.google.com.         42618   IN      A       216.239.38.10
ns2.google.com.         332111  IN      A       216.239.34.10
ns1.google.com.         236001  IN      A       216.239.32.10
ns3.google.com.         77163   IN      AAAA    2001:4860:4802:36::a
ns4.google.com.         44121   IN      AAAA    2001:4860:4802:38::a
ns2.google.com.         165617  IN      AAAA    2001:4860:4802:34::a
ns1.google.com.         221984  IN      AAAA    2001:4860:4802:32::a

;; Query time: 10 msec
;; SERVER: 8.8.4.4#53(8.8.4.4)
;; WHEN: Mon Apr 06 13:14:45 CST 2020
;; MSG SIZE  rcvd: 296
```
### whois
whois
当我们想要查询某个域是被谁管的，也就是注册这个域名的用户的相关信息，不过，因为这个命令输出信息较详细，为了保护用户隐私，命令输出结果不见得完全正确，仅供参考。查询命令如下