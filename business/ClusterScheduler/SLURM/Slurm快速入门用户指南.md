# Slurm快速入门用户指南

快速入门用户指南



## **概观**

Slurm是一个开源，容错，高度可扩展的集群管理和作业调度系统，适用于大型和小型Linux集群。Slurm不需要对其操作进行内核修改，并且相对独立。作为集群工作负载管理器，Slurm有三个关键功能。首先，它在一段时间内为用户分配对资源（计算节点）的独占和/或非独占访问，以便他们可以执行工作。其次，它提供了一个框架，用于在分配的节点集上启动，执行和监视工作（通常是并行作业）。最后，它通过管理待处理工作的队列来仲裁资源争用。

## **架构**

如图1所示，Slurm包含在每个计算节点上运行的**slurmd**守护程序和在管理节点上运行的中央**slurmctld**守护程序（带有可选的故障转移双胞胎）。该**slurmd**守护程序提供容错层次通信。用户命令包括：**sacct**，**salloc**，**sattach**，**sbatch**，**sbcast**，**scancel**，**scontrol**， **sinfo**，**SMAP**，**SQUEUE**，**SRUN**，**strigger** 和**sview**。所有命令都可以在群集中的任何位置运行。

![img](https://gblobscdn.gitbook.com/assets%2F-LLbdKuFKEy4lqaLSO-q%2F-LLbo5WYVVXFo6rTYDA4%2F-LLboWCdQs9vu4toKMQM%2Fimage.png?alt=media&token=62af9427-49cb-4ac5-bd9f-54338a9972ec)

图1. Slurm组件

由这些Slurm守护进程管理的实体（如图2所示）包括 **节点（node）**，Slurm中的计算资源， **分区（Partition）**，将节点分组为逻辑（可能重叠）集， **作业(Job)**或分配给用户的指定数量的资源分配时间和 **工作步骤(Job Step)**，这是作业中的（可能是并行的）任务集。可以将分区视为作业队列，每个分区都有各种约束，例如作业大小限制，作业时间限制，允许使用它的用户等。优先级排序的作业在分区内分配节点，直到资源（节点，该分区内的处理器，内存等都已耗尽。一旦为作业分配了一组节点，用户就能够在分配中的任何配置中以作业步骤的形式启动并行工作。例如，可以开始利用分配给作业的所有节点的单个作业步骤，或者若干作业步骤可以独立地使用分配的一部分。  

![img](https://gblobscdn.gitbook.com/assets%2F-LLbdKuFKEy4lqaLSO-q%2F-LLbo5WYVVXFo6rTYDA4%2F-LLbop2j2okUOMPqdOpr%2Fimage.png?alt=media&token=48d84c10-0f8c-4acd-95bc-4089d0e47fb9)

图2. Slurm实体

## **命令**

所有Slurm守护进程，命令和API函数都存在手册页。命令选项--help还提供了选项的简短摘要。请注意，命令选项都区分大小写。

**sacct**用于报告有关活动或已完成作业的作业或作业步骤会计信息。

**salloc**用于实时为作业分配资源。通常，这用于分配资源并生成shell。然后使用shell执行srun命令以启动并行任务。

**sattach**用于将标准输入，输出和错误加信号功能附加到当前正在运行的作业或作业步骤。可以多次附加和分离作业。

**sbatch**用于提交作业脚本以供以后执行。该脚本通常包含一个或多个用于启动并行任务的srun命令。

**sbcast**用于将文件从本地磁盘传输到分配给作业的节点上的本地磁盘。这可用于有效地使用无盘计算节点或相对于共享文件系统提供改进的性能。

**scancel**用于取消挂起或正在运行的作业或作业步骤。它还可用于向与正在运行的作业或作业步骤相关联的所有进程发送任意信号。

**scontrol**是用于查看和/或修改Slurm状态的管理工具。请注意，许多 scontrol 命令只能以root用户身份执行。

**sinfo**报告由Slurm管理的分区和节点的状态。它具有各种过滤，排序和格式选项。

**smap**报告由Slurm管理的作业，分区和节点的状态信息，但以图形方式显示反映网络拓扑的信息。

**squeue**报告工作或工作步骤的状态。它具有各种过滤，排序和格式选项。默认情况下，它按优先级顺序报告正在运行的作业，然后按优先级顺序报告挂起的作业。

**srun**用于提交作业以便实时执行或启动作业步骤。 srun 有多种选项来指定资源要求，包括：最小和最大节点数，处理器数，要使用或不使用的特定节点，以及特定节点特征（如此多的内存，磁盘空间，某些必需的功能等） 。作业可以包含在作业节点分配中的独立或共享资源上顺序或并行执行的多个作业步骤。

**strigger**用于设置，获取或查看事件触发器。事件触发器包括节点关闭或作业接近其时间限制等事件。

**sview**是一个图形用户界面，用于获取和更新Slurm管理的作业，分区和节点的状态信息。

## **例子**

首先，我们确定系统上存在哪些分区，它们包含哪些节点以及一般系统状态。此信息由sinfo命令提供。在下面的示例中，我们发现有两个分区：*debug* 和*batch*。在*下列名称调试结果表明是提交作业的默认分区。我们看到两个分区都处于*UP*状态。某些配置可能包括较大作业的分区，除了周末或晚上外，它们都是*DOWN*。关于每个分区的信息可以分成多于一行，以便可以识别不同状态的节点。在这种情况下，两个节点*adev* [*1-2*]是下来。状态下降后的*表示节点没有响应。请注意对节点名称规范使用简洁表达式，并使用公共前缀*adev*和标识的数字范围或特定数字。此格式允许轻松管理非常集群。该sinfo命令有许多选项，让你轻松浏览感兴趣的信息，在你所喜欢的任何格式。有关更多信息，请参见手册页。



```
adev0: sinfo
PARTITION AVAIL  TIMELIMIT NODES  STATE NODELIST
debug*       up      30:00     2  down* adev[1-2]
debug*       up      30:00     3   idle adev[3-5]
batch        up      30:00     3  down* adev[6,13,15]
batch        up      30:00     3  alloc adev[7-8,14]
batch        up      30:00     4   idle adev[9-12]
```

接下来，我们使用squeue命令确定系统上存在哪些作业 。在 ST场的工作状态。两个作业处于运行状态（*R是Running的缩写*），而一个作业处于挂起状态（*PD是Pending的缩写*）。在时间栏显示多久作业已经运行使用格式天小时：分钟：秒。该节点列表（*REASON*）字段指示作业正在运行或者原因，仍有待地方。挂起作业的典型原因是资源（等待资源可用）和优先级 （排在更高优先级的工作后面）。该SQUEUE命令有许多选项，让你轻松浏览感兴趣的信息，在你所喜欢的任何格式。有关更多信息，请参见手册页。



```
adev0: squeue
JOBID PARTITION  NAME  USER ST  TIME NODES NODELIST(REASON)
65646     batch  chem  mike  R 24:19     2 adev[7-8]
65647     batch   bio  joan  R  0:09     1 adev14
65648     batch  math  phil PD  0:00     6 (Resources)
```

该scontrol命令可用于报告有关节点，分区作业，作业步骤和配置的详细信息。系统管理员也可以使用它来进行配置更改。下面显示了几个例子。有关更多信息，请参见手册页。



```
adev0: scontrol show partition
PartitionName=debug TotalNodes=5 TotalCPUs=40 RootOnly=NO
   Default=YES OverSubscribe=FORCE:4 PriorityTier=1 State=UP
   MaxTime=00:30:00 Hidden=NO
   MinNodes=1 MaxNodes=26 DisableRootJobs=NO AllowGroups=ALL
   Nodes=adev[1-5] NodeIndices=0-4

PartitionName=batch TotalNodes=10 TotalCPUs=80 RootOnly=NO
   Default=NO OverSubscribe=FORCE:4 PriorityTier=1 State=UP
   MaxTime=16:00:00 Hidden=NO
   MinNodes=1 MaxNodes=26 DisableRootJobs=NO AllowGroups=ALL
   Nodes=adev[6-15] NodeIndices=5-14


adev0: scontrol show node adev1
NodeName=adev1 State=DOWN* CPUs=8 AllocCPUs=0
   RealMemory=4000 TmpDisk=0
   Sockets=2 Cores=4 Threads=1 Weight=1 Features=intel
   Reason=Not responding [slurm@06/02-14:01:24]

65648     batch  math  phil PD  0:00     6 (Resources)
adev0: scontrol show job
JobId=65672 UserId=phil(5136) GroupId=phil(5136)
   Name=math
   Priority=4294901603 Partition=batch BatchFlag=1
   AllocNode:Sid=adev0:16726 TimeLimit=00:10:00 ExitCode=0:0
   StartTime=06/02-15:27:11 EndTime=06/02-15:37:11
   JobState=PENDING NodeList=(null) NodeListIndices=
   NumCPUs=24 ReqNodes=1 ReqS:C:T=1-65535:1-65535:1-65535
   OverSubscribe=1 Contiguous=0 CPUs/task=0 Licenses=(null)
   MinCPUs=1 MinSockets=1 MinCores=1 MinThreads=1
   MinMemory=0 MinTmpDisk=0 Features=(null)
   Dependency=(null) Account=(null) Requeue=1
   Reason=None Network=(null)
   ReqNodeList=(null) ReqNodeListIndices=
   ExcNodeList=(null) ExcNodeListIndices=
   SubmitTime=06/02-15:27:11 SuspendTime=None PreSusTime=0
   Command=/home/phil/math
   WorkDir=/home/phil
```

可以使用srun命令在单个命令行中创建资源分配并启动作业步骤的任务 。根据所使用的MPI实现，也可以以这种方式启动MPI作业。有关更多MPI特定信息，请参阅[MPI](https://slurm.schedmd.com/quickstart.html#mpi)部分。在此示例中，我们 在三个节点（*-N3*）上执行 /bin/hostname，并在输出（*-l*）上包含任务编号。将使用默认分区。默认情况下，将使用每个节点一个任务。请注意，srun命令有许多选项可用于控制分配的资源以及如何在这些资源之间分配任务。



```
adev0: srun -N3 -l /bin/hostname
0: adev3
1: adev4
2: adev5
```

上一个示例的此变体在四个任务（-*n4*）中执行 /bin/hostname。默认情况下将使用每个任务一个处理器（请注意，我们不指定节点计数）。



```
adev0: srun -n4 -l /bin/hostname
0: adev3
1: adev3
2: adev3
3: adev3
```

一种常见的操作模式是提交脚本以供以后执行。在此示例中，脚本名称为*my.script*，我们明确使用节点adev9和adev10（*-w“adev [9-10]”*，注意使用节点范围表达式）。我们还明确声明后续作业步骤将分别产生四个任务，这将确保我们的分配包含至少四个处理器（每个任务要启动一个处理器）。输出将出现在文件my.stdout（“ - o my.stdout”）中。此脚本包含嵌入其中的作业的时间限制。通过使用前缀“#SBATCH”后跟脚本开头的选项（在脚本中执行任何命令之前），可以根据需要提供其他选项。命令行上提供的选项将覆盖脚本中指定的任何选项。请注意我的。srun命令并按顺序执行。



```
adev0: cat my.script
#!/bin/sh
#SBATCH --time=1
/bin/hostname
srun -l /bin/hostname
srun -l /bin/pwd

adev0: sbatch -n4 -w "adev[9-10]" -o my.stdout my.script
sbatch: Submitted batch job 469

adev0: cat my.stdout
adev9
0: adev9
1: adev9
2: adev10
3: adev10
0: /home/jette
1: /home/jette
2: /home/jette
3: /home/jette
```

最终的操作模式是创建资源分配并在该分配中生成作业步骤。该salloc命令用来创建一个资源分配，并且典型地启动分配内的壳。通常在该分配内使用srun命令执行一个或多个作业步骤以启动任务（取决于所使用的MPI的类型，启动机制可能不同，请参阅下面的[MPI](https://slurm.schedmd.com/quickstart.html#mpi)细节）。最后，salloc创建的shell将使用exit终止命令。Slurm不会自动将可执行文件或数据文件迁移到分配给作业的节点。文件必须存在于本地磁盘或某些全局文件系统（例如NFS或Lustre）中。我们提供工具sbcast，使用Slurm的分层通信将文件传输到分配节点上的本地存储。在此示例中，我们使用sbcast将可执行程序*a.out*传输到已分配节点的本地存储上的*/tmp/joe.a.out*。执行程序后，我们将其从本地存储中删除。



```
tux0: salloc -N1024 bash
$ sbcast a.out /tmp/joe.a.out
Granted job allocation 471
$ srun /tmp/joe.a.out
Result is 3.14159
$ srun rm /tmp/joe.a.out
$ exit
salloc: Relinquishing job allocation 471
```

在此示例中，我们提交批处理作业，获取其状态并取消它。



```
adev0: sbatch test
srun: jobid 473 submitted

adev0: squeue
JOBID PARTITION NAME USER ST TIME  NODES NODELIST(REASON)
  473 batch     test jill R  00:00 1     adev9

adev0: scancel 473

adev0: squeue
JOBID PARTITION NAME USER ST TIME  NODES NODELIST(REASON)
```

## **最佳实践，大型工作计数**

考虑将相关工作放入单个Slurm作业中，其中包括多个作业步骤，这些都是出于性能原因和易于管理的原因。每个Slurm作业都可以包含大量的作业步骤，Slurm中用于管理作业步骤的开销远低于单个作业的开销。

[作业](https://docs.slurm.cn/users/~/edit/drafts/-LLbo5NllegwS0P-dXSY/gong-zuo-fu-ze-jing-li-de-rosetta-stone)数组是管理具有相同资源要求的批处理作业集合的有效机制。大多数Slurm命令可以将作业数组作为单个元素（任务）或作为单个实体来管理（例如，在单个命令中删除整个作业数组）。

## **MPI**

MPI的使用取决于所使用的MPI的类型。这些各种MPI实现使用了三种根本不同的操作模式。

1. Slurm直接启动任务并通过PMI2或PMIx API执行通信初始化。（由大多数现代MPI实现支持。）
2. Slurm为作业创建资源分配，然后mpirun使用Slurm的基础结构（旧版本的OpenMPI）启动任务。
3. Slurm为作业创建资源分配，然后mpirun使用除Slurm之外的某些机制（如SSH或RSH）启动任务。这些任务是在Slurm的监控或控制之外启动的。Slurm的epilog应配置为在放弃作业分配时清除这些任务。强烈建议使用pam_slurm_adopt。

下面提供了使用Slurm使用多种MPI的说明链接。

[英特尔MPI](https://docs.slurm.cn/users/~/edit/drafts/-LLbo5NllegwS0P-dXSY/mpi-he-upc-yong-hu-zhi-nan)

[MPICH2](https://docs.slurm.cn/users/~/edit/drafts/-LLbo5NllegwS0P-dXSY/mpi-he-upc-yong-hu-zhi-nan)

[MVAPCH2](https://docs.slurm.cn/users/~/edit/drafts/-LLbo5NllegwS0P-dXSY/mpi-he-upc-yong-hu-zhi-nan)

[打开MPI](https://docs.slurm.cn/users/~/edit/drafts/-LLbo5NllegwS0P-dXSY/mpi-he-upc-yong-hu-zhi-nan)