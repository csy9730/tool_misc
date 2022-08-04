# git diff old mode 解决办法

![img](https://upload.jianshu.io/users/upload_avatars/6574148/133c1beb-6e04-4743-ad2b-38fdbc03e870?imageMogr2/auto-orient/strip|imageView2/1/w/96/h/96/format/webp)

[HongXunPan](https://www.jianshu.com/u/3f7f9f782c2e)关注

2020.02.29 16:14:04字数 106阅读 537

把项目部署到服务器后没有做改动，用 `git pull` 拉取变更的代码提示本地文件已修改。随便 `git diff` 则显示

```bash
git diff xxx
old mode 100644
new mode 100755
```

明显可以看到是文件权限改变了引起的，解决办法也很简单，只需要设置 git 忽略本地文件的权限价差

- 方法1，当前项目设置

```bash
git config core.filemode false
```

- 方法2，git 全局设置

```bash
git config -
```