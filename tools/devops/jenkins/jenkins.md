# jenkins

## install

### run
``` bash
cd "cd C:\Program Files (x86)\Jenkins"
# 关闭Jenkins服务：
jenkins.exe stop;
# 重启Jenkins服务：
jenkins.exe start;
```
## arch
Jenkins

* jenkins.exe
* Jenkins.war
* jenkins.exe.config
* jenkins.xml
* jenkins.out.log
* jenkins.err.log
* jenkins.wrapper.log

### xml
``` xml
<service>
  <id>jenkins</id>
  <name>Jenkins</name>
  <description>This service runs Jenkins automation server.</description>
  <env name="JENKINS_HOME" value="%LocalAppData%\Jenkins\.jenkins"/>
  <executable>C:\Program Files\Java\jre1.8.0_201\bin\java.exe</executable>
  <arguments>-Xrs -Xmx256m -Dhudson.lifecycle=hudson.lifecycle.WindowsServiceLifecycle -jar "E:\Program Files\Jenkins\jenkins.war" --httpPort=8108 --webroot="%LocalAppData%\Jenkins\war"</arguments>
  <logmode>rotate</logmode>
  <onfailure action="restart"/>
  <extensions>
    <!-- This is a sample configuration for the RunawayProcessKiller extension. -->
    <extension enabled="true" className="winsw.Plugins.RunawayProcessKiller.RunawayProcessKillerExtension" id="killOnStartup">
      <pidfile>%LocalAppData%\Jenkins\jenkins.pid</pidfile>
      <stopTimeout>10000</stopTimeout>
      <stopParentFirst>false</stopParentFirst>
    </extension>
  </extensions>

</service>
```

可以看到 默认的 `"JENKINS_HOME"="%LocalAppData%\Jenkins\.jenkins"`

### 工作目录

默认工作目录：`C:\Windows\System32\config\systemprofile\AppData\Local\Jenkins\.jenkins`
修改Jenkins工作目录为：D:\jenkins（修改前关闭tomcat服务）

  在环境变量中增加：JENKINS_HOME，值：D:\jenkins

  修改后启动tomcat服务

### help
``` 
A wrapper binary that can be used to host executables as Windows services

Usage: winsw [/redirect file] <command> [<args>]
       Missing arguments trigger the service mode

Available commands:
  install     install the service to Windows Service Controller
  uninstall   uninstall the service
  start       start the service (must be installed before)
  stop        stop the service
  stopwait    stop the service and wait until it's actually stopped
  restart     restart the service
  restart!    self-restart (can be called from child processes)
  status      check the current status of the service
  test        check if the service can be started and then stopped
  testwait    starts the service and waits until a key is pressed then stops the service
  version     print the version info
  help        print the help info (aliases: -h,--help,-?,/?)

Extra options:
  /redirect   redirect the wrapper's STDOUT and STDERR to the specified file

WinSW 2.9.0.0
More info: https://github.com/kohsuke/winsw
Bug tracker: https://github.com/kohsuke/winsw/issues
```

## misc
gogs 发送事件，jenkins消费事件，worker执行事件。