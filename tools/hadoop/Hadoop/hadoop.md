# hadoop

[http://hadoop.apache.org/](http://hadoop.apache.org/)

The Apache™ Hadoop® project develops open-source software for reliable, scalable, distributed computing.

The Apache Hadoop software library is a framework that allows for the distributed processing of large data sets across clusters of computers using simple programming models. It is designed to scale up from single servers to thousands of machines, each offering local computation and storage. Rather than rely on hardware to deliver high-availability, the library itself is designed to detect and handle failures at the application layer, so delivering a highly-available service on top of a cluster of computers, each of which may be prone to failures.

## install

### download

[https://dlcdn.apache.org/hadoop/common/stable/](https://dlcdn.apache.org/hadoop/common/stable/)


### install
```
bin/  
	container-executor  
	hadoop  hadoop.cmd  
	hdfs  hdfs.cmd  
	mapred.cmd   mapred
	test-container-executor  
	yarn yarn.cmd
    oom-listener  
include/  
lib/      
sbin/
	FederationStateStore/   mr-jobhistory-daemon.sh         workers.sh
	distribute-exclude.sh  refresh-namenodes.sh   httpfs.sh    kms.sh            
	hadoop-daemon.sh    hadoop-daemons.sh       
	start-all.cmd start-all.sh  stop-all.cmd    stop-all.sh               
	start-dfs.sh     start-dfs.cmd        stop-dfs.sh    stop-dfs.cmd  
	start-yarn.cmd  start-yarn.sh  stop-yarn.cmd   stop-yarn.sh yarn-daemons.sh   yarn-daemon.sh 
	start-secure-dns.sh   stop-secure-dns.sh
	start-balancer.sh    stop-balancer.sh             
                  
etc/hadoop/
	capacity-scheduler.xml      hadoop-user-functions.sh.example  kms-log4j.properties        ssl-client.xml.example
	configuration.xsl           hdfs-rbf-site.xml                 kms-site.xml                ssl-server.xml.example
	container-executor.cfg      hdfs-site.xml                     log4j.properties            user_ec_policies.xml.template
	core-site.xml               httpfs-env.sh                     mapred-env.cmd              workers
	hadoop-env.cmd              httpfs-log4j.properties           mapred-env.sh               yarn-env.cmd
	hadoop-env.sh               httpfs-site.xml                   mapred-queues.xml.template  yarn-env.sh
	hadoop-metrics2.properties  kms-acls.xml                      mapred-site.xml             yarn-site.xml
	hadoop-policy.xml           kms-env.sh                        shellprofile.d              yarnservice-log4j.properties
share/
input/    
libexec/  

licenses-binary  NOTICE-binary  README.txt  
LICENSE-binary    LICENSE.txt    NOTICE.txt 
```
### config

``` bash
# set to the root of your Java installation
export JAVA_HOME=/usr/java/latest

```

### run

``` bash
hadoop version



Hadoop 3.3.4
Source code repository https://github.com/apache/hadoop.git -r a585a73c3e02ac6136643a5e72350cf6095a3dbb
Compiled by stevel on 2022-07-29T12:32Z
Compiled with protoc 3.7.1
From source with checksum fb9dd8918a7b8a5b430d61af858f6ec
This command was run using /opt/hadoop-3.3.4/share/hadoop/common/hadoop-common-3.3.4.jar
```





#### 三种模式
之前提到过的 Hadoop 三种模式：单机模式、伪集群模式和集群模式。

单机模式：Hadoop 仅作为库存在，可以在单计算机上执行 MapReduce 任务，仅用于开发者搭建学习和试验环境。

伪集群模式：此模式 Hadoop 将以守护进程的形式在单机运行，一般用于开发者搭建学习和试验环境。

集群模式：此模式是 Hadoop 的生产环境模式，也就是说这才是 Hadoop 真正使用的模式，用于提供生产级服务。

- [Local (Standalone) Mode](https://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-common/SingleCluster.html#Standalone_Operation)
- [Pseudo-Distributed Mode](https://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-common/SingleCluster.html#Pseudo-Distributed_Operation)
- [Fully-Distributed Mode](https://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-common/SingleCluster.html#Fully-Distributed_Operation)


### run HDFS

#### config

`cd $HADOOP_HOME/etc/hadoop`
这里我们修改两个文件：core-site.xml 和 hdfs-site.xml

在 core-site.xml 中，我们在 标签下添加属性：
``` xml
<property>
    <name>fs.defaultFS</name>
    <value>hdfs://<你的IP>:9000</value>
</property>
```
在 hdfs-site.xml 中的 标签下添加属性：
``` xml
<property>
    <name>dfs.replication</name>
    <value>1</value>
</property>
```
格式化文件结构：

`hdfs namenode -format`

#### config hadoop-env.sh

```
root@DESKTOP:/opt/hadoop-3.3.4# ./sbin/start-dfs.sh
/usr/local/lib/jdk1.8.0_361
Starting namenodes on [localhost]
ERROR: Attempting to operate on hdfs namenode as root
ERROR: but there is no HDFS_NAMENODE_USER defined. Aborting operation.
Starting datanodes
ERROR: Attempting to operate on hdfs datanode as root
ERROR: but there is no HDFS_DATANODE_USER defined. Aborting operation.
Starting secondary namenodes [DESKTOP]
ERROR: Attempting to operate on hdfs secondarynamenode as root
ERROR: but there is no HDFS_SECONDARYNAMENODE_USER defined. Aborting operation.
```

```
export HDFS_NAMENODE_USER=root
export HDFS_DATANODE_USER=root
export HDFS_SECONDARYNAMENODE_USER=root
export YARN_RESOURCEMANAGER_USER=root
export YARN_NODEMANAGER_USER=root
```

`$HADOOP_HOME/etc/hadoop/hadoop-env.sh`


#### start-dfs.sh
然后启动 HDFS：


```
start-dfs.sh
```
启动分三个步骤，分别启动 NameNode、DataNode 和 Secondary NameNode。



## misc
### faq
```
hduser@desktop's password:
DESKTOP: /opt/hadoop-3.3.4/etc/hadoop/hadoop-env.sh: line 444: fg: no job control
DESKTOP: /opt/hadoop-3.3.4/etc/hadoop/hadoop-env.sh: line 444: fg: no job control
DESKTOP: /opt/hadoop-3.3.4/etc/hadoop/hadoop-env.sh: line 444: fg: no job control
DESKTOP: /opt/hadoop-3.3.4/etc/hadoop/hadoop-env.sh: line 445: fg: no job control
DESKTOP: /opt/hadoop-3.3.4/etc/hadoop/hadoop-env.sh: line 445: fg: no job control
DESKTOP: /opt/hadoop-3.3.4/bin/../libexec/hadoop-functions.sh: line 1186: dirname: command not found
DESKTOP: /opt/hadoop-3.3.4/bin/../libexec/hadoop-functions.sh: line 1186: dirname: command not found
DESKTOP: /opt/hadoop-3.3.4/bin/../libexec/hadoop-functions.sh: line 1186: dirname: command not found
DESKTOP: /opt/hadoop-3.3.4/bin/../libexec/hadoop-functions.sh: line 1186: dirname: command not found
DESKTOP: /opt/hadoop-3.3.4/bin/../libexec/hadoop-functions.sh: line 1186: dirname: command not found
DESKTOP: /opt/hadoop-3.3.4/bin/../libexec/hadoop-functions.sh: line 1186: dirname: command not found
DESKTOP: /opt/hadoop-3.3.4/bin/../libexec/hadoop-functions.sh: line 1186: dirname: command not found
DESKTOP: /opt/hadoop-3.3.4/bin/../libexec/hadoop-functions.sh: line 1186: dirname: command not found
DESKTOP: /opt/hadoop-3.3.4/bin/../libexec/hadoop-functions.sh: line 67: dirname: command not found
DESKTOP: /opt/hadoop-3.3.4/bin/../libexec/hadoop-functions.sh: line 68: basename: command not found
DESKTOP: ERROR: Unable to write in /tmp. Aborting.
```
