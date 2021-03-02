import sqlite3

# 连接数据库（如果数据库不存在就会创建新的数据库）#
con = sqlite3.connect("DEMO.db")
cur = con.cursor()


def addTable():
    sql = "CREATE TABLE IF NOT EXISTS test(id INTEGER PRIMARY KEY,name TEXT,age INTEGER)"
    cur.execute(sql)
    con.commit()


def addData():
    # #添加单条数据
    data = "1,'Desire',5"
    cur.execute('INSERT INTO test VALUES (%s)' % data)
    con.commit()


def addData2():
    # ②：添加单条数据
    cur.execute("INSERT INTO test values(?,?,?)", (6, "zgq", 20))
    # ③：添加多条数据
    cur.executemany('INSERT INTO test VALUES (?,?,?)', [(3, 'name3', 19), (4, 'name4', 26)])
    con.commit()


def updateData():
    # 方式一
    cur.execute("UPDATE test SET name=? WHERE id=?", ("nihao", 1))
    # 方式二
    cur.execute("UPDATE test SET name='haha' WHERE id=3")
    con.commit()
    # con.rollback()


def delData():
    # 方式一
    cur.execute("DELETE FROM test WHERE id=?", (1,))
    # 方式二
    cur.execute("DELETE FROM test WHERE id=3")


def queryData():
    cur.execute("select * from Test")
    print(cur.fetchone())


def queryData2(): 
    cur.execute("select * from Test")
    print(cur.fetchall())
    print(cur.fetchmany(3))


if __name__ == "__main__":
    addTable()
    addData()
    addData2()
    queryData2()
    
    # 关闭游标
    cur.close()
    # 断开数据库连接
    con.close()