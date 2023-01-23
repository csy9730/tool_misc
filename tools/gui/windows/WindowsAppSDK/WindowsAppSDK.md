# Windows App SDK

[https://docs.microsoft.com/en-us/windows/apps/windows-app-sdk/](https://docs.microsoft.com/en-us/windows/apps/windows-app-sdk/)


# Windows App SDK

- 11/17/2021
- 5 minutes to read
- - [![img](https://github.com/stevewhims.png?size=32)](https://github.com/stevewhims)
  - [![img](https://github.com/zaryaf.png?size=32)](https://github.com/zaryaf)
  - [![img](https://github.com/andrewleader.png?size=32)](https://github.com/andrewleader)
  - [![img](https://github.com/v-chmccl.png?size=32)](https://github.com/v-chmccl)
  - [![img](https://github.com/mcleanbyron.png?size=32)](https://github.com/mcleanbyron)
  - 

Is this page helpful?

The Windows App SDK is a set of new developer components and tools that represent the next evolution in the Windows app development platform. The Windows App SDK provides a unified set of APIs and tools that can be used in a consistent way by any desktop app on Windows 11 and downlevel to Windows 10, version 1809.

The Windows App SDK does not replace the Windows SDK or existing desktop Windows app types such as .NET (including Windows Forms and WPF) and desktop Win32 with C++. Instead, the Windows App SDK complements these existing tools and app types with a common set of APIs that developers can rely on across these platforms. For more details, see [Benefits of the Windows App SDK](https://docs.microsoft.com/en-us/windows/apps/windows-app-sdk/#benefits-of-the-windows-app-sdk-for-windows-developers).

## Get started with the Windows App SDK

The Windows App SDK provides extensions for Visual Studio 2019 and Visual Studio 2022. These extensions include project templates configured to use the Windows App SDK components in new projects. The Windows App SDK libraries are also available via a NuGet package that you can install in existing projects.

[Start by installing developer tools](https://docs.microsoft.com/en-us/windows/apps/windows-app-sdk/set-up-your-development-environment)

If you have already installed the required developer tools, you are ready to [create your first WinUI 3 app](https://docs.microsoft.com/en-us/windows/apps/winui/winui3/create-your-first-winui3-app) You can also [use the Windows App SDK in an existing project](https://docs.microsoft.com/en-us/windows/apps/windows-app-sdk/use-windows-app-sdk-in-existing-project).

For guidance on specific Windows App SDK versions, see [Release channels](https://docs.microsoft.com/en-us/windows/apps/windows-app-sdk/release-channels) and [Downloads](https://docs.microsoft.com/en-us/windows/apps/windows-app-sdk/downloads).

### Windows App SDK features

The following table highlights the development features that are provided by the current releases of the Windows App SDK. For more details about the release channels of the Windows App SDK that include each of these features, see [Features available by release channel](https://docs.microsoft.com/en-us/windows/apps/windows-app-sdk/release-channels#features-available-by-release-channel).

| Feature                                                      | Description                                                  |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| [WinUI 3](https://docs.microsoft.com/en-us/windows/apps/winui/) | The premiere native user interface (UI) framework for Windows desktop apps, including managed apps that use C# and .NET and native apps that use C++ with the Win32 API. WinUI 3 provides consistent, intuitive, and accessible experiences using the latest user interface (UI) patterns. |
| [Render text with DWriteCore](https://docs.microsoft.com/en-us/windows/apps/windows-app-sdk/dwritecore) | Render text using a device-independent text layout system, high quality sub-pixel Microsoft ClearType text rendering, hardware-accelerated text, multi-format text, wide language support, and much more. |
| [Manage resources with MRT Core](https://docs.microsoft.com/en-us/windows/apps/windows-app-sdk/mrtcore/mrtcore-overview) | Manage app resources such as strings and images in multiple languages, scales, and contrast variants independently of your app's logic. |
| [App lifecycle: App instancing](https://docs.microsoft.com/en-us/windows/apps/windows-app-sdk/applifecycle/applifecycle-instancing) | Control whether multiple instances of your app's process can run at the same time. |
| [App lifecycle: Rich activation](https://docs.microsoft.com/en-us/windows/apps/windows-app-sdk/applifecycle/applifecycle-rich-activation) | Process information about different kinds activations for your app. |
| [App lifecycle: Power management](https://docs.microsoft.com/en-us/windows/apps/windows-app-sdk/applifecycle/applifecycle-power) | Gain visibility into how your app affects the device's power state, and enable the app to make intelligent decisions about resource usage. |
| [Manage app windows](https://docs.microsoft.com/en-us/windows/apps/windows-app-sdk/windowing/windowing-overview) | Create and manage the windows associated with your app.      |
| [Push notifications](https://docs.microsoft.com/en-us/windows/apps/windows-app-sdk/notifications/push/) | Send rich notifications to your app using Azure App Registration identities. |
| [Deployment](https://docs.microsoft.com/en-us/windows/apps/windows-app-sdk/deployment-architecture) | Deploy Windows App SDK runtime with your unpackaged and packaged app |

### Windows App SDK release channels

The following table provides an overview of the different release channels.

| Release channel                                              | Description                                                  |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| [Stable](https://docs.microsoft.com/en-us/windows/apps/windows-app-sdk/stable-channel) | This channel is supported for use by apps in production environments. It only includes stable APIs. By default, the Windows App SDK docs focus on the Stable channel. |
| [Preview](https://docs.microsoft.com/en-us/windows/apps/windows-app-sdk/preview-channel) | This channel provides a preview of the next stable release. There may be breaking API changes between a given preview channel release and the next stable release. For documentation on using the Preview release, see [Preview and Experimental guidance](https://docs.microsoft.com/en-us/windows/apps/windows-app-sdk/preview-experimental-install). |
| [Experimental](https://docs.microsoft.com/en-us/windows/apps/windows-app-sdk/experimental-channel) | This channel includes experimental features that are in early stages of development. Experimental features may be removed from the next release, or may never be released. For documentation on using the Experimental release, see [Preview and Experimental guidance](https://docs.microsoft.com/en-us/windows/apps/windows-app-sdk/preview-experimental-install). |

For more details about the release channels of the Windows App SDK, see [Windows App SDK release channels](https://docs.microsoft.com/en-us/windows/apps/windows-app-sdk/release-channels).

## Benefits of the Windows App SDK for Windows developers

The Windows App SDK provides a broad set of Windows APIs with implementations that are decoupled from the OS and released to developers via NuGet packages. The Windows App SDK is not meant to replace the Windows SDK. The Windows SDK will continue to work as is, and there are many core components of Windows that will continue to evolve via APIs that are delivered via OS and Windows SDK releases. Developers are encouraged to adopt the Windows App SDK at their own pace.

### Unified API surface across desktop app platforms

Developers who want to create desktop Windows apps must choose between several app platforms and frameworks. Although each platform provides many features and APIs that can be used by apps that are built using other platforms, some features and APIs can only be used by specific platforms. The Windows App SDK unifies access to Windows APIs for desktop Windows 11 and Windows 10 apps. No matter which app model you choose, you will have access to the same set of Windows APIs that are available in the Windows App SDK.

Over time, we plan to make further investments in the Windows App SDK that remove more distinctions between the different app models. The Windows App SDK will include both WinRT APIs and native C APIs.

### Consistent experience across Windows versions

As the Windows APIs continue to evolve with new OS versions, developers must use techniques such as [version adaptive code](https://docs.microsoft.com/en-us/windows/uwp/debug-test-perf/version-adaptive-code) to account for all the differences in versions to reach their application audience. This can add complexity to the code and the development experience.

Windows App SDK APIs will work on Windows 11 and downlevel to Windows 10, version 1809. This means that as long as your customers are on Windows 10, version 1809, or any later version of Windows, you can use new Windows App SDK APIs and features as soon as they are released, and without having to write version adaptive code.

### Faster release cadence

New Windows APIs and features have typically been tied to OS releases that happen on a once or twice a year release cadence. The Windows App SDK will ship updates on a faster cadence, enabling you to get earlier and more rapid access to innovations in the Windows development platform as soon as they are created.

## Developer roadmap

For the latest Windows App SDK plans, see our [roadmap](https://github.com/microsoft/WindowsAppSDK/blob/main/docs/roadmap.md).

## Give feedback and contribute

We are building the Windows App SDK as an open source project. We have a lot more information on our [Github page](https://github.com/microsoft/WindowsAppSDK) about how we're building the Windows App SDK, and how you can be a part of the development process. Check out our [contributor guide](https://github.com/microsoft/WindowsAppSDK/blob/main/docs/contributor-guide.md) to ask questions, start discussions, or make feature proposals. We want to make sure that the Windows App SDK brings the biggest benefits to developers like you.

## Related topics

- [Release channels and release notes](https://docs.microsoft.com/en-us/windows/apps/windows-app-sdk/release-channels)
- [Set up your development environment](https://docs.microsoft.com/en-us/windows/apps/windows-app-sdk/set-up-your-development-environment)
- [Create a new project that uses the Windows App SDK](https://docs.microsoft.com/en-us/windows/apps/winui/winui3/create-your-first-winui3-app)
- [Use the Windows App SDK in an existing project](https://docs.microsoft.com/en-us/windows/apps/windows-app-sdk/use-windows-app-sdk-in-existing-project)
- [Deploy apps that use the Windows App SDK](https://docs.microsoft.com/en-us/windows/apps/package-and-deploy/#apps-that-use-the-windows-app-sdk)



## Feedback

Submit and view feedback for