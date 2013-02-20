
if [[ "$OSTYPE" == 'msys' ]]; then

  echo "Loading windows msys conf"

  alias vim='gvim'
  alias vi='gvim'
  
  # Env vars
  http_proxy=127.0.0.1:8888
  https_proxy=$http_proxy
  HTTP_PROXY=$http_proxy
  HTTPS_PROXY=$http_proxy

  BIN2=/d/devel/bin
  JAVA_HOME=$BIN2/jdk1.6.0_07

  GIT_COMPLETION=/etc/git-completion.bash

  # PATH MADNESS
  BINS=
  BINS=$BINS:$HOME/bin
  BINS=$BINS:/usr/local/bin
  BINS=$BINS:/mingw/bin
  BINS=$BINS:/bin
  BINS=$BINS:/cmd
  BINS=$BINS:$HOME/bin

  PROGRAMS=

  PROGRAMS=$PROGRAMS:/c/Program Files/TortoiseSVN/bin
  PROGRAMS=$PROGRAMS:$BIN2/apache-maven/bin
  PROGRAMS=$PROGRAMS:$BIN2/apache-ant-1.8.2/bin
  PROGRAMS=$PROGRAMS:$JAVA_HOME
  PROGRAMS=$PROGRAMS:$BIN2/mysql-5.5.15-win32/bin
  PROGRAMS=$PROGRAMS:$BIN2/svn-win32-1.6.6/bin

  PROGRAMS=$PROGRAMS:$BIN2/Vim/vim73/
  PROGRAMS=$PROGRAMS:$BIN2/ctags58
  PROGRAMS=$PROGRAMS:$BIN2/Pandoc/bin
  PROGRAMS=$PROGRAMS:$BIN2/Markdown
  PROGRAMS=$PROGRAMS:$BIN2/dotLess
  PROGRAMS=$PROGRAMS:$BIN2/ack

  PROGRAMS=$PROGRAMS:$BIN2/Ruby193/bin
  PROGRAMS=$PROGRAMS:$BIN2/Python
  PROGRAMS=$PROGRAMS:$BIN2/clojure-1.3.0
  PROGRAMS=$PROGRAMS:$BIN2/lein/
  PROGRAMS=$PROGRAMS:$BIN2/coffeescript
  PROGRAMS=$PROGRAMS:$BIN2/node
  PROGRAMS=$PROGRAMS:$HOME/AppData/Roaming/npm

  PROGRAMS=$PROGRAMS:$BIN2/phantomjs
  PROGRAMS=$PROGRAMS:$BIN2/casperjs/bin
  PROGRAMS=$PROGRAMS:$BIN2/love-0.8.0-win-x64
  PROGRAMS=$PROGRAMS:$BIN2/node-webkit-latest-win-ia32

  PROGRAMS=$PROGRAMS:$BIN2/mongodb/bin

  PROGRAMS=$PROGRAMS:/d/devel/projects/git-based/js-beautify/python
  PROGRAMS=$PROGRAMS:/d/devel/projects/git-based/jessay/jessay

  PATH=$PATH:$BINS:$BIN2:$PROGRAMS:.

  # Prompt customizations

  source $GIT_COMPLETION
  # enable git unstaged indicators - set to a non-empty value
  GIT_PS1_SHOWDIRTYSTATE="."
  # enable showing of untracked files - set to a non-empty value
  GIT_PS1_SHOWUNTRACKEDFILES="."
  # enable stash checking - set to a non-empty value
  GIT_PS1_SHOWSTASHSTATE="."
  # enable showing of HEAD vs its upstream
  GIT_PS1_SHOWUPSTREAM="auto"


else
  
  echo "Loading osx conf"
  # OSX

  alias vim='mvim'

  # alias to nw
  alias nw="/Applications/node-webkit.app/Contents/MacOS/node-webkit"

  #homebrew stuff
  export PATH=/usr/local/bin:/usr/local/sbin:$PATH

  #npm bins
  NODE_PATH=/usr/local/lib/node_modules
  export PATH=/usr/local/share/npm/bin:$PATH

  #lein stuff
  export PATH=$PATH:$HOME/.lein/bin

  #my scripts
  export PATH=~/bin:$PATH

  if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
  fi

fi

# Aliases
#

alias ls='ls -G'
alias ll='ls -l'
alias la='ls -a'
alias l='ls -lha'

alias rm='rm -i'

alias serve_this='python -m SimpleHTTPServer'
alias c='clear'

alias g='git'

alias v='vim'
alias v='vim .'

alias collapse="sed -e 's/  */ /g'"
alias cuts="cut -d' '"

# Vars
#

TERM=xterm-color

# Enables color in the terminal bash shell export
CLICOLOR=1

