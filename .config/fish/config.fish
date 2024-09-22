#
# managing paths:
#
# - add: `fish_add_path <path>`
# - list: `set --show fish_user_paths`
# - remove: `set --erase fish_user_paths[1]` (index starts from 1)
#

# environment variables:
set -x EDITOR nvim
# set -x GOPATH (go env GOPATH)
# set -x GOROOT (go env GOROOT)

# aliases - shortcuts:
abbr --add v $EDITOR
abbr --add p pnpm

alias ls "eza --all --icons --group-directories-first --time-style long-iso"
alias ll "ls --long"
alias tree "ls --tree --level 2"

# abbr upgrade_brew "brew autoremove && brew update && brew upgrade && brew cleanup --prune=all && brew doctor"
# abbr upgrade_port "sudo port selfupdate && sudo port upgrade outdated && sudo port uninstall inactive && sudo port uninstall rleaves"
# abbr upgrade_apt "sudo apt update && sudo apt upgrade && sudo apt autoremove && sudo apt clean"
# abbr upgrade_pacman "sudo pacman -Syu && sudo pacman -Scc && sudo pacman -Qdtq | sudo pacman -Rns -"
# abbr upgrade_npm_global "npm install npm -g; npm update -g"
# abbr upgrade_fisher "fisher update"

starship init fish | source
fzf --fish | source
zoxide init fish | source
