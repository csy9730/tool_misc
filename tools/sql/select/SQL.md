# SQL


SQL (Structured Query Language:结构化查询语言) 是用于管理关系数据库管理系统（RDBMS）。 SQL 的范围包括数据插入、查询、更新和删除，数据库模式创建和修改，以及数据访问控制。

SQL 是什么？
- SQL 指结构化查询语言，全称是 Structured Query Language。
- SQL 让您可以访问和处理数据库，包括数据插入、查询、更新和删除。
- SQL 在1986年成为 ANSI（American National Standards Institute 美国国家标准化组织）的一项标准，在 1987 年成为国际标准化组织（ISO）标准。

### arch
- 数据库 DATABASE
- 表 TABLE
  - 列名
- 索引
- 数据
  - 元素


### database
- CREATE DATABASE dbname;
- ALTER DATABASE database_name - 修改数据库
- DROP DATABASE database_name


DROP INDEX
### table

- CREATE TABLE - 创建新表
- ALTER TABLE table_name - 变更（改变）数据库表
- DROP TABLE table_name - 删除表
- CREATE INDEX - 创建索引（搜索键）
- TRUNCATE TABLE 清空表内的数据
- 查询表的列名，约束？

#### 元表

众表之表

sqlite查询库里所有表名
```

SELECT name FROM sqlite_master WHERE type="table" ORDER BY name;  
SELECT name FROM sqlite_master; 
SELECT * FROM sqlite_master; 
```

sqlite的元表
```
sqlite>  PRAGMA table_info(sqlite_master)
   ...> ;
0|type|text|0||0
1|name|text|0||0
2|tbl_name|text|0||0
3|rootpage|int|0||0
4|sql|text|0||0
```

mysql的元表
``` sql
SELECT TABLE_NAME,TABLE_ROWS FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA=’dbname'; %–dbname为mysql的数据库名称
```

查询指定数据库中指定表的所有字段名
``` dql
select column_name from information_schema.columns where table_schema=’YOURDATABASENAME’ and table_name=’YOURTABLENAME’
```
#### 索引

在不读取整个表的情况下，索引使数据库应用程序可以更快地查找数据。

您可以在表中创建索引，以便更加快速高效地查询数据。

用户无法看到索引，它们只能被用来加速搜索/查询。

注释：更新一个包含索引的表需要比更新一个没有索引的表花费更多的时间，这是由于索引本身也需要更新。因此，理想的做法是仅仅在常常被搜索的列（以及表）上面创建索引。


- CREATE INDEX index_name ON table_name (column_name) 表中创建索引。
- DROP INDEX index_name - 删除索引
#### COLUMN
- DROP COLUMN column_name

``` sql
ALTER TABLE Customers
DROP COLUMN ContactName;
```

#### data


SELECT - 从数据库中提取数据
UPDATE - 更新数据库中的数据
DELETE - 从数据库中删除数据
INSERT INTO - 向数据库中插入新数据



### sql关键字
#### select from
``` sql
SELECT column_name,column_name
FROM table_name;


SELECT * FROM table_name;


```
#### SELECT DISTINCT 语句
SELECT DISTINCT 语句用于返回唯一不同的值。

下面的 SQL 语句仅从 "Websites" 表的 "country" 列中选取唯一不同的值，也就是去掉 "country" 列重复值：

实例
SELECT DISTINCT country FROM Websites;

#### where
条件过滤器

下面的 SQL 语句从 "Websites" 表中选取国家为 "CN" 的所有网站：

实例
`SELECT * FROM Websites WHERE country='CN';`


下面的运算符可以在 WHERE 子句中使用：

| 运算符  | 描述                                                       |
| :------ | :--------------------------------------------------------- |
| =       | 等于                                                       |
| <>      | 不等于。**注释：**在 SQL 的一些版本中，该操作符可被写成 != |
| >       | 大于                                                       |
| <       | 小于                                                       |
| >=      | 大于等于                                                   |
| <=      | 小于等于                                                   |
| BETWEEN | 在某个范围内                                               |
| LIKE    | 搜索某种模式  模糊查询                                              |
| IN      | 指定针对某个列的多个可能值                                 |
| is null    | 空值判断                                |

``` sql
Select * from emp where sal in (5000,3000,1500);
Select * from emp where comm is null;
```
#### expression
条件表达式
#### AND & OR 运算符

AND & OR 运算符用于基于一个以上的条件对记录进行过滤。


下面的 SQL 语句从 "Websites" 表中选取国家为 "CN" 且alexa排名大于 "50" 的所有网站：

实例
``` sql
SELECT * FROM Websites
WHERE country='CN'
AND alexa > 50;
```

您也可以把 AND 和 OR 结合起来（使用圆括号来组成复杂的表达式）。

下面的 SQL 语句从 "Websites" 表中选取 alexa 排名大于 "15" 且国家为 "CN" 或 "USA" 的所有网站：

实例
```
SELECT * FROM Websites
WHERE alexa > 15
AND (country='CN' OR country='USA');
```
#### NOT

#### ORDER BY 关键字
ORDER BY 关键字用于对结果集进行排序。
``` sql
SELECT * FROM Websites
ORDER BY alexa;
```
下面的 SQL 语句从 "Websites" 表中选取所有网站，并按照 "alexa" 列降序排序：
``` sql
SELECT * FROM Websites
ORDER BY alexa DESC;
```

下面的 SQL 语句从 "Websites" 表中选取所有网站，并按照 "country" 和 "alexa" 列排序：

实例
``` sql
SELECT * FROM Websites
ORDER BY country,alexa;
```
#### LIKE

``` sql
Select * from emp where ename like 'M%';
```
查询 EMP 表中 Ename 列中有 M 的值，M 为要查询内容中的模糊信息。

 % 表示多个字值，_ 下划线表示一个字符；
 M% : 为能配符，正则表达式，表示的意思为模糊查询信息为 M 开头的。
 %M% : 表示查询包含M的所有内容。
 %M_ : 表示查询以M在倒数第二位的所有内容。
#### 通配符
通配符可用于替代字符串中的任何其他字符。

，通配符与 SQL LIKE 操作符一起使用。

SQL 通配符用于搜索表中的数据。


在 SQL 中，可使用以下通配符：

| 通配符                         | 描述                       |
| :----------------------------- | :------------------------- |
| %                              | 替代 0 个或多个字符        |
| _                              | 替代一个字符               |
| [*charlist*]                   | 字符列中的任何单一字符     |
| [^*charlist*] 或 [!*charlist*] | 不在字符列中的任何单一字符 |

#### IN 操作符
IN 操作符允许您在 WHERE 子句中规定多个值。

下面的 SQL 语句选取 name 为 "Google" 或 "菜鸟教程" 的所有网站：

实例
``` sql
SELECT * FROM Websites
WHERE name IN ('Google','菜鸟教程');
```
#### BETWEEN 操作符
下面的 SQL 语句选取 alexa 介于 1 和 20 之间的所有网站：

实例
``` sql
SELECT * FROM Websites
WHERE alexa BETWEEN 1 AND 20;
```
#### SELECT TOP 
SELECT TOP 子句用于规定要返回的记录的数目。

SELECT TOP 子句对于拥有数千条记录的大型表来说，是非常有用的。
#### LIMIT
下面的 SQL 语句从 "Websites" 表中选取头两条记录：

实例
SELECT * FROM Websites LIMIT 2;

#### As 别名
AS alias_name

#### join
SQL join 用于把来自两个或多个表的行结合起来。

下图展示了 LEFT JOIN、RIGHT JOIN、INNER JOIN、OUTER JOIN 相关的 7 种用法。
![s](https://www.runoob.com/wp-content/uploads/2019/01/sql-join.png)

在我们继续讲解实例之前，我们先列出您可以使用的不同的 SQL JOIN 类型：

INNER JOIN：如果表中有至少一个匹配，则返回行
LEFT JOIN：即使右表中没有匹配，也从左表返回所有的行
RIGHT JOIN：即使左表中没有匹配，也从右表返回所有的行
FULL JOIN：只要其中一个表中存在匹配，则返回行
#### union

UNION 操作符用于合并两个或多个 SELECT 语句的结果集。

请注意，UNION 内部的每个 SELECT 语句必须拥有相同数量的列。列也必须拥有相似的数据类型。同时，每个 SELECT 语句中的列的顺序必须相同。
#### CHECK
SQL CHECK 约束
CHECK 约束用于限制列中的值的范围。

如果对单个列定义 CHECK 约束，那么该列只允许特定的值。

如果对一个表定义 CHECK 约束，那么此约束会基于行中其他列的值在特定的列中对值进行限制。
#### Constraints
约束

SQL 约束用于规定表中的数据规则。

如果存在违反约束的数据行为，行为会被约束终止。

约束可以在创建表时规定（通过 CREATE TABLE 语句），或者在表创建之后规定（通过 ALTER TABLE 语句）。
#### create table

``` sql
CREATE TABLE Persons
(
ID int NOT NULL AUTO_INCREMENT,
LastName varchar(255) NOT NULL,
FirstName varchar(255),
Address varchar(255),
City varchar(255),
PRIMARY KEY (ID)
)
```

#### TRUNCATE TABLE
TRUNCATE TABLE 语句
如果我们仅仅需要删除表内的数据，但并不删除表本身，那么我们该如何做呢？

请使用 TRUNCATE TABLE 语句：
``` sql
TRUNCATE TABLE table_name
```

#### AUTO INCREMENT

#### view
视图是基于 SQL 语句的结果集的可视化的表。

视图包含行和列，就像一个真实的表。视图中的字段就是来自一个或多个数据库中的真实的表中的字段。

您可以向视图添加 SQL 函数、WHERE 以及 JOIN 语句，也可以呈现数据，就像这些数据来自于某个单一的表一样。

#### DROP VIEW

DROP VIEW view_name

#### sql 函数
last()
max()
min()
sum()
len()
avg()
#### count()
COUNT(column_name) 函数返回指定列的值的数目（NULL 不计入）：
SELECT COUNT(column_name) FROM table_name


SQL COUNT(*) 实例
如果我们省略 WHERE 子句，比如这样：

SELECT COUNT(*) AS NumberOfOrders FROM Orders


SQL COUNT(DISTINCT column_name) 实例
现在，我们希望计算 "Orders" 表中不同客户的数目。

我们使用如下 SQL 语句：

SELECT COUNT(DISTINCT Customer) AS NumberOfCustomers FROM Orders

#### first()
#### MySQL Date 函数

下面的表格列出了 MySQL 中最重要的内建日期函数：

| 函数                                                         | 描述                                |
| :----------------------------------------------------------- | :---------------------------------- |
| [NOW()](https://www.runoob.com/sql/func-now.html)            | 返回当前的日期和时间                |
| [CURDATE()](https://www.runoob.com/sql/func-curdate.html)    | 返回当前的日期                      |
| [CURTIME()](https://www.runoob.com/sql/func-curtime.html)    | 返回当前的时间                      |
| [DATE()](https://www.runoob.com/sql/func-date.html)          | 提取日期或日期/时间表达式的日期部分 |
| [EXTRACT()](https://www.runoob.com/sql/func-extract.html)    | 返回日期/时间的单独部分             |
| [DATE_ADD()](https://www.runoob.com/sql/func-date-add.html)  | 向日期添加指定的时间间隔            |
| [DATE_SUB()](https://www.runoob.com/sql/func-date-sub.html)  | 从日期减去指定的时间间隔            |
| [DATEDIFF()](https://www.runoob.com/sql/func-datediff-mysql.html) | 返回两个日期之间的天数              |
| [DATE_FORMAT()](https://www.runoob.com/sql/func-date-format.html) | 用不同的格式显示日期/时间           |


#### 数据类型

数据库表中的每个列都要求有名称和数据类型。Each column in a database table is required to have a name and a data type.

SQL 开发人员必须在创建 SQL 表时决定表中的每个列将要存储的数据的类型。数据类型是一个标签，是便于 SQL 了解每个列期望存储什么类型的数据的指南，它也标识了 SQL 如何与存储的数据进行交互。

下面的表格列出了 SQL 中通用的数据类型：

| 数据类型                           | 描述                                                         |
| :--------------------------------- | :----------------------------------------------------------- |
| CHARACTER(n)                       | 字符/字符串。固定长度 n。                                    |
| VARCHAR(n) 或 CHARACTER VARYING(n) | 字符/字符串。可变长度。最大长度 n。                          |
| BINARY(n)                          | 二进制串。固定长度 n。                                       |
| BOOLEAN                            | 存储 TRUE 或 FALSE 值                                        |
| VARBINARY(n) 或 BINARY VARYING(n)  | 二进制串。可变长度。最大长度 n。                             |
| INTEGER(p)                         | 整数值（没有小数点）。精度 p。                               |
| SMALLINT                           | 整数值（没有小数点）。精度 5。                               |
| INTEGER                            | 整数值（没有小数点）。精度 10。                              |
| BIGINT                             | 整数值（没有小数点）。精度 19。                              |
| DECIMAL(p,s)                       | 精确数值，精度 p，小数点后位数 s。例如：decimal(5,2) 是一个小数点前有 3 位数，小数点后有 2 位数的数字。 |
| NUMERIC(p,s)                       | 精确数值，精度 p，小数点后位数 s。（与 DECIMAL 相同）        |
| FLOAT(p)                           | 近似数值，尾数精度 p。一个采用以 10 为基数的指数计数法的浮点数。该类型的 size 参数由一个指定最小精度的单一数字组成。 |
| REAL                               | 近似数值，尾数精度 7。                                       |
| FLOAT                              | 近似数值，尾数精度 16。                                      |
| DOUBLE PRECISION                   | 近似数值，尾数精度 16。                                      |
| DATE                               | 存储年、月、日的值。                                         |
| TIME                               | 存储小时、分、秒的值。                                       |
| TIMESTAMP                          | 存储年、月、日、小时、分、秒的值。                           |
| INTERVAL                           | 由一些整数字段组成，代表一段时间，取决于区间的类型。         |
| ARRAY                              | 元素的固定长度的有序集合                                     |
| MULTISET                           | 元素的可变长度的无序集合                                     |
| XML                                | 存储 XML 数据                                                |
#### SQL AVG() 函数
AVG() 函数
AVG() 函数返回数值列的平均值。

SQL AVG() 语法
SELECT AVG(column_name) FROM table_name

#### GROUP BY
分组查询
#### Having
group by + having 用来分组查询后指定一些条件来输出查询结果
having 和 where 一样，但 having 只能用于 group by