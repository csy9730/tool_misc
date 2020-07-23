

git init
echo A > file
git add file
git commit -mA
git tag vA
echo B >> file ; git commit -mB file;git tag vB
echo C >> file ; git commit -mC file;git tag vC
echo D >> file ; git commit -mD file;git tag vD
git show-branch --more=4 master
git format-patch -1
git format-patch -3

git format-patch master~3..master

git checkout vB
git branch  alt
echo X>> file ; git commit -mX file;git tag vX
echo Y>> file ; git commit -mY file;git tag vY
echo Z >> file ; git commit -mZ file;git tag vZ

git log --graph --pretty=oneline --abbrev-commit --all

git checkout master
git merge alt

pause
git add file
git commit -m 'all lines'

echo F >> file ; git commit -mF file;git tag vF
