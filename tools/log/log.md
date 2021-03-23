# log



## elk

### logstash

使用jruby实现，需要java sdk支持。


### Elasticsearch
### Kibana

### Filebeat 
### Fluentd

## misc
elk 框架 和爬虫框架类似：
url/source/log =》agent/browser =》 filter/parser =》 db =》 queryer => viewer
Elasticsearch 对应queryer，logstash 对应 parser， Kibana 对应 viewer。Filebeat 对应 agent部分