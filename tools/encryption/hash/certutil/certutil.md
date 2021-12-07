# certutil

比如在网上下载的文件，需要校验文件完整性，查看是否遭到破坏。

Windows下shell中也集成了专门的工具用来校验文件的MD5值、SHA1值、SHA256值的：`C:\Windows\System32\certutil.exe`

``` powershell
certutil -hashfile xxx MD5
certutil -hashfile xxx SHA1
certutil -hashfile xxx SHA256
```


xxx表示将验证文件的绝对路径

``` 
E:\project>certutil -hashfile abc.log MD5
MD5 的 abcabc.log 哈希:
2a32ec634c70f3caf00e8710dad45858
CertUtil: -hashfile 命令成功完成。
```



## help

``` 

E:\project>certutil /?

动词:
  -dump             -- 转储配置信息或文件
  -dumpPFX          -- 转储 PFX 结构
  -asn              -- 分析 ASN.1 文件

  -decodehex        -- 解码十六进制编码的文件
  -decode           -- 解码 Base64 编码的文件
  -encode           -- 将文件编码为 Base64

  -deny             -- 拒绝挂起的申请
  -resubmit         -- 重新提交挂起的申请
  -setattributes    -- 为挂起申请设置属性
  -setextension     -- 为挂起申请设置扩展
  -revoke           -- 吊销证书
  -isvalid          -- 显示当前证书部署

  -getconfig        -- 获取默认配置字符串
  -ping             -- Ping Active Directory 证书服务申请接口
  -pingadmin        -- Ping Active Directory 证书服务管理接口
  -CAInfo           -- 显示 CA 信息
  -ca.cert          -- 检索 CA 的证书
  -ca.chain         -- 检索 CA 的证书链
  -GetCRL           -- 获取 CRL
  -CRL              -- 发布新的 CRL [或仅增量 CRL]
  -shutdown         -- 关闭 Active Directory 证书服务

  -installCert      -- 安装证书颁发机构证书
  -renewCert        -- 续订证书颁发机构证书

  -schema           -- 转储证书架构
  -view             -- 转储证书视图
  -db               -- 转储原始数据库
  -deleterow        -- 删除服务器数据库行

  -backup           -- 备份 Active Directory 证书服务
  -backupDB         -- 备份 Active Directory 证书服务数据库
  -backupKey        -- 备份 Active Directory 证书服务证书和私钥
  -restore          -- 还原 Active Directory 证书服务
  -restoreDB        -- 还原 Active Directory 证书服务数据库
  -restoreKey       -- 还原 Active Directory 证书服务证书和私钥
  -importPFX        -- 导入证书和私钥
  -dynamicfilelist  -- 显示动态文件列表
  -databaselocations -- 显示数据库位置
  -hashfile         -- 通过文件生成并显示加密哈希

  -store            -- 转储证书存储
  -enumstore        -- 枚举证书存储
  -addstore         -- 将证书添加到存储
  -delstore         -- 从存储删除证书
  -verifystore      -- 验证存储中的证书
  -repairstore      -- 修复密钥关联，或者更新证书属性或密钥安全描述符
  -viewstore        -- 转储证书存储
  -viewdelstore     -- 从存储删除证书
  -UI               -- 调用 CryptUI
  -attest           -- 验证密钥证明请求

  -dsPublish        -- 将证书或 CRL 发布到 Active Directory

  -ADTemplate       -- 显示 AD 模板
  -Template         -- 显示注册策略模板
  -TemplateCAs      -- 显示模板的 CA
  -CATemplates      -- 显示 CA 的模板
  -SetCASites       -- 管理 CA 的站点名称
  -enrollmentServerURL -- 显示、添加或删除与 CA 关联的注册服务器 URL
  -ADCA             -- 显示 AD CA
  -CA               -- 显示注册策略 CA
  -Policy           -- 显示注册策略
  -PolicyCache      -- 显示或删除注册策略缓存项目
  -CredStore        -- 显示、添加或删除凭据存储项目
  -InstallDefaultTemplates -- 安装默认的证书模板
  -URLCache         -- 显示或删除 URL 缓存项目
  -pulse            -- 以脉冲方式执行自动注册事件或 NGC 任务
  -MachineInfo      -- 显示 Active Directory 计算机对象信息
  -DCInfo           -- 显示域控制器信息
  -EntInfo          -- 显示企业信息
  -TCAInfo          -- 显示 CA 信息
  -SCInfo           -- 显示智能卡信息

  -SCRoots          -- 管理智能卡根证书

  -verifykeys       -- 验证公/私钥集
  -verify           -- 验证证书，CRL 或链
  -verifyCTL        -- 验证 AuthRoot 或不允许的证书 CTL
  -syncWithWU       -- 与 Windows 更新同步
  -generateSSTFromWU -- 通过 Windows 更新生成 SST
  -generatePinRulesCTL -- 生成捆绑规则 CTL
  -downloadOcsp     -- 下载 OCSP 响应并写入目录
  -generateHpkpHeader -- 使用指定文件或目录中的证书生成 HPKP 头
  -flushCache       -- 刷新选定进程(例如 lsass.exe)中的指定缓存
  -addEccCurve      -- 添加 ECC 曲线
  -deleteEccCurve   -- 删除 ECC 曲线
  -displayEccCurve  -- 显示 ECC 曲线
  -sign             -- 重新签名 CRL 或证书

  -vroot            -- 创建/删除 Web 虚拟根和文件共享
  -vocsproot        -- 创建/删除 OCSP Web Proxy 的 Web 虚拟根
  -addEnrollmentServer -- 添加注册服务器应用程序
  -deleteEnrollmentServer -- 删除注册服务器应用程序
  -addPolicyServer  -- 添加策略服务器应用程序
  -deletePolicyServer -- 删除策略服务器应用程序
  -oid              -- 显示 ObjectId 或设置显示名称
  -error            -- 显示错误代码消息文本
  -getreg           -- 显示注册表值
  -setreg           -- 设置注册表值
  -delreg           -- 删除注册表值

  -ImportKMS        -- 为密钥存档导入用户密钥和证书到服务器数据库
  -ImportCert       -- 将证书文件导入数据库
  -GetKey           -- 检索存档的私钥恢复 Blob，生成恢复脚本 或恢复存档的密钥
  -RecoverKey       -- 恢复存档的私钥
  -MergePFX         -- 合并 PFX 文件
  -ConvertEPF       -- 将 PFX 文件转换为 EPF 文件

  -add-chain        -- (-AddChain) 添加证书链
  -add-pre-chain    -- (-AddPrechain) 添加预植证书链
  -get-sth          -- (-GetSTH) 获取签名树头
  -get-sth-consistency -- (-GetSTHConsistency) 获取签名树头更改
  -get-proof-by-hash -- (-GetProofByHash) 获取哈希证明
  -get-entries      -- (-GetEntries) 获取项
  -get-roots        -- (-GetRoots) 获取根
  -get-entry-and-proof -- (-GetEntryAndProof) 获取项和证明
  -VerifyCT         -- 验证证书 SCT
  -?                -- 显示该用法消息


CertUtil -?              -- 显示动词列表(命名列表)
CertUtil -dump -?        -- 显示 "dump" 动词的帮助文本
CertUtil -v -?           -- 显示所有动词的所有帮助文本

CertUtil: -? 命令成功完成。
```



### hashfile

```
E:\project>certutil -hashfile  /?
用法:
  CertUtil [选项] -hashfile InFile [HashAlgorithm]
  通过文件生成并显示加密哈希

选项:
  -Unicode          -- 以 Unicode 编写重定向输出
  -gmt              -- 将时间显示为 GMT
  -seconds          -- 用秒和毫秒显示时间
  -v                -- 详细操作
  -privatekey       -- 显示密码和私钥数据
  -pin PIN                  -- 智能卡 PIN
  -sid WELL_KNOWN_SID_TYPE  -- 数字 SID
            22 -- 本地系统
            23 -- 本地服务
            24 -- 网络服务

哈希算法: MD2 MD4 MD5 SHA1 SHA256 SHA384 SHA512

CertUtil -?              -- 显示动词列表(命名列表)
CertUtil -hashfile -?    -- 显示 "hashfile" 动词的帮助文本
CertUtil -v -?           -- 显示所有动词的所有帮助文本
```

