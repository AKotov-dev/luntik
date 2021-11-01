# Luntik -simple OpenVPN connector
Luntik is a simplified version of the OpenVPN-GUI. Loads any password-free `*.ovpn` configuration, adapts it to VPN-Up/Down events to work correctly with VPN/DNS, and turns off `persist-tun`, since most free configurations are designed for Windows. There is an autostart on reboot.

The connection is raised immediately after downloading the `*.ovpn` file. The connection can be stopped or restarted at any time. VPN indication: yellow - waiting/open, green - active. Tested and works with `network.service/net_applet` and `NetworkManager/nm-applet` in Mageia-8/9.

Note: Don't forget to open the iptables ports required for configurations.

![](https://github.com/jon/coolproject/raw/master/image/image.png)
