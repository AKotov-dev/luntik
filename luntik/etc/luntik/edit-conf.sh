#!/bin/bash

# Загрузка и редактирование конфигурации
#if [[ -z $(find /etc/luntik/luntik.conf -mtime -3) ]]; then
#curl -m 10 -o /etc/luntik/luntik.conf https://tools.vanwa.tech/download-free-openvpn-config >> /var/log/luntik.log 2>&1 &&

systemctl stop luntik &&

echo -e "\n"\
"#DNS from VPN\n"\
"script-security 2\n"\
"up /etc/luntik/update-resolv-conf\n"\
"down /etc/luntik/update-resolv-conf" >> /etc/luntik/luntik.conf
sed -i 's/^persist-tun*/#persist-tun/' /etc/luntik/luntik.conf
#fi;

systemctl start luntik

exit 0
