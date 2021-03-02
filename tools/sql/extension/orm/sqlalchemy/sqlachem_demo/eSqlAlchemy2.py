import os
from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

Base = declarative_base()
class Role(Base):
    __tablename__ = 'roles'
    id = Column(Integer, primary_key=True)
    name = Column(String(64), unique=True)
    users = relationship('User', backref='role', lazy='dynamic')

    def __repr__(self):
        return '<Role %r>' % self.name


class User(Base):
    __tablename__ = 'users'
    id = Column(Integer, primary_key=True)
    username = Column(String(64), unique=True, index=True)
    role_id = Column(Integer, ForeignKey('roles.id'))

    def __repr__(self):
        return '<User %r>' % self.username

def createDb():
    engine = create_engine('sqlite:///foo.db', echo=True)
    # engine = create_engine('sqlite:///foo.db?check_same_thread=False', echo=True)
    # if not os.path.exists('data.sqlite'):
    #     db.create_all()
    # # db.drop_all()

    Base.metadata.create_all(engine, checkfirst=True)
    return engine


# 数据库中 增 改 删 都是操作,也就是说执行以上三种操作的时候一定要commit
def insertData(DBSession):
    # 创建session对象:
    session = DBSession()
    # 创建新User对象:
    # admin_role = Role(name='Admin')
    a_user = User(username='Alice')
    # 添加到session:
    # session.add(admin_role)
    session.add(a_user)
    # 提交即保存到数据库:
    session.commit()
    # 关闭session:
    session.close()


def queryData(DBSession):
    # 创建session对象:
    session = DBSession()
    # 创建Query查询，filter是where条件，最后调用one()返回唯一行，如果调用all()则返回所有行:
    a_role = session.query(Role).filter(Role.name=='Admin').one()
    print(a_role)
    # 关闭session:
    session.close()


def queryData2(DBSession):
    # 创建session对象:
    session = DBSession()
    # 创建Query查询，filter是where条件，最后调用one()返回唯一行，如果调用all()则返回所有行:
    a_user = session.query(User).filter().all()
    print(a_user)
    # 关闭session:
    session.close()


def insertDatas(DBSession):
    session = DBSession()
    user_list = [
        User(username="wang1"),
        User(username="wang2"),
        User(username="wang3")
    ]
    session.add_all(user_list)
    session.commit()
    session.close()


def updateData(DBSession):
    session = DBSession()
    user2 = session.query(User).filter(User.username == 'Admin').one()
    user2.update({User.username: 'Admin2'}, synchronize_session=False)
    print(user2)
    session.commit()


def deleteData(DBSession):
    session = DBSession()
    user_object = session.query(User).filter(User.username == 'Admin').delete()
    print(user_object)
    session.commit()


def querySort(session):
    # 字符串匹配方式筛选条件 并使用 order_by进行排序
    r6 = session.query(User).filter(text("id<:value and name=:name")).params(value=224, name='wang').order_by(User.id).all()


if __name__ == "__main__":
    engine = createDb()
    DBSession = sessionmaker(bind=engine) 
    insertData(DBSession)
    queryData(DBSession)


# user = User.query.filter_by(username="boo").first()
# print(user)

# 量词  one first 和all，one有什么区别？
