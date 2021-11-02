# github Action



GitHub Actions 有一些自己的术语。

（1）workflow （工作流程）：持续集成一次运行的过程，就是一个 workflow。

（2）job （任务）：一个 workflow 由一个或多个 jobs 构成，含义是一次持续集成的运行，可以完成多个任务。

（3）step（步骤）：每个 job 由多个 step 构成，一步步完成。

（4）action （动作）：每个 step 可以依次执行一个或多个命令（action）。

workflow 包括build任务
build任务包括多个步骤： lint ，单元测试，编译，发布
每个步骤包括多个动作。

常见的动作有 拉去代码`actions/checkout@master`,
### jobs
jobs
工作流程运行包括一项或多项作业。 作业默认是并行运行。 要按顺序运行作业，您可以使用 <job_id>needs 关键词在其他作业上定义依赖项。

每个作业在 runs-on 指定的环境中运行。

### action
action:
name:
on:
jobs.<job_id>.steps.uses

```
env:
  SERVER: production
```

jobs.<job_id>.steps.run
jobs.<job_id>.steps.shell

jobs.<job_id>.steps.with

输入参数的 map 由操作定义。 每个输入参数都是一个键/值对。 输入参数被设置为环境变量。 该变量的前缀为 INPUT_，并转换为大写。