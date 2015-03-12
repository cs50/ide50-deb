# configure prompt
if [ "$PS1" ]; then
  export PS1="\u@\h (\w): "
fi

# if not root
if [[ $UID -ne 0 ]]; then

  # set umask
  umask 0077

  # configure clang
  export CC=clang
  export CFLAGS="-ggdb3 -O0 -std=c99 -Wall -Werror"
  export LDLIBS="-lcs50 -lm"

  # configure man
  export MANSECT="3,2,1"

  # protect user
  alias cp="cp -i"
  alias mv="mv -i"
  alias rm="rm -i"

  # convenience
  alias ll="ls -l --color=auto"
  alias gdb="gdb -q"

  # allow core dumps
  ulimit -c unlimited

fi

# set editor
export EDITOR=nano

# set locale
export LANG=C

# Node.js
export NODE_ENV=dev

# SPL for pset3
export CLASSPATH=.:/usr/lib/spl.jar
