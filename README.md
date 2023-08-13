# Arch Install

DISCLAIMER: INTENDED FOR MY USE ONLY. DON'T BLINDLY COPY.

---

- (ref.) [Installation guide](https://wiki.archlinux.org/title/installation_guide)
- [USB flash installation medium - Using Rufus](https://wiki.archlinux.org/title/USB_flash_installation_medium#Using_Rufus)
  - [Arch Linux Downloads](https://archlinux.org/download/)
- if dual-booting with Windows:
  - [How to Disable Fast Startup in Windows 10 and Windows Server 2016](https://www.ninjaone.com/blog/how-to-disable-fast-startup-in-windows/)
  - [UTC in Microsoft Windows](https://wiki.archlinux.org/title/System_time#UTC_in_Microsoft_Windows)
- (alt.) [ArchWSL](https://github.com/yuk7/ArchWSL)
  - [Initialize keyring](https://wsldl-pg.github.io/ArchW-docs/How-to-Setup/#initialize-keyring)
  - [Setting Default User](https://github.com/yuk7/ArchWSL/issues/25)

```sh
# check boot mode:
cat /sys/firmware/efi/fw_platform_size
# want: 64

# view available disk devices:
lsblk

# partition the disks:
#
# if using Windows:
# - use Disk Management to create partitions (without labels and formatting)
# - run `gdisk /dev/sda` # CHANGE
#   - `t`: change partition type hex code
#   - `c`: change partition name (e.g. Linux Boot, Linux Root, Linux Swap)
#
gdisk /dev/sda # CHANGE
#
# - `n`: create GPT (the partition table)
#
#     # partition 1: EFI system partition (a.k.a. ESP)
#     Command: n
#     Partition number (default 1):
#     First sector:
#     Last sector: +300M
#     Hex code: ef00
#
#     # partition 2: XBOOTLDR partition (when dual-booting with Windows)
#     # (ref.) [systemd-boot - Installation using XBOOTLDR](https://wiki.archlinux.org/title/Systemd-boot)
#     Command: n
#     Partition number (default 2):
#     First sector:
#     Last sector: +300M
#     Hex code: ea00
#
#     # partition 3: Linux swap partition
#     # (ref.) [In defence of swap: common misconceptions](https://chrisdown.name/2018/01/02/in-defence-of-swap.html)
#     # (ref.) [Why are swap partitions discouraged on SSD drives, are they harmful?](https://askubuntu.com/questions/652337/why-are-swap-partitions-discouraged-on-ssd-drives-are-they-harmful)
#     # (ref.) [How much should be the swap size?](https://itsfoss.com/swap-size/#how-much-should-be-the-swap-size)
#     Command: n
#     Partition number (default 3):
#     First sector:
#     Last sector: +4G
#     Hex code: 8200
#
#     # partition 4: Linux root partition
#     Command: n
#     Partition number (default 4):
#     First sector:
#     Last sector:
#     Hex code (default 8300):
#
# - (`l` + Enter: list partition hex codes for reference)
# - `p`: print GPT, check Size, Name
# - (`d`: delete a partition, in case of typo)
# - (`o`: reset GPT, in case of typo)
# - `w`: write / confirm
#

# confirm changes:
lsblk # check NAME, SIZE

# format the partitions:
mkfs.fat -F32 /dev/sda1 # CHANGE, must be FAT32 for ESP
mkfs.fat -F32 /dev/sda2 # CHANGE, (ref.) [Installation update XBOOTLDR](https://wiki.archlinux.org/title/Talk:Systemd-boot#Installation_update_XBOOTLDR)
mkswap /dev/sda3 # CHANGE
mkfs.ext4 /dev/sda4 # CHANGE

# confirm changes:
lsblk -f # check FSTYPE, FSVER

# install Arch Linux:
# (ref.) [[SOLVED] Security hole when using command "bootctl install"](https://bbs.archlinux.org/viewtopic.php?id=287790)
mount /dev/sda4 /mnt # CHANGE
mount -o fmask=0077,dmask=0077 --mkdir /dev/sda2 /mnt/boot # CHANGE
pacstrap -K /mnt base linux linux-firmware git neovim

# generate fstab:
mount -o fmask=0077,dmask=0077 --mkdir /dev/sda1 /mnt/efi # CHANGE
swapon /dev/sda3 # CHANGE
genfstab -U /mnt >> /mnt/etc/fstab

# start a shell:
arch-chroot /mnt

# run my install script:
cd ~
git clone --depth 1 https://github.com/nixonyung/arch-install.git
~/arch-install/arch-install.sh

# setting up boot loader:
bootctl --esp-path=/efi --boot-path=/boot install
nvim /efi/loader/loader.conf
#
# default arch.conf
# timeout 0
# console-mode max
# editor no
#
nvim /boot/loader/entries/arch.conf
#
# title Arch Linux
# linux /vmlinuz-linux
# initrd /intel-ucode.img
# initrd /initramfs-linux.img
# options root=/dev/sda4 nvidia_drm.modeset=1 rw    # CHANGE
#

# setup network:
ip link # check interface name
nvim /etc/systemd/network/enp0s3.network # CHANGE
#
# [Match]
# Name=enp0s3    # CHANGE
#
# [Network]
# DHCP=yes
#
systemctl enable systemd-networkd.service


exit
umount -R /mnt
reboot

#
# after login...
#

sudo timedatectl set-ntp true
sudo ufw default deny
sudo ufw allow from 192.168.0.0/24
sudo ufw allow Deluge
sudo ufw limit ssh
sudo ufw enable
~/arch-init.fish
sudo systemctl --user enable hyprland.service

# change password
passwd

# overriding git user info:
git config --global user.name "Your Name"
git config --global user.email "youremail@yourdomain.com"

# install miniforge: https://github.com/conda-forge/miniforge/releases
# then run `~/mambaforge/bin/conda init fish`



#
# helpers:
#
# # generate pywal colorscheme
# # (ref.) [pywal - Customization](https://github.com/dylanaraps/pywal/wiki/Customization#discord)
# # - e.g. firefox extension, VS Code theme
# wal -i <image_path> -b 1e1e2e --saturate 0.3
#
# # search name of installed font:
# fc-list | rg --smart-case recursive
#
# # update initramfs when the linux kernel or the nvidia driver is updated:
# sudo mount /dev/sda2 /boot    # CHANGE
# sudo mkinitcpio -P
```
