# make install

0. 生成配置文件
1. 执行配置，生成makefile
2. 执行编译
3. 安装到可执行路径

``` bash
./autogen.sh
chmode +x ./configure # 添加可执行权限
./configure 
make
make install 
```