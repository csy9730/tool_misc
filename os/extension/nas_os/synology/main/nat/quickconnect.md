# nat

## quickconnect

[http://quickconnect.to/(quickconnectID)](http://quickconnect.to/quickconnectID)

QuickConnect 允许客户端应用程序通过 Internet 连接到 Synology NAS，而无需设置端口转发规则。QuickConnect 可以与其它 Synology 开发的套件搭配使用，如 Audio Station、Video Station、Download Station、Surveillance Station、Photo Station、File Station、Note Station、CMS、Cloud Station 和移动设备应用程序。

#### 若要启用 QuickConnect：

1. 请进入**控制面板** > **QuickConnect** > **常规**。
2. 勾选**启用 QuickConnect**。
3. 输入现有 Synology 帐户信息或注册新帐户。
4. 指定一个新的、好记的 QuickConnect ID，这样您就可以随时访问您的 Synology NAS。
5. 单击**应用**。

#### 注：

自定义 QuickConnect ID 可包含英文字母、数字和连字符 (-)，且开头必须为字母。

#### 若要提高 QuickConnect 连接性：

您的 Synology NAS 提供了高级选项以使 QuickConnect 访问更适应不同的网络环境。

1. 请进入**控制面板** > **QuickConnect** > **高级**。
2. 选择以下选项以适合您的需求：
   - **启用 QuickConnect 中继服务**：如果无法在当前网络环境下无法访问 Synology NAS，则您的 QuickConnect 连接将通过 Synology 中继服务器。
   - **自动创建端口转送规则**：当您的 Synology NAS 在已启用 UPnP 的路由器下时，路由器将收到通知为 QuickConnect 创建端口转送规则。
3. 单击**应用**。

#### 注：

- 中继的 QuickConnect 连接可能较慢，因为网络延迟较长。
- 当允许路由器为 QuickConnect 创建端口转送规则时，Synology NAS 可能有安全风险。

#### 若要为特定应用程序/服务启用/禁用 QuickConnect：

1. 请进入**控制面板** > **QuickConnect** > **高级**。
2. 选择您要为其启用 QuickConnect 的应用程序/服务。
3. 单击**应用**。

#### 注：

为使 QuickConnect 有更好的性能，建议您进入**控制面板** > **外部访问** > **路由器配置**中为各项服务配置端口转送规则：

- DSM：5000 (HTTP)；5001 (HTTPS)
- Photo Station：80 (HTTP)；443 (HTTPS)
- Cloud Station：6690

#### 疑难解答

如果您看到**发生网络错误**信息，表示 QuickConnect 服务因网络错误而中止。请检查以下内容：

- 您的 Synology NAS 连接到活动网络 (在**控制面板** > **网络** > **网络接口**)。
- 已适当配置 DNS 服务器和默认网关设置 (在**控制面板** > **网络** > **常规**)。
- 确认 Synology NAS 可通过以下目标端口访问 Internet： 80, 443, 8888.

网络错误修复后，QuickConnect 服务会在数分钟内自动恢复。
## other

### zerotier

### frp