# PBS 作业管理系统

[自可乐](https://www.jianshu.com/u/59ef38a1d84b)关注

22018.05.26 22:38:31字数 1,103阅读 26,108

在[上一篇](https://www.jianshu.com/p/33889de160c0)中我们非常简单地介绍了在 C 语言中嵌入 mpi4py 程序的方法。

前面我们所给出的各个例程一般都是在单台计算机上直接使用 mpiexec 或 mpirun 执行的，但是在实际应用中，对规模比较大的高性能计算任务，一般会提交到集群或超级计算机平台上进行计算。集群系统具有低成本、高性能的特性，提供了强大的批处理和并行计算能力，代表了高性能计算机发展的新方向。在集群或者超级计算机平台上，一般不能随意地直接以 mpiexec 或 mpirun 运行我们的并行计算程序，而必须通过其上提供的作业管理系统来提交计算任务。作为集群系统软件的重要组成部分，集群作业管理系统可以根据用户的需求，统一管理和调度集群的软硬件资源，保证用户作业公平合理地共享集群资源，提高系统利用率和吞吐率。下面我们将简要地介绍几个常用的集群作业管理系统：PBS，LSF 和 SLURM。下面我们首先简要介绍 PBS 作业管理系统。

# PBS 简介

PBS （Protable Batch System） 作业管理系统会根据一个集群上的可用计算节点的计算资源管理和调度所有计算作业（无论是批处理作业还是交互式作业）。

# PBS 常用命令

## 作业控制

- qsub：提交作业
- qdel：取消作业
- qsig：给作业发送信号
- qhold：挂起作业
- qrls：释放挂起的作业
- qrerun：重新运行作业
- qmove：将作业移动到另一个队列
- qalter： 更改作业资源属性

## 作业监测

- qstat：显示作业状态
- showq： 查看所有作业

## 节点状态

- pbsnodes：列出集群中所有节点的状态和属性

# PBS 作业属性

可以用两种方式设置 PBS 作业属性：

- 通过命令行参数传递给 qsub 命令；
- 在 PBS 脚本中以 #PBS 方式指定。

下表列出常用的 PBS 作业属性

| 属性 | 取值                      | 说明                           |
| :--- | :------------------------ | :----------------------------- |
| -l   | 以逗号分隔的资源列表      | 设定作业所需资源               |
| -N   | 作业名称                  | 设定作业名称                   |
| -o   | 文件路径                  | 设定作业的标准输出文件路径     |
| -e   | 文件路径                  | 设定作业的标准错误文件路径     |
| -p   | -1024 到 +1023 之间的整数 | 设定作业优先级，越大优先级越高 |
| -q   | 队列名称                  | 设定作业队列名称               |

比较常用的作业资源如下：

| 资源     | 取值                           | 说明                              |
| :------- | :----------------------------- | :-------------------------------- |
| nodes    | 节点资源构型                   | 设定作业所需计算节点资源          |
| walltime | hh:mm:ss                       | 设定作业所需的最大 wallclock 时间 |
| cput     | hh:mm:ss                       | 设定作业所需的最大 CPU 时间       |
| mem      | 正整数，后面可跟 b，kb，mb，gb | 设定作业所需的最大内存            |
| ncpus    | 正整数                         | 设定作业所需的 CPU 数目           |

可以用以下方法设定节点资源构型：

1. 设定所需节点数：

   nodes=<num nodes>

2. 设定所需节点数和每个节点上使用的处理器数目：

   nodes=<num nodes>:ppn=<num procs per node>

3. 设定所用的节点：

   nodes=<list of node names separated by '+'>

# PBS 环境变量

下表列出常用的 PBS 环境变量：

| 环境变量        | 说明                                                 |
| :-------------- | :--------------------------------------------------- |
| PBS_ENVIRONMENT | 批处理作业为 PBS_BATCH，交互式作业为 PBS_INTERACTIVE |
| PBS_JOBID       | PBS 系统给作业分配的标识号                           |
| PBS_JOBNAME     | 用户指定的作业名称                                   |
| PBS_NODEFILE    | 包含作业所用计算节点的文件名                         |
| PBS_QUEUE       | 作业所执行的队列名称                                 |
| PBS_O_HOME      | 执行 qsub 命令的 HOME 环境变量值                     |
| PBS_O_PATH      | 执行 qsub 命令的 PATH 环境变量值                     |
| PBS_O_SHELL     | 执行 qsub 命令的 SHELL 环境变量值                    |
| PBS_O_HOST      | 执行 qsub 命令节点名称                               |
| PBS_O_QUEUE     | 提交的作业的最初队列名称                             |
| PBS_O_WORKDIR   | 执行 qsub 命令所在的绝对路径                         |

# 提交批处理作业

用以下命令形式提交批处理作业：

```ruby
$ qsub [options] <control script>
```

作业提交后一般会先排队等待，PBS 系统会根据作业的优先级和可用的计算资源来调度和执行作业。

PBS 脚本本质上是一个 Linux shell 脚本，在 PBS 脚本中可以用一种特殊形式的注释（#PBS）作为 PBS 指令以设定作业属性。下面是一个 PBS 脚本示例：

```bash
#!/bin/bash

# file: example.pbs

### set job name
#PBS -N example-job
### set output files
#PBS -o example.stdout
#PBS -e example.stderr
### set queue name
#PBS -q example-queue
### set number of nodes
#PBS -l nodes=2:ppn=4

# enter job's working directory
cd $PBS_O_WORKDIR

# get the number of processors
NP=`cat $PBS_NODEFILE | wc -l`

# run an example mpi4py job
mpirun -np $NP -machinefile $PBS_NODEFILE python example_mpi4py.py
```

用以下命令提交该作业：

```ruby
$ qsub example.pbs
```

# 取消或停止作业

要取消或停止一个作业，需要得到该作业的作业标识号 <job ID >，可以通过 qstat 命令获得。

## 取消排队等待的作业

取消一个正在排队等待的作业，可用以下命令：

```ruby
$ qdel <job ID >
```

## 停止正在运行的作业

要停止一个正在运行的作业，可用向其发送 KILL 信号：

```ruby
$ qsig -s KILL <job ID>
```

# 交互式作业

交互式的计算作业通过类似于下面的命令使用：

```ruby
$ qsub -I [options]
```

例如要求 2 台计算节点，运行在 example-queue 队列上的交互式作业，执行如下命令：

```cpp
$ qsub -I -l nodes=2 -q example-queue
```

执行完以上命令，等 PBS 系统分配好资源后会进入所分配的第一台计算节点，可在其命令终端上执行交互式的计算任务，如要退出交互作业，可在终端输入 exit 命令，或使用按键 Ctrl+D。

以上简要介绍了 PBS 作业管理系统，在[下一篇](https://www.jianshu.com/p/601ca9f33b31)中我们将介绍 LSF 作业管理系统。