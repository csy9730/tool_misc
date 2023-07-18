# [python3-sql解析库——sqlparse](https://www.cnblogs.com/jiangbei/p/11274942.html)

## 官方文档

　　https://sqlparse.readthedocs.io/en/latest/

## 快速开始

　　使用pip或者conda安装：

 

```
conda install sqlparse
```

 

　　使用官网示例快速入门，使用sqlparse的三大常用功能：



```python
# -*- coding:UTF-8 -*-
import sqlparse

sql = "select id,name_,age from dual;select id,'18;19',age from actor;"
# 1.分割SQL
stmts = sqlparse.split(sql)
for stmt in stmts:
    # 2.format格式化
    print(sqlparse.format(stmt, reindent=True, keyword_case="upper"))
    # 3.解析SQL
    stmt_parsed = sqlparse.parse(stmt)
    print(stmt_parsed[0].tokens)
```



　　输出如下：



```
SELECT id,
       name_,
       age
FROM dual;
[<DML 'select' at 0x20A7A0F3F48>, <Whitespace ' ' at 0x20A7A0FD5E8>, <IdentifierList 'id,nam...' at 0x20A7A0FA6D8>, <Whitespace ' ' at 0x20A7A0FD828>, <Keyword 'from' at 0x20A7A0FD888>, <Whitespace ' ' at 0x20A7A0FD8E8>, <Identifier 'dual' at 0x20A7A0FA660>, <Punctuation ';' at 0x20A7A0FD9A8>]
SELECT id,
       '18;19',
       age
FROM actor;
[<DML 'select' at 0x20A7A0F3B88>, <Whitespace ' ' at 0x20A7A0F3BE8>, <IdentifierList 'id,'18...' at 0x20A7A0FA7C8>, <Whitespace ' ' at 0x20A7A0F3E28>, <Keyword 'from' at 0x20A7A0F3E88>, <Whitespace ' ' at 0x20A7A0F3EE8>, <Identifier 'actor' at 0x20A7A0FA0C0>, <Punctuation ';' at 0x20A7A0F36A8>]
```



3.实例

 

分类: [Python](https://www.cnblogs.com/jiangbei/category/1179064.html)