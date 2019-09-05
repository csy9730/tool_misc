# git submodule

$ git submodule add <仓库地址> <本地路径> # clone 仓库地址作为submodule到本地。

 git submodule add ssh://git@10.2.237.56:23/dennis/sub.git lib

添加成功后，在父仓库根目录增加了.gitmodule文件。

 #.git/config 加入submodule段。


 git submodule update --init --recursive


 submodule
```
git submodule add <submodule_url>  # 添加子项目
git clone --recurse-submodules <main_project_url>  # 获取主项目和所有子项目源码

git submodule init
git submodule update

rm -rf sm_path  # 删除子模块目录及源码
vi .gitmodules # 删除项目目录下.gitmodules文件中子模块相关条目
vi .git/config # 删除配置项中子模块相关条目
rm .git/module/* # 删除模块下的子模块目录，每个子模块对应一个目录
git rm --cached 子模块名称 # 清理错误
```