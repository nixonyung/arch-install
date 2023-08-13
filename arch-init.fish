#!/usr/bin/env fish

set -U fish_greeting
fish_add_path ~/.local/bin

# install fish plugins:
fisher install \
    jorgebucaran/autopair.fish \
    meaningful-ooo/sponge \
    kidonng/zoxide.fish
set sponge_purge_only_on_exit true

# setting yay:
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si
cd ..
rm -rf yay-bin
yay -Y --gendb

# install AUR packages
set -x MAKEFLAGS -j$(nproc)
yay -S \
    hyprland-git libva-nvidia-driver \
    rancher-k3d-bin tilt-bin \
    visual-studio-code-bin \
    noto-fonts-hk-vf ttf-recursive

rm ~/arch-init.fish
