# NTLM

[https://docs.microsoft.com/zh-cn/windows-server/security/kerberos/ntlm-overview](https://docs.microsoft.com/zh-cn/windows-server/security/kerberos/ntlm-overview)

## 功能描述

NTLM 身份验证是 Windows Msv1_0.dll 中包括的一系列身份验证协议。 NTLM 身份验证协议包括 LAN Manager 版本 1 和 2 以及 NTLM 版本 1 和 2。 NTLM 身份验证协议根据一种证明是服务器或域控制器的挑战/响应机制对用户和计算机进行身份验证，用户要知道该服务器和域控制器的与帐户关联的密码。 在使用 NTLM 协议时，每当需要新的访问令牌时，资源服务器必须执行以下操作之一来验证计算机或用户的身份：

- 如果计算机或用户的帐户是域帐户，请联系域控制器的部门域认证服务来获取该帐户的域。
- 如果该计算机或用户的帐户是本地帐户，请在本地帐户数据库中查找该帐户。