function mkfile -d "create files with missing directories"
    argparse h/help -- $argv
    or return

    if set -ql _flag_help
        echo -e "Usage: mkfile FILE...\n\
Create the FILE(s) and also create their missing directories, if they do not already exist."
    end

    for arg in $argv
        mkdir -p (dirname $arg) && touch $arg
    end
end
