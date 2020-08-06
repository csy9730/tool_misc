#!/bin/sh
sudo apt upgrade # 更新apt软件
sudo apt update  # 更新软件包
sudo apt-get install zsh -y
sudo apt-get install gcc g++ git cmake -y
sudo apt-get install vim -y
sudo apt-get install wget -y
sudo apt-get install curl -y
`sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"`
sudo apt install python3 -y
sudo apt install pip3 -y


# sudo apt-get install  python python-dev -y
# sudo apt-get install mercurial -y
# sudo apt-get install bzr -y
# sudo apt-get install gdb valgrind -y
# sudo apt-get install gsl-bin libgsl0-dev libgsl0ldbl -y
# sudo apt-get install flex bison libfl-dev -y
# sudo apt-get install g++-3.4 gcc-3.4 -y
# sudo apt-get install tcpdump -y
# sudo apt-get install aqlite aqlite3 libsqlite3-dev -y
# sudo apt-get install libxml2 libxml2-dev -y
# sudo apt-get install libgtk2.0-0 libgtk2.0-dev -y
# sudo apt-get install vtun lxc -y
# sudo apt-get install uncrustify -y
# sudo apt-get install doxygen grphviz imagemagick -y
# sudo apt-get install texlive texlive-extra-untils texlive-latex-extra -y
# sudo apt-get install libboost-signals-dev libboost-filesystem-dev -y
# sudo apt-get install openmpi* -y

curl -sSL http://acs-public-mirror.oss-cn-hangzhou.aliyuncs.com/docker-engine/internet | sh -
