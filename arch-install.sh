#!/usr/bin/env bash

# setting up pacman:
sed -i '/Color/s/^#//g' /etc/pacman.conf
sed -i '/ParallelDownloads/s/^#//g' /etc/pacman.conf

pacman -S --noconfirm \
    intel-ucode pulseaudio nvidia nvidia-utils ddcutil \
    base-devel zip unzip wget man-db man-pages texinfo \
    wl-clipboard grim slurp qt5-wayland qt6-wayland qt5ct libva pipewire wireplumber xdg-desktop-portal-hyprland mako waybar pavucontrol swaybg bemenu-wayland \
    reflector ufw openssh \
    clang python python-pip python-virtualenv go rustup lua nodejs-lts-hydrogen npm pnpm jdk17-openjdk \
    docker docker-buildx docker-compose kubectl helm buf pre-commit llvm cuda \
    fish fisher starship eza ripgrep fzf fd zoxide tealdeer git-delta just jq bats lazygit \
    kitty firefox \
    ttf-ibmplex-mono-nerd ttf-victor-mono-nerd inter-font

# (ref.) [How to get Hyprland to possibly work on Nvidia](https://wiki.hyprland.org/Nvidia/#how-to-get-hyprland-to-possibly-work-on-nvidia)
# (ref.) [NVIDIA - mkinitcpio](https://wiki.archlinux.org/title/NVIDIA#Early_loading)
sed -i 's/^MODULES=()/MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)/' /etc/mkinitcpio.conf
mkinitcpio -P
cat ~/arch-install/templates/pacman-nvidia.hook >/etc/pacman.d/hooks/nvidia.hook

# ddcuril: load i2c-dev kernel module
echo "i2c-dev" >>/etc/modules-load.d/i2c-dev.conf

# locale settings:
# time zone
ln -sf /usr/share/zoneinfo/Asia/Hong_Kong /etc/localtime
hwclock --systohc
# localization
sed -i '/en_HK.UTF-8/s/^#//g' /etc/locale.gen
locale-gen
echo "LANG=en_HK.UTF-8" >>/etc/locale.conf
echo "KEYMAP=us" >>/etc/vconsole.conf

# network settings:
# hostname
echo "nixonyung-arch" >>/etc/hostname

# accounts settings:
# root account:
chsh -s /usr/bin/fish
echo "root:root" | chpasswd # echo "<user>:<password>"
# user account:
sed -i '78 i Defaults timestamp_type=global' /etc/sudoers
sed -i '/%wheel ALL=(ALL:ALL) ALL/s/^# //g' /etc/sudoers
useradd --create-home --groups wheel,docker --shell /usr/bin/fish nixonyung
echo "nixonyung:1234" | chpasswd # echo "<user>:<password>"
cat ~/arch-install/templates/autologin.conf >/etc/systemd/system/getty@tty1.service.d/autologin.c

# setvices settings:
cp -r ~/arch-install/.config /home/nixonyung
cat ~/arch-install/templates/reflector.conf >/etc/xdg/reflector/reflector.conf
# (ref.) [Google Public DNS - Gettings Started - Linux](https://developers.google.com/speed/public-dns/docs/using#linux)
cat ~/arch-install/templates/resolv.conf >/etc/resolv.conf
systemctl enable docker.service
systemctl enable reflector.service
systemctl enable systemd-resolved.service
systemctl enable ufw.service
systemctl enable --user hyprland.service

# cleanup:
cp ~/arch-install/arch-init.fish /home/nixonyung
chown -R nixonyung /home/nixonyung
rm -r ~/arch-install
