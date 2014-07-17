
export UNAME=$(uname)

if [[ $UNAME == "Darwin" ]]; then
  echo "Loading osx conf"

  # alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'

  # alias to nw
  alias nw="/Applications/node-webkit.app/Contents/MacOS/node-webkit"

  #homebrew stuff
  export PATH=/usr/local/bin:/usr/local/sbin:$PATH

  #npm bins
  NODE_PATH=/usr/local/lib/node_modules
  export PATH=/usr/local/share/npm/bin:$PATH

  # Ruby shit
  export PATH=$PATH:/usr/local/opt/ruby/bin

  #lein stuff
  export PATH=$PATH:$HOME/.lein/bin

  if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
  fi

  eval "$(fasd --init auto)"

  alias v='a -e vim'
  alias o='a -e open'
  alias ls='ls -G'

  _fasd_bash_hook_cmd_complete v o

elif [[ $UNAME == "Linux" ]]; then
  echo "Loading linux conf"

  source ~/.bashrc.ubuntu

  case "$TERM" in
    xterm*) TERM=xterm-256color
  esac

  alias open='xdg-open'

  # enable programmable completion features (you don't need to enable
  # this, if it's already enabled in /etc/bash.bashrc and /etc/profile
  # sources /etc/bash.bashrc).
  if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
      . /etc/bash_completion
  fi
fi

source ~/.bash_prompt


#my scripts
export PATH=~/bin:$PATH

# Aliases
#

alias v.='vim .'
alias vi='vim'
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

