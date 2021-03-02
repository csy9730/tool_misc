# MySQL

## 安装

指定路径安装即可。默认路径 `C:\Program Files\MySQL\MySQL Server 8.0\bin\mysqld.exe`

### server

```bash
mysqld --initialize # 初始化 MySQL,使用随机密码

net start mysql5


```

执行 `mysqld.exe` 将会开启MySQL服务, 监听 3306 端口。

``` bash
# 获取服务器状态
$ mysqladmin --version
mysqladmin  Ver 8.0.11 for Win64 on x86_64 (MySQL Community Server - GPL)

# 关闭目前运行的 MySQL 服务器
$ ./mysqladmin -u root -p shutdown

# 查看是否开启sql服务，端口是否占用
tasklist |grep mysqld.exe
netstat -anp |grep 3306

```

``` bash
mysqld --initialize --console
mysqld --initialize --user=mysql # 初始化并以指定用户开启服务
mysqld --install mysql5 # ？
mysqld --shared-memory --skip-grant-tables # ？
```

## client

客户端位于 `C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe`
``` bash

mysql -u root -p # -u 后面跟登录数据库的用户名称，root；-p 后面是用户登录密码。
# -h 后面的参数是服务器的主机地址
```

### SQL操作


以分号结束，# 标记注释语句。

``` sql
show database; # 分号结束
help; # 显示帮助
```

#### DATABASE
``` sql
show database; # 列举所有表
CREATE DATABASE test_db; # 创建所有表
SHOW DATABASES LIKE '%db'; # 列举表
DROP DATABASE test_db_del; # 删除
use mysql; # 切换到指定表
```

#### table
``` sql
show tables;
CREATE TABLE IF NOT EXISTS `_tbl`(
   `_id` INT UNSIGNED AUTO_INCREMENT,
   `_title` VARCHAR(100) NOT NULL,
   `_author` VARCHAR(40) NOT NULL,
   `submission_date` DATE,
   PRIMARY KEY ( `_id` )
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE _tbl
```
#### column

``` sql


USE test_db;// Database changed
CREATE TABLE tb_emp1
    -> (
    -> id INT(11),
    -> name VARCHAR(25),
    -> deptId INT(11),
    -> salary FLOAT
    -> );
DESC  tb_emp1

SELECT * FROM 表名;
SELECT name,age FROM tb_students_info WHERE age<22;

INSERT INTO tb_courses
	(course_id,course_name,course_grade,course_info)
	 VALUES(1,'Network',3,'Computer Network');
```



mysql> DESC  tb_empl;
+--------+-------------+------+-----+---------+-------+

| Field | Type | Null | Key  | Default | Extra |
| ----- | ---- | ---- | ---- | ------- | ----- |
|       |      |      |      |         |       |
+--------+-------------+------+-----+---------+-------+
| id   | int(11) | YES  |      | NULL |      |
| ---- | ------- | ---- | ---- | ---- | ---- |
|      |         |      |      |      |      |
| name | varchar(25) | YES  |      | NULL |      |
| ---- | ----------- | ---- | ---- | ---- | ---- |
|      |             |      |      |      |      |
| deptId | int(11) | YES  |      | NULL |      |
| ------ | ------- | ---- | ---- | ---- | ---- |
|        |         |      |      |      |      |
| salary | float | YES  |      | NULL |      |
| ------ | ----- | ---- | ---- | ---- | ---- |
|        |       |      |      |      |      |
+--------+-------------+------+-----+---------+-------+
4 rows in set (0.03 sec)



```SQL
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '新密码';

insert into mysql.user(Host,User,Password) values("localhost","test",password("1234"));
```

##  MySQL 存储引擎

不同的存储引擎都有各自的特点，以适应不同的需求，如表所示。为了做出选择，首先要考虑每一个存储引擎提供了哪些不同的功能。

| 功能         | MylSAM | MEMORY | InnoDB | Archive |
| ------------ | ------ | ------ | ------ | ------- |
| 存储限制     | 256TB  | RAM    | 64TB   | None    |
| 支持事务     | No     | No     | Yes    | No      |
| 支持全文索引 | Yes    | No     | No     | No      |
| 支持树索引   | Yes    | Yes    | Yes    | No      |
| 支持哈希索引 | No     | Yes    | No     | No      |
| 支持数据缓存 | No     | N/A    | Yes    | No      |
| 支持外键     | No     | No     | Yes    | No      |

InnoDB 是系统的默认引擎，支持可靠的事务处理。



### [MySQL](http://c.biancheng.net/mysql/) 常见数据类型

在 MySQL 中常见的数据类型如下：

#### 1) 整数类型

包括 TINYINT、SMALLINT、MEDIUMINT、INT、BIGINT，浮点数类型 FLOAT 和 DOUBLE，定点数类型 DECIMAL。

#### 2) 日期/时间类型

包括 YEAR、TIME、DATE、DATETIME 和 TIMESTAMP。

#### 3) 字符串类型

包括 CHAR、VARCHAR、BINARY、VARBINARY、BLOB、TEXT、ENUM 和 SET 等。

#### 4) 二进制类型

包括 BIT、BINARY、VARBINARY、TINYBLOB、BLOB、MEDIUMBLOB 和 LONGBLOB。

## misc

``` bash
MySQL 8.0 Command Line Client=

"E:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" "--defaults-file=E:\ProgramData\MySQL\MySQL Server 8.0\my.ini" "-uroot" "-p"
```


## 拓展

mysqlclient 适用于python3
MySQL-python 适用于python2

## 可视化工具

workbench

navicat 

MySQL ODBC Connector

