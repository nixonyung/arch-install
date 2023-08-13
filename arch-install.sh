#!/usr/bin/env bash
set -o errexit  # exit on any failed command
set -o nounset  # fail command that access undefined variable
set -o pipefail # exit pipe on any failed command

# setting up pacman:
sed -i '/Color/s/^#//g' /etc/pacman.conf
sed -i '/ParallelDownloads/s/^#//g' /etc/pacman.conf

pacman -S --noconfirm \
    intel-ucode pulseaudio nvidia nvidia-utils ddcutil \
    qt5-wayland qt6-wayland qt5ct libva pipewire wireplumber xdg-desktop-portal-hyprland \
    base-devel rust zip unzip wget reflector ufw man-db man-pages texinfo wl-clipboard grim slurp \
    go lua clang python python-pip python-virtualenv nodejs-lts-hydrogen npm pnpm jdk17-openjdk docker docker-compose buf \
    fish fisher starship eza ripgrep fzf fd zoxide tealdeer pre-commit python-pywal \
    kitty mako waybar pavucontrol swaybg bemenu-wayland firefox bitwarden \
    ttf-ibmplex-mono-nerd ttf-victor-mono-nerd inter-font

systemctl enable docker.service

# update initramfs to use nvidia
sed -i 's/^MODULES=()/MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)/' /etc/mkinitcpio.conf
mkinitcpio -P

# load i2c-dev kernel module to use ddcutil
echo "i2c-dev" >>/etc/modules-load.d/i2c-dev.conf

# setting time zone:
ln -sf /usr/share/zoneinfo/Asia/Hong_Kong /etc/localtime
hwclock --systohc

# setting localization:
sed -i '/en_HK.UTF-8/s/^#//g' /etc/locale.gen
locale-gen
echo "LANG=en_HK.UTF-8" >>/etc/locale.conf
echo "KEYMAP=us" >>/etc/vconsole.conf

# setting hosts:
echo "nixonyung-arch" >>/etc/hostname
systemctl enable systemd-resolved.service

# setting Google DNS
# (ref.) [Google Public DNS - Gettings Started - Linux](https://developers.google.com/speed/public-dns/docs/using#linux)
printf -- "
nameserver 8.8.8.8
nameserver 8.8.4.4
nameserver 2001:4860:4860::8888
nameserver 2001:4860:4860::8844
" >>/etc/resolv.conf

# setting firewall
systemctl enable ufw.service

# setting reflector (auto update pacman mirrors):
printf -- "--save /etc/pacman.d/mirrorlist
--country \"Hong Kong\",China,Taiwan,Australia,\"United States\"
--protocol https
--latest 10
--sort rate
" >/etc/xdg/reflector/reflector.conf
systemctl enable reflector.service

# setting root account:
chsh -s /usr/bin/fish
echo "root:root" | chpasswd # echo "<user>:<password>"

# setting user account:
sed -i '78 i Defaults timestamp_type=global' /etc/sudoers
sed -i '/%wheel ALL=(ALL:ALL) ALL/s/^# //g' /etc/sudoers
useradd --create-home --groups wheel,docker --shell /usr/bin/fish nixonyung
echo "nixonyung:1234" | chpasswd # echo "<user>:<password>"
# auto login
mkdir -p /etc/systemd/system/getty@tty1.service.d
printf -- "[Service]
ExecStart=
ExecStart=-/sbin/agetty -o '-p -f -- \\\\\\\\u' --noclear --autologin nixonyung %%I \$TERM
" >/etc/systemd/system/getty@tty1.service.d/autologin.conf

cp -r arch-install/.config /home/nixonyung
cp ~/arch-install/arch-init.fish /home/nixonyung
chown -R nixonyung /home/nixonyung
rm -r ~/arch-install
