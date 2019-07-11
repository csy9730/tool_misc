mkdir 1
cd 1
git init
echo 1>>1.txt
echo 11>>11.txt
git add .
git commit -m "add 11"
pause
git submodule add ../22
