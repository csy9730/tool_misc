# sqlite3 dump

## dump

sqlite3 中导出
``` sql
sqlite> # 指定重定向输出文件
sqlite> .output foo.sql
sqlite> .dump
sqlite> .exit
```

命令行导出
`sqlite3 data.sqlite .dump  > foo.sql`

dump 包括导出 schema 和 data 两种语句。

### dump schema

只导出schema到sql脚本中

``` sql
sqlite> .schema
CREATE TABLE alembic_version (
        version_num VARCHAR(32) NOT NULL,
        CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num)
);
```

### dump data

只导出数据到sql脚本中
```
sqlite> .mode insert
sqlite> .output data.sql
sqlite> select * from artists;


```

### sqlite 导出导入

导出 
```
sqlite3 old.db .dump > newsfeed.sql
```

newsfeed.sql 的内容：
``` sql
PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE alembic_version (
	version_num VARCHAR(32) NOT NULL, 
	CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num)
);
INSERT INTO alembic_version VALUES('f8f4dd4890d5');

CREATE TABLE todos (
	id INTEGER NOT NULL, 
	name VARCHAR(60), 
	status BOOLEAN, 
	progress INTEGER, 
	tag VARCHAR(6) DEFAULT 'weekly' NOT NULL, description VARCHAR(660), 
	PRIMARY KEY (id), 
	CHECK (status IN (0, 1)), 
	CHECK (tag IN ('weekly', 'work', 'study', 'relax'))
);
INSERT INTO todos VALUES(1,'111',0,0,'weekly',NULL);
INSERT INTO todos VALUES(2,'223',1,0,'study',NULL);
INSERT INTO todos VALUES(3,'1233',1,5,'weekly',NULL);
COMMIT;
```

导入 sqlte语句
`sqlite3 new.db < newsfeed.sql`


## export+import
``` bash
sqlite3 data-dev2.sqlite .dump > newsfeed.sql
sqlite3 new.sqlite < newsfeed.sql
```


## export csv

``` sql
sqlite3 c:/sqlite/chinook.db
sqlite> .headers on
sqlite> .mode csv
sqlite> .output data.csv
sqlite> SELECT customerid,
   ...>        firstname,
   ...>        lastname,
   ...>        company
   ...>   FROM customers;
sqlite> .quit
```

或者执行以下语句
`sqlite3 -header -csv c:/sqlite/chinook.db "select * from tracks;" > tracks.csv`
## misc


**Q**: sqlite3 check constraint failed 

**A**: 由于插入语句不满足约束条件，所以插入失败。


**Q**: 在SQLite中创建后可以更改列约束吗?

**A**: 不可以删除或更改约束，只能删表，重建表。


**Q**: "sqlalchemy.exc.DatabaseError: database disk image is malformed" on CLI command

**A**: 硬盘损坏，导致 sqlite3文件损坏。不能使用


[https://www.sqlitetutorial.net/sqlite-dump/](https://www.sqlitetutorial.net/sqlite-dump/)

[https://www.sqlitetutorial.net/sqlite-tutorial/sqlite-export-csv/](https://www.sqlitetutorial.net/sqlite-tutorial/sqlite-export-csv/)