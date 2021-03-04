# jenkins


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