### 一行命令查看所有代码文件的行数
# find . -name "*.py" -exec wc {} \;
# 400  1692 19891 ./coco_dataset.py

# find . -name "*.py" -exec wc {} \; |awk '{print $1}' 
find . -name "*.py" -exec wc {} \; |awk '{sum += $1};END {print sum}' 
