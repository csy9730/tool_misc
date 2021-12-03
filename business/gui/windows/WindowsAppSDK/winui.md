# Windows UI 库 (WinUI)

[https://docs.microsoft.com/zh-cn/windows/apps/winui/](https://docs.microsoft.com/zh-cn/windows/apps/winui/)

- 2021/11/18
- - [![img](https://github.com/Karl-Bridge-Microsoft.png?size=32)](https://github.com/Karl-Bridge-Microsoft)
  - [![img](https://github.com/olprod.png?size=32)](https://github.com/olprod)

此页面有帮助吗?

![WinUI 徽标](https://docs.microsoft.com/zh-cn/windows/apps/images/logo-winui.png)

Windows UI 库 (WinUI) 是适用于 Windows 桌面应用程序和 UWP 应用程序的本机用户体验 (UX) 框架。

通过将 [Fluent Design 系统](https://www.microsoft.com/design/fluent/#/)整合到所有体验、控件和样式中，WinUI 使用最新的用户界面 (UI) 模式提供一致、直观且可访问的体验。

通过对桌面应用和 UWP 应用的支持，可使用 WinUI 从头构建应用，也可以使用熟悉的语言（例如 C++、C#、Visual Basic 和 Javascript）通过[用于 Windows 的 React Native](https://microsoft.github.io/react-native-windows/) 逐步迁移现有的 MFC、WinForms 或 WPF 应用。

 重要

目前，有两代 Windows UI 库 (WinUI) 正在积极开发中：[WinUI 2](https://docs.microsoft.com/zh-cn/windows/apps/winui/winui2/) 和 WinUI 3。 虽然两者都可以在 Windows 10 及更高版本上的生产就绪应用中使用，但它们各自有不同的开发目标和发布计划。

请参阅 [WinUI 3 与 WinUI 2 的比较](https://docs.microsoft.com/zh-cn/windows/apps/winui/#comparison-of-winui-3-and-winui-2)。

## WinUI 资源

**GitHub**：WinUI 是托管在 GitHub 上的一个开源项目。 使用 [WinUI 存储库](https://github.com/microsoft/microsoft-ui-xaml)提交功能请求或 bug，与 WinUI 团队互动，并通过[路线图](https://github.com/microsoft/microsoft-ui-xaml/blob/master/docs/roadmap.md)查看该团队针对 WinUI 3 和更高版本的计划。

网站：[WinUI 网站](https://aka.ms/winui)进行了产品比较，说明了 WinUI 的各种优势并有助于为产品献计献策及与产品团队保持联系。

## WinUI 3 与 WinUI 2 的比较

下表突出显示了 WinUI 3 与 WinUI 2 之间的一些最显著的差异。

| WinUI 3                                                      | WinUI 2                                                      |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| [WinUI 3](https://docs.microsoft.com/zh-cn/windows/apps/winui/winui3/) 随 [Windows 应用 SDK](https://docs.microsoft.com/zh-cn/windows/apps/windows-app-sdk/) 提供。 | **WinUI 2** ，第 2 代 WinUI，随附于、独立 [NuGet 包](https://www.nuget.org/packages/Microsoft.UI.Xaml/)并与 [Windows 10 及更高版本 SDK](https://developer.microsoft.com/windows/downloads/windows-10-sdk/) 集成。 |
| UX 堆栈和控件库与 OS 和 [Windows 10 及更高版本 SDK](https://developer.microsoft.com/windows/downloads/windows-10-sdk/) 完全分离，包括 UX 堆栈的核心框架层、组合层和输入层。 | UX 堆栈和控件库与 OS 和 [Windows 10 及更高版本 SDK](https://developer.microsoft.com/windows/downloads/windows-10-sdk/) 紧密耦合。 |
| WinUI 3 可用于生成生产就绪的桌面/Win32 Windows 应用。        | WinUI 2 可用于 UWP 应用程序并可纳入使用 [XAML 岛](https://docs.microsoft.com/zh-cn/windows/apps/desktop/modernize/xaml-islands)的桌面应用程序（有关安装说明，请参阅 [WinUI 2 库入门](https://docs.microsoft.com/zh-cn/windows/apps/winui/winui2/getting-started)）。 |
| WinUI 3 作为 [Windows 应用 SDK](https://docs.microsoft.com/zh-cn/windows/apps/windows-app-sdk/) 框架包的组件提供，在 Windows 应用 SDK Visual Studio 扩展 (VSIX) 中随附 Visual Studio 项目模板。 | WinUI 2的一部分通过操作系统本身（UWP WinRT API 的 Windows.UI.* 系列）提供，一部分作为一个库（“Windows UI 库 2”）并在操作系统本身已包含内容的基础上附带其他控件、元素和最新样式。 对于 WinUI 2，这些功能以可下载的 NuGet 包的形式提供。 但是，UI 堆栈的其他重要部分仍内置于 OS 中，如核心 XAML 框架层、输入层和组合层。 |
| WinUI 3 支持将 C#（.NET 5 及更高版本）和 C++ 用于桌面应用。  | WinUI 2 支持 C# 和 Visual Basic (.NET Native)，还支持 C++ 应用。 |
| WinUI 3 仅在基于桌面的项目中受支持。 UWP 项目可以[将其项目类型迁移到桌面](https://docs.microsoft.com/zh-cn/windows/apps/windows-app-sdk/migrate-to-windows-app-sdk/migrate-to-windows-app-sdk-ovw)以使用 WinUI 3。 | 通过将 NuGet 包安装到新的或现有 UWP 项目中，即可将 WinUI 2 并入生产 UWP 应用。 然后，可在新应用中直接引用 WinUI 控件和样式，也可将“Windows.UI.” 命名空间引用更新为“Microsoft.UI.” 来进行引用。 |
| WinUI 3 支持基于 Chromium 的 [WebView2](https://docs.microsoft.com/zh-cn/microsoft-edge/webview2/) 控件 | WinUI 2 支持在所有设备上使用 [WebView](https://docs.microsoft.com/zh-cn/windows/uwp/design/controls-and-patterns/web-view) 控件，并且从 WinUI 2.7 预发行版开始，支持在桌面版上使用 [WebView2](https://docs.microsoft.com/zh-cn/microsoft-edge/webview2/) 控件。 将来，WebView2 控件将成为 WinUI 2.x 稳定版。 |
| WinUI 3 最低支持 Windows 10 2018 年 10 月更新（版本 1809，OS 内部版本 17763）。 | WinUI 2 最低支持 Windows 10 创意者更新（版本 1703，OS 内部版本 15063）。 |

------

## 建议的内容

- 创建 WinUI 3 项目 - Windows apps

  Visual Studio 中可用的 WinUI 3 项目和项模板的摘要。

- 使用 C++/WinRT 生成 XAML 控件 - Windows apps

  本文介绍如何使用 C++/WinRT 创建适用于 WinUI 3 的 XAML 模板化控件。

- Windows UI 库 (WinUI) 3 - Windows apps

  提供有关使用 Windows App SDK 开发 WinUI 3 和 Windows 应用的信息。