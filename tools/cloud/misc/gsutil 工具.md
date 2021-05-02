# gsutil 工具

gsutil 是一个 Python 应用，该应用可让您通过命令行访问 Cloud Storage。您可以使用 gsutil 完成各种各样的存储分区和对象管理任务，包括：

- 创建和删除存储分区。
- 上传、下载和删除对象。
- 列出存储分区和对象。
- 移动、复制和重命名对象。
- 修改对象和存储分区 ACL。

gsutil 使用 HTTPS 和传输层安全协议 (TLS) 执行所有操作，包括上传和下载。

如需查看完整的指南列表，以了解如何使用 gsutil 完成任务，请参阅 [Cloud Storage 操作指南](https://cloud.google.com/storage/docs/how-to)。

## 亲自尝试 

如果您是 Google Cloud 新手，请创建一个帐号来评估 Cloud Storage 在实际场景中的表现。新客户还可获享 $300 赠金，用于运行、测试和部署工作负载。

免费试用 Cloud Storage

## 使用入门

要开始使用 gsutil 工具，最好的方法是按照 [gsutil 快速入门](https://cloud.google.com/storage/docs/quickstart-gsutil)中的说明进行操作。此快速入门向您展示如何设置 Google Cloud 项目，启用结算，安装 gsutil 以及使用该工具运行基本命令。

如果另一个用户已经设置了 Cloud Storage 帐号，并已将您作为团队成员添加到项目中，或者您已被授予对象或存储分区的访问权限，则您能够以 [Cloud SDK](https://cloud.google.com/sdk/docs) 组件的形式获得 gsutil 并使用该工具来访问受保护的数据。您无需激活 Cloud Storage 或设置结算功能。

**注意**：建议您将 gsutil 作为 Google Cloud SDK 软件包的一部分进行下载并安装，但您也可以选择将该工具作为独立产品进行安装。如需了解详情，请参[如何安装 gsutil](https://cloud.google.com/storage/docs/gsutil_install#install)。

#### 访问公开数据

如果您只想访问公开数据，请按照[访问公开数据](https://cloud.google.com/storage/docs/access-public-data)中的说明进行操作。只需按照 **gsutil** 标签页中的步骤进行操作，您可以立即访问免费提供的、可公开访问的数据；您无需注册 Google 帐号或向 Cloud Storage 做出身份验证即可使用 gsutil 来访问这些数据。

## 用于访问资源的语法

gsutil 使用前缀 `gs://` 表示 Cloud Storage 中的资源：



```
gs://BUCKET_NAME/OBJECT_NAME
```

除了指定确切的资源外，gsutil 还支持在命令中使用[通配符](https://cloud.google.com/storage/docs/gsutil/addlhelp/WildcardNames)。

默认情况下，gsutil 通过 JSON API [请求端点](https://cloud.google.com/storage/docs/request-endpoints)访问 Cloud Storage。您可以[将此默认值更改为 XML API](https://cloud.google.com/storage/docs/gsutil/addlhelp/CloudStorageAPIs)。

## 内置帮助内容

gsutil 包含与每个命令有关的、全面的内置帮助内容以及大量主题，您可以通过运行以下命令来获取这些帮助内容：



```
gsutil help
```

此命令可输出一个列表（此列表中包含所有命令以及可用的帮助主题），然后，您可以获得与每个命令或主题有关的详细帮助信息。例如，您可以通过运行以下命令获得有关 `gsutil cp` 命令的帮助：



```
gsutil help cp
```

如需获取与 gsutil 顶级命令行选项有关的信息，请使用以下命令：



```
gsutil help options
```

要获取与 gsutil 安装有关的信息，请使用以下命令：



```
gsutil version -l
```

您也可以在线访问 gsutil 帮助页面。例如，上述命令对应的在线页面分别是 [gsutil help](https://cloud.google.com/storage/docs/gsutil/commands/help)、[gsutil cp](https://cloud.google.com/storage/docs/gsutil/commands/cp)、[gsutil options](https://cloud.google.com/storage/docs/gsutil/addlhelp/TopLevelCommandLineOptions) 和 [gsutil version](https://cloud.google.com/storage/docs/gsutil/commands/version)。

## 使用情况统计信息

在安装过程中，您可以选择跟踪使用情况统计信息，以帮助改进 gsutil 工具。如果您以后决定要停用这些使用情况统计信息，请按照相关说明进行操作：

- 如果您将 gsutil 作为 [Cloud SDK](https://cloud.google.com/sdk/docs) 的一部分进行安装，请参阅[使用情况统计信息](https://cloud.google.com/sdk/usage-statistics)。
- 如果您将 gsutil 作为独立版本进行安装，请删除文件 `/.gsutil/analytics-uuid`。

## 关于 gsutil

gsutil 是一个开源项目。如需下载 gsutil 的开发者版本或志愿帮助开发 gsutil，请访问 GitHub 上的 [gsutil 项目](https://github.com/GoogleCloudPlatform/gsutil/)。

## 后续步骤

- [安装 gsutil](https://cloud.google.com/storage/docs/gsutil_install#install)。
- 阅读[使用 gsutil 完成任务的指南](https://cloud.google.com/storage/docs/how-to)。
- 参阅 [gsutil Stack Overflow 问题](http://stackoverflow.com/questions/tagged/google-cloud-storage+gsutil)中的社区讨论。