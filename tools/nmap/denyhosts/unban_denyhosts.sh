systemctl stop rsyslog
daemon-control-dist stop  

# export IP=123.45.67.89
# export IP2=123.45.67.90

if [ "$2" = "" ]; then
    export IP2=113.68.154.63
else
    export IP2=$2
fi

if [ "$1" = "" ]; then
    export IP=113.68.153.62
else
    export IP=$1
fi

echo "replace ${IP} ${IP2}"

sed -i "s/${IP}/${IP2}/g"  /var/log/secure # centos sshd log
sed -i "s/${IP}/${IP2}/g"  /var/log/auth.log # ubuntu sshd log
sed -i "s/${IP}/${IP2}/g"  /var/log/denyhosts
sed -i "s/${IP}/${IP2}/g"  /etc/hosts.deny

sed -i "s/${IP}/${IP2}/g"  /var/lib/denyhosts/hosts
sed -i "s/${IP}/${IP2}/g"  /var/lib/denyhosts/hosts-restricted
sed -i "s/${IP}/${IP2}/g"  /var/lib/denyhosts/hosts-root
sed -i "s/${IP}/${IP2}/g"  /var/lib/denyhosts/hosts-valid
sed -i "s/${IP}/${IP2}/g"  /var/lib/denyhosts/offset
sed -i "s/${IP}/${IP2}/g"  /var/lib/denyhosts/suspicious-logins
sed -i "s/${IP}/${IP2}/g"  /var/lib/denyhosts/users-hosts
sed -i "s/${IP}/${IP2}/g"  /var/lib/denyhosts/users-invalid
sed -i "s/${IP}/${IP2}/g"  /var/lib/denyhosts/users-valid


systemctl restart rsyslog
daemon-control-dist start 
systemctl restart sshd
systemctl restart firewalld