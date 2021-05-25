## [Linux查看库依赖方法](https://www.cnblogs.com/silentdoer/p/11748567.html)

1. 查看依赖的库：`objdump -x a.out |grep NEEDED`
2. 查看可执行程序依赖的库：`objdump -x exe_name | grep NEEDED`
3. 查看缺少的库：`ldd xxx.so` .如果某个依赖的库不存在，会打印类似“xxx.so not found”的提示






