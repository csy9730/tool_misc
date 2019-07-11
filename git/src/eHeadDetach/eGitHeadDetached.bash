# HEAD 就会处于 detached 状态（游离状态）。

git branch -v  
git branch temp # 新建一个 temp 分支
git checkout temp # 当前提交的代码放到整个分支 
git checkout master
git merge temp
git pull
git push