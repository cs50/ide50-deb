# set maximum file size to 512MB
ulimit -f 524288

# disable auto-logout
export TMOUT=0

# suppress this error for now: /home/jharvard/.dropbox-dist/libz.so.1: version `ZLIB_1.2.3.3' not found (required by /usr/lib/libxml2.so.2) F$
# http://forums.dropbox.com/topic.php?id=48321 http://forums.dropbox.com/topic.php?id=19439
alias dropbox="dropbox 2> /dev/null"

# if not root
if [ "$(id -u)" != "0" ]; then

  # set umask
  umask 0077

  # enable commands installed in /opt/cs50/bin
  [[ ":$PATH:" == *:/opt/cs50/bin:* ]] ||
    export PATH=/opt/cs50/bin:$PATH

  # configure clang
  export CC=clang
  export CFLAGS="-ggdb3 -O0 -std=c11 -Wall -Werror -Wshadow"
  export LDLIBS="-lcs50 -lm"

  # protect user
  alias cp="cp -i"
  alias mv="mv -i"
  alias rm="rm -i"

  alias gdb="gdb -q"

  alias apachectl='echo "Please use apache50 instead!"'
  alias mysql-ctl='echo "Please use mysql50 instead!"'
  alias phpmyadmin-ctl='echo "Please use mysql50 instead!"'

  # shift out and in of block character palettes
  alias break50="printf '\x0e'"
  alias fix50="printf '\x0f'"

fi

# python3
alias python=python3
alias pip=pip3

# set editor
export EDITOR=nano

# set locale
export LANG=C

# Node.js
export NODE_ENV=dev

# web application environment
export APPLICATION_ENV=dev
