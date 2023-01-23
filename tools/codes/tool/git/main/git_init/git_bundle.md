# git bundle

## demo

### init & bundle
以下方法可以完美复制仓库
``` bash
git bundle create a.bundle master # 复制仓库

scp a.bundle rmt:/foo
ssh rmt & cd foo
git clone a.bundle
```


### patch

以下方法可以远程发送补丁，并且确保版本号一致。format-patch难以确保版本一致。
```
git bundle create a.bundle abcd..master
scp a.bundle rmt:/foo

ssh rmt & cd foo
git bundle verify a.bundle
git pull a.bundle master
```


