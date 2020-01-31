# config



## Q&A

**Q**: `git clone `执行时出现 `rpc failed`
**A**: 一般是网络不好，可以通过配置提高网络容错。

``` bash
1、查看当前配置命令
git config -l

2、httpBuffer加大
git config --global http.postBuffer 524288000

3、压缩配置
git config --global core.compression -1

4、修改配置文件(可选)
export GIT_TRACE_PACKET=1
export GIT_TRACE=1
export GIT_CURL_VERBOSE=1
```