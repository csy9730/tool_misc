# Github 新的项目管理模式——Projects

## Issues

Github 中传统的项目管理是使用 issue 和 pull request 进行的，这部分内容不是本文重点，不再赘述。 但有一些功能需要提及：

- Tag： 每个 issue 可以添加不同的 tag，可以用于标记 issue 的种类和 issue 的处理进度；
- MileStone：每个 issue 只属于一个 milestone，用于显示 issue 的处理进度。

## Projects 概述

这是Github 2016年9月份新的功能，如图所示：

![no-project.png](https://xn--8mr166hf6s.xn--fiqs8s/attachment/11/no-project.png)

Project 提供了真正的管理 issue 的能力；而传统的 tag 方式只能以手工的方式管理分类（如 Q&A，bug，duplicate，feature 这些标签🏷），或者以手工的方式管理 issue 进度（need test, in progress, wait approval 等这些标签）。

不过在开始讨论这个之前，有必要先讨论一下看板方法。

## 看板（Kanban）

#### 什么是看板？

> 看板管理，起源于丰田的生产模式中，指为了达到及时生产（JIT）方式控制现场生产流程的工具。及时生产方式中的拉式（Pull）生产系统可以使信息的流程缩短，并配合定量、固定装货容器等方式，而使生产过程中的物料流动顺畅。

需要详细了解的请看[Wiki](https://en.wikipedia.org/wiki/Kanban)。

如果还是没看懂，这里有几个看板的例子：

### KanbanFlow & Trello

[KanbanFlow](https://kanbanflow.com/) ![kanbanflow.png](https://xn--8mr166hf6s.xn--fiqs8s/attachment/11/kanbanflow.png)

[Trello](https://trello.com/) ![trello.png](https://xn--8mr166hf6s.xn--fiqs8s/attachment/11/trello.png)

可以看出，所谓看板，就是把一块木板上分成几列，然后在每一列上贴上不同内容的卡片。 木板上的这几列一般是有顺序的，卡片可以在不同的列之间移动来表明所处的状态。

以上的两个例子，看板并不是针对软件工程的，他们的市场也是一般的企业（比如丰田这样的）。

### Zenhub & Github Projects

下面的两个例子则是针对软件开发做了优化，准确的说，它们都是对 Github 做了适配。

[Zenhub](https://www.zenhub.com/) ![zenhub-task-board.jpg](https://xn--8mr166hf6s.xn--fiqs8s/attachment/11/zenhub-task-board.jpg)

[Github Projects](https://help.github.com/categories/managing-your-work-on-github) ![Github-Kanban.png](https://xn--8mr166hf6s.xn--fiqs8s/attachment/11/Github-Kanban.png)

[Zenhub](https://www.zenhub.com/) 是个浏览器插件，就是把 Github 的 issues 当作卡片，以 Kanban 的形式展现 issue，也提供了一个比较鸡肋的 Epic 的功能，同时针对个人也有 TODO 项管理。
而 Github 最近推出的 Project 不仅可以使用 issues 作为卡片，还可以使用Note（左侧的三个），这样我们就没有必要为了在看板上记录可能的需求而创建一个新的 issues 或者把问题记录在个人的 TODO 列表上了。

## Github Projects

一个仓库可以包含多个项目；最初，这个设定让我疑惑，直到使用之后才明白， 一个代码仓库通常有很多事情要做，比如：

- 拟定线路图
- 增加一个新功能
- 发布一个新版本

因此，我们可以为以上每一件事创建一个 Project，由于 Github 中并没有类似 Epic 的机制，因此使用不同的 Project 则很有用了。

可以看到，有了 Project 的 Kanban 之后，原来 tag 的部分功能（如标记处理进度等）可以被看板替代。 Github Project 提供的 Note 可以在需要的时候单项转换为 issue：

![convert-to-issue.png](https://xn--8mr166hf6s.xn--fiqs8s/attachment/11/convert-to-issue.png)

同时，Kanban 不仅可以包含 issue 和 note，还可以包含 pull request。

Github 终于有了比较靠谱的项目管理工具，开源项目的又有了更好的工具。 撒花o(^▽^)o

祝愿我自己早日完成我的第一个开源项目（IMAP Server）。