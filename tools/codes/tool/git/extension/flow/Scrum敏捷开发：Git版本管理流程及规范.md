# Scrum敏捷开发：Git版本管理流程及规范

[![Johny Sinn](https://pica.zhimg.com/v2-c00180a75462420aede182a00cbc8535_l.jpg?source=172ae18b)](https://www.zhihu.com/people/linzihao-239)

[Johny Sinn](https://www.zhihu.com/people/linzihao-239)

一位见多识广、持续增长的IT人 & 商人✔️

## 分支概述

![img](https://pic3.zhimg.com/80/v2-9c61999b5e4f8ec9333317cc4410ebb6_720w.webp)

- 分支流程中包含4类分支，分别是master、release、dev、hotfix，各类分支作用和生命周期各不相同。

- - master：该分支是线上稳定版本代码，禁止提交代码
  - dev：从master分支切出，是需要开发代码的分支，所有开发均在dev分支
  - release：从dev分支切出，dev合并到release分支进行测试，同时也是发布分支
  - hotfix：从master分支切出，解决线上紧急BUG的修复

## 角色及职责

- 开发组员

- - dev、hotfix的分支开发

- 开发组长

- - 从master打dev、release、hotfix分支
  - dev、hotfix的分支开发
  - 从dev分支合并到release
  - 从release分支合并到master
  - 将master合并到release分支
  - 删除hotfix分支

> 分支记录存放位置 - Git->wikis->分支记录

## 版本号规范

- dev及release版本号命名规则 - <主版本号>.<副版本号>.<发布号>

- - 主版本号设置规则

  - - 产品的主体构件进行重大修改，主版本号加1
    - 产品的主体构件之间的接口协议重大修改，主版本号加1

- - 副版本号设置规则

  - - 主版本号变更时，副版本号置0
    - 数据结构变更(新增或修改注释含义的情况除外)，副版本号加1
    - 若副版本号累加至超过90时，采用主版本号进位制，主版本号加1，副版本号重新置0

- - 发布号设置规则

  - - 主版本号或副版本号变更时，发布号置0
    - 若发布的版本无数据结构变更，则发布号加1

- hotfix版本号命名规则 - <主版本号>.<副版本号>.<发布号>

- - hotfix由于即修即删，因此同release版本的版本号即可

> 主版本号和副版本号的变更标志着重要的功能或结构变动。发布号的变更，用于体现小的功能变更

## 各种场景流程规则

### 正常开发常规版本

![img](https://pic4.zhimg.com/80/v2-c1da0cd6d16a83b4551f16bb8270c067_720w.webp)

- 当需要开发常规迭代时：

分值类型命名规范创建自合并到备注devdevx.x.xmasterrelease新功能开发完成后提测releaseggreleasex.x.xdevmaster新版本发布后

- 从`master`分支创建`dev`分支，例如：dev1.3.0
- 在`dev`分支上开发代码，push到远程仓库
- `dev`分支代码开发完毕，合并到`release`分支，例如：release1.3.0 <开发组长>
- 测试人员在release1.3.0分支进行测试，测试完毕后拿release1.3.0分支部署
- 上线验收完毕后将release1.3.0分支合并到`master`分支

### 紧急&BUG修复版本流程规则

![img](https://pic3.zhimg.com/80/v2-0e18c9e0bd3b95a64ca4255398e9175a_720w.webp)

- 当需要修复线上紧急BUG时：

分值类型命名规范创建自合并到备注hotfixhotfixmasterreleaseBUG修复后提测

- 从`master`分支创建`hotfix`分支
- 在`hotfix`分支修复BUG，push到远程仓库
- BUG修复完毕后切出最新的`release`分支，例如：release1.3.1 <开发组长>
- 测试人员在release1.3.1分支进行测试，测试完毕后拿release1.3.1分支部署
- 上线验收完毕后将release1.3.1分支合并到`master`分支

## 注意事项

- dev分支之间不能合并代码
- release分支不能合并到dev分支
- 从dev分支合并到release分支测试时，只能合并dev分支上自己的commit到release，可参考git cherry-pick、git rebase命令
- 如发现当前release分支测试时，落后于master一个版本及以上，需要将master合并至当前release分支；

## 相关环境

- - 预发布环境
  - 生产环境
  - 开发环境
  - 测试环境



发布于 2020-06-23 10:46