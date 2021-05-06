systemctl stop rsyslog
daemon-control-dist stop  

export IP=123.45.67.89
export IP2=123.45.67.90
sed -i "s/${IP}/${IP2}/g"  /var/log/secure
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