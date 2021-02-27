# [Linux那些事——GTK+, Qt, Gnome, KDE, xWindow, xOrg区别](https://www.cnblogs.com/devilyouwei/p/12248297.html)



# Linux那些事——GTK+, Qt, Gnome, KDE, xWindow, xOrg区别

Linux不仅内核开源，系统配置也是高度可定制化的，其中就包括我们所熟知的图形界面，从桌面环境，主题，字体，Icon我们都可以通过修改Linux的配置文件来修改。这就是为什么我选择Linux的理由，高度的个性化。

用了8年多的Linux桌面发行版，一直没有好好研究一下linux的图形界面xwindow，今天拿出来好好整理一下，也希望对刚入门linux的童鞋有一定帮助。

首先Linux是个开源且自由的软件，他只是一个内核，这意味着我们可以对其任何细节，模块，内核进行高度的定制化。所谓的图形界面，是在Linux环境下的一套或者说一个软件，为Linux提供了图形界面的能力。这和windows的设计很不一样，windows是把图形界面作为必不可少的部分（内核），也就是windows的发布永远携带了图形界面，他和windows系统是一体的，对于linux来说，图形界面是个可有可无的软件而已，没有xwindow，linux是操作系统，有xwindow，linux还是个操作系统，当你安装上了这个xwindow，linux只是多了一个软件而已。

那么关于Linux的图形界面，有很多故事可以讲，这里就来区分一下这些专业的名词。

## x Window Server 与 x协议

又被称为x11或者X，所谓server，是一种服务器，就像http服务器，ftp服务器，简而言之这就是一个用来显示图形界面的服务器。xwindow最早由MIT研发，后广泛运用于Unix和Unix Like系统之上。现在几乎所有的操作系统都支持这个xWindow的运行。光有xwindow是不够的，这是一个协议，就像http服务器，http也是一个协议，所有遵守http协议开发的服务器都是http服务器，所有遵守x协议的服务器都叫x window server，所以x winwow server还需要client，这个客户端就是x协议下的应用，例如KDE，Gnome。这些client软件一般都是通过x11协议下的GTK和Qt图形库开发的，因为都遵守x协议，所以可以与x window server沟通，就像浏览器都可以和http服务器沟通一样。
[注：x11中11是x协议的版本号，目前是第11个版本]

## x.org

Org顾名思义，是一个组织，他们致力于实现x11这套协议，并且基于这套协议，架构开发出了自己的x window server，就像apache开发了apache，是一个http服务器。xorg实现的这套xwindow在linux系统的图形界面中被广为接受，也是目前最流行的图形界面服务软件，当然除此以外也有其他组织和公司实现了这套x协议，比如Xfree86，Xnest，MOTIF等
理论上，任何公司，组织，个人都可以用计算机语言去实现一套xWindow服务系统，只需要遵守x11的协议，但是x.Org发布的这一套更加的有名，被Linux各发行版广为使用。苹果的Mac OS也是基于这个x协议的，并且mac的darwin内核内置了一个x window server，中和linux不太一样，linux没有把xwindow放在内核中。

## GTK+ and Qt

这两个是GUI toolkits，这两个是软件库，类似c语言的stdio.h，win32，java里import的各种外部包，可以任开发者调用（应该是C/C++使用的库）去创建一些图形界面里面的控件，例如button，下拉菜单，窗口等。我记得JAVA里面也有类似AWT和Swing库。用这一套库开发出的图形空间将会有一套统一的风格和标准，这就是不同系统安装的不同软件有的时候会有相同的样式，因为他们可能使用了GTK或者QT的库。KDE默认使用Qt库开发，Gnome默认使用GTK+库开发，而这两套库又是基于X window server的，需要遵守x11协议，在xwindow server上运行，作为client应用实现的基础类库。接下来就要说说KDE和Gnome以及其他基于GTK和Qt开发的x软件。

## KDE and Gnome

KDE 和 Gnome才是我们用户真正看到的图形界面，窗口管理器，当然他们还提供了例如菜单，软件列表，鼠标，桌面等控件，所以称他们为桌面环境更合适！他们属于x client级的应用，因为很多图形界面软件基于这些环境才能被管理，例如firefox，gimp等，桌面环境包含了大量的开发完成的桌面的控件，窗口，按钮，表单，动画等，除此以外，还有专门基于这两个桌面环境的软件，对于KDE，大部分的软件和控件都是基于QT库开发的，但也不是全部，GTK开发的软件同样可以运行在KDE环境中，但是有可能出现一些些小问题，崩溃等。而Gnome的大部分软件都是基于GTK+库开发，同样Qt开发的软件也可以运行于Gnome，这主要也归功于Gnome，KDE以及这些软件（firefox，gimp等）都是遵循x11的协议的client应用，他们具有兼容性，这里要强调，虽然KDE和gnome是桌面环境，窗口管理器，看似更庞大，更底层，但是对于x11协议来说，他们和在他们之上运行的窗口应用（例如firefox，gimp等）属于同级，都是基于x的client软件，他们只是为了方便管理图形界面下的多应用程序而生的。

## 其他环境

除了KDE和Gnome还有更多的桌面环境被广泛运用于Linux，之所以大家都听说这两个，是因为这两个桌面环境运用十分广泛，也可以说这两个软件用的人更多。其他的环境还有：

1. XFCE-简单快速的桌面环境，基于GTK
2. Cinnamon基于GTK
3. MATE基于GTK
4. LXDE基于GTK
5. Trinity基于Qt

笔者搜索了一些关于桌面库的资料，发现，GTK的桌面环境多于Qt派，Qt几乎只有可怜的KDE一枝独秀，而且笔者也不太喜欢KDE，现在的KDE桌面环境一般是指KDE Plasma。Ubuntu有一个分支就是基于KDE的，有兴趣的童鞋可以安装Kubuntu体验一下，KDE的特色就是“花里胡哨”。

