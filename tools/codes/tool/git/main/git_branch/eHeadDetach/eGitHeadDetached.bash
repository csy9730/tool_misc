# HEAD 就会处于 detached 状态（游离状态）。


git branch temp # 新建一个 temp 分支
git checkout temp # 当前提交的代码放到整个分支 
# edit temp branch 
# git commit 

git checkout master
git merge temp
git branch -d temp # delete temp branch 
# git pull
# git push



function foo{
    git checkout master
    git merge xxx_id
}