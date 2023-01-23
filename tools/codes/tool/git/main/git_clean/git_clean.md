# git clean

``` bash

git clean # 清除所有untracked文件，不包括untracked文件夹
git clean -d # 清除所有untracked文件，包括untracked文件夹
git clean  -X    # 只清除.gitignore文件
git clean  -Xd  # 只清除.gitignore文件和文件夹

git clean  -x    # 清除.gitignore文件和untracked文件
git clean  -xd  # 清除.gitignore和untracked文件和文件夹

git clean -f # 强制删除
git clean -i # 交互模式
git clean -n # dry-run模式,显示可删除文件，并不真的执行删除。

```