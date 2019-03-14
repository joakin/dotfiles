# START TRACING
# gdate for OSX, date for linux
# PS4='+ $(gdate "+%s.%N")\011 '
# exec 3>&2 2>/tmp/bashstart.log
# set -x

# source ~/.config/bash/colors.sh

shopt -s globstar
shopt -s extglob

export UNAME=$(uname)

if [[ $UNAME == "Darwin" ]]; then
  # homebrew stuff
  export PATH=/usr/local/bin:/usr/local/sbin:$PATH

  # npm bins
  NODE_PATH=/usr/local/lib/node_modules
  export PATH=$NODE_PATH:$PATH
  source <(npm completion)

  # Ruby shit
  export PATH=$PATH:/usr/local/opt/ruby/bin

  #lein stuff
  export PATH=$PATH:$HOME/.lein/bin

  #rust stuff
  export PATH=$PATH:$HOME/.cargo/bin
  export LIBRARY_PATH=$LIBRARY_PATH:/usr/local/lib

  export BASH_COMPLETION_COMPAT_DIR="/usr/local/etc/bash_completion.d"
  [[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]] && . "$(brew --prefix)/etc/profile.d/bash_completion.sh"

  source $(brew --prefix)/etc/bash_completion.d/git-prompt.sh

  alias ls='ls -G'

elif [[ $UNAME == "Linux" ]]; then
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

# Trying neovim

WHICHVIM=$(which vim)
alias oldvim="${WHICHVIM}"
alias vim='nvim'

alias v='nvim'
alias v.='nvim .'
alias vi='nvim'
alias n='nvim'
alias emacs='emacs -nw'

alias ll='ls -l'
alias la='ls -a'
alias l='ls -lha'

# alias rm='rm -i'

alias serve_this='python -m SimpleHTTPServer'
alias c='clear'

alias g='git'

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

export EDITOR=nvim
export VISUAL=nvim

# Enables color in the terminal bash shell export
export CLICOLOR=1

export HISTSIZE=1000000
export HISTFILESIZE=1000000000

# export MANPAGER="col -b | nvim -c 'set ft=man ts=8 nomod nolist nonu' -c 'nnoremap i <nop>' -"
export MANPAGER="/bin/sh -c \"col -b | nvim -c 'set ft=man ts=8 nomod nolist nonu noma' -\""

# node
export PATH=./node_modules/.bin:$PATH
npm config set ignore-scripts true
alias nr="npm run --silent --ignore-scripts=false"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# JVM
export JAVA_OPTS="-Xms256m -Xmx512m"

# FZF
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# RUST
source $HOME/.cargo/env

# END TRACING
# set +x
# exec 2>&3 3>&-
