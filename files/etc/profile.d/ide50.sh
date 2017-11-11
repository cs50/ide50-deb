# if not root
if [ "$(id -u)" != "0" ]; then

    # set umask
    umask 0077

    # set pyenv root
    export PYENV_ROOT="/opt/pyenv"

    # enable commands installed in /opt/cs50/bin
    case ":$PATH:" in
        *:/opt/cs50/bin:*)
            : ;;
        *)
            export PATH="/opt/cs50/bin:$PATH" ;;
    esac

    # enable commands installed in /home/ubuntu/.cs50/bin
    case ":$PATH:" in
        *:/home/ubuntu/.cs50/bin:*)
            : ;;
        *)
            export PATH="/home/ubuntu/.cs50/bin:$PATH" ;;
    esac

    # enable commands installed in $HOME/.local/bin
    case ":$PATH:" in
        *:$HOME/.local/bin:*)
            : ;;
        *)
            export PATH="$PATH:$HOME/.local/bin" ;;

    esac

    # enable pyenv commands
    case ":$PATH:" in
        *:$PYENV_ROOT/bin:*)
            : ;;
        *)
            export PATH="$PYENV_ROOT/bin:$PATH"
    esac

    case ":$PATH:" in
        *:$PYENV_ROOT/shims:*)
            : ;;
        *)
            export PATH="$PYENV_ROOT/shims:$PATH"
    esac

    # configure clang
    export CC="clang"
    export CFLAGS="-fsanitize=signed-integer-overflow -fsanitize=undefined -ggdb3 -O0 -std=c11 -Wall -Werror -Wextra -Wno-sign-compare -Wshadow"
    export LDLIBS="-lcrypt -lcs50 -lm"

    # protect user
    alias cp="cp -i"
    alias mv="mv -i"
    alias rm="rm -i"

    # suppress gdb's startup output
    alias gdb="gdb -q"

    # unconditionally make all targets
    alias make="make -B"

    alias apachectl='echo "Please use apache50 instead!"'
    alias mysql-ctl='echo "Please use mysql50 instead!"'
    alias phpmyadmin-ctl='echo "Please use mysql50 instead!"'

    # shift out and in of block character palettes
    alias break50="printf '\x0e'"
    alias fix50="printf '\x0f'"
fi

# set maximum file size to 512MB
ulimit -f 524288

# workspace type
export C9_TEMPLATE=ide50

# disable auto-logout
export TMOUT="0"

# java
export CLASSPATH=".:/usr/share/java/cs50.jar"

# c9 open
alias open="c9 open"

# python3
alias pip="pip3"
alias pylint="pylint3"
alias python="python3"
export PYTHONDONTWRITEBYTECODE="1"

# sqlite3
alias sqlite3="sqlite3 -column -header"

# sudo
# trailing space enables elevated command to be an alias
alias sudo="sudo "

# apt-get
export DEBIAN_FRONTEND=noninteractive

# flask
export FLASK_APP="application.py"
export FLASK_DEBUG="0"
alias flask="/home/ubuntu/.cs50/bin/flask"

# http-server
alias http-server="/home/ubuntu/.cs50/bin/http-server"

# language
if [ -f /home/ubuntu/.cs50/language ]; then
    source /home/ubuntu/.cs50/language
fi

# valgrind defaults
export VALGRIND_OPTS="--memcheck:leak-check=full --memcheck:track-origins=yes"

# set editor
export EDITOR="nano"

# set locale
export LANG="C"

# Node.js
export NODE_ENV="dev"

# web application environment
export APPLICATION_ENV="dev"

# short-circuit RVM's cd script
# https://news.ycombinator.com/item?id=1637354
export rvm_project_rvmrc="0"
