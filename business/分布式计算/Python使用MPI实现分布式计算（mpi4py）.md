# Python使用MPI实现分布式计算（mpi4py）

[Pjer](https://www.zhihu.com/people/pjer)





科学盐究员



246 人赞同了该文章

## 并行计算

多年以前，计算机的主频还是MHz级别制程还是微米级别的时候，CPU每次更新换代都会带来巨大提升，可以通过提升电子工艺的方式以及提升主频的方式提高计算速度。单机计算能力在那个时代大刀阔斧向前走。科学计算的规模也随着计算能力的提升逐渐升级。计算能力的提升也带来了很多学科的兴起和繁荣，比如计算物理。

直到主频到了GHz量级，传统工艺已经触碰到经典物理的天花板，再提高主频缩小原件的话就会出现无法预料的不确定性。

然而，科学计算的需求还在日渐提升。对计算能力的强烈需求让学者找到了另外一个突破口：大规模并行。

这就提到了MPI



## MPI

MPI （Message Passing Interface）是一套标准，在很长一段时间里我都错误地以为它是一个软件，或者是一个语言（因为总听学长同事说装MPI编MPI程序）。事实上它是一套并行运算中信息传递和处理的标准，在这个标准之上，编程者可以很方便地组织自己的并行程序。

这套标准有很多种实现，比如C++，Fortran，Python的mpi4py，Matlab-MPI等等。在这些程序中调用响应的库来实现程序的并行化。

这其中，Fortran，C++ 开发效率太低，Python我个人非常喜欢

![img](https://pic2.zhimg.com/80/v2-316fa7280c13ab6dbac71bc20ebc3459_720w.jpg)

以及在我所在的天文领域，Python正在占领全局。

开发迅速，可以很快速的把算法转化成程序，并投入计算。带上Numba，pycuda，pytorch等工具的加速，速度也很快。

这里试图用集群并行的方法加速并行化在单机优化了很久的Python程序，解决方案就是mpi4py。可以原生支持Python和np array。

以下是实现过程的细节，走一步记一步。



## 安装mpi4py

Linux 下的安装非常方便

```text
sudo apt install python-mpi4py
```

它会自己组织好依赖，开箱即用。



然而，我需要在本地编写并测试程序，所以我需要在windows下也安装mpi4py，就稍微有点麻烦了，不过最终也解决了。首先是遇到一个No compiler的问题。

这个问题如果安装的Visual Studio并在安装时勾选了C++模块的话就不会遇到了。

解决方法是安装VSCompiler，官方下载地址：

[ [https://visualstudio.microsoft.com/visual-cpp-build-tools/](https://link.zhihu.com/?target=https%3A//visualstudio.microsoft.com/visual-cpp-build-tools/) ]

![img](https://pic1.zhimg.com/80/v2-080a0767ff57a5c35afa56d31c63a3bc_720w.jpg)

需要勾选这些，安装编译器和Windows SDK。

开始编译之后还是遇到了一个问题，就是没有mpi的库文件，编译报错。

```text
 “mpi.h”: No such file or directory
```

需要安装MS-MPI

![img](https://pic3.zhimg.com/80/v2-d79f7c186625fb33b23936489c07524a_720w.jpg)

setup 和 SDK都需要装。

安装之后可以正常编译mpi4py ：

![img](https://pic4.zhimg.com/80/v2-6b358cbfb36550915f5f3f0e8621d30f_720w.jpg)



安装完成之后可以尝试跑一个小小例子来验证一下它确实是装好了。

```python
from mpi4py import MPI

comm = MPI.COMM_WORLD
size = comm.Get_size()
rank = comm.Get_rank()

if rank == 0:
    msg = 'Hello, world'
    comm.send(msg, dest=1)
elif rank == 1:
    s = comm.recv()
    print("rank %d: %s" % (rank, s))
else:
    print("rank %d: idle" % (rank))
```

运行方式，命令行里执行：

```text
mpiexec -np 8 python MPI_test.py
```

得到如下结果：

```text
rank 4: idle
rank 5: idle
rank 3: idle
rank 7: idle
rank 2: idle
rank 6: idle
rank 1: Hello, world
```

可以说明MPI正确地启动了8个进程， 并且给引为1的进程发送了“Hello World”，而后该进程接收到了这个信息。

到这里，程序就已经可以实现并行了，相比Python自带的Multiprocessing包，MPI语法更复杂，不过好处是，它扩展性更强，后期可以扩展到多节点分布式计算。而Multiprocessing只能打单机。



## mpi4py实现并行计算

如果你有已经写好的单线程串行程序，仅仅想通过同时执行多个不同参数下的串行运算来做并行分布式计算的话，并行起来是非常简单的，只要安排一下哪个线程执行哪个参数的任务就行了。

我写了个小例子：

```python
# for multiple node cluster
# based on MPI

from mpi4py import MPI 
import random

from myhome import big_job # to be parallelized 

def bigjobMPI(arr_a,arr_b):

    comm = MPI.COMM_WORLD
    size = comm.Get_size()
    rank = comm.Get_rank()
    
    size_a,size_b =  arr_a.shape[0],arr_b.shape[0]
    numjobs=size_a*size_b

    job_content = [] # the collection of parameters [a,b]
    for a_cur in arr_a:
        for b_cur in arr_b:
            job_content.append((a_cur,b_cur))

    # arrange the works and jobs
    if rank==0:
        # this is head worker
        # jobs are arranged by this worker
        job_all_idx =list(range(numjobs))  
        random.shuffle(job_all_idx)
        # shuffle the job index to make all workers equal
        # for unbalanced jobs
    else:
        job_all_idx=None
    
    job_all_idx = comm.bcast(job_all_idx,root=0)
    
    njob_per_worker = int(numjobs/size) 
    # the number of jobs should be a multiple of the NumProcess[MPI]
    
    this_worker_job = [job_all_idx[x] for x in range(rank*njob_per_worker, (rank+1)*njob_per_worker)]
    
    # map the index to parameterset [eps,anis]
    work_content = [job_content[x] for x in this_worker_job ]

    for a_piece_of_work in work_content:
        big_job(*a_piece_of_work)

if __name__=="__main__": 
    
    # parameter space to explore
    arr_a   = np.linspace(0.03,0.5,36)    
    arr_b = np.linspace(0.05,0.95,36)
    
    bigjobMPI(arr_eps,arr_alpha)
    pass
```



然后在命令行里执行：

```text
mpiexec -n 128 python myscript.py
```

如果有调度系统（如LSF），就写个提交脚本申请对应的CPU资源并运行上述命令。

就可以实现把之前的串行程序改成并行执行了。



这种并行方式非常适合用来做参数化讨论的任务，要看一个系统在各种参数不同组合情况下的计算结果，这些不同组的参数的计算本身之间是相互不影响的，所以在逻辑上是可以并行的，这里的mpi4py只是提供了一种比较方便的把已经写好的串行程序放到集群上大规模并行的工具。



## 任务提交

很多超算使用lsf任务管理系统，这种系统中多用户提交的任务由系统自动实现有优先级的调度。多用户的排队和调度使得超算资源可以最大限度地得到利用。

在这种系统中，提交任务的时候声明自己需要的资源，包括使用什么节点，需要多少物理核心。系统会根据用户的优先级以及申请的资源来进行排队调度。

例如，使用SBATCH以脚本的方式提交任务：

```bash
#!/bin/sh
# script for MPI job submission
#SBATCH -J MY_JOB_NAME
#SBATCH -o job_001-%j.log
#SBATCH -e job_001-%j.err
#SBATCH -N 8 --ntasks-per-node=40
echo Time is `date`
echo Directory is $PWD
echo This job runs on the following nodes:
echo $SLURM_JOB_NODELIST
echo This job has allocated $SLURM_JOB_CPUS_PER_NODE cpu cores.

source /path/to/env.sh # init the env
conda activate torch15 # activate the python enviroment

#module load mpich/3.2/intel/2016.3.210
MPIRUN=mpiexec # use MPICH
MPIOPT="-iface ib0" #MPICH3 # use infiniband for communication
$MPIRUN $MPIOPT -n 320 python /path/to/my_mpi4py_run.py  # the task
 
echo End at `date`  # for the measure of the running time of the 
```

其中#SBATCH 这几句声明任务和使用资源。

比如这个任务，申请使用8个节点，每个节点40线程，声明语句就是

```bash
#SBATCH -N 8 --ntasks-per-node=40
```

养成一个好习惯，填写有意义的算例名称： #SBATCH -J MY_JOB_NAME

方便后期查看log以及管理员辨识。

最后就是运行你自己程序 $MPIRUN



**值得注意的是：**超算多使用共享存储，所以在运算完之后，尽快把计算产生数据传输到自己的存储设备上然后删除超算上的部分，不要把超算存储区当成个人备份盘。



（未完）

TODO：

【mpi4py点对点通讯】

编辑于 2020-09-10

超级计算机

编程

Python

赞同 246