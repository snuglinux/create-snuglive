sudo rm -R /etc/pacman.d/gnupg/
sudo rm -R /root/.gnupg/
gpg --refresh-keys
pacman-key --init && pacman-key --populate archlinux
pacman -Sy archlinux-keyring
passwd
install-snuglinux
