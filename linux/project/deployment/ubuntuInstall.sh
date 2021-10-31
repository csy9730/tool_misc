#!/bin/sh
sudo apt update -y
sudo apt upgrate -y

sudo apt install -y git vim zsh wget curl 
sudo apt install tmux screenzip -y
sudo apt install net-tools  openssh-server rdesktop putty adb -y


# sudo apt install python3 python3-dev -y
# sudo apt install pip3 -y

# sudo apt install nginx redis -y

# java

# sudo apt install nmap  -y

# apt install sqlite

# sudo apt install perl lua5.3  -y

installGcc(){
    sudo apt-get install gcc g++ cmake  -y
    apt install autoconf  automake libtool pkg-config -y
}

installNode(){
# sudo apt install nodejs npm -y

}

installVm(){
# vm
# kali
}

installDocker(){

}

installEtcHosts(){
    sudo  bash -c 'echo "12.34.56.78 foo foo.com">> /etc/hosts'

}

installSshConfig(){
    sudo apt install knock -y

    sudo chmod 700 ~/.ssh
}

installShadowsocks(){
    sudo apt install  shadowsocks-libev -y
    # ss-local -c /etc/shadowsocks-libev/config.json 
    git config --global http.proxy 'socks5://127.0.0.1:1080'
    git config --global https.proxy 'socks5://127.0.0.1:1080'

    # 取消代理

    # git config --global --unset http.proxy
    # git config --global --unset https.proxy

    export http_proxy="socks5://127.0.0.1:1080"
    export https_proxy="socks5://127.0.0.1:1080"
}

installOhmyzsh(){
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    # sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
}

installAnaconda(){
    echo "Anaconda"
    wget -nc https://repo.anaconda.com/archive/Anaconda3-2021.05-Linux-x86_64.sh
    chmod +x Anaconda3-2021.05-Linux-x86_64.sh
    ./Anaconda3-2021.05-Linux-x86_64.sh

    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/
    conda config --set show_channel_urls yes
}


installInputMethod(){
    # google/sougou  pinyin input 
}

installNvidia(){
    sudo apt install build-essential libglvnd-dev pkg-config
    wget NVIDIA-Linux-x86_64-440.44.run # 
}

installAll(){
    installAnaconda
}
