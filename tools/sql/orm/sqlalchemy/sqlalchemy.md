# sqlalchemy

SQLAlchemy本身无法操作数据库，其必须以来pymsql等第三方插件，Dialect用于和数据API进行交流，根据配置文件的不同调用不同的数据库API，从而实现对数据库的操作.

* MySQL 
    * origin `mysql://username:password@hostname/database`
    * PyMySQL: `mysql+pymysql://user:pass@some_mariadb/dbname?charset=utf8mb4`
    * PyMySQL: `mariadb+pymysql://user:pass@some_mariadb/dbname?charset=utf8mb4`
    * mysqlclient: `mysql+mysqldb://<user>:<password>@<host>[:<port>]/<dbname>`
    * mysqlclient: `mysql+mysqldb://root@/<dbname>?unix_socket=/cloudsql/<projectid>:<instancename>`
    * MySQL连接器: `mysql+mysqlconnector://<user>:<password>@<host>[:<port>]/<dbname>`
    * CyMySQL   `mysql+cymysql://<username>:<password>@<host>/<dbname>[?<options>]`
    * OurSQL
    * PyODBC
* Postgres `postgresql://username:password@hostname/database`
* SQLite
    * （Unix） `sqlite:////absolute/path/to/database`
    * （Windows） `sqlite:///c:/absolute/path/to/database`

dialect/DBAPI  有：mysqlclient ，PyMySQL，MySQL Connector/Python。只有 mysqlclient 和 PyMySQL是推荐的，

## main

在列上指定server_default，如下所示：
``` python
class LaunchId(Base):
    """Launch ID table for runs"""
    __tablename__ = 'launch_ids'

    id = Column(Integer, primary_key=True)
    launch_time = Column(DateTime, nullable=False
                         server_default=text("(now() at time zone 'utc')"))
```

然后通过会话添加一个新的launch_id就可以了。server_default的工作方式与default不同，因为它是在服务器端生成的。官方SQLAlchemy文档：[defaults.html#server-side-defaults](http://docs.sqlalchemy.org/en/latest/core/defaults.html#server-side-defaults)


通过指定nullable=False, 可以禁止属性的输入为空。

### init

表创建：可以通过`Base.metadata.create_all`, 或使用`alembic`生成。


