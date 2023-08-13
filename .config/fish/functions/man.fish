function man -d "colored man"
    # (ref.) [How to get color man pages under fish shell?](https://askubuntu.com/questions/522599/how-to-get-color-man-pages-under-fish-shell)

    # section header and command name
    set -x LESS_TERMCAP_md (set_color blue)

    # code parameters
    set -x LESS_TERMCAP_us (set_color --italics --underline red)

    # footer and search match
    set -x LESS_TERMCAP_so (set_color --italics --background yellow black)

    # text (inconsistent, leave as normal)
    set -x LESS_TERMCAP_me (set_color normal)
    set -x LESS_TERMCAP_ue (set_color normal)
    set -x LESS_TERMCAP_se (set_color normal)

    command man $argv
end
