lsof | grep /mnt/dev/
umount -R /mnt/
sudo rm -R /etc/pacman.d/gnupg/
sudo rm -R /root/.gnupg/
killall gpg-agent && pacman-key --init && pacman-key --populate archlinux
pacman -Sy archlinux-keyring
passwd
install-snuglinux
