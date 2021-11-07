#coding=utf-8
import mysql.connector

conn = mysql.connector.connect(user='csy_lg', password='123456',
        buffered=True)

# conn = mysql.connector.connect(user='root', password='mysql8233*@##', database='test', use_unicode=True)
cursor = conn.cursor()
print(cursor)
if 1:
    # global cursor,conn
    cursor.execute("SHOW DATABASES")
    print(cursor )
    exist = False
    for x in cursor:
        print(x)
        if x[0] == 'py_test_db':
            exist = True
            break
    if not exist:
        cursor2 =cursor.execute("CREATE DATABASE py_test_db;")
        print(cursor2 )
        cursor.execute('use  py_test_db; ')
        cursor.execute('create table user (id varchar(20) primary key, name varchar(20));')
        # 插入一行记录，注意MySQL的占位符是%s:
        # cursor.execute('use table user ;')
        cursor.execute('insert into user (id, name) values (%s, %s)', ['1', 'Michael'])

        cursor.execute('insert into user (id, name) values (%s, %s)', ['2', 'John'])
        cursor.execute('insert into user (id, name) values (%s, %s)', ['3', 'Amy'])
        conn.commit()
    else:
        print("exist")
        cursor.execute('use  py_test_db; ')

    cursor.close()
if 1:
    st="""  
    IF EXISTS (SELECT * FROM user WHERE id='1')
    UPDATE user SET id=1 WHERE name='Michael'
    ELSE BEGIN
    INSERT INTO user (id,name) VALUES ( %s,%s)
    END4
    """%(1, 'Michael')
    cursor = conn.cursor()
    # cursor.execute(st)
    print(cursor.rowcount)
    # 提交事务:
    conn.commit()
    cursor.close()

# 运行查询:

cursor = conn.cursor()
cursor.execute('select * from user where id = %s', ('2',))
values = cursor.fetchall()
print(values)
# 关闭Cursor和Connection:
cursor.close()
conn.close()
def clear():
    conn = mysql.connector.connect(user='csy_lg', password='123456',
        buffered=True)
    cursor = conn.cursor()
    cursor.execute("DROP DATABASE py_test_db;")
    print(cursor )
    cursor.close()
    conn.close()
def main():
    pass
    clear()
    # sqlInsert()
    #sqlGet() 

if __name__ == "__main__":
    main()