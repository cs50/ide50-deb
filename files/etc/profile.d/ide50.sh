# if not root
if [ "$(id -u)" != "0" ]; then

  # set umask
  umask 0077

  # enable commands installed in /opt/cs50/bin
  case ":$PATH:" in
      *:/opt/cs50/bin:*)
          : ;;
      *)
          export PATH=/opt/cs50/bin:$PATH ;;
  esac

  # enable commands installed in $HOME/.local/bin
  case ":$PATH:" in
      *:$HOME/.local/bin:*)
          : ;;
      *)
          export PATH=$PATH:$HOME/.local/bin ;;
  esac

  # configure clang
  export CC=clang
  export CFLAGS="-fsanitize=integer -fsanitize=undefined -ggdb3 -O0 -std=c11 -Wall -Werror -Wextra -Wno-sign-compare -Wshadow"
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

# disable auto-logout
export TMOUT=0

# python3
alias pip=pip3
alias pylint=pylint3
alias python=python3
export PYTHONDONTWRITEBYTECODE=1
export PYTHONPATH="/home/ubuntu/.local/lib/python3.4/site-packages:/usr/lib/python3/dist-packages:/usr/local/lib/python3.4/dist-packages"

# sqlite3
alias sqlite3="sqlite3 -column -header"

# sudo
# trailing space enables elevated command to be an alias
alias sudo="sudo "

# flask
export FLASK_APP=application.py
export FLASK_DEBUG=1
flask()
{
    if [ "$1" = "run" ]; then
        shift
        command flask run --host=0.0.0.0 --port=8080 --with-threads "$@"
    else
        command flask "$@"
    fi
}

# http-server
http-server()
{
	# IP address
	addr=$(/sbin/ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}')

	# default options
	a="-a $addr"
	c="-c-1"
	cors="--cors"
	i="-i false"
	p="-p 8080"

	# override default options
	while test ${#} -gt 0
	do
		if [[ "$1" =~ ^-c-?[0-9]+$ ]]; then
			c="$1"
			shift
		elif [[ "$1" =~ ^--cors(=.*)?$ ]]; then
			cors="$1"
			shift
		elif [[ "$1" =~ ^-i\ .+$ ]]; then
			i="$1 $2"
			shift
			shift
		elif [[ "$1" =~ ^-p$ ]]; then
			p="$1 $2"
			shift
			shift
		else
			shift
		fi
	done

	# spawn http-server, retaining colorized output
	script --flush --quiet --return /dev/null --command "http-server $a $c $cors $i $p" |
		while IFS= read -r line
		do
			# rewrite address as $C9_HOSTNAME
			if [[ "$line" =~ "Available on:" ]]; then
				rewrite=true
			fi
			if [[ "$rewrite" = true && "$line" =~ ^(.+)http://$addr:(.+)$ ]]; then
				echo "${BASH_REMATCH[1]}http://$C9_HOSTNAME:${BASH_REMATCH[2]}"
			else
				echo "$line"
			fi
			if [[ "$rewrite" = true && "$line" =~ "Hit CTRL-C to stop the server" ]]; then
				rewrite=
			fi
		done
}

# valgrind defaults
export VALGRIND_OPTS="--memcheck:leak-check=full --memcheck:track-origins=yes"

# set editor
export EDITOR=nano

# set locale
export LANG=C

# Node.js
export NODE_ENV=dev

# web application environment
export APPLICATION_ENV=dev

# short-circuit RVM's cd script
# https://news.ycombinator.com/item?id=1637354
export rvm_project_rvmrc=0
