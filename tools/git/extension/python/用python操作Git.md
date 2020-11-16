# 用python操作Git          



# 安装第三方模块

```
pip install gitpython
```

 

```
使用
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
from git import Repo

r = Repo("C:\\Users\\robert\\Desktop\\test") # 创建一个操作对象

# git add 添加测试.txt
r.index.add([r'C:\Users\robert\Desktop\test\添加测试.txt'])  

# git commit -m 'python 操作git'
r.index.commit("python 操作git")

# git branch
r.branches  # [<git.Head "refs/heads/dev">, <git.Head "refs/heads/list">]
print([str(b) for b in r.branches]) # ['dev', 'list', 'master']

# git tag
r.tags
print([ str(t) for t in r.tags]) # ['v0.0.1', 'v0.1']

# 当前分支
r.active_branch

# 创建分支 git branch 分支名
r.create_head('dev')

# 克隆 git clone
r.clone_from(url,to_path)

# git tag -a v1.3 创建tag
r.create_tag("v1.3")

# git log
r.iter_commits()
print([str(i.message) for i in r.iter_commits()]) # 获取提交信息
print([str(i.message) for i in r.iter_commits()]) # 查看提交的hash值

# git push origin master
r.remote().push('master')

# git pull
r.remote().pull()
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

 

#### 执行Git原生语句的方法

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
from git import Git

r = Git("C:\\Users\\robert\\Desktop\\test")

# 执行原生语句
r.execute('git log') 
print(r.execute('git log'))

# 提交记录
r.commit('-m 提交记录')

# 切换分支
r.checkout('master')
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

 