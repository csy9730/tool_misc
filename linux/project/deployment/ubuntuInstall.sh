#!/bin/sh
sudo apt update -y
sudo apt upgrate -y

sudo apt install -y git vim zsh wget curl 
sudo apt install tmux net-tools zip openssh-server

# sudo apt-get install gcc g++ cmake -y
# sudo apt install python3 python3-dev -y
# sudo apt install pip3 -y

# `sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"`
# `sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"`
# 1其本质就是下载并执行了github上的install.sh脚本, 该脚本位于oh-my-zsh/tools/install.sh

