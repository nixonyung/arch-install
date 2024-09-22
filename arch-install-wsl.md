# Installing Arch WSL

```powershell
wsl --install --no-distribution
wsl --set-default-version 2
# reboot
```

- download [Arch.zip](https://github.com/yuk7/ArchWSL/releases/latest)
  - unzip to user Documents and run `Arch.exe`
- run `wsl`

```sh
# (ref.) [Initialize keyring](https://wsldl-pg.github.io/ArchW-docs/How-to-Setup/#initialize-keyring)
pacman-key --init
pacman-key --populate
pacman -Sy archlinux-keyring

pacman -S ca-certificates openssl openssh reflector git neovim
```

- replace `/etc/xdg/reflector/reflector.conf`

  ```conf
  --save /etc/pacman.d/mirrorlist
  --country "Hong Kong,China,Taiwan,Singapore,Australia,United States"
  --protocol https
  --latest 10
  --sort rate
  ```

```sh
systemctl enable reflector.service
systemctl restart reflector.service # wait for around 3mins
pacman -Syu \
  base-devel zip unzip wget man-db man-pages texinfo fish fisher starship eza ripgrep fzf fd zoxide tealdeer git-delta just jq bats \
  go rustup lua docker docker-buildx docker-compose kubectl helm buf pre-commit llvm cuda
tldr --update
systemctl enable docker.service
systemctl disable systemd-networkd

chsh -s /usr/bin/fish
passwd # change root password

sed -i '78 i Defaults timestamp_type=global' /etc/sudoers
sed -i '/%wheel ALL=(ALL:ALL) ALL/s/^# //g' /etc/sudoers
useradd --create-home --groups wheel,docker --shell /usr/bin/fish nixonyung
passwd nixonyung # change user password
```

- exit WSL

```powershell
# (ref.) [Setting Default User](https://github.com/yuk7/ArchWSL/issues/25)
.\Arch.exe config --default-user nixonyung
```

- run `wsl`

```fish
set -U fish_greeting
fish_add_path ~/.local/bin

fisher install \
    jorgebucaran/autopair.fish \
    jorgebucaran/nvm.fish \
    meaningful-ooo/sponge
set sponge_purge_only_on_exit true

# setting yay:
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si
cd ..
rm -rf yay-bin
yay -Y --gendb
```

- copy fish, git, nvim, starship configs
