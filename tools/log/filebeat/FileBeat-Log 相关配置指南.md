# FileBeat-Log 相关配置指南

 发表于 2019-11-26  更新于 2020-08-20  分类于 [Elasticsearch](https://www.cyhone.com/categories/Elasticsearch/)  阅读次数： 2221

本文主要介绍 Filebeat 7.5 版本中 Log 相关的各个配置项的含义以及其应用场景。

一般情况下，我们使用 log input 的方式如下，只需要指定一系列 paths 即可。

```yaml
filebeat.inputs:
- type: log
  paths:
    - /var/log/messages
    - /var/log/*.log
```

但其实除了基本的 paths 配置外，log input 还有大概十几个配置项需要我们关注。

这些配置项或多或少都会影响到 Filebeat 的使用方式以及性能。虽然其默认值基本足够日常使用，但是还是需要深刻理解每个配置项背后的含义，这样才能够对其完全把控。

同时，在 filebeat 的日常线上运维中，也会涉及到这些配置参数的调节。



# log input 配置

## paths

我们可以指定一系列的 paths 作为信息输入源，在指定 path 的时候，注意以下规则：

1. 指定的路径必须是文件，不能是目录。
2. 支持 Glob 模式。
3. 默认支持递归路径，如 `/**/` 形式，Filebeat 将会展开 8 层嵌套目录。

### Glob 模式

Glob 模式支持通配符匹配，目前支持的语法有：

| 通配符 | 解释                   | 示例          | 匹配                                    |
| ------ | ---------------------- | ------------- | --------------------------------------- |
| *      | 匹配任意数目的任意字符 | `La*`         | Law, Lawyer                             |
| ?      | 匹配任意的单字符       | `?at`         | Cat, cat, Bat or bat                    |
| [abc]  | 匹配一个在中括号的字符 | `[CB]at`      | Cat or Bat                              |
| [a-z]  | 匹配一个指定范围的字符 | `Letter[0-9]` | Letter0, Letter1, Letter2 up to Letter9 |

### 递归的 Glob 模式

此外，filebeat 对传统的 Glob 模式进行了扩展，支持用户指定 `/**/` 模式的路径，filebeat 可以将其展开为 8 层的 Glob 路径。

例如，假如指定了 `/home/data/**/my*.log`, filebeat 将会把 `/**/` 翻译成 8 层的子目录，如下：

```none
/home/data/my*.log
/home/data/*/my*.log
/home/data/*/*/my*.log
/home/data/*/*/*/my*.log
/home/data/*/*/*/*/my*.log
/home/data/*/*/*/*/*/my*.log
/home/data/*/*/*/*/*/*/my*.log
/home/data/*/*/*/*/*/*/*/my*.log
/home/data/*/*/*/*/*/*/*/*/my*.log
```

加上不带子目录的 Glob 路径，一共会有 8 条 Glob 路径。这些路径都会作为 input 的输入源路径进行搜索。

但是在使用的时候需要注意：

1. filebeat 展开为 8 层子目录的规则，是直接 hardcode 在代码中的，无法通过配置修改匹配层数
2. 只支持单纯的 `/**/` 模式，对于 `/data**/` 模式不支持
3. 递归模式默认开启，可通过 `recursive_glob.enabled` 配置项关闭

## recursive_glob.enabled:

是否开启递归的 Glob 模式，默认为 true。

## encoding

指定日志编码，默认是 plain。即 ASCII 模式

## exclude_lines

可指定多个正则表达式，来去除某些不需要上报的行。例如：

```yaml
filebeat.inputs:
- type: log
  ...
  exclude_lines: ['^DBG']
```

该配置将会去除以 `DBG` 开头的行。

## include_lines

可指定多项正则表达式，来仅上报匹配的行。例如：

```yaml
filebeat.inputs:
- type: log
  ...
  include_lines: ['^ERR', '^WARN']
```

该配置将会仅上报以 `ERR` 和 `WARN` 开头的行。

问题来了，如果同时指定了 exclude_lines 和 include_lines 会怎么处理？

对于这种情况，Filebeat 将会先校验 include_lines，再校验 exclude_lines，其代码实现如下：

```go
func (h *Harvester) shouldExportLine(line string) bool {
    if len(h.config.IncludeLines) > 0 {
        if !harvester.MatchAny(h.config.IncludeLines, line) {
            // drop line
            return false
        }
    }
    if len(h.config.ExcludeLines) > 0 {
        if harvester.MatchAny(h.config.ExcludeLines, line) {
            return false
        }
    }

    return true
}
```

## exclude_files

可指定多个正则表达式，匹配到的文件名将不会被处理。

例如:

```yaml
exclude_files: ['.gz$']
```

这里需要注意的是，不管是 exclude_files，还是 exclude_lines、include_lines, 声明正则的时候，最好使用单引号引用正则表达式，不要用双引号。否则 yaml 会报转义问题

## harvester_buffer_size

读文件时的 buffer 大小，最终会应用在 golang 的 `File.Read` 函数上面。

```go
func (f *File) Read(b []byte) (n int, err error)
```

默认是 16384。即 16k。

## max_bytes

表示一条 log 消息的最大 bytes 数目。超过这个大小，剩余就会被截断。
默认值为 10485760(即 10MB)。

## multiline

multiline 是为了解决需要多行聚合在一起发送的情况，例如 Java Stack Traces 信息等。
虽然 filebeat 默认不开启 multiline，但是官方的配置文件给了一个例子，可以支持 Java Stack Traces 或者是 C 语言式的换行连续符 `\`, 可在 [Examples of multiline configuration](https://www.elastic.co/guide/en/beats/filebeat/master/_examples_of_multiline_configuration.html) 中查看。

由于大部分场景不涉及 multiline，本文不再进行深入讨论。关于 multiline 配置的详细资料可查看官方文档：
<https://www.elastic.co/guide/en/beats/filebeat/7.5/multiline-examples.html>

## ignore_older

ignore_older 表示对于最近修改时间距离当前时间已经超过某个时长的文件，就暂时不进行处理。默认值为 0，表示禁用该功能。

注意：ignore_older 只是暂时不处理该文件，并不会在 Registrar 中改变该文件的状态。

其代码实现如下：

```go
func (p *Input) isIgnoreOlder(state file.State) bool {
    // ignore_older is disable
    if p.config.IgnoreOlder == 0 {
        return false
    }

    modTime := state.Fileinfo.ModTime()
    if time.Since(modTime) > p.config.IgnoreOlder {
        return true
    }

    return false
}
```

## close_* 系列

log input 中有一系列以 close_开头配置，这些配置决定了 Harvester 何时结束对文件的读取。

1. close_eof
   如果读取到了 EOF(即文件末尾)，是否要结束读取。如果为 true，则读取到文件末尾就结束读取，否则 Harvester 将会继续工作。默认只为 false。
2. close_inactive
   如果配置了 close_eof 为 false，则 Harvester 即使读取到了文件末尾也不会终止。close_inactive 决定了最长没有读到新消息的时长，默认为 5m(即五分钟)。如果超过了 close_inactive 规定的时间依然没有新消息，则 Harvester 退出。
3. close_timeout
   决定了一个 Harvester 的最长工作时间，如果 Harvester 工作了一段时间后依然没有停止，则强行停止 Harvester。默认为 0，表示不强行停止 Harvester。
4. close_renamed
   文件更名时是否退出，默认为 false。文件更名一般发生在日志轮替的场景下。
5. close_removed
   表示当文件被删除时 Harvester 是否要继续。默认为 true，表示当文件被删除时，Harvester 即刻停止工作。

不过即使 Harvester 关闭了也关系不大。因为根据 filebeat 会定时扫描文件，如果关闭后又有了新增内容，filebeat 依然是可以检查出来的。

## clean_* 系列

clean_开头的一系列配置用来清理 Registrar 中的文件状态，同时也可以起到减小 Registrar 文件大小、防止 inode 复用等作用。

1. clean_inactive
   表示一个时间段。用于移除已经一长段时间没有新产生内容的日志文件，默认为 0，表示禁用该功能。
2. clean_removed
   在 Registrar 中移除那些已经不存在的文件。默认为 true，表示当文件不存在时，则从 Registrar 中移除。

## scan_frequency

代表 input 的扫描频率，默认为 10s。
input 会按照此频率，启动定时器定时扫描路径，以发现新文件和文件的改动情况。

## scan.sort 和 scan.order

这两个配置项需要放在一起讲。
`scan.sort` 可取的值为: modtime 和 filename。默认值为空，不进行排序。
`scan.order` 可取的值为：asc 和 desc。默认值为 asc。`scan.order` 仅在 `scan.sort` 非空时生效。

需要注意的是：该功能目前为实验功能，可能会在以后版本移除。

## tail_files

默认情况下，Harvester 处理文件时，会文件头开始读取文件。开启此功能后，filebeat 将直接会把文件的 offset 置到末尾，从文件末尾监听消息。默认值是 false。

注意： 开启了 tail_files, 则所有文件中的当前内容将不会被上报，只有新产生消息时才会上报。

在真实的实现中，tail_files 被当做 `ignore_older=1ns` 处理。因此，在启动的时候，只要是新文件，里面的内容都会被忽略，直接把 offset 置为文件末尾。

所以使用该配置项时千万要谨慎！

## harvester_limit

harvester_limit 决定了一个 input 最多同时有多少个 harvester 启动。默认为 0，代表不对 harvester 个数进行限制。
在使用时要注意两点：

1. 如果一个文件对应的 harvester 在本轮扫描时没能启动，那会在下次扫描时，有其他文件的 harvester 完全退出时，该文件的 harvester 才能启动。
2. harvester_limit 仅对针对配置的 input 进行了限制，多个 input 之间的 harvester_limit 互不影响。

## symlinks

代表是否要对符号链接进行处理，默认值为 false，代表不处理。

## backoff 相关配置

我们上文讲到 `close_eof` 选项，当读取到 eof 时，且 close_eof 为 false，则 Harvester 还会一直尝试读取文件。

在这种情况下，Harvester 继续读取之前，其实 filebeat 还会等待一段时间。等待的时长就是由 `backoff`、`backoff_factor` 和 `max_backoff` 三个配置项共同决定。

对应的代码实现为：

```go
func (f *Log) wait() {
    // Wait before trying to read file again. File reached EOF.
    select {
    case <-f.done:
        return
    case <-time.After(f.backoff):
    }

    // Increment backoff up to maxBackoff
    if f.backoff < f.config.MaxBackoff {
        f.backoff = f.backoff * time.Duration(f.config.BackoffFactor)
        if f.backoff > f.config.MaxBackoff {
            f.backoff = f.config.MaxBackoff
        }
    }
}
```

其中，`backoff` 默认值为 1s, `backoff_factor` 默认值为 2，`max_backoff` 默认值为 10s。

该配置项意味着，如果读到 EOF，则 filebeat 将会等待一段时间再去读文件。
等待时间开始为 1s，如果一直是 EOF，则会逐渐增大等待时间，每次的等待时间是前一次的两倍，且一次最长等待 10s。

再结合 `close_inactive` 选项，如果等待时间超过了默认值 5 分钟，则 Harvester 结束。

此外，如果等待的时候文件又追加了新的数据，则 backoff 将会重新置为初始值。

# 全局配置

除了 log input 相关的属性外，有一些全局属性也需要我们注意。

## queue 相关配置

filebeat 会将 event 暂时存放在 queue 里面。filebeat 的 queue 目前有 mem 和 spool 两种实现，默认是 mem。
本文只介绍下 mem 的相关配置项。

```yaml
queue:
  mem:
    events: 4096
    flush.min_events: 2048
    flush.timeout: 1s
```

events 代表 queue 最多能够承载的 event 的个数。如果个数达到最大值，则 input 将不能再向 queue 中插入数据，直至 output 将数据消费。

`flush.min_events` 代表只有 queue 里面的数据到达了指定个数，才将数据发送给 output。设为 0 代表直接发送给 output，不进行等待。默认值是2048。

`flush.timeout` 代表定时刷新 event 到 output 中，即使其个数没有达到 `flush.min_events`。该配置项只会在 `flush.min_events` 大于 0 时生效。

## registry 相关配置

1. filebeat.registry.path
   定制 registry 文件的目录，默认值是 `registry`。

注意，这里指定的只是 registry 的目录，最终的 registry 文件的路径会是这样:

```none
${filebeat.registry.path}/filebeat/data.json
```

1. filebeat.registry.flush
   将 registry 文件内容定时刷新到磁盘中。默认为 0s，代表每次更新时直接写文件。
   配置了该选项可以提高些 filebeat 的性能，避免频繁写磁盘，但是也增加了一定数据丢失的风险。
2. filebeat.registry.file_permissions
   默认为 0600，即只有拥有者可以读写该用户, 其他用户不可以修改。

## 日志相关配置

filebeat 可以对输出日志的进行相关配置，filebeat 提供了如下日志相关的配置:

```yaml
logging.level: info # 日志输出的最小级别
logging.selectors: [] # 过滤器，用户可在 logp.NewLogger 时指定
logging.to_stderr: false # 将日志输出到 stderr
logging.to_syslog: false # 将日志输出到 syslog (主要用于 unix)
logging.to_eventlog: false # 将日志输出到 windows 的 event log
logging.to_files: true # 将日志输出到文件中
logging.files:
    path: ${filebeat_bin_path}/logs/ # 日志目录
    name: filebeat  # 文件名 filebeat filebeat.1 filebeat.2
    rotateonstartup: true # 在 filebeat 启动时进行日志轮替
    rotateeverybytes: 10485760 # = 10MB 日志轮替的默认值
    keepfiles: 7 # 日志保留个数
    permissions: 0600 # 日志权限
    interval: 0 # 日志轮替
logging.metrics.enabled: true
logging.metrics.period: 30s
logging.json: false
```

filebeat 可以选择将日志输出到许多地方，在线上运营时我们常常会将日志输出到文件, 所以接下来讲下文件相关的配置。

我们可以配置日志文件的所在目录以及文件名，分别对应 `logging.files.path` 和 `logging.files.name`。
默认情况下，日志的输出目录是在 filebeat 的 bin 文件所在目录下的 logs 文件。

filebeat 会进行日志轮替，一般情况下，常见的日志轮替规则有按大小和按时间，filebeat 两种规则均支持。
其中:

1. `rotateeverybytes` 决定了日志文件的最大值，如果日志文件超过了该值，将发生日志轮替，默认值为 10MB。
2. `rotateonstartup` 是说明是否在每次启动时都进行一次日志轮替，这样的话，每次启动的日志都会从一个新文件开始。默认为 true

按文件大小进行轮替后，日志文件名将会变成 filebeat、filebeat.1、filebeat.2 这种格式，后缀越大文件越旧。

filebeat 也支持按时间进行轮替，可以配置 `logging.files` 下的 interval 属性，支持按照秒、分钟、小时、周、月、年进行轮替，对应值为 `1s`,`1m`, `1h`, `24h`, `7*24h`, `30*24h`, 和 `365*24h`。当然，最小值是 1s。

按照时间进行轮替时，时间将会以连字符进行分割, 例如：按照 1 小时进行轮替的话，文件格式为：`filebeat-2019-11-28-15`。filebeat 目前还不支持日期格式的自定义。

同时，我们也可以指定日志的保留策略，目前只能通过设置 `keepfiles` 来决定保留日志的个数。

在日志里面还有 `logging.metrics` 相关配置，filebeat 会定时输出一些当前的运行指标，例如输出下当前 ack 成功的数目、当前的内存占用情况等：

- `logging.metrics.enabled` 决定是否开启指标搜集
- `logging.metrics.period` 决定指标输出的间隔

## 使用环境变量

我们可以在使用配置文件中直接使用环境变量，使用方式如下:

```yaml
fields:
    env: ${ENV_NAME}
```

我们可以直接用 `${ENV_NAME}` 来引用系统的环境变量。
除了直接引用外，filebeat 还提供了两个表达式配合使用:

1. `${VAR:default_value}`。如果没有环境变量 `VAR`, 则使用默认值 default_value
2. `${VAR:?error_text}`。如果没有环境变量 `VAR`，则显示错误提示 `error_text`

filebeat 也支持在启动时指定命令行参数来提供环境变量: `-E name=${NAME}`

# 相关阅读

- [Elastic-Filebeat 实现剖析](https://www.cyhone.com/articles/analysis-of-filebeat/)

# 参考

- <https://www.elastic.co/guide/en/beats/filebeat/7.5/filebeat-input-log.html>
- <https://github.com/elastic/beats/blob/7.5/filebeat/filebeat.reference.yml>
- <https://en.wikipedia.org/wiki/Glob_(programming)>
- <https://www.elastic.co/guide/en/beats/filebeat/current/using-environ-vars.html>

如果你在阅读过程中发现本文有错误或者存疑之处，请在下方评论区或者通过公众号进行留言，作者会尽快回复和解答。感谢您的支持与帮助。

![cyhone wechat](https://www.cyhone.com/img/wechat_subscriber_search.png)

- **本文作者：** cyhone
- **本文链接：** <https://www.cyhone.com/articles/usage-of-filebeat-log-config/>
- **版权声明：** 本博客所有文章除特别声明外，均采用 [BY-NC-SA](https://creativecommons.org/licenses/by-nc-sa/4.0/) 许可协议。转载请注明出处！