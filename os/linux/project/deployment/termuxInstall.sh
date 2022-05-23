#!/bin/sh
sudo apt update -y
sudo apt upgrate -y

sudo apt install -y git vim zsh wget curl 
sudo apt install tmux screen zip -y


enableSshd(){

}

installPython(){
    apt install python3 python3-dev -y
}

installVirtualenv(){
    pip install virtualenv -y
    # mkdir -p ~/conda/venv/ && cd ~/conda/venv/
    # virtualenv a_env
}

main(){
    installPython
    installVirtualenv
}
main $@