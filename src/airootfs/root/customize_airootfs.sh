#!/bin/bash

set -e -u

sed -i /etc/locale.gen -e 's|#\(en_US.UTF-8 UTF-8\)|\1|'
sed -i /etc/locale.gen -e 's|#\(uk_UA.UTF-8 UTF-8\)|\1|'
sed -i /etc/locale.gen -e 's|#\(ru_RU.UTF-8 UTF-8\)|\1|'

locale-gen

ln -sf /usr/share/zoneinfo/UTC /etc/localtime

#usermod -s /usr/bin/zsh root
usermod -s /bin/bash root
#cp -aT /etc/skel/ /root/
cp -aT -n /etc/skel/ /root/
chmod 700 /root

sed -i 's/#\(PermitRootLogin \).\+/\1yes/' /etc/ssh/sshd_config
sed -i "s/#Server/Server/g" /etc/pacman.d/mirrorlist
sed -i 's/#\(Storage=\)auto/\1volatile/' /etc/systemd/journald.conf

sed -i 's/#\(HandleSuspendKey=\)suspend/\1ignore/' /etc/systemd/logind.conf
sed -i 's/#\(HandleHibernateKey=\)hibernate/\1ignore/' /etc/systemd/logind.conf
sed -i 's/#\(HandleLidSwitch=\)suspend/\1ignore/' /etc/systemd/logind.conf

systemctl enable pacman-init.service choose-mirror.service
systemctl set-default multi-user.target
