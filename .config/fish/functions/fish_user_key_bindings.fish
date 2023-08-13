function fish_user_key_bindings
    # (ref.) [Default bindings](https://fishshell.com/docs/current/interactive.html#command-line-editor)
    # (ref.) [help bind](https://fishshell.com/docs/current/cmds/bind.html)

    fish_vi_key_bindings
    fzf_key_bindings --no-erase

    # <C-c>
    bind -M default \cc 'commandline -f repaint'
    bind -M insert \cc 'set fish_bind_mode default; commandline -f repaint'

    # command navigation
    bind -M default \cj history-search-forward
    bind -M insert \cj history-search-forward
    bind -M default \ck history-search-backward
    bind -M insert \ck history-search-backward
end
