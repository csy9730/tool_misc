
# sqlalchemy中一对多、多对多关系

## 一对多关系

一对多关系：
主键在“一”的一方，外键在“多”的一方，在sqlalchemy中使用关系属性（relationship）关联时，就是把“一”的一方的主键添加到“多”的一方数据的外键里，从而让“一”和“多”产生逻辑上的关联，即再添加“多”的数据时，无需关注外键，使用relationship关系属性后，会自动添加相应的外键：


``` python
class Role(db.Model):
    __tablename__ = 'roles'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(64), unique=True)
    users = db.relationship('User', backref='role', lazy='dynamic')

    def __repr__(self):
        return '<Role %r>' % self.name


class User(db.Model):
    __tablename__ = 'users'
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(64), unique=True, index=True)
    role_id = db.Column(db.Integer, db.ForeignKey('roles.id'))

    def __repr__(self):
        return '<User %r>' % self.username
```

## 多对多关系：
多对多关系中，使用relationship关联两张表，需要先建立一张关系表，关系表存储的是其他两张表的主键，同样在操作时也可以使用remove/append方法来删除、添加数据，在多对多关系中，使用append/remove方法，操作的仍然是外键（第三张表，即关系表）。

## restriction

#### primary_key
主键
#### ForeignKey
 Column('user_id', ForeignKey('user_account.id'), nullable=False),
#### relationship
  addresses = relationship("Address", back_populates="user")