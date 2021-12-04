# imdb
### imdb数据集
Large Movie Review Dataset v1.0
imdb数据集,主要是txt文件，此外还有.feat文件。
* train
  * pos 12500个txt文件
  * neg 12500个txt文件
  * unsup 15343个txt文件
* test
  * pos 12500个txt文件
  * neg 12500个txt文件

文本处理过程
1. 下载数据集，划分文本文件
2. 分割单词,去掉句号，去掉标点符号,生成["a","good","day"]
3. 统计词频，构建词典
4. 单词转化为数字列表，list(str)转化成list(int)列表
5. 对不定长长列表处理成指定长度，长的截断，短的拼接0值
