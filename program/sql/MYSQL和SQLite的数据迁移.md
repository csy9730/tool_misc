# MYSQL和SQLite的数据迁移

[![img](https://upload.jianshu.io/users/upload_avatars/1633182/4814fead-3b6a-4098-9e73-f5f631d20faa.jpg?imageMogr2/auto-orient/strip|imageView2/1/w/96/h/96/format/webp)](https://www.jianshu.com/u/1a2cd7c1f23a)

[peterzen](https://www.jianshu.com/u/1a2cd7c1f23a)关注

2019.06.27 18:28:47字数 283阅读 1,420

在使用中，有遇到需要MYSQL和SQLite的数据需要互相迁移的情况，下面针对一种情况使用`Navicat`来实现做说明，另外一种情况同理可证。

## MYSQL的数据迁移到SQLite

### 1. 连接上MYSQL

### 2. `sql` file导入MYSQL

![img](https://upload-images.jianshu.io/upload_images/1633182-3716b3e7722cb6d1.png?imageMogr2/auto-orient/strip|imageView2/2/w/176/format/webp)

open_sql.png

![img](https://upload-images.jianshu.io/upload_images/1633182-a673bafcdf407074.png?imageMogr2/auto-orient/strip|imageView2/2/w/528/format/webp)

sql_execute.png

### 3. 建立空SQLite数据库

使用命令行工具创建空数据库



```shell
> sqlite3 SQLITEDB.db
```

此时只是创建了一个size为0的文件。

### 4. 打开SQLite数据库

![img](https://upload-images.jianshu.io/upload_images/1633182-e2dccfca04079ed3.png?imageMogr2/auto-orient/strip|imageView2/2/w/384/format/webp)

open_sqlite_db.png



打开刚才创建的空数据库文件。

### 5. 导出MYSQL到SQLite database

![img](https://upload-images.jianshu.io/upload_images/1633182-8fad67d7c8e4f34d.png?imageMogr2/auto-orient/strip|imageView2/2/w/194/format/webp)

数据传输.png



![img](https://upload-images.jianshu.io/upload_images/1633182-142bc197449dd21d.png?imageMogr2/auto-orient/strip|imageView2/2/w/670/format/webp)

convert.png



执行数据传输以后，可以查看一下文件size，此时已经有内容了。

### 6. 验证内容



```shell
> sqlite3 SQLITEDB.db
sqilte3> .tables
```

或者是直接用GUI工具`SQLite Expert Personal`来打开`SQLITEDB.db`来进行查看。

## SQLite数据迁移到MYSQL

SQLite的数据迁移到MYSQL的方法基本一致，最大的区别是在`第5步数据传输`时，对应的`源`和`目标`做一个对调，源为SQLite，目的为MYSQL的数据库。
数据传输完成后，即可以看到数据导入到了MYSQL database中