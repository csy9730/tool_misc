#coding=utf-8

#  导入MySQL驱动:
import mysql.connector
# 注意把password设为你的root口令:
conn = mysql.connector.connect(user='root', password='12345', database='test', use_unicode=True)
cursor = conn.cursor()

# 创建user表:
#cursor.execute('create table user (id varchar(20) primary key, name varchar(20))')
# 插入一行记录，注意MySQL的占位符是%s:
#cursor.execute('use table user ')
#cursor.execute('insert into user (id, name) values (%s, %s)', ['1', 'Michael'])

#cursor.execute('insert into user (id, name) values (%s, %s)', ['3', 'John'])
#cursor.execute('insert into user (id, name) values (%s, %s)', ['3', 'Amy'])

str="""  
IF EXISTS (SELECT * FROM user WHERE id='1')
UPDATE user SET id=1 WHERE name='Michael'
ELSE BEGIN
INSERT INTO user (id,name) VALUES ( %s,%s)
END
"""%(1, 'Michael')
#cursor.execute(str)

print(cursor.rowcount)
raw_input("press key to continue")
# 提交事务:
conn.commit()
cursor.close()
# 运行查询:
cursor = conn.cursor()
cursor.execute('select * from user where id = %s', ('1',))
values = cursor.fetchall()
print(values)
# 关闭Cursor和Connection:
cursor.close()
conn.close()