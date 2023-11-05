
#!/bin/sh

# update by csy on 20230709

# sudo apt update -y
# sudo apt upgrate -y

sudo yum install -y git vim zsh wget curl 
sudo yum install tmux screen zip -y
sudo yum install openssh-server -y
# sudo yum install net-tools  rdesktop putty adb -y

guess_os(){
    isLinux=$(uname -a |grep -i Linux)
    guess_os=""
    if [ "$isCentos" != ""  ] ;then
        # isCentos=$(lsb_release -a |grep -i Centos)
        if test -n "$(cat /etc/issue |grep -i Ubuntu)" ;then
            echo "Your system is ubuntu"
            guess_os="Linux ubuntu"
        elif test -n "$(cat /etc/redhat-release |grep -i CentOS)" ;then
            echo "Your system is Centos"
            guess_os="Linux Centos"
        elif test -n "$(uname -a |grep -i android)" ;then
            echo "Your system is android"
            guess_os="Linux android"
        else
            guess_os="Linux"
            echo "Your system is Linux"
        fi
    elif test -n "$(uname -a |grep -i NT)"; then
        guess_os="windows"
        echo "Your system is windows"
    else
        echo "Your system is else"
    fi
}

# 
installPython(){
    sudo yum install python3 python3-dev -y
}


installPip(){
    # apt install python-pip  -y
    apt install python3-pip  -y
    #  wget https://bootstrap.pypa.io/get-pip.py
    # python get-pip.py

    python3 -m pip -V # query version
    python3 -m pip  install -U pip
}


# sudo apt install nginx redis -y

installJava(){
    sudo yum install jre -y
    # apt install openjdk-11-jre-headless        
    # apt install openjdk-8-jre-headless 
    java --version
    # export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64

    sudo apt install default-jdk -y

    javac -version

}
installGo(){

}
# sudo apt install nmap  -y

# apt install sqlite

# sudo apt install perl lua5.3  -y

installGcc(){
    sudo yum install gcc g++ cmake  -y
    # apt install autoconf  automake libtool pkg-config -y
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
    installJava
}

enableSshd(){
    # systemctl status sshd
    service sshd start
}

main(){
    
}
main $@
