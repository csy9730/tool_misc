#!/bin/bash
# 一行命令查看所有代码文件的bytes数
# find . -name "*.py" -exec wc -c {} \;

# 一行命令查看所有代码文件的行数
# find . -name "*.py" -exec wc -l {} \;
# find . -name "*.py" -exec wc {} \; |awk '{print $1}' 

# 查看所有代码文件的行数的合计
find . -name "*.py" -exec wc -l {} \; |awk '{sum += $1};END {print sum}' 
