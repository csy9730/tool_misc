# docker help

## help

```
➜  ~ docker -h
Flag shorthand -h has been deprecated, please use --help

Usage:  docker COMMAND

A self-sufficient runtime for containers

Options:
      --config string      Location of client config files (default "/root/.docker")
  -D, --debug              Enable debug mode
      --help               Print usage
  -H, --host list          Daemon socket(s) to connect to (default [])
  -l, --log-level string   Set the logging level ("debug", "info", "warn", "error", "fatal") (default "info")
      --tls                Use TLS; implied by --tlsverify
      --tlscacert string   Trust certs signed only by this CA (default "/root/.docker/ca.pem")
      --tlscert string     Path to TLS certificate file (default "/root/.docker/cert.pem")
      --tlskey string      Path to TLS key file (default "/root/.docker/key.pem")
      --tlsverify          Use TLS and verify the remote
  -v, --version            Print version information and quit

Management Commands:
  container   Manage containers
  image       Manage images
  network     Manage networks
  node        Manage Swarm nodes
  plugin      Manage plugins
  secret      Manage Docker secrets
  service     Manage services
  stack       Manage Docker stacks
  swarm       Manage Swarm
  system      Manage Docker
  volume      Manage volumes

Commands:
  attach      Attach to a running container
  build       Build an image from a Dockerfile
  commit      Create a new image from a container's changes
  cp          Copy files/folders between a container and the local filesystem
  create      Create a new container
  diff        Inspect changes on a container's filesystem
  events      Get real time events from the server
  exec        Run a command in a running container
  export      Export a container's filesystem as a tar archive
  history     Show the history of an image
  images      List images
  import      Import the contents from a tarball to create a filesystem image
  info        Display system-wide information
  inspect     Return low-level information on Docker objects
  kill        Kill one or more running containers
  load        Load an image from a tar archive or STDIN
  login       Log in to a Docker registry
  logout      Log out from a Docker registry
  logs        Fetch the logs of a container
  pause       Pause all processes within one or more containers
  port        List port mappings or a specific mapping for the container
  ps          List containers
  pull        Pull an image or a repository from a registry
  push        Push an image or a repository to a registry
  rename      Rename a container
  restart     Restart one or more containers
  rm          Remove one or more containers
  rmi         Remove one or more images
  run         Run a command in a new container
  save        Save one or more images to a tar archive (streamed to STDOUT by default)
  search      Search the Docker Hub for images
  start       Start one or more stopped containers
  stats       Display a live stream of container(s) resource usage statistics
  stop        Stop one or more running containers
  tag         Create a tag TARGET_IMAGE that refers to SOURCE_IMAGE
  top         Display the running processes of a container
  unpause     Unpause all processes within one or more containers
  update      Update configuration of one or more containers
  version     Show the Docker version information
  wait        Block until one or more containers stop, then print their exit codes

Run 'docker COMMAND --help' for more information on a command.
➜  ~
```


### images manager


#### docker images
`docker image list` = `docker images`
列出所有镜像：
```
➜  ~ docker images
REPOSITORY              TAG                 IMAGE ID            CREATED             SIZE
docker.io/ubuntu        latest              adafef2e596e        7 months ago        73.9 MB
docker.io/hello-world   latest              bf756fb1ae65        13 months ago       13.3 kB

```
#### docker rmi

#### docker search
#### docker load
从tar文件中加载一个镜像
#### docker save

### conatainer manager

#### docker run/exec

如何使容器在终端退出时还可以后台运行？
启用 -d 守护模式。


#### docker rm/create
#### docker ps/port

#### docker start/stop/kill/pause/restart



### filesystem
#### attach

官方解释：attach Attach local standard input, output, and error streams to a running container
谷歌翻译：attach 附加将本地标准输入，输出和错误流附加到正在运行的容器

通俗解释：将终端依附到容器上（其实就是进入容器）


```
docker run -i -t ubuntu /bin/bash
```

```
docker attach c600c4519fc8
```


退出这个容器
```
[root@c600c4519fc8 /]# exit
exit
```

如何在不关闭容器的情况下，退出attach？

### misc
#### login
#### logout