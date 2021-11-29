# docker toolbox

docker toolbox 适用于 win7/win8，原理是通过docker实现linux虚拟机，进而运行 docker。
win10中使用hyperv实现虚拟机，进而运行docker。

## install

### arch

C:\Program Files\Docker Toolbox
- docker.exe
- docker-machine.exe
- docker-compose.exe
- docker-start.cmd
- start.sh
- docker-quickstart-terminal
- installers/
    - virtualbox/
        - virtualbox.msi
        - common.cab
- kitematic/
    - resources/
        - resources/
            - msys.dll
            - ssh.exe
        - app.asar
        - electron.asar
    - Kitematic.exe
    - locales/
        - *.pak

#### start.sh

docker-start.cmd 的内容是 `"C:\Program Files\Git\bin\bash.exe" -c " \"/c/Program Files/Docker Toolbox/start.sh\" \"%*\"" `

```
C:\Program Files\Docker Toolbox>"C:\Program Files\Docker Toolbox\docker-start.cm
d"



                        ##         .
                  ## ## ##        ==
               ## ## ## ## ##    ===
           /"""""""""""""""""\___/ ===
      ~~~ {~~ ~~~~ ~~~ ~~~~ ~~~ ~ /  ===- ~~~
           \______ o           __/
             \    \         __/
              \____\_______/

docker is configured to use the default machine with IP 192.168.99.100
For help getting started, check out the docs at https://docs.docker.com


Start shell with command

```

#### docker-machine ls

```
C:\Program Files\Docker Toolbox>docker-machine.exe ls
NAME      ACTIVE   DRIVER       STATE     URL                         SWARM   DO
CKER      ERRORS
default   -        virtualbox   Running   tcp://192.168.99.100:2376           v1
9.03.12
```

## help

```
$docker-machine --help
Usage: docker-machine [OPTIONS] COMMAND [arg...]

Create and manage machines running Docker.

Version: 0.16.1, build cce350d7

Author:
  Docker Machine Contributors - <https://github.com/docker/machine>

Options:
  --debug, -D							Enable debug mode
  --storage-path, -s "C:\Users\csy_acer_win8\.docker\machine"	Configures storage path [$MACHINE_STORAGE_PATH]
  --tls-ca-cert 						CA to verify remotes against [$MACHINE_TLS_CA_CERT]
  --tls-ca-key 							Private key to generate certificates [$MACHINE_TLS_CA_KEY]
  --tls-client-cert 						Client cert to use for TLS [$MACHINE_TLS_CLIENT_CERT]
  --tls-client-key 						Private key used in client TLS auth [$MACHINE_TLS_CLIENT_KEY]
  --github-api-token 						Token to use for requests to the Github API [$MACHINE_GITHUB_API_TOKEN]
  --native-ssh							Use the native (Go-based) SSH implementation. [$MACHINE_NATIVE_SSH]
  --bugsnag-api-token 						BugSnag API token for crash reporting [$MACHINE_BUGSNAG_API_TOKEN]
  --help, -h							show help
  --version, -v							print the version
  
Commands:
  active		Print which machine is active
  config		Print the connection config for machine
  create		Create a machine
  env			Display the commands to set up the environment for the Docker client
  inspect		Inspect information about a machine
  ip			Get the IP address of a machine
  kill			Kill a machine
  ls			List machines
  provision		Re-provision existing machines
  regenerate-certs	Regenerate TLS Certificates for a machine
  restart		Restart a machine
  rm			Remove a machine
  ssh			Log into or run a command on a machine with SSH.
  scp			Copy files between machines
  mount			Mount or unmount a directory from a machine with SSHFS.
  start			Start a machine
  status		Get the status of a machine
  stop			Stop a machine
  upgrade		Upgrade a machine to the latest version of Docker
  url			Get the URL of a machine
  version		Show the Docker Machine version or a machine docker version
  help			Shows a list of commands or help for one command
  
Run 'docker-machine COMMAND --help' for more information on a command.
```

- create 创建设备
- kill  关闭设备运行
- start 开始运行设备
- stop
- status
- restart
- rm
- ls  查看所有设备


## misc

### env init
```

PS C:\Program Files\Docker Toolbox> docker-machine env default
$Env:DOCKER_TLS_VERIFY = "1"
$Env:DOCKER_HOST = "tcp://192.168.99.100:2376"
$Env:DOCKER_CERT_PATH = "C:\Users\csy_acer_win8\.docker\machine\machines\default
"
$Env:DOCKER_MACHINE_NAME = "default"
$Env:COMPOSE_CONVERT_WINDOWS_PATHS = "true"
# Run this command to configure your shell:
# & "C:\Program Files\Docker Toolbox\docker-machine.exe" env default | Invoke-Ex
pression
```

```

C:\Program Files\Docker Toolbox>docker ps
error during connect: Get http://%2F%2F.%2Fpipe%2Fdocker_engine/v1.39/containers
/json: open //./pipe/docker_engine: The system cannot find the file specified. I
n the default daemon configuration on Windows, the docker client must be run ele
vated to connect. This error may also indicate that the docker daemon is not run
ning.
```
### rebuild default


``` bash
docker-machine kill default
docker-machine rm default
docker-machine create -d virtualbox --virtualbox-disk-size "50000" default
```


