
platform='unknown'
is_win=false
if [[ "$OSTYPE" == 'msys' ]]; then
    is_win=true
fi

if [[ $is_win ]]; then

    alias vim='gvim'
    alias vi='gvim'

else

  alias vim='mvim'

  #homebrew stuff
  export PATH=/usr/local/bin:/usr/local/sbin:$PATH

  #npm bins
  NODE_PATH=/usr/local/lib/node_modules
  export PATH=/usr/local/share/npm/bin:$PATH

  #lein stuff
  export PATH=$PATH:$HOME/.lein/bin

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

# Vars
#

export TERM=xterm-color

# Enables color in the terminal bash shell export
CLICOLOR=1

