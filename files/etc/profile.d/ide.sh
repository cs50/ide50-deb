# if not root
if [ "$(id -u)" != "0" ]; then

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

    # legacy
    alias apachectl='echo "Please use apache50 instead!"'
    alias mysql-ctl='echo "Please use mysql50 instead!"'
    alias phpmyadmin-ctl='echo "Please use mysql50 instead!"'

fi

# set maximum file size to 512MB
ulimit -f 524288

# disable auto-logout
export TMOUT="0"

# language
if [ -f /home/ubuntu/.cs50/language ]; then
    source /home/ubuntu/.cs50/language
fi
