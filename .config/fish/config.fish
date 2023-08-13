# managing paths:
# - add: `fish_add_path <path>`
# - list: `set --show fish_user_paths`
# - remove: `set --erase fish_user_paths[1]` (index starts from 1)

# environment variables:
set -x EDITOR nvim
set -x GOPATH (go env GOPATH)
set -x GOROOT (go env GOROOT)

# aliases - shortcuts:
abbr --add v $EDITOR
abbr --add p pnpm
abbr --add gc git checkout

alias ls "eza --all --icons --group-directories-first --time-style long-iso"
alias ll "ls --long"
alias tree "ls --tree --level 2"

# abbr upgrade_apt "sudo apt update && sudo apt upgrade && sudo apt autoremove && sudo apt clean"
# abbr upgrade_brew "brew autoremove && brew update && brew upgrade && brew cleanup --prune=all && brew doctor"
# abbr upgrade_port "sudo port selfupdate && sudo port upgrade outdated; sudo port uninstall inactive; sudo port uninstall rleaves"
# abbr upgrade_npm_global "npm install npm -g; npm update -g"
# TODO: flutter upgrade, fisher update, python pip, upgrade all
