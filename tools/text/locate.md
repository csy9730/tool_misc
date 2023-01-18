# locate

对于一个系统管理员来说，草中寻针一样的查找文件的事情并不少见。在一台拥挤的机器上，文件系统中可能存在数十万个文件。当你需要确定一个特定的配置文件是最新的，但是你不记得它在哪里时怎么办？本篇文章为大家分享一个比find快得多的命令，搜索任何文件几乎都能在一秒内返回。
## mlocate

这个命令的原理是，先为文件系统创建索引数据库，mlocate只是搜索索引，所以速度快

准备工作：创建数据库（创建索引）

`sudo updatedb` 
只有root权限才能执行，他会扫描整个系统，为整个系统创建索引，数据库在/var/lib/mlocate/mlocate.db

这个过程会比较慢，可以在中午或晚上跑一下，执行完了上面的命令就可以使用mlocate搜索文件