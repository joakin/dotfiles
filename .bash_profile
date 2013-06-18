
echo "Loading osx conf"
# OSX

alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'
# alias tmux="TERM=screen-256color tmux"

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

alias collapse="sed -e 's/  */ /g'"
alias cuts="cut -d' '"

# Vars
#

export EDITOR=vim
export VISUAL=vim

# Enables color in the terminal bash shell export
export CLICOLOR=1

export HISTSIZE=1000000
export HISTFILESIZE=1000000000

eval "$(fasd --init auto)"

alias v='a -e vim'
alias o='a -e open'

_fasd_bash_hook_cmd_complete v o
