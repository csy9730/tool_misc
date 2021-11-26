git init
touch readme.txt
git add . && git commit -m "init"
git config  core.autocrlf false

git branch -b dev
echo a>>readme.txt
git add . & git commit -m "add a"
echo b>>readme.txt
git add . & git commit -m "add b"
echo c>>readme.txt
git add . & git commit -m "add c"

echo master merge dev + rebase
git checkout master
git merge dev --squash
git add . && git commit -m "add abc"

echo dev merge master + update
git checkout dev
git merge master

echo d>>readme.txt
git add . && git commit -m "add d"

echo 2 master merge dev + rebase 

git checkout master
git merge dev --squash
git commit -m "add d"

