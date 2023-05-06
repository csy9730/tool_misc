#!/bin/bash
cd /tmp
# 去掉EOF两边的空格
sftp ali_csy <<EOF
cd /tmp
get demo.cpp .
exit
EOF