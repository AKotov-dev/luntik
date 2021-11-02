#!/bin/bash

# Редактирование конфигурации и перезапуск
systemctl stop luntik

echo -e "\n"\
"#DNS from VPN\n"\
"script-security 2\n"\
"up /etc/luntik/update-resolv-conf\n"\
"down /etc/luntik/update-resolv-conf" >> /etc/luntik/luntik.conf
sed -i 's/^persist-tun*/#persist-tun/' /etc/luntik/luntik.conf
sed -i 's/^auth-user-pass*/#auth-user-pass/' /etc/luntik/luntik.conf

systemctl start luntik

exit 0;
