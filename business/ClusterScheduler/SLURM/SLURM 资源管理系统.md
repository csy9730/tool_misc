# SLURM 资源管理系统

[自可乐](https://www.jianshu.com/u/59ef38a1d84b)关注

12018.05.27 11:16:34字数 1,177阅读 35,210

在[上一篇](https://www.jianshu.com/p/601ca9f33b31)中我们简要介绍了 LSF 作业管理系统，下面将介绍 SLURM 资源管理系统。

# 简介

SLURM （Simple Linux Utility for Resource Management）是一种可用于大型计算节点集群的高度可伸缩和容错的集群管理器和作业调度系统，被世界范围内的超级计算机和计算集群广泛采用。SLURM 维护着一个待处理工作的队列并管理此工作的整体资源利用。它以一种共享或非共享的方式管理可用的计算节点（取决于资源的需求），以供用户执行工作。SLURM 会为任务队列合理地分配资源，并监视作业至其完成。如今，SLURM 已经成为了很多最强大的超级计算机上使用的领先资源管理器，如天河二号上便使用了 SLURM 资源管理系统。

# 常用命令

下面是一些最常用的 SLURM 命令：

- sacct：查看历史作业信息
- salloc：分配资源
- sbatch：提交批处理作业
- scancel：取消作业
- scontrol：系统控制
- sinfo：查看节点与分区状态
- squeue：查看队列状态
- srun：执行作业

# 常用环境变量

下表是 SLURM 环境变量：

| 变量                    | 说明                                                       |
| :---------------------- | :--------------------------------------------------------- |
| SLURM_NPROCS            | 要加载的进程数                                             |
| SLURM_TASKS_PER_NODE    | 每节点要加载的任务数                                       |
| SLURM_JOB_ID            | 作业的 JobID                                               |
| SLURM_SUBMIT_DIR        | 提交作业时的工作目录                                       |
| SLURM_JOB_NODELIST      | 作业分配的节点列表                                         |
| SLURM_JOB_CPUS_PER_NODE | 每个节点上分配给作业的 CPU 数                              |
| SLURM_JOB_NUM_NODES     | 作业分配的节点数                                           |
| HOSTNAME                | 对于批处理作业，此变量被设置为批处理脚本所执行节点的节点名 |

# 资源管理系统实体

SLURM 资源管理系统的管理对象包括：节点，分区，作业和作业步。

- 节点：Node
  - 即指计算节点
  - 包含处理器、内存、磁盘空间等资源
  - 具有空闲、分配、故障等状态
  - 使用节点名字标识
- 分区：Partition
  - 节点的逻辑分组
  - 提供一种管理机制，可设置资源限制、访问权限、优先级等
  - 分区可重叠，提供类似于队列的功能
  - 使用分区名字标识
- 作业：Job
  - 一次资源分配
  - 位于一个分区中，作业不能跨分区
  - 排队调度后分配资源运行
  - 通过作业 ID 标识
- 作业步：Jobstep
  - 通过 srun 进行的任务加载
  - 作业步可只使用作业中的部分节点
  - 一个作业可包含多个作业步，可并发运行
  - 在作业内通过作业步 ID 标识

# 作业运行模式

SLURM 系统有三种作业运行模式：

- 交互模式，以 srun 命令运行；
- 批处理模式，以 sbatch 命令运行；
- 分配模式，以 salloc 命令运行。

## 交互模式

交互模式作业的使用过程为：

1. 在终端提交资源分配请求，指定资源数量与限制；
2. 等待资源分配；
3. 获得资源后，加载计算任务；
4. 运行中，任务 I/O 传递到终端；
5. 可与任务进行交互，包括 I/O，信号等；
6. 任务执行结束后，资源被释放。

例如使用 srun 申请 4 个进程生成一个作业步：

```ruby
$ srun -n 4 ./example
```

## 批处理模式

批处理模式作业的使用过程为：

1. 用户编写作业脚本；
2. 提交作业；
3. 作业排队等待资源分配；
4. 分配资源后执行作业；
5. 脚本执行结束，释放资源；
6. 运行结果定向到指定的文件中记录。

下面给出作业脚本示例：

```bash
#!/bin/env bash

# file: example.sh

# set the number of nodes
#SBATCH --nodes=2

# set the number of tasks (processes) per node
#SBATCH --ntasks-per-node=4

# set partition
#SBATCH --partition=example-partition

# set max wallclock time
#SBATCH --time=2:00:00

# set name of job
#SBATCH --job-name=example-mpi4py

# set batch script's standard output
#SBATCH --output=example.out

# mail alert at start, end and abortion of execution
#SBATCH --mail-type=ALL

# send mail to this address
#SBATCH --mail-user=user@mail.com

# run the application
srun python example-mpi4py.py
```

用以下命令提交批处理作业：

```ruby
$ sbatch example.sh
```

## 分配模式

分配模式作业的使用过程为：

1. 提交资源分配请求；
2. 作业排队等待资源分配；
3. 执行用户指定的命令；
4. 命令执行结束，释放资源。

分配模式通过 salloc 命令运行，举例如下（使用 2 个节点，4 个进程，预计运行时间 100 秒）：

```ruby
$ salloc -N 2 -n 4 -p example-partition -t 100 /bin/bash
```

资源分配请求成功后会进入 bash shell 终端，在其中可以使用 srun 交互式地执行作业任务。在终端输入 exit 命令或 Ctrl+D 退出分配模式。

# 天河二号上的 SLURM 管理系统

天河二号上使用的是 SLURM 资源管理系统，不过天河二号上使用的 SLURM 命令都是将标准的 SLURM 命令开头的 s 改成了 yh，如下：

- yhacct：查看历史作业信息
- yhalloc：分配资源
- yhbatch：提交批处理作业
- yhcancel：取消作业
- yhcontrol：系统控制
- yhinfo/yhi：查看节点与分区状态
- yhqueue/yhq：查看队列状态
- yhrun：执行作业

以上介绍了 SLURM 资源管理系统，在[下一篇](https://www.jianshu.com/p/e62f1acadf08)中我们将介绍 MPI-3 的新特性。