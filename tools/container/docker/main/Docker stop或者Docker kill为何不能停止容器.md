# Docker stop或者Docker kill为何不能停止容器

![img](https://cdn2.jianshu.io/assets/default_avatar/5-33d2da32c552b8be9a0548c7a4576607.jpg)

[marshalzxy](https://www.jianshu.com/u/575b4f97e8d2)关注

2019.02.23 17:03:23字数 1,594阅读 22,111

# 背景

我们内部压力（cpu 80%，内存90%）通过stress （做页面压力测试）在容器内部做测试中，发现某几个时候通过
`docker stop $containerid`
docker cli退出后，短暂时间内docker ps查看到容器依然在运行状态。但是很快docker ps查看容器或者ps查看容器主进程pid就可以确认容器推出了。我们需要解释一下Docker stop发生了什么

# Docker主要执行流程

## Docker Stop主要流程

1.Docker 通过containerd向容器主进程发送SIGTERM信号后等待一段时间后，如果从containerd收到了容器退出消息那么容器退出成功。
2、在上一步中，如果等待超时，那么Docker将使用Docker kill 方式试图终止容器

## Docker Kill主要流程

1.Docker引擎通过containerd使用SIGKILL发向容器主进程，等待一段时间后，如果从containerd收到容器退出消息，那么容器Kill成功
2.在上一步中如果等待超时，Docker引擎将跳过Containerd自己亲自动手通过kill系统调用向容器主进程发送SIGKILL信号。如果此时kill系统调用返回主进程不存在，那么Docker kill成功。否则引擎将一直死等到containerd通过引擎，容器退出。

## Docker stop中存在的问题

在上文中我们看到Docker stop首先间接向容器主进程发送sigterm信号试图通知容器主进程优雅退出。**但是容器主进程如果没有显示处理sigterm信号的话，那么容器主进程对此过程会不会有任何反应，此信号被忽略了** 这里和常规认识不同，在常规想法中任何进程的默认sigterm处理应该是退出。**但是namespace中pid==1的进程，sigterm默认动作是忽略。也即是容器首进程如果不处理sigterm，那么此信号默认会被忽略，**这就是很多时候Docker Stop不能立即优雅关闭容器的原因——因为容器主进程根本没有处理SIGTERM

*特别指出linux上全局范围内pid=1的进程，不能被sigterm、sigkill、sigint终止*
*进程组首进程退出后，子进程收到sighub*

在bash shell里可以通过trap命令捕获发往shell的信号，如果docker的主进程是shell进程的话，可以通过trap命令实现SIGTERM信号的捕获和处理：

```bash
term_func(){
      echo “receiving SIGTERM”
      kill -s SIGTERM  $1
}
pid=
trap “ term_func $pid” TERM
Your command & pid = $!
wait
```

*wait 命令的意思是等待所有子进程退出。放在这里是因为，trap命令只能等前台运行的命令结束后才能处理信号，但是wait命令会在收到信号后立即退出，所以将命令后台化以后加wait，可以保证脚本对信号的即时响应。关于shell里通过trap命令处理信号的详细使用方式见《shell trap信号处理》《Sending and Trapping Signals》*

## Docker kill为何会阻塞

### 容器主/子进程处于D状态

进程D状态表示进程处于不可中断睡眠状态，一般都是在等待IO资源。当然有些时候如果系统IO出现问题，那么将有大量的进程处于D状态。在这种状态，信号是无法将进程唤醒；只有等待进程自己从D状态中返回。而且在常规内核中，如果某个进程一直处于D状态，那么理论上除了重启系统那么没有什么方法或手段将它从D中接回。

从上面解释Docker kill第二步中可以看到一旦容器中主进程或者子进程处于D状态，那么Docker将等待，一直等到所有容器主进程和其子进程都退出后才返回，那么此时Docker kill就卡住了。

## 问题解释

当出现问题时刻，宿主机上发现大量的stress进程（实际是容器的进程）处于D状态，而系统响应变慢。问题可以这样解释：
1.Docker kill通过containerd间接向容器主进程发送SIGKill信号以后，由于系统响应慢，容器内部子进程（stress）处于D状态，那么在超时时间内containerd没有上报容器退出。Docker kill走到了直接发送Sigkill阶段
2.在此阶段前，容器内部主进程退出了，所以系统调用kill 发送SIGKILL很快就返回进程不存在了。引擎认为自己把容器杀死了，Docker kill成功返回了。
3.在一定时间后容器子进程从D状态中恢复，它们退出了，containerd上报容器退出，引擎清理资源，此时Docker ps看到容器才是退出状态

## 在docker pidnamespace共享特性下容器对信号的响应

在k8s的pod下常见的场景，pause容器和其他容器共享pid namespace（pause容器pidnamespace共享给相同pod下其他容器使用）。pause容器退出后，其他容器也会退出（pause容器如果收到SIGTERM并退出了，那么其他容器也会退出）；直接给其他容器发送SIGTERM信号，pause容器不会收到SIGTERM。

# 总结

- 容器主进程最好需要自己处理SIGTERM信号，因为这是你优雅退出的机会。如果你不处理，那么在Docker stop里你会收到Kill，你未保存的数据就会直接丢失掉。
- Docker stop和Docker kill返回并不意味着容器真正退出成功了，必须通过docker ps查看。
- 对于通过restful与docker 引擎链接的客户端，需要在docker stop和kill restful请求链接上加上超时。对于docker cli用户，需要有另外的机制监控Docker stop或Docker kill命令超时卡死
- 处于D状态一致卡死的进程，内核无法杀死，docker系统也救不了它。只有重启系统才能清除。