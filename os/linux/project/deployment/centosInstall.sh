installJava(){
    sudo yum install jre -y
    # apt install openjdk-11-jre-headless        
    # apt install openjdk-8-jre-headless 
    java --version
    # export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64

    sudo apt install default-jdk -y

    javac -version

}