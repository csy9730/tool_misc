# hadoop

[http://hadoop.apache.org/](http://hadoop.apache.org/)

The Apache™ Hadoop® project develops open-source software for reliable, scalable, distributed computing.

The Apache Hadoop software library is a framework that allows for the distributed processing of large data sets across clusters of computers using simple programming models. It is designed to scale up from single servers to thousands of machines, each offering local computation and storage. Rather than rely on hardware to deliver high-availability, the library itself is designed to detect and handle failures at the application layer, so delivering a highly-available service on top of a cluster of computers, each of which may be prone to failures.

## install

```
sudo apt-get install ssh
udo apt-get install pdsh



```

[https://dlcdn.apache.org/hadoop/common/stable/](https://dlcdn.apache.org/hadoop/common/stable/)


### file arch
```
bin/  
include/  
lib/      
sbin/
etc/  
share/
input/    
libexec/  

licenses-binary  NOTICE-binary  README.txt  
 LICENSE-binary    LICENSE.txt    NOTICE.txt 
```

### run
``` bash

 # set to the root of your Java installation
  export JAVA_HOME=/usr/java/latest


bin/hadoop
  ```


- [Local (Standalone) Mode](https://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-common/SingleCluster.html#Standalone_Operation)
- [Pseudo-Distributed Mode](https://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-common/SingleCluster.html#Pseudo-Distributed_Operation)
- [Fully-Distributed Mode](https://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-common/SingleCluster.html#Fully-Distributed_Operation)

#### Standalone Mode

```
  $ mkdir input
  $ cp etc/hadoop/*.xml input
  $ bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-3.3.1.jar grep input output 'dfs[a-z.]+'
  $ cat output/*

```


```
➜  hadoop-3.3.1 bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-3.3.1.jar grep input output 'dfs[a-z.]+'
2021-11-12 22:23:11,630 INFO impl.MetricsConfig: Loaded properties from hadoop-metrics2.properties
2021-11-12 22:23:11,678 INFO impl.MetricsSystemImpl: Scheduled Metric snapshot period at 10 second(s).
2021-11-12 22:23:11,678 INFO impl.MetricsSystemImpl: JobTracker metrics system started
2021-11-12 22:23:11,754 INFO input.FileInputFormat: Total input files to process : 10
2021-11-12 22:23:11,766 INFO mapreduce.JobSubmitter: number of splits:10
2021-11-12 22:23:11,838 INFO mapreduce.JobSubmitter: Submitting tokens for job: job_local1714907630_0001
2021-11-12 22:23:11,838 INFO mapreduce.JobSubmitter: Executing with tokens: []
2021-11-12 22:23:11,909 INFO mapreduce.Job: The url to track the job: http://localhost:8080/
2021-11-12 22:23:11,909 INFO mapreduce.Job: Running job: job_local1714907630_0001
2021-11-12 22:23:11,910 INFO mapred.LocalJobRunner: OutputCommitter set in config null
2021-11-12 22:23:11,913 INFO output.FileOutputCommitter: File Output Committer Algorithm version is 2
2021-11-12 22:23:11,913 INFO output.FileOutputCommitter: FileOutputCommitter skip cleanup _temporary folders under output directory:false, ignore cleanup failures: false
2021-11-12 22:23:11,913 INFO mapred.LocalJobRunner: OutputCommitter is org.apache.hadoop.mapreduce.lib.output.FileOutputCommitter
2021-11-12 22:23:11,934 INFO mapred.LocalJobRunner: Waiting for map tasks
2021-11-12 22:23:11,935 INFO mapred.LocalJobRunner: Starting task: attempt_local1714907630_0001_m_000000_0
2021-11-12 22:23:11,947 INFO output.FileOutputCommitter: File Output Committer Algorithm version is 2
2021-11-12 22:23:11,947 INFO output.FileOutputCommitter: FileOutputCommitter skip cleanup _temporary folders under output directory:false, ignore cleanup failures: false
2021-11-12 22:23:11,955 INFO mapred.Task:  Using ResourceCalculatorProcessTree : [ ]
2021-11-12 22:23:11,957 INFO mapred.MapTask: Processing split: file:/home/csy/bin/hadoop-3.3.1/input/hadoop-policy.xml:0+11765
2021-11-12 22:23:11,992 INFO mapred.MapTask: (EQUATOR) 0 kvi 26214396(104857584)
2021-11-12 22:23:11,992 INFO mapred.MapTask: mapreduce.task.io.sort.mb: 100
2021-11-12 22:23:11,992 INFO mapred.MapTask: soft limit at 83886080
2021-11-12 22:23:11,992 INFO mapred.MapTask: bufstart = 0; bufvoid = 104857600
2021-11-12 22:23:11,992 INFO mapred.MapTask: kvstart = 26214396; length = 6553600
2021-11-12 22:23:11,995 INFO mapred.MapTask: Map output collector class = org.apache.hadoop.mapred.MapTask$MapOutputBuffer
2021-11-12 22:23:12,006 INFO mapred.LocalJobRunner: 
2021-11-12 22:23:12,006 INFO mapred.MapTask: Starting flush of map output
2021-11-12 22:23:12,006 INFO mapred.MapTask: Spilling map output
2021-11-12 22:23:12,006 INFO mapred.MapTask: bufstart = 0; bufend = 17; bufvoid = 104857600
2021-11-12 22:23:12,006 INFO mapred.MapTask: kvstart = 26214396(104857584); kvend = 26214396(104857584); length = 1/6553600
2021-11-12 22:23:12,013 INFO mapred.MapTask: Finished spill 0
2021-11-12 22:23:12,019 INFO mapred.Task: Task:attempt_local1714907630_0001_m_000000_0 is done. And is in the process of committing
2021-11-12 22:23:12,020 INFO mapred.LocalJobRunner: map
2021-11-12 22:23:12,020 INFO mapred.Task: Task 'attempt_local1714907630_0001_m_000000_0' done.
2021-11-12 22:23:12,024 INFO mapred.Task: Final Counters for attempt_local1714907630_0001_m_000000_0: Counters: 18
	File System Counters
		FILE: Number of bytes read=294147
		FILE: Number of bytes written=912054
		FILE: Number of read operations=0
		FILE: Number of large read operations=0
		FILE: Number of write operations=0
	Map-Reduce Framework
		Map input records=275
		Map output records=1
		Map output bytes=17
		Map output materialized bytes=25
		Input split bytes=120
		Combine input records=1
		Combine output records=1
		Spilled Records=1
		Failed Shuffles=0
		Merged Map outputs=0
		GC time elapsed (ms)=0
		Total committed heap usage (bytes)=251658240
	File Input Format Counters 
		Bytes Read=11765
2021-11-12 22:23:12,024 INFO mapred.LocalJobRunner: Finishing task: attempt_local1714907630_0001_m_000000_0
2021-11-12 22:23:12,025 INFO mapred.LocalJobRunner: Starting task: attempt_local1714907630_0001_m_000001_0
2021-11-12 22:23:12,025 INFO output.FileOutputCommitter: File Output Committer Algorithm version is 2
2021-11-12 22:23:12,025 INFO output.FileOutputCommitter: FileOutputCommitter skip cleanup _temporary folders under output directory:false, ignore cleanup failures: false
2021-11-12 22:23:12,025 INFO mapred.Task:  Using ResourceCalculatorProcessTree : [ ]
2021-11-12 22:23:12,026 INFO mapred.MapTask: Processing split: file:/home/csy/bin/hadoop-3.3.1/input/capacity-scheduler.xml:0+9213
2021-11-12 22:23:12,054 INFO mapred.MapTask: (EQUATOR) 0 kvi 26214396(104857584)
2021-11-12 22:23:12,054 INFO mapred.MapTask: mapreduce.task.io.sort.mb: 100
2021-11-12 22:23:12,054 INFO mapred.MapTask: soft limit at 83886080
2021-11-12 22:23:12,054 INFO mapred.MapTask: bufstart = 0; bufvoid = 104857600
2021-11-12 22:23:12,054 INFO mapred.MapTask: kvstart = 26214396; length = 6553600
2021-11-12 22:23:12,054 INFO mapred.MapTask: Map output collector class = org.apache.hadoop.mapred.MapTask$MapOutputBuffer
2021-11-12 22:23:12,057 INFO mapred.LocalJobRunner: 
2021-11-12 22:23:12,057 INFO mapred.MapTask: Starting flush of map output
2021-11-12 22:23:12,059 INFO mapred.Task: Task:attempt_local1714907630_0001_m_000001_0 is done. And is in the process of committing
2021-11-12 22:23:12,059 INFO mapred.LocalJobRunner: map
2021-11-12 22:23:12,060 INFO mapred.Task: Task 'attempt_local1714907630_0001_m_000001_0' done.
2021-11-12 22:23:12,060 INFO mapred.Task: Final Counters for attempt_local1714907630_0001_m_000001_0: Counters: 18
	File System Counters
		FILE: Number of bytes read=304566
		FILE: Number of bytes written=912092
		FILE: Number of read operations=0
		FILE: Number of large read operations=0
		FILE: Number of write operations=0
	Map-Reduce Framework
		Map input records=244
		Map output records=0
		Map output bytes=0
		Map output materialized bytes=6
		Input split bytes=125
		Combine input records=0
		Combine output records=0
		Spilled Records=0
		Failed Shuffles=0
		Merged Map outputs=0
		GC time elapsed (ms)=0
		Total committed heap usage (bytes)=357040128
	File Input Format Counters 
		Bytes Read=9213
2021-11-12 22:23:12,060 INFO mapred.LocalJobRunner: Finishing task: attempt_local1714907630_0001_m_000001_0
2021-11-12 22:23:12,060 INFO mapred.LocalJobRunner: Starting task: attempt_local1714907630_0001_m_000002_0
2021-11-12 22:23:12,060 INFO output.FileOutputCommitter: File Output Committer Algorithm version is 2
2021-11-12 22:23:12,061 INFO output.FileOutputCommitter: FileOutputCommitter skip cleanup _temporary folders under output directory:false, ignore cleanup failures: false
2021-11-12 22:23:12,061 INFO mapred.Task:  Using ResourceCalculatorProcessTree : [ ]
2021-11-12 22:23:12,061 INFO mapred.MapTask: Processing split: file:/home/csy/bin/hadoop-3.3.1/input/kms-acls.xml:0+3518
2021-11-12 22:23:12,088 INFO mapred.MapTask: (EQUATOR) 0 kvi 26214396(104857584)
2021-11-12 22:23:12,089 INFO mapred.MapTask: mapreduce.task.io.sort.mb: 100
2021-11-12 22:23:12,089 INFO mapred.MapTask: soft limit at 83886080
2021-11-12 22:23:12,089 INFO mapred.MapTask: bufstart = 0; bufvoid = 104857600
2021-11-12 22:23:12,089 INFO mapred.MapTask: kvstart = 26214396; length = 6553600
2021-11-12 22:23:12,089 INFO mapred.MapTask: Map output collector class = org.apache.hadoop.mapred.MapTask$MapOutputBuffer
2021-11-12 22:23:12,091 INFO mapred.LocalJobRunner: 
2021-11-12 22:23:12,091 INFO mapred.MapTask: Starting flush of map output
2021-11-12 22:23:12,092 INFO mapred.Task: Task:attempt_local1714907630_0001_m_000002_0 is done. And is in the process of committing
2021-11-12 22:23:12,093 INFO mapred.LocalJobRunner: map
2021-11-12 22:23:12,093 INFO mapred.Task: Task 'attempt_local1714907630_0001_m_000002_0' done.
2021-11-12 22:23:12,093 INFO mapred.Task: Final Counters for attempt_local1714907630_0001_m_000002_0: Counters: 18
	File System Counters
		FILE: Number of bytes read=309290
		FILE: Number of bytes written=912130
		FILE: Number of read operations=0
		FILE: Number of large read operations=0
		FILE: Number of write operations=0
	Map-Reduce Framework
		Map input records=135
		Map output records=0
		Map output bytes=0
		Map output materialized bytes=6
		Input split bytes=115
		Combine input records=0
		Combine output records=0
		Spilled Records=0
		Failed Shuffles=0
		Merged Map outputs=0
		GC time elapsed (ms)=0
		Total committed heap usage (bytes)=462422016
	File Input Format Counters 
		Bytes Read=3518
2021-11-12 22:23:12,093 INFO mapred.LocalJobRunner: Finishing task: attempt_local1714907630_0001_m_000002_0
2021-11-12 22:23:12,093 INFO mapred.LocalJobRunner: Starting task: attempt_local1714907630_0001_m_000003_0
2021-11-12 22:23:12,093 INFO output.FileOutputCommitter: File Output Committer Algorithm version is 2
2021-11-12 22:23:12,093 INFO output.FileOutputCommitter: FileOutputCommitter skip cleanup _temporary folders under output directory:false, ignore cleanup failures: false
2021-11-12 22:23:12,094 INFO mapred.Task:  Using ResourceCalculatorProcessTree : [ ]
2021-11-12 22:23:12,094 INFO mapred.MapTask: Processing split: file:/home/csy/bin/hadoop-3.3.1/input/hdfs-site.xml:0+775
2021-11-12 22:23:12,121 INFO mapred.MapTask: (EQUATOR) 0 kvi 26214396(104857584)
2021-11-12 22:23:12,121 INFO mapred.MapTask: mapreduce.task.io.sort.mb: 100
2021-11-12 22:23:12,121 INFO mapred.MapTask: soft limit at 83886080
2021-11-12 22:23:12,121 INFO mapred.MapTask: bufstart = 0; bufvoid = 104857600
2021-11-12 22:23:12,121 INFO mapred.MapTask: kvstart = 26214396; length = 6553600
2021-11-12 22:23:12,122 INFO mapred.MapTask: Map output collector class = org.apache.hadoop.mapred.MapTask$MapOutputBuffer
2021-11-12 22:23:12,123 INFO mapred.LocalJobRunner: 
2021-11-12 22:23:12,123 INFO mapred.MapTask: Starting flush of map output
2021-11-12 22:23:12,124 INFO mapred.Task: Task:attempt_local1714907630_0001_m_000003_0 is done. And is in the process of committing
2021-11-12 22:23:12,125 INFO mapred.LocalJobRunner: map
2021-11-12 22:23:12,125 INFO mapred.Task: Task 'attempt_local1714907630_0001_m_000003_0' done.
2021-11-12 22:23:12,125 INFO mapred.Task: Final Counters for attempt_local1714907630_0001_m_000003_0: Counters: 18
	File System Counters
		FILE: Number of bytes read=311271
		FILE: Number of bytes written=912168
		FILE: Number of read operations=0
		FILE: Number of large read operations=0
		FILE: Number of write operations=0
	Map-Reduce Framework
		Map input records=21
		Map output records=0
		Map output bytes=0
		Map output materialized bytes=6
		Input split bytes=116
		Combine input records=0
		Combine output records=0
		Spilled Records=0
		Failed Shuffles=0
		Merged Map outputs=0
		GC time elapsed (ms)=0
		Total committed heap usage (bytes)=567803904
	File Input Format Counters 
		Bytes Read=775
2021-11-12 22:23:12,125 INFO mapred.LocalJobRunner: Finishing task: attempt_local1714907630_0001_m_000003_0
2021-11-12 22:23:12,125 INFO mapred.LocalJobRunner: Starting task: attempt_local1714907630_0001_m_000004_0
2021-11-12 22:23:12,126 INFO output.FileOutputCommitter: File Output Committer Algorithm version is 2
2021-11-12 22:23:12,126 INFO output.FileOutputCommitter: FileOutputCommitter skip cleanup _temporary folders under output directory:false, ignore cleanup failures: false
2021-11-12 22:23:12,126 INFO mapred.Task:  Using ResourceCalculatorProcessTree : [ ]
2021-11-12 22:23:12,126 INFO mapred.MapTask: Processing split: file:/home/csy/bin/hadoop-3.3.1/input/core-site.xml:0+774
2021-11-12 22:23:12,153 INFO mapred.MapTask: (EQUATOR) 0 kvi 26214396(104857584)
2021-11-12 22:23:12,153 INFO mapred.MapTask: mapreduce.task.io.sort.mb: 100
2021-11-12 22:23:12,154 INFO mapred.MapTask: soft limit at 83886080
2021-11-12 22:23:12,154 INFO mapred.MapTask: bufstart = 0; bufvoid = 104857600
2021-11-12 22:23:12,154 INFO mapred.MapTask: kvstart = 26214396; length = 6553600
2021-11-12 22:23:12,155 INFO mapred.MapTask: Map output collector class = org.apache.hadoop.mapred.MapTask$MapOutputBuffer
2021-11-12 22:23:12,157 INFO mapred.LocalJobRunner: 
2021-11-12 22:23:12,157 INFO mapred.MapTask: Starting flush of map output
2021-11-12 22:23:12,158 INFO mapred.Task: Task:attempt_local1714907630_0001_m_000004_0 is done. And is in the process of committing
2021-11-12 22:23:12,158 INFO mapred.LocalJobRunner: map
2021-11-12 22:23:12,158 INFO mapred.Task: Task 'attempt_local1714907630_0001_m_000004_0' done.
2021-11-12 22:23:12,159 INFO mapred.Task: Final Counters for attempt_local1714907630_0001_m_000004_0: Counters: 18
	File System Counters
		FILE: Number of bytes read=313251
		FILE: Number of bytes written=912206
		FILE: Number of read operations=0
		FILE: Number of large read operations=0
		FILE: Number of write operations=0
	Map-Reduce Framework
		Map input records=20
		Map output records=0
		Map output bytes=0
		Map output materialized bytes=6
		Input split bytes=116
		Combine input records=0
		Combine output records=0
		Spilled Records=0
		Failed Shuffles=0
		Merged Map outputs=0
		GC time elapsed (ms)=0
		Total committed heap usage (bytes)=673185792
	File Input Format Counters 
		Bytes Read=774
2021-11-12 22:23:12,159 INFO mapred.LocalJobRunner: Finishing task: attempt_local1714907630_0001_m_000004_0
2021-11-12 22:23:12,159 INFO mapred.LocalJobRunner: Starting task: attempt_local1714907630_0001_m_000005_0
2021-11-12 22:23:12,159 INFO output.FileOutputCommitter: File Output Committer Algorithm version is 2
2021-11-12 22:23:12,159 INFO output.FileOutputCommitter: FileOutputCommitter skip cleanup _temporary folders under output directory:false, ignore cleanup failures: false
2021-11-12 22:23:12,159 INFO mapred.Task:  Using ResourceCalculatorProcessTree : [ ]
2021-11-12 22:23:12,160 INFO mapred.MapTask: Processing split: file:/home/csy/bin/hadoop-3.3.1/input/mapred-site.xml:0+758
2021-11-12 22:23:12,187 INFO mapred.MapTask: (EQUATOR) 0 kvi 26214396(104857584)
2021-11-12 22:23:12,187 INFO mapred.MapTask: mapreduce.task.io.sort.mb: 100
2021-11-12 22:23:12,187 INFO mapred.MapTask: soft limit at 83886080
2021-11-12 22:23:12,187 INFO mapred.MapTask: bufstart = 0; bufvoid = 104857600
2021-11-12 22:23:12,187 INFO mapred.MapTask: kvstart = 26214396; length = 6553600
2021-11-12 22:23:12,187 INFO mapred.MapTask: Map output collector class = org.apache.hadoop.mapred.MapTask$MapOutputBuffer
2021-11-12 22:23:12,189 INFO mapred.LocalJobRunner: 
2021-11-12 22:23:12,189 INFO mapred.MapTask: Starting flush of map output
2021-11-12 22:23:12,190 INFO mapred.Task: Task:attempt_local1714907630_0001_m_000005_0 is done. And is in the process of committing
2021-11-12 22:23:12,191 INFO mapred.LocalJobRunner: map
2021-11-12 22:23:12,191 INFO mapred.Task: Task 'attempt_local1714907630_0001_m_000005_0' done.
2021-11-12 22:23:12,191 INFO mapred.Task: Final Counters for attempt_local1714907630_0001_m_000005_0: Counters: 18
	File System Counters
		FILE: Number of bytes read=314703
		FILE: Number of bytes written=912244
		FILE: Number of read operations=0
		FILE: Number of large read operations=0
		FILE: Number of write operations=0
	Map-Reduce Framework
		Map input records=21
		Map output records=0
		Map output bytes=0
		Map output materialized bytes=6
		Input split bytes=118
		Combine input records=0
		Combine output records=0
		Spilled Records=0
		Failed Shuffles=0
		Merged Map outputs=0
		GC time elapsed (ms)=0
		Total committed heap usage (bytes)=778567680
	File Input Format Counters 
		Bytes Read=758
2021-11-12 22:23:12,191 INFO mapred.LocalJobRunner: Finishing task: attempt_local1714907630_0001_m_000005_0
2021-11-12 22:23:12,191 INFO mapred.LocalJobRunner: Starting task: attempt_local1714907630_0001_m_000006_0
2021-11-12 22:23:12,191 INFO output.FileOutputCommitter: File Output Committer Algorithm version is 2
2021-11-12 22:23:12,191 INFO output.FileOutputCommitter: FileOutputCommitter skip cleanup _temporary folders under output directory:false, ignore cleanup failures: false
2021-11-12 22:23:12,191 INFO mapred.Task:  Using ResourceCalculatorProcessTree : [ ]
2021-11-12 22:23:12,192 INFO mapred.MapTask: Processing split: file:/home/csy/bin/hadoop-3.3.1/input/yarn-site.xml:0+690
2021-11-12 22:23:12,219 INFO mapred.MapTask: (EQUATOR) 0 kvi 26214396(104857584)
2021-11-12 22:23:12,219 INFO mapred.MapTask: mapreduce.task.io.sort.mb: 100
2021-11-12 22:23:12,219 INFO mapred.MapTask: soft limit at 83886080
2021-11-12 22:23:12,219 INFO mapred.MapTask: bufstart = 0; bufvoid = 104857600
2021-11-12 22:23:12,219 INFO mapred.MapTask: kvstart = 26214396; length = 6553600
2021-11-12 22:23:12,219 INFO mapred.MapTask: Map output collector class = org.apache.hadoop.mapred.MapTask$MapOutputBuffer
2021-11-12 22:23:12,220 INFO mapred.LocalJobRunner: 
2021-11-12 22:23:12,220 INFO mapred.MapTask: Starting flush of map output
2021-11-12 22:23:12,222 INFO mapred.Task: Task:attempt_local1714907630_0001_m_000006_0 is done. And is in the process of committing
2021-11-12 22:23:12,222 INFO mapred.LocalJobRunner: map
2021-11-12 22:23:12,222 INFO mapred.Task: Task 'attempt_local1714907630_0001_m_000006_0' done.
2021-11-12 22:23:12,222 INFO mapred.Task: Final Counters for attempt_local1714907630_0001_m_000006_0: Counters: 18
	File System Counters
		FILE: Number of bytes read=316087
		FILE: Number of bytes written=912282
		FILE: Number of read operations=0
		FILE: Number of large read operations=0
		FILE: Number of write operations=0
	Map-Reduce Framework
		Map input records=19
		Map output records=0
		Map output bytes=0
		Map output materialized bytes=6
		Input split bytes=116
		Combine input records=0
		Combine output records=0
		Spilled Records=0
		Failed Shuffles=0
		Merged Map outputs=0
		GC time elapsed (ms)=0
		Total committed heap usage (bytes)=883949568
	File Input Format Counters 
		Bytes Read=690
2021-11-12 22:23:12,223 INFO mapred.LocalJobRunner: Finishing task: attempt_local1714907630_0001_m_000006_0
2021-11-12 22:23:12,223 INFO mapred.LocalJobRunner: Starting task: attempt_local1714907630_0001_m_000007_0
2021-11-12 22:23:12,223 INFO output.FileOutputCommitter: File Output Committer Algorithm version is 2
2021-11-12 22:23:12,223 INFO output.FileOutputCommitter: FileOutputCommitter skip cleanup _temporary folders under output directory:false, ignore cleanup failures: false
2021-11-12 22:23:12,223 INFO mapred.Task:  Using ResourceCalculatorProcessTree : [ ]
2021-11-12 22:23:12,224 INFO mapred.MapTask: Processing split: file:/home/csy/bin/hadoop-3.3.1/input/hdfs-rbf-site.xml:0+683
2021-11-12 22:23:12,250 INFO mapred.MapTask: (EQUATOR) 0 kvi 26214396(104857584)
2021-11-12 22:23:12,250 INFO mapred.MapTask: mapreduce.task.io.sort.mb: 100
2021-11-12 22:23:12,250 INFO mapred.MapTask: soft limit at 83886080
2021-11-12 22:23:12,250 INFO mapred.MapTask: bufstart = 0; bufvoid = 104857600
2021-11-12 22:23:12,250 INFO mapred.MapTask: kvstart = 26214396; length = 6553600
2021-11-12 22:23:12,251 INFO mapred.MapTask: Map output collector class = org.apache.hadoop.mapred.MapTask$MapOutputBuffer
2021-11-12 22:23:12,252 INFO mapred.LocalJobRunner: 
2021-11-12 22:23:12,252 INFO mapred.MapTask: Starting flush of map output
2021-11-12 22:23:12,253 INFO mapred.Task: Task:attempt_local1714907630_0001_m_000007_0 is done. And is in the process of committing
2021-11-12 22:23:12,253 INFO mapred.LocalJobRunner: map
2021-11-12 22:23:12,253 INFO mapred.Task: Task 'attempt_local1714907630_0001_m_000007_0' done.
2021-11-12 22:23:12,253 INFO mapred.Task: Final Counters for attempt_local1714907630_0001_m_000007_0: Counters: 18
	File System Counters
		FILE: Number of bytes read=317464
		FILE: Number of bytes written=912320
		FILE: Number of read operations=0
		FILE: Number of large read operations=0
		FILE: Number of write operations=0
	Map-Reduce Framework
		Map input records=20
		Map output records=0
		Map output bytes=0
		Map output materialized bytes=6
		Input split bytes=120
		Combine input records=0
		Combine output records=0
		Spilled Records=0
		Failed Shuffles=0
		Merged Map outputs=0
		GC time elapsed (ms)=0
		Total committed heap usage (bytes)=989331456
	File Input Format Counters 
		Bytes Read=683
2021-11-12 22:23:12,253 INFO mapred.LocalJobRunner: Finishing task: attempt_local1714907630_0001_m_000007_0
2021-11-12 22:23:12,254 INFO mapred.LocalJobRunner: Starting task: attempt_local1714907630_0001_m_000008_0
2021-11-12 22:23:12,254 INFO output.FileOutputCommitter: File Output Committer Algorithm version is 2
2021-11-12 22:23:12,254 INFO output.FileOutputCommitter: FileOutputCommitter skip cleanup _temporary folders under output directory:false, ignore cleanup failures: false
2021-11-12 22:23:12,254 INFO mapred.Task:  Using ResourceCalculatorProcessTree : [ ]
2021-11-12 22:23:12,255 INFO mapred.MapTask: Processing split: file:/home/csy/bin/hadoop-3.3.1/input/kms-site.xml:0+682
2021-11-12 22:23:12,281 INFO mapred.MapTask: (EQUATOR) 0 kvi 26214396(104857584)
2021-11-12 22:23:12,281 INFO mapred.MapTask: mapreduce.task.io.sort.mb: 100
2021-11-12 22:23:12,281 INFO mapred.MapTask: soft limit at 83886080
2021-11-12 22:23:12,281 INFO mapred.MapTask: bufstart = 0; bufvoid = 104857600
2021-11-12 22:23:12,281 INFO mapred.MapTask: kvstart = 26214396; length = 6553600
2021-11-12 22:23:12,282 INFO mapred.MapTask: Map output collector class = org.apache.hadoop.mapred.MapTask$MapOutputBuffer
2021-11-12 22:23:12,283 INFO mapred.LocalJobRunner: 
2021-11-12 22:23:12,283 INFO mapred.MapTask: Starting flush of map output
2021-11-12 22:23:12,284 INFO mapred.Task: Task:attempt_local1714907630_0001_m_000008_0 is done. And is in the process of committing
2021-11-12 22:23:12,285 INFO mapred.LocalJobRunner: map
2021-11-12 22:23:12,285 INFO mapred.Task: Task 'attempt_local1714907630_0001_m_000008_0' done.
2021-11-12 22:23:12,285 INFO mapred.Task: Final Counters for attempt_local1714907630_0001_m_000008_0: Counters: 18
	File System Counters
		FILE: Number of bytes read=318840
		FILE: Number of bytes written=912358
		FILE: Number of read operations=0
		FILE: Number of large read operations=0
		FILE: Number of write operations=0
	Map-Reduce Framework
		Map input records=20
		Map output records=0
		Map output bytes=0
		Map output materialized bytes=6
		Input split bytes=115
		Combine input records=0
		Combine output records=0
		Spilled Records=0
		Failed Shuffles=0
		Merged Map outputs=0
		GC time elapsed (ms)=0
		Total committed heap usage (bytes)=1094713344
	File Input Format Counters 
		Bytes Read=682
2021-11-12 22:23:12,285 INFO mapred.LocalJobRunner: Finishing task: attempt_local1714907630_0001_m_000008_0
2021-11-12 22:23:12,285 INFO mapred.LocalJobRunner: Starting task: attempt_local1714907630_0001_m_000009_0
2021-11-12 22:23:12,285 INFO output.FileOutputCommitter: File Output Committer Algorithm version is 2
2021-11-12 22:23:12,285 INFO output.FileOutputCommitter: FileOutputCommitter skip cleanup _temporary folders under output directory:false, ignore cleanup failures: false
2021-11-12 22:23:12,286 INFO mapred.Task:  Using ResourceCalculatorProcessTree : [ ]
2021-11-12 22:23:12,286 INFO mapred.MapTask: Processing split: file:/home/csy/bin/hadoop-3.3.1/input/httpfs-site.xml:0+620
2021-11-12 22:23:12,313 INFO mapred.MapTask: (EQUATOR) 0 kvi 26214396(104857584)
2021-11-12 22:23:12,313 INFO mapred.MapTask: mapreduce.task.io.sort.mb: 100
2021-11-12 22:23:12,313 INFO mapred.MapTask: soft limit at 83886080
2021-11-12 22:23:12,313 INFO mapred.MapTask: bufstart = 0; bufvoid = 104857600
2021-11-12 22:23:12,313 INFO mapred.MapTask: kvstart = 26214396; length = 6553600
2021-11-12 22:23:12,313 INFO mapred.MapTask: Map output collector class = org.apache.hadoop.mapred.MapTask$MapOutputBuffer
2021-11-12 22:23:12,315 INFO mapred.LocalJobRunner: 
2021-11-12 22:23:12,315 INFO mapred.MapTask: Starting flush of map output
2021-11-12 22:23:12,316 INFO mapred.Task: Task:attempt_local1714907630_0001_m_000009_0 is done. And is in the process of committing
2021-11-12 22:23:12,317 INFO mapred.LocalJobRunner: map
2021-11-12 22:23:12,317 INFO mapred.Task: Task 'attempt_local1714907630_0001_m_000009_0' done.
2021-11-12 22:23:12,317 INFO mapred.Task: Final Counters for attempt_local1714907630_0001_m_000009_0: Counters: 18
	File System Counters
		FILE: Number of bytes read=319642
		FILE: Number of bytes written=912396
		FILE: Number of read operations=0
		FILE: Number of large read operations=0
		FILE: Number of write operations=0
	Map-Reduce Framework
		Map input records=17
		Map output records=0
		Map output bytes=0
		Map output materialized bytes=6
		Input split bytes=118
		Combine input records=0
		Combine output records=0
		Spilled Records=0
		Failed Shuffles=0
		Merged Map outputs=0
		GC time elapsed (ms)=0
		Total committed heap usage (bytes)=1200095232
	File Input Format Counters 
		Bytes Read=620
2021-11-12 22:23:12,317 INFO mapred.LocalJobRunner: Finishing task: attempt_local1714907630_0001_m_000009_0
2021-11-12 22:23:12,317 INFO mapred.LocalJobRunner: map task executor complete.
2021-11-12 22:23:12,324 INFO mapred.LocalJobRunner: Waiting for reduce tasks
2021-11-12 22:23:12,324 INFO mapred.LocalJobRunner: Starting task: attempt_local1714907630_0001_r_000000_0
2021-11-12 22:23:12,329 INFO output.FileOutputCommitter: File Output Committer Algorithm version is 2
2021-11-12 22:23:12,329 INFO output.FileOutputCommitter: FileOutputCommitter skip cleanup _temporary folders under output directory:false, ignore cleanup failures: false
2021-11-12 22:23:12,329 INFO mapred.Task:  Using ResourceCalculatorProcessTree : [ ]
2021-11-12 22:23:12,330 INFO mapred.ReduceTask: Using ShuffleConsumerPlugin: org.apache.hadoop.mapreduce.task.reduce.Shuffle@33424544
2021-11-12 22:23:12,331 WARN impl.MetricsSystemImpl: JobTracker metrics system already initialized!
2021-11-12 22:23:12,341 INFO reduce.MergeManagerImpl: MergerManager: memoryLimit=2603509248, maxSingleShuffleLimit=650877312, mergeThreshold=1718316160, ioSortFactor=10, memToMemMergeOutputsThreshold=10
2021-11-12 22:23:12,346 INFO reduce.EventFetcher: attempt_local1714907630_0001_r_000000_0 Thread started: EventFetcher for fetching Map Completion Events
2021-11-12 22:23:12,360 INFO reduce.LocalFetcher: localfetcher#1 about to shuffle output of map attempt_local1714907630_0001_m_000009_0 decomp: 2 len: 6 to MEMORY
2021-11-12 22:23:12,361 INFO reduce.InMemoryMapOutput: Read 2 bytes from map-output for attempt_local1714907630_0001_m_000009_0
2021-11-12 22:23:12,362 INFO reduce.MergeManagerImpl: closeInMemoryFile -> map-output of size: 2, inMemoryMapOutputs.size() -> 1, commitMemory -> 0, usedMemory ->2
2021-11-12 22:23:12,363 INFO reduce.LocalFetcher: localfetcher#1 about to shuffle output of map attempt_local1714907630_0001_m_000006_0 decomp: 2 len: 6 to MEMORY
2021-11-12 22:23:12,363 INFO reduce.InMemoryMapOutput: Read 2 bytes from map-output for attempt_local1714907630_0001_m_000006_0
2021-11-12 22:23:12,363 INFO reduce.MergeManagerImpl: closeInMemoryFile -> map-output of size: 2, inMemoryMapOutputs.size() -> 2, commitMemory -> 2, usedMemory ->4
2021-11-12 22:23:12,364 INFO reduce.LocalFetcher: localfetcher#1 about to shuffle output of map attempt_local1714907630_0001_m_000003_0 decomp: 2 len: 6 to MEMORY
2021-11-12 22:23:12,364 INFO reduce.InMemoryMapOutput: Read 2 bytes from map-output for attempt_local1714907630_0001_m_000003_0
2021-11-12 22:23:12,364 INFO reduce.MergeManagerImpl: closeInMemoryFile -> map-output of size: 2, inMemoryMapOutputs.size() -> 3, commitMemory -> 4, usedMemory ->6
2021-11-12 22:23:12,365 INFO reduce.LocalFetcher: localfetcher#1 about to shuffle output of map attempt_local1714907630_0001_m_000000_0 decomp: 21 len: 25 to MEMORY
2021-11-12 22:23:12,365 INFO reduce.InMemoryMapOutput: Read 21 bytes from map-output for attempt_local1714907630_0001_m_000000_0
2021-11-12 22:23:12,365 INFO reduce.MergeManagerImpl: closeInMemoryFile -> map-output of size: 21, inMemoryMapOutputs.size() -> 4, commitMemory -> 6, usedMemory ->27
2021-11-12 22:23:12,365 INFO reduce.LocalFetcher: localfetcher#1 about to shuffle output of map attempt_local1714907630_0001_m_000007_0 decomp: 2 len: 6 to MEMORY
2021-11-12 22:23:12,366 INFO reduce.InMemoryMapOutput: Read 2 bytes from map-output for attempt_local1714907630_0001_m_000007_0
2021-11-12 22:23:12,366 INFO reduce.MergeManagerImpl: closeInMemoryFile -> map-output of size: 2, inMemoryMapOutputs.size() -> 5, commitMemory -> 27, usedMemory ->29
2021-11-12 22:23:12,366 INFO reduce.LocalFetcher: localfetcher#1 about to shuffle output of map attempt_local1714907630_0001_m_000004_0 decomp: 2 len: 6 to MEMORY
2021-11-12 22:23:12,366 INFO reduce.InMemoryMapOutput: Read 2 bytes from map-output for attempt_local1714907630_0001_m_000004_0
2021-11-12 22:23:12,366 INFO reduce.MergeManagerImpl: closeInMemoryFile -> map-output of size: 2, inMemoryMapOutputs.size() -> 6, commitMemory -> 29, usedMemory ->31
2021-11-12 22:23:12,367 INFO reduce.LocalFetcher: localfetcher#1 about to shuffle output of map attempt_local1714907630_0001_m_000001_0 decomp: 2 len: 6 to MEMORY
2021-11-12 22:23:12,367 INFO reduce.InMemoryMapOutput: Read 2 bytes from map-output for attempt_local1714907630_0001_m_000001_0
2021-11-12 22:23:12,367 INFO reduce.MergeManagerImpl: closeInMemoryFile -> map-output of size: 2, inMemoryMapOutputs.size() -> 7, commitMemory -> 31, usedMemory ->33
2021-11-12 22:23:12,368 INFO reduce.LocalFetcher: localfetcher#1 about to shuffle output of map attempt_local1714907630_0001_m_000008_0 decomp: 2 len: 6 to MEMORY
2021-11-12 22:23:12,368 INFO reduce.InMemoryMapOutput: Read 2 bytes from map-output for attempt_local1714907630_0001_m_000008_0
2021-11-12 22:23:12,368 INFO reduce.MergeManagerImpl: closeInMemoryFile -> map-output of size: 2, inMemoryMapOutputs.size() -> 8, commitMemory -> 33, usedMemory ->35
2021-11-12 22:23:12,368 INFO reduce.LocalFetcher: localfetcher#1 about to shuffle output of map attempt_local1714907630_0001_m_000005_0 decomp: 2 len: 6 to MEMORY
2021-11-12 22:23:12,368 INFO reduce.InMemoryMapOutput: Read 2 bytes from map-output for attempt_local1714907630_0001_m_000005_0
2021-11-12 22:23:12,368 INFO reduce.MergeManagerImpl: closeInMemoryFile -> map-output of size: 2, inMemoryMapOutputs.size() -> 9, commitMemory -> 35, usedMemory ->37
2021-11-12 22:23:12,369 INFO reduce.LocalFetcher: localfetcher#1 about to shuffle output of map attempt_local1714907630_0001_m_000002_0 decomp: 2 len: 6 to MEMORY
2021-11-12 22:23:12,369 INFO reduce.InMemoryMapOutput: Read 2 bytes from map-output for attempt_local1714907630_0001_m_000002_0
2021-11-12 22:23:12,369 INFO reduce.MergeManagerImpl: closeInMemoryFile -> map-output of size: 2, inMemoryMapOutputs.size() -> 10, commitMemory -> 37, usedMemory ->39
2021-11-12 22:23:12,369 INFO reduce.EventFetcher: EventFetcher is interrupted.. Returning
2021-11-12 22:23:12,369 INFO mapred.LocalJobRunner: 10 / 10 copied.
2021-11-12 22:23:12,370 INFO reduce.MergeManagerImpl: finalMerge called with 10 in-memory map-outputs and 0 on-disk map-outputs
2021-11-12 22:23:12,372 INFO mapred.Merger: Merging 10 sorted segments
2021-11-12 22:23:12,372 INFO mapred.Merger: Down to the last merge-pass, with 1 segments left of total size: 10 bytes
2021-11-12 22:23:12,373 INFO reduce.MergeManagerImpl: Merged 10 segments, 39 bytes to disk to satisfy reduce memory limit
2021-11-12 22:23:12,373 INFO reduce.MergeManagerImpl: Merging 1 files, 25 bytes from disk
2021-11-12 22:23:12,373 INFO reduce.MergeManagerImpl: Merging 0 segments, 0 bytes from memory into reduce
2021-11-12 22:23:12,373 INFO mapred.Merger: Merging 1 sorted segments
2021-11-12 22:23:12,373 INFO mapred.Merger: Down to the last merge-pass, with 1 segments left of total size: 10 bytes
2021-11-12 22:23:12,374 INFO mapred.LocalJobRunner: 10 / 10 copied.
2021-11-12 22:23:12,380 INFO Configuration.deprecation: mapred.skip.on is deprecated. Instead, use mapreduce.job.skiprecords
2021-11-12 22:23:12,380 INFO mapred.Task: Task:attempt_local1714907630_0001_r_000000_0 is done. And is in the process of committing
2021-11-12 22:23:12,380 INFO mapred.LocalJobRunner: 10 / 10 copied.
2021-11-12 22:23:12,380 INFO mapred.Task: Task attempt_local1714907630_0001_r_000000_0 is allowed to commit now
2021-11-12 22:23:12,381 INFO output.FileOutputCommitter: Saved output of task 'attempt_local1714907630_0001_r_000000_0' to file:/home/csy/bin/hadoop-3.3.1/grep-temp-874110544
2021-11-12 22:23:12,381 INFO mapred.LocalJobRunner: reduce > reduce
2021-11-12 22:23:12,381 INFO mapred.Task: Task 'attempt_local1714907630_0001_r_000000_0' done.
2021-11-12 22:23:12,382 INFO mapred.Task: Final Counters for attempt_local1714907630_0001_r_000000_0: Counters: 24
	File System Counters
		FILE: Number of bytes read=320066
		FILE: Number of bytes written=912544
		FILE: Number of read operations=0
		FILE: Number of large read operations=0
		FILE: Number of write operations=0
	Map-Reduce Framework
		Combine input records=0
		Combine output records=0
		Reduce input groups=1
		Reduce shuffle bytes=79
		Reduce input records=1
		Reduce output records=1
		Spilled Records=1
		Shuffled Maps =10
		Failed Shuffles=0
		Merged Map outputs=10
		GC time elapsed (ms)=0
		Total committed heap usage (bytes)=1200095232
	Shuffle Errors
		BAD_ID=0
		CONNECTION=0
		IO_ERROR=0
		WRONG_LENGTH=0
		WRONG_MAP=0
		WRONG_REDUCE=0
	File Output Format Counters 
		Bytes Written=123
2021-11-12 22:23:12,382 INFO mapred.LocalJobRunner: Finishing task: attempt_local1714907630_0001_r_000000_0
2021-11-12 22:23:12,382 INFO mapred.LocalJobRunner: reduce task executor complete.
2021-11-12 22:23:12,912 INFO mapreduce.Job: Job job_local1714907630_0001 running in uber mode : false
2021-11-12 22:23:12,914 INFO mapreduce.Job:  map 100% reduce 100%
2021-11-12 22:23:12,916 INFO mapreduce.Job: Job job_local1714907630_0001 completed successfully
2021-11-12 22:23:12,921 INFO mapreduce.Job: Counters: 30
	File System Counters
		FILE: Number of bytes read=3439327
		FILE: Number of bytes written=10034794
		FILE: Number of read operations=0
		FILE: Number of large read operations=0
		FILE: Number of write operations=0
	Map-Reduce Framework
		Map input records=792
		Map output records=1
		Map output bytes=17
		Map output materialized bytes=79
		Input split bytes=1179
		Combine input records=1
		Combine output records=1
		Reduce input groups=1
		Reduce shuffle bytes=79
		Reduce input records=1
		Reduce output records=1
		Spilled Records=2
		Shuffled Maps =10
		Failed Shuffles=0
		Merged Map outputs=10
		GC time elapsed (ms)=0
		Total committed heap usage (bytes)=8458862592
	Shuffle Errors
		BAD_ID=0
		CONNECTION=0
		IO_ERROR=0
		WRONG_LENGTH=0
		WRONG_MAP=0
		WRONG_REDUCE=0
	File Input Format Counters 
		Bytes Read=29478
	File Output Format Counters 
		Bytes Written=123
2021-11-12 22:23:12,931 WARN impl.MetricsSystemImpl: JobTracker metrics system already initialized!
2021-11-12 22:23:12,935 INFO input.FileInputFormat: Total input files to process : 1
2021-11-12 22:23:12,935 INFO mapreduce.JobSubmitter: number of splits:1
2021-11-12 22:23:12,943 INFO mapreduce.JobSubmitter: Submitting tokens for job: job_local665752141_0002
2021-11-12 22:23:12,943 INFO mapreduce.JobSubmitter: Executing with tokens: []
2021-11-12 22:23:12,982 INFO mapreduce.Job: The url to track the job: http://localhost:8080/
2021-11-12 22:23:12,982 INFO mapreduce.Job: Running job: job_local665752141_0002
2021-11-12 22:23:12,982 INFO mapred.LocalJobRunner: OutputCommitter set in config null
2021-11-12 22:23:12,982 INFO output.FileOutputCommitter: File Output Committer Algorithm version is 2
2021-11-12 22:23:12,982 INFO output.FileOutputCommitter: FileOutputCommitter skip cleanup _temporary folders under output directory:false, ignore cleanup failures: false
2021-11-12 22:23:12,983 INFO mapred.LocalJobRunner: OutputCommitter is org.apache.hadoop.mapreduce.lib.output.FileOutputCommitter
2021-11-12 22:23:12,984 INFO mapred.LocalJobRunner: Waiting for map tasks
2021-11-12 22:23:12,984 INFO mapred.LocalJobRunner: Starting task: attempt_local665752141_0002_m_000000_0
2021-11-12 22:23:12,984 INFO output.FileOutputCommitter: File Output Committer Algorithm version is 2
2021-11-12 22:23:12,984 INFO output.FileOutputCommitter: FileOutputCommitter skip cleanup _temporary folders under output directory:false, ignore cleanup failures: false
2021-11-12 22:23:12,985 INFO mapred.Task:  Using ResourceCalculatorProcessTree : [ ]
2021-11-12 22:23:12,985 INFO mapred.MapTask: Processing split: file:/home/csy/bin/hadoop-3.3.1/grep-temp-874110544/part-r-00000:0+111
2021-11-12 22:23:13,012 INFO mapred.MapTask: (EQUATOR) 0 kvi 26214396(104857584)
2021-11-12 22:23:13,012 INFO mapred.MapTask: mapreduce.task.io.sort.mb: 100
2021-11-12 22:23:13,012 INFO mapred.MapTask: soft limit at 83886080
2021-11-12 22:23:13,012 INFO mapred.MapTask: bufstart = 0; bufvoid = 104857600
2021-11-12 22:23:13,012 INFO mapred.MapTask: kvstart = 26214396; length = 6553600
2021-11-12 22:23:13,013 INFO mapred.MapTask: Map output collector class = org.apache.hadoop.mapred.MapTask$MapOutputBuffer
2021-11-12 22:23:13,017 INFO mapred.LocalJobRunner: 
2021-11-12 22:23:13,017 INFO mapred.MapTask: Starting flush of map output
2021-11-12 22:23:13,017 INFO mapred.MapTask: Spilling map output
2021-11-12 22:23:13,017 INFO mapred.MapTask: bufstart = 0; bufend = 17; bufvoid = 104857600
2021-11-12 22:23:13,017 INFO mapred.MapTask: kvstart = 26214396(104857584); kvend = 26214396(104857584); length = 1/6553600
2021-11-12 22:23:13,018 INFO mapred.MapTask: Finished spill 0
2021-11-12 22:23:13,018 INFO mapred.Task: Task:attempt_local665752141_0002_m_000000_0 is done. And is in the process of committing
2021-11-12 22:23:13,019 INFO mapred.LocalJobRunner: map
2021-11-12 22:23:13,019 INFO mapred.Task: Task 'attempt_local665752141_0002_m_000000_0' done.
2021-11-12 22:23:13,019 INFO mapred.Task: Final Counters for attempt_local665752141_0002_m_000000_0: Counters: 17
	File System Counters
		FILE: Number of bytes read=601361
		FILE: Number of bytes written=1819040
		FILE: Number of read operations=0
		FILE: Number of large read operations=0
		FILE: Number of write operations=0
	Map-Reduce Framework
		Map input records=1
		Map output records=1
		Map output bytes=17
		Map output materialized bytes=25
		Input split bytes=129
		Combine input records=0
		Spilled Records=1
		Failed Shuffles=0
		Merged Map outputs=0
		GC time elapsed (ms)=0
		Total committed heap usage (bytes)=1305477120
	File Input Format Counters 
		Bytes Read=123
2021-11-12 22:23:13,019 INFO mapred.LocalJobRunner: Finishing task: attempt_local665752141_0002_m_000000_0
2021-11-12 22:23:13,019 INFO mapred.LocalJobRunner: map task executor complete.
2021-11-12 22:23:13,019 INFO mapred.LocalJobRunner: Waiting for reduce tasks
2021-11-12 22:23:13,020 INFO mapred.LocalJobRunner: Starting task: attempt_local665752141_0002_r_000000_0
2021-11-12 22:23:13,020 INFO output.FileOutputCommitter: File Output Committer Algorithm version is 2
2021-11-12 22:23:13,020 INFO output.FileOutputCommitter: FileOutputCommitter skip cleanup _temporary folders under output directory:false, ignore cleanup failures: false
2021-11-12 22:23:13,020 INFO mapred.Task:  Using ResourceCalculatorProcessTree : [ ]
2021-11-12 22:23:13,020 INFO mapred.ReduceTask: Using ShuffleConsumerPlugin: org.apache.hadoop.mapreduce.task.reduce.Shuffle@4fd0784f
2021-11-12 22:23:13,020 WARN impl.MetricsSystemImpl: JobTracker metrics system already initialized!
2021-11-12 22:23:13,021 INFO reduce.MergeManagerImpl: MergerManager: memoryLimit=2603509248, maxSingleShuffleLimit=650877312, mergeThreshold=1718316160, ioSortFactor=10, memToMemMergeOutputsThreshold=10
2021-11-12 22:23:13,021 INFO reduce.EventFetcher: attempt_local665752141_0002_r_000000_0 Thread started: EventFetcher for fetching Map Completion Events
2021-11-12 22:23:13,027 INFO reduce.LocalFetcher: localfetcher#2 about to shuffle output of map attempt_local665752141_0002_m_000000_0 decomp: 21 len: 25 to MEMORY
2021-11-12 22:23:13,027 INFO reduce.InMemoryMapOutput: Read 21 bytes from map-output for attempt_local665752141_0002_m_000000_0
2021-11-12 22:23:13,027 INFO reduce.MergeManagerImpl: closeInMemoryFile -> map-output of size: 21, inMemoryMapOutputs.size() -> 1, commitMemory -> 0, usedMemory ->21
2021-11-12 22:23:13,027 INFO reduce.EventFetcher: EventFetcher is interrupted.. Returning
2021-11-12 22:23:13,027 INFO mapred.LocalJobRunner: 1 / 1 copied.
2021-11-12 22:23:13,027 INFO reduce.MergeManagerImpl: finalMerge called with 1 in-memory map-outputs and 0 on-disk map-outputs
2021-11-12 22:23:13,028 INFO mapred.Merger: Merging 1 sorted segments
2021-11-12 22:23:13,028 INFO mapred.Merger: Down to the last merge-pass, with 1 segments left of total size: 11 bytes
2021-11-12 22:23:13,028 INFO reduce.MergeManagerImpl: Merged 1 segments, 21 bytes to disk to satisfy reduce memory limit
2021-11-12 22:23:13,028 INFO reduce.MergeManagerImpl: Merging 1 files, 25 bytes from disk
2021-11-12 22:23:13,028 INFO reduce.MergeManagerImpl: Merging 0 segments, 0 bytes from memory into reduce
2021-11-12 22:23:13,028 INFO mapred.Merger: Merging 1 sorted segments
2021-11-12 22:23:13,028 INFO mapred.Merger: Down to the last merge-pass, with 1 segments left of total size: 11 bytes
2021-11-12 22:23:13,028 INFO mapred.LocalJobRunner: 1 / 1 copied.
2021-11-12 22:23:13,029 INFO mapred.Task: Task:attempt_local665752141_0002_r_000000_0 is done. And is in the process of committing
2021-11-12 22:23:13,029 INFO mapred.LocalJobRunner: 1 / 1 copied.
2021-11-12 22:23:13,030 INFO mapred.Task: Task attempt_local665752141_0002_r_000000_0 is allowed to commit now
2021-11-12 22:23:13,030 INFO output.FileOutputCommitter: Saved output of task 'attempt_local665752141_0002_r_000000_0' to file:/home/csy/bin/hadoop-3.3.1/output
2021-11-12 22:23:13,030 INFO mapred.LocalJobRunner: reduce > reduce
2021-11-12 22:23:13,030 INFO mapred.Task: Task 'attempt_local665752141_0002_r_000000_0' done.
2021-11-12 22:23:13,030 INFO mapred.Task: Final Counters for attempt_local665752141_0002_r_000000_0: Counters: 24
	File System Counters
		FILE: Number of bytes read=601443
		FILE: Number of bytes written=1819088
		FILE: Number of read operations=0
		FILE: Number of large read operations=0
		FILE: Number of write operations=0
	Map-Reduce Framework
		Combine input records=0
		Combine output records=0
		Reduce input groups=1
		Reduce shuffle bytes=25
		Reduce input records=1
		Reduce output records=1
		Spilled Records=1
		Shuffled Maps =1
		Failed Shuffles=0
		Merged Map outputs=1
		GC time elapsed (ms)=5
		Total committed heap usage (bytes)=1371537408
	Shuffle Errors
		BAD_ID=0
		CONNECTION=0
		IO_ERROR=0
		WRONG_LENGTH=0
		WRONG_MAP=0
		WRONG_REDUCE=0
	File Output Format Counters 
		Bytes Written=23
2021-11-12 22:23:13,030 INFO mapred.LocalJobRunner: Finishing task: attempt_local665752141_0002_r_000000_0
2021-11-12 22:23:13,030 INFO mapred.LocalJobRunner: reduce task executor complete.
2021-11-12 22:23:13,983 INFO mapreduce.Job: Job job_local665752141_0002 running in uber mode : false
2021-11-12 22:23:13,983 INFO mapreduce.Job:  map 100% reduce 100%
2021-11-12 22:23:13,984 INFO mapreduce.Job: Job job_local665752141_0002 completed successfully
2021-11-12 22:23:13,987 INFO mapreduce.Job: Counters: 30
	File System Counters
		FILE: Number of bytes read=1202804
		FILE: Number of bytes written=3638128
		FILE: Number of read operations=0
		FILE: Number of large read operations=0
		FILE: Number of write operations=0
	Map-Reduce Framework
		Map input records=1
		Map output records=1
		Map output bytes=17
		Map output materialized bytes=25
		Input split bytes=129
		Combine input records=0
		Combine output records=0
		Reduce input groups=1
		Reduce shuffle bytes=25
		Reduce input records=1
		Reduce output records=1
		Spilled Records=2
		Shuffled Maps =1
		Failed Shuffles=0
		Merged Map outputs=1
		GC time elapsed (ms)=5
		Total committed heap usage (bytes)=2677014528
	Shuffle Errors
		BAD_ID=0
		CONNECTION=0
		IO_ERROR=0
		WRONG_LENGTH=0
		WRONG_MAP=0
		WRONG_REDUCE=0
	File Input Format Counters 
		Bytes Read=123
	File Output Format Counters 
		Bytes Written=23
```

```
➜  hadoop-3.3.1 cat output/*
1	dfsadmin
```
