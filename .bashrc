
# source ~/.config/bash/colors.sh

export UNAME=$(uname)

if [[ $UNAME == "Darwin" ]]; then
  # alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'

  # alias to nw
  alias nw="/Applications/node-webkit.app/Contents/MacOS/node-webkit"

  # homebrew stuff
  export PATH=/usr/local/bin:/usr/local/sbin:$PATH

  # npm bins
  NODE_PATH=/usr/local/lib/node_modules
  export PATH=/usr/local/share/npm/bin:$PATH

  # Ruby shit
  export PATH=$PATH:/usr/local/opt/ruby/bin

  #lein stuff
  export PATH=$PATH:$HOME/.lein/bin

  #rust stuff
  export PATH=$PATH:$HOME/.cargo/bin
  export LIBRARY_PATH=$LIBRARY_PATH:/usr/local/lib

  if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
  fi

  source $(brew --prefix)/etc/bash_completion.d/git-prompt.sh

  eval "$(fasd --init auto)"

  alias ls='ls -G'

  _fasd_bash_hook_cmd_complete v o

  # OSX Docker stuff
  export DOCKER_TLS_VERIFY=1
  export DOCKER_HOST=tcp://192.168.59.103:2376
  export DOCKER_CERT_PATH=/Users/jhernandez/.boot2docker/certs/boot2docker-vm

elif [[ $UNAME == "Linux" ]]; then
  source ~/.bashrc.ubuntu

  case "$TERM" in
    xterm*) TERM=xterm-256color
  esac

  alias open='xdg-open'

  #npm bins
  NODE_PATH=~/.npm/bin
  export PATH=$NODE_PATH:$PATH

  # enable programmable completion features (you don't need to enable
  # this, if it's already enabled in /etc/bash.bashrc and /etc/profile
  # sources /etc/bash.bashrc).
  if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
      . /etc/bash_completion
  fi
  source ~/bin/git-prompt
fi

source ~/.bash_prompt


#my scripts
export PATH=~/bin:$PATH

# Aliases
#

alias v='vim'
alias v.='vim .'
alias vi='vim'
alias n='nvim'
alias emacs='emacs -nw'

alias ll='ls -l'
alias la='ls -a'
alias l='ls -lha'

# alias rm='rm -i'

alias serve_this='python -m SimpleHTTPServer'
alias c='clear'

alias g='git'
__git_complete g __git_main

alias collapse="sed -e 's/  */ /g'"
alias cuts="cut -d' '"

alias rlwrap2="rlwrap -r -m \"\" -q '\\\"' -b \"(){}[],^%3@\\\";:'\""
alias cljs-node-repl="lein trampoline noderepl"

alias t='tree -L 1'

alias renamephotos='jhead -autorot -n%Y%m%d-%H%M%S-%f '

alias today='date +%Y-%m-%d'

alias node-repl='NODE_NO_READLINE=1 rlwrap -p green node'

alias fuck='figlet -t -f broadway fuck '

# Vars
#

export EDITOR=vim
export VISUAL=vim

# Enables color in the terminal bash shell export
export CLICOLOR=1

export HISTSIZE=1000000
export HISTFILESIZE=1000000000

# export MANPAGER="col -b | vim -c 'set ft=man ts=8 nomod nolist nonu' -c 'nnoremap i <nop>' -"
export MANPAGER="/bin/sh -c \"col -b | vim -c 'set ft=man ts=8 nomod nolist nonu noma' -\""

# node
export PATH=./node_modules/.bin:$PATH

# Wikimedia stuff
export GERRIT_USERNAME=Jhernandez
alias gerritr="gerrit --gtscore -1 --ignorepattern \"WIP\" --excludeuser $GERRIT_USERNAME"
alias gerritm="gerrit --byuser $GERRIT_USERNAME"
# Wikimedia Cucumber vars
export MEDIAWIKI_API_URL=http://127.0.0.1:8080/w/api.php
export MEDIAWIKI_USER=Selenium_user
export MEDIAWIKI_PASSWORD=vagrant
export MEDIAWIKI_URL=http://127.0.0.1:8080/wiki/
export BROWSER=phantomjs
# MF jsduck and others
export MW_INSTALL_PATH=/Users/jhernandez/dev/wikimedia/mediawiki-vagrant/mediawiki
# grunt qunit debugging, default to true (readable tests)
export QUNIT_DEBUG=true
export MW_SERVER='http://localhost:8080'
export MW_SCRIPT_PATH='/w'

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# JVM
export JAVA_OPTS="-Xms256m -Xmx512m"
