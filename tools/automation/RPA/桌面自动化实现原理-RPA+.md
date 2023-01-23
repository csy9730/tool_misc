# 桌面自动化实现原理-RPA+

[![RPAPlus](https://pic1.zhimg.com/v2-9c5fa928e77912905f30e72151ce855d_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/rpaplus)

[RPAPlus](https://www.zhihu.com/people/rpaplus)

RPA专家

创作声明：内容包含虚构创作

<svg class="Zi Zi--ArrowDown css-zzd7cz-Label" fill="rgba(23, 81, 153, 0.72)" viewBox="0 0 24 24" width="26" height="26"><path d="M12 13L8.285 9.218a.758.758 0 0 0-1.064 0 .738.738 0 0 0 0 1.052l4.249 4.512a.758.758 0 0 0 1.064 0l4.246-4.512a.738.738 0 0 0 0-1.052.757.757 0 0 0-1.063 0L12.002 13z" fill-rule="evenodd"></path></svg>

16 人赞同了该文章

RPA产品实现自动化从类型上大致可以分为桌面应用/浏览器应用/其它（Mainframe/Java等），本文将分析RPA或者自动化类工具实现桌面应用自动化的原理。

不管使用什么技术来执行自动化至少都得包含如下几个要素：

- - **找**



找元素、控件、输入框、等等想找的内容

- - **读**



读取文本，状态，位置，是否勾选等等

- - **控**



单击、双击、输入内容、下拉等操作属于控制的范畴



![img](https://pic3.zhimg.com/80/v2-5127fffb66051691a27965620c136bde_1440w.jpg)



### **Win32API:**

Windows API是微软在Windows操作系统中提供的一套核心应用程序编程接口(API)。

Windows API (Win32)主要关注于编程语言C，因为其公开的函数和数据结构在其文档的最新版本中都是用该语言描述的。但是，任何能够处理低级数据结构以及为调用和回调指定的调用约定的编程语言编译器或汇编程序都可以使用该API。类似地，API函数的内部实现历史上是用几种语言开发的。尽管C语言不是面向对象的编程语言，但Windows API和Windows在历史上都被描述为面向对象的。还有许多面向对象语言的包装器类和扩展，它们使这个面向对象的结构更加显式(Microsoft Foundation Class Library (MFC)、Visual Component Library (VCL)、GDI+等)。例如，Windows 8提供了Windows API和WinRT API，这些API是用c++实现的，设计上是面向对象的。

无论是MFC，VCL还是VB6，Win32 SDK 都是其根本，最终打交道的其实都是HWND和Windows Message。

【本文以Windows 10 ,系统自带 calc.exe（计算器程序举例）】



![img](https://pic2.zhimg.com/80/v2-ce6c08be4b4bdfa4b4baa5391d8c6bc9_1440w.jpg)



Spy++获取的信息非常有限

**Spy++ 下载：** **Windows Spy++ (下载2)**

使用最新框架开发计算器应用，Spy++ 仅仅可以识别计算器窗体最基础的名称，位置，HWND等信息，无法识别更细节的每一个按钮，Win32API无法完全自动化这类应用。



![img](https://pic2.zhimg.com/80/v2-4e3d575de42113d97b331ddd0929a3e9_1440w.jpg)



Spy++获取的有用信息很少，查找信息麻烦

Spy++工具提取了上百个各类窗体信息，导致查找效率低，比较适合一些较老的应用，在与MSAA和UIA搭配使用时可以获得不错的效果。

Win32API可以操作底层的OS接口，用来处理模拟键盘鼠标，特殊的一些窗体时有奇效。



![img](https://pic1.zhimg.com/80/v2-97e0632cdc890cb70f0d8322810ed9a8_1440w.jpg)



BluePrism Win Mode获取的信息与Spy++一致

BluePrism可以手动切换Win32/AA/UIA的拾取方式。

基于Win32API有一款非常知名的自动化工具 AutoIT

[https://www.autoitscript.com/site/](https://link.zhihu.com/?target=https%3A//www.autoitscript.com/site/)

AutoIt v3是一种类似于Basic的免费软件脚本语言，用于自动化Windows GUI和通用脚本。它使用模拟击键、鼠标移动和窗口/控制操作的组合，以一种其他语言(例如VBScript和SendKeys)不可能或不可靠的方式自动化任务。AutoIt也非常小，自包含，可以运行在所有版本的Windows开箱即用，不需要烦人的“运行时”!

**【 Win32API缺点：】**

- 使用复杂，实现成本高。Win32 API的使用上有很多需要特别注意的细节， 比如有的Win32 API不能跨进程工作，有的Windows Message只能发给当前线程所创建的窗口，稍有不慎，就导致自动化程序不稳定。
- 过于底层，不便使用。为了方便调用，往往需要对API进行封装，增加了实现成本。例如Win32查询窗体方法，内置方法FindWindow 和 FindWindowEx需要逐层获取HWND，逐层查找，在嵌套多层的UI程序面前显特别不方便。于是就需要自己封装一些实用的方法和类

def find_idxSubHandle(pHandle, winClass, index=0):
“””
已知子窗口的窗体类名
寻找第index号个同类型的兄弟窗口
“””
assert type(index) == int and index >= 0
handle = win32gui.FindWindowEx(pHandle, 0, winClass, None)
while index > 0:
handle = win32gui.FindWindowEx(pHandle, handle, winClass, None)
index -= 1
return handle

def find_subHandle(pHandle, winClassList):
“””
递归寻找子窗口的句柄
pHandle是祖父窗口的句柄
winClassList是各个子窗口的class列表，父辈的list-index小于子辈
“””
assert type(winClassList) == list
if len(winClassList) == 1:
return find_idxSubHandle(pHandle, winClassList[0][0], winClassList[0][1])
else:
pHandle = find_idxSubHandle(pHandle, winClassList[0][0], winClassList[0][1])
return find_subHandle(pHandle, winClassList[1:])

- 不同的开发工具，比如MFC， VCL，以及.NET Framework，在内部实现上对Win32 API有很多细节的处理。例如， .NET 中的WinForm Control对Win32 HWND的维护是动态的，同一个WinForm Control的HWND在程序的生命周期内是可能发生改变的，这一点对于依赖HWND作为唯一标识的Win32 API就是一个致命伤。
- 无法识别许多新框架窗体内容。例如这次举例的计算器程序，使得Win32 API对于这类应用基本没什么用武之地。

### **MSAA:**

Microsoft Active Accessibility (MSAA)是一个用于用户界面可访问性的应用程序编程接口(API)。MSAA是在1997年作为Microsoft Windows 95的附加平台引入的。MSAA旨在帮助辅助技术(AT)产品与应用程序(或操作系统)的标准和自定义用户界面(UI)元素进行交互，以及访问、标识和操作应用程序的UI元素。AT产品与MSAA支持的应用程序一起工作，以便为有身体或认知困难、缺陷或残疾的个人提供更好的访问。AT产品的一些例子是为视力有限的用户提供的屏幕阅读器，为身体接触有限的用户提供的屏幕键盘，或为听力有限的用户提供的旁白器。MSAA还可以用于自动化测试工具和基于计算机的培训应用程序。



![img](https://pic2.zhimg.com/80/v2-6de0021813cd89e68b6a774ed82d2719_1440w.jpg)



MSAA的最新规范可以在Microsoft UI自动化社区承诺规范中找到。



![img](https://pic2.zhimg.com/80/v2-586a4f3d66f33a42c389d1f033d0d7a1_1440w.jpg)



AccExplorer 识别数字9

**AccExplorer 2 下载** **AccExplorer32 (下载2)**

AccExplorer工具识别的响应速度非常快，但是忽略了许多对自动化很重要的属性参数例如：AumationId , Control Type 等，所以实际应用中是蛮不方便的。

MSAA拾取方式可以适配的Window 桌面应用类型是非常广泛的，尽管UIA会继承MSAA，只是当下MSAA可以搞定自动化元素场景还是挺丰富的。



![img](https://pic3.zhimg.com/80/v2-ffcd268a52254c1416fb3da584d58916_1440w.jpg)



Uibot以默认方式识别数字9

MSAA方式识别计算器按键9 ，

“数字键盘” 的Control Type: 50026

“九”的Control Type :50000

其他各项指标也都可以一一对应。

由此可以确定Uibot默认识别Window应用窗体方式为MSAA， 将”Control Type”属性的名称修改为了 “cid”

Uibot使用MSAA对元素的识别和影响速度非常快，优化的应该挺好的。

**【 MSAA缺点：】**

- MSAA基于COM技术， 但IAccessible并不是一个COM标准接口。比如使用者不需要调用CoInitialize即可使用，也无法通过QueryInterface进一步获取更多的自定义接口。这局限了MSAA所能提供的功能。
- IAccessible接口的定义有缺陷。里面不少方法是可有可无的，但是又缺少一些支持UI自动化的关键方法。比如它提供了accSelect支持控件的选取，但是却没有类似accExpand这样的方法支持树状控件的展开等。
- 复杂窗体元素定位效率低

### **UIA:**

Microsoft UI Automation (UIA)是一个应用程序编程接口(API)，它允许访问、标识和操作另一个应用程序的用户界面(UI)元素。UIA的目标是提供UI可访问性，它是Microsoft Active Accessibility的继承者。它还促进了GUI测试自动化，并且它是许多测试自动化工具所基于的引擎。许多RPA工具也使用它来自动化业务流程中的桌面应用程序。

UIAutomation是微软从Windows Vista开始推出的一套全新UI自动化测试技术， 简称UIA。在最新的Windows SDK中，UIA和MSAA等其它支持UI自动化技术的组件放在一起发布，叫做Windows Automation API。UIA的属性提供程序同时支持Win32和.net程序。



![img](https://pic4.zhimg.com/80/v2-5bd0795753ef7fed6cbda4df61496ddf_1440w.jpg)





![img](https://pic4.zhimg.com/80/v2-338f4f5d54ad0d9fb43bdd0c838d1cd7_1440w.jpg)



Uipath默认方式拾取按键9

阅读UiPath拾取器Selector属性即可发现，Uipath通过UIA的拾取方式提取了上图内容。



![img](https://pic3.zhimg.com/80/v2-0054b90b76522902a8905f557ff0adba_1440w.jpg)



RPAPlus SPY+可以清晰展示树状结构，UIA属性

【UIA应用举例2-微信桌面版】



![img](https://pic4.zhimg.com/80/v2-8bf237c2e2482202aa9debee4ced5cbb_1440w.jpg)



Uipath拾取微信桌面版-整个窗体高亮

是不是微信桌面版无法拾取呢？其实不是

通过RPAPlus-SPY+扫描后分析，马上可以找到原因



![img](https://pic1.zhimg.com/80/v2-4516421a3031b65aa35ede507f992798_1440w.jpg)



微信桌面版-在窗体表面添加了一个popupshadow



![img](https://pic3.zhimg.com/80/v2-db048a633a51cb07a1c76bbcc7c800f6_1440w.jpg)



微信桌面版在程序表面添加了一层类似阴影或者蒙版的窗体，用来阻隔UIA识别工具的侦察。（高~~~）

**【 UIA VS MSAA：】来自微软官方文档**

**基本设计原则：**

MSAA和UIA是两种不同的技术，但它们的基本设计原则是相似的。这两种技术的目的都是公开有关Windows应用程序中使用的UI元素的丰富信息。易访问性工具的开发人员可以使用这些信息来创建软件，使在Windows上运行的应用程序更容易被有视觉、听觉或运动障碍的人访问。

MSAA和UIA都将UI对象模型公开为层次树，以桌面为根。MSAA将单个UI元素表示为可访问的对象，而UI Automation将它们表示为自动化元素。两者都将可访问性工具或软件自动化程序作为客户端。然而，MSAA将提供可访问性UI的应用程序或控件称为服务器，而UI Automation将其称为提供者。

**属性和控制模式：**

Microsoft Active Accessibility提供了一个带有固定的小属性集的组件对象模型(COM)接口。UIA提供了一组更丰富的属性，以及一组称为控制模式的扩展接口，以Microsoft Active Accessibility所不能的方式操作可访问的对象。

**MSAA角色和UI自动化控制模式：**

微软在Windows 95发布的同时设计了Microsoft Active Accessibility object模型。该模型基于十年前定义的“角色”，不能支持新的UI行为，也不能将两个或多个角色合并在一起。例如，没有文本对象模型来帮助辅助技术处理复杂的web内容。UIA通过引入使对象支持多个角色的控制模式克服了这些限制，UIA文本控制模式提供了成熟的文本对象模型。

**对象模型导航：**

Microsoft Active Accessibility的另一个限制是在对象模型中导航。Microsoft Active Accessibility将UI表示为可访问对象的层次结构。客户端使用可访问对象提供的接口和方法从一个可访问对象导航到另一个可访问对象。服务器可以使用IAccessible接口的属性或标准IEnumVARIANT COM接口公开可访问对象的子对象。但是，客户端必须能够为任何服务器处理这两种方法。这种模糊性意味着客户端实现者要做额外的工作，而服务器实现者要做破碎的可访问对象模型。

UIA将UI表示为自动化元素的层次结构树，并提供用于导航树的单个接口。客户端可以通过限定作用域和筛选来定制树中元素的视图。

**对象模型的可扩展性：**

如果不破坏或更改IAccessible COM接口规范，Microsoft Active Accessibility属性和函数就不能进行扩展。结果是，新的控制行为不能通过对象模型公开;它往往是静态的。

通过UIA，当创建新的UI元素时，应用程序开发人员可以引入自定义属性、控制模式和事件来描述新元素。

**从MSAA过渡：**

Windows自动化API框架提供了从Microsoft Active Accessibility server到UIA提供者的转换支持。IAccessibleEx接口支持将特定的UIA属性和控制模式添加到遗留的Microsoft Active Accessibility服务器，而不需要重写整个实现。IAccessibleEx接口还允许进程内Microsoft Active Accessibility客户端直接访问UIA提供程序接口，而不是通过UIA客户端接口。

**选择MSAA、UIA或IAccessibleEx：**

如果您正在开发一个新的应用程序或控件，Microsoft建议使用UIA。尽管Microsoft Active Accessibility在短期内更容易实现，但是该技术固有的局限性，例如其老化的对象模型和无法支持新的UI行为或合并角色，使其在长期内更加困难和昂贵。在引入新的控制时，这些限制变得尤为明显。

UIA对象模型比Microsoft Active Accessibility模型更易于使用，也更灵活。UIA元素反映了用户界面的演变，开发人员可以定义自定义UIA控制模式、属性和事件。

对于超出流程的客户端，Microsoft Active Accessibility往往运行缓慢。为了提高性能，可访问性工具程序的开发人员经常选择在目标应用程序过程中挂入并运行他们的程序:这是一种极其困难和危险的方法。UIA对于进程外的客户端来说更容易实现，并且提供了更好的性能和可靠性。

**【 简单总结UIA优势：】**

- 适应不同类型的UI程序，包括Win32、WinForm、 WPF、QT、Silverlight。由于WPF和Silverlight中的子窗口和控件并不是传统的HWND，所以Win32 API和MSAA无能为力。而UIA可以直接支持这两种程序。
- UIA兼容传统的Win32和MSAA模式。前面提到过，UIA技术的内部实现可以多样化。
- UIA对于进程外的客户端来说更容易实现。
- UIA可以引入自定义属性、控制模式和事件来描述新元素。
- UIA提供完善的工具、文档、开发包、例子程序等。

以上是处理桌面自动化最标准最靠谱的技术实现方式，然而除了标准方法之外，还可以扩展更多选项：

【基于坐标】/【基于颜色】/【基于CV】 为桌面自动化增加了更多可能和无限想象，最后的结果想必是只要人能操作的，机器人也一定能操作。

在所有自动化技术方案中基于【基于坐标】可能是最不可能的，最主要的原因是缺少了文章开头提到的**”找、读、控“**三要素之一的读，导致自动化流程的准确性降低，成熟的智能自动化工程师应该尽量避免使用基于坐标的方法。

今后我们也会对其它类型的自动化，网页自动化，做更多更深入的分享。

包含：Chrome/IE自动化，Java Access Bridge支持下的自动化/Mainframe Emulator自动化 等等。

服务号文章后续无法实时更新，但官网的这篇文章后续会随着时间的推移，修改和补充更多内容进去。

► [RPA是什么？你们公司部署的可能只是桌面自动化](https://link.zhihu.com/?target=http%3A//mp.weixin.qq.com/s%3F__biz%3DMzI2NjE2NjQ0Ng%3D%3D%26mid%3D2247484985%26idx%3D1%26sn%3D3e2f92894bfacc44b317cecdf9ea546e%26chksm%3Dea930ff8dde486ee0f37947f9a0297f99d0c55212933911aa4f2fe06f25ba2fb1bcccd614ce0%26scene%3D21%23wechat_redirect)[► 2019年全球TOP 几大RPA厂商商业数据分析](https://link.zhihu.com/?target=http%3A//mp.weixin.qq.com/s%3F__biz%3DMzI2NjE2NjQ0Ng%3D%3D%26mid%3D2247484973%26idx%3D1%26sn%3Dfe02470a568d352a294bcbcfeb896fff%26chksm%3Dea930fecdde486fa8d9feee8eb1594ad2b8a9eeef2bdefbca1164b340a30785cc77f7c04f9bd%26scene%3D21%23wechat_redirect)►[【RPA vs BPA】RPA与BPA的区别](https://link.zhihu.com/?target=http%3A//mp.weixin.qq.com/s%3F__biz%3DMzI2NjE2NjQ0Ng%3D%3D%26mid%3D2247484973%26idx%3D3%26sn%3Da979e947fc1c34ba2ca48b09a7bd48dc%26chksm%3Dea930fecdde486fab451e4da5fe0c0b2ae8993a6cb442bd74b3506aa63a0c98ba52804084c0a%26scene%3D21%23wechat_redirect)[► 几款不错的RPA开源软件分享[RPA Plus\]](https://link.zhihu.com/?target=http%3A//mp.weixin.qq.com/s%3F__biz%3DMzI2NjE2NjQ0Ng%3D%3D%26mid%3D2247484934%26idx%3D1%26sn%3Dd7d105996c81ac9af8a5567a6db799aa%26chksm%3Dea930fc7dde486d137d60d0a013db9d2f7390c0b3876da95a47ef8b0f17857fbab6fa40bd17b%26scene%3D21%23wechat_redirect)[► 企业有关于未来工作的路线计划图吗？](https://link.zhihu.com/?target=http%3A//mp.weixin.qq.com/s%3F__biz%3DMzI2NjE2NjQ0Ng%3D%3D%26mid%3D2247484922%26idx%3D1%26sn%3D45980e02f8a45b3a244c328449926a8e%26chksm%3Dea930c3bdde4852d9b1d9fbbcd3f547d94c550b5b03e001a44a5622e3142fde407b317b1dded%26scene%3D21%23wechat_redirect)► [免费入驻-RPA产品在中国页面](https://link.zhihu.com/?target=http%3A//mp.weixin.qq.com/s%3F__biz%3DMzI2NjE2NjQ0Ng%3D%3D%26mid%3D2247484922%26idx%3D2%26sn%3Df75f77fc0b0eae2bd6ffb381aa65c15b%26chksm%3Dea930c3bdde4852d3eb8d19bc4033d51c3451b74d864c3a474f60575cb1ee315707faa898385%26scene%3D21%23wechat_redirect)[► RPA新宣言：流程自动化机器人的十大定律](https://link.zhihu.com/?target=http%3A//mp.weixin.qq.com/s%3F__biz%3DMzI2NjE2NjQ0Ng%3D%3D%26mid%3D2247484906%26idx%3D1%26sn%3D77e037189670113c71d3d2f12e8db734%26chksm%3Dea930c2bdde4853dffa2679bde8e1f79b9eca989ea01a08682ab5f7a351ed088163fecaabaf9%26scene%3D21%23wechat_redirect)► [Uipath 收发消息 R-Connect范例（官网可下载）](https://link.zhihu.com/?target=http%3A//mp.weixin.qq.com/s%3F__biz%3DMzI2NjE2NjQ0Ng%3D%3D%26mid%3D2247484885%26idx%3D2%26sn%3Da8204304393d84a7797c71cabaf8ea39%26chksm%3Dea930c14dde48502bb59a24f8198204806dc688754764cd5d1b1e2870afe1e0696d9d6d3b1a0%26scene%3D21%23wechat_redirect)► [RPA开发利器，R-Connect 人机交互解决方案](https://link.zhihu.com/?target=http%3A//mp.weixin.qq.com/s%3F__biz%3DMzI2NjE2NjQ0Ng%3D%3D%26mid%3D2247484869%26idx%3D1%26sn%3Df8ca698b65961b07ddd4751cfd5035a8%26chksm%3Dea930c04dde4851273925de36ff491dfdecc98686d3758dde47532288888c9ab0ef6732600e6%26scene%3D21%23wechat_redirect)► [搜索引擎机器人-可下载](https://link.zhihu.com/?target=http%3A//mp.weixin.qq.com/s%3F__biz%3DMzI2NjE2NjQ0Ng%3D%3D%26mid%3D2247484858%26idx%3D1%26sn%3D0d38c3ddb6a762dde723580659bcfa8d%26chksm%3Dea930c7bdde4856d8a7c9bdc9a707f06ba294fc368dd4861cf99e9cb302874916e6412c59343%26scene%3D21%23wechat_redirect)► [RPA的门槛真的很低吗?](https://link.zhihu.com/?target=http%3A//mp.weixin.qq.com/s%3F__biz%3DMzI2NjE2NjQ0Ng%3D%3D%26mid%3D2247484846%26idx%3D1%26sn%3D07014323bba52b1e29b1525603fc88df%26chksm%3Dea930c6fdde48579ac341a438e02365a11b786cf73242cf3f89def934bb8668c87ef2f81d448%26scene%3D21%23wechat_redirect)► [RPAPlus 2020合作计划](https://link.zhihu.com/?target=http%3A//mp.weixin.qq.com/s%3F__biz%3DMzI2NjE2NjQ0Ng%3D%3D%26mid%3D2247484832%26idx%3D1%26sn%3De467abaf2020dece71c8274643bfa867%26chksm%3Dea930c61dde4857730d80841429968034a04a5522eb705253689f0fe2c830e45402e626c12c4%26scene%3D21%23wechat_redirect)[► 突破RPA的障碍和最佳实践 RPA Plus](https://link.zhihu.com/?target=http%3A//mp.weixin.qq.com/s%3F__biz%3DMzI2NjE2NjQ0Ng%3D%3D%26mid%3D2247484807%26idx%3D1%26sn%3D8aa2b6d8ffa70978b4d0467b836d3f62%26chksm%3Dea930c46dde4855060731681882481fe0063827c136eea070913dc3c906a45b0a73ce1f47c08%26scene%3D21%23wechat_redirect)► [国产RPA软件横评报告](https://link.zhihu.com/?target=http%3A//mp.weixin.qq.com/s%3F__biz%3DMzI2NjE2NjQ0Ng%3D%3D%26mid%3D2247484754%26idx%3D1%26sn%3Da8ca9aed797d41a461153d8294bfef9c%26chksm%3Dea930c93dde48585e3fb603a8a23786c3ea0cdacf00e40d9ec3b907874531489409b47c2669e%26scene%3D21%23wechat_redirect)

发布于 2020-05-15 09:56

RPA（机器人流程自动化）

自动化

人工智能