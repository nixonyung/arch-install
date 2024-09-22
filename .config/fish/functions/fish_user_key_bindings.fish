function fish_user_key_bindings
    fish_vi_key_bindings
    # (ref.) [Bind Ctrl-C in fish vi-mode to switch from insert mode to normal mode](https://stackoverflow.com/questions/45961905/bind-ctrl-c-in-fish-vi-mode-to-switch-from-insert-mode-to-normal-mode)
    bind -M default \cc 'commandline -f repaint'
    bind -M insert \cc 'set fish_bind_mode default; commandline -f repaint'
end
