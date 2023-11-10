# git push


## git_push
```

```


``` bash
git push origin master
git push origin dev:satellite/dev

# 指定默认推送
git push -u origin master

# 执行默认推送
git push

git push origin HEAD

# 多个分支推送
git push origin
git push origin :

# 多个分支推送，指定映射
git push mothership master:satellite/master dev:satellite/dev
```

refs/heads/master

remotes/origin/master 


#### 3
```
git push origin master
```
如果远程分支被省略，如上则表示将本地分支推送到与之存在追踪关系的远程分支（通常两者同名），如果该远程分支不存在，则会被新建



#### push
`git push <远程主机名> <本地分支名> : <远程分支名>`

例如

`git push origin master：refs/for/master`

是将本地的master分支推送到远程主机origin上的对应master分支

```
origin 是远程主机名，
第一个master是本地分支名，
第二个master是远程分支名。
```

#### 4
``` bash
git push origin HEAD:refs/for/master
```


```
git push 肯定是推送
origin : 是远程的库的名字
HEAD: 这里是指代master
refs/for :意义在于我们提交代码到服务器之后是需要经过 code review 之后才能进行merge的
refs/heads： 不需要code review
```


## misc
HEAD是一个特别的指针，它是一个指向你正在工作的本地分支的指针，可以把它当做本地分支的别名，git这样就可以知道你工作在哪个分支, 