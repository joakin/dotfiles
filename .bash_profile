
platform='unknown'
is_win=false
if [[ "$OSTYPE" == 'msys' ]]; then
    is_win=true
fi

if [[ $is_win ]]; then
    alias vim='gvim'
    alias vi='gvim'
fi

# Aliases
#

alias ls='ls --color'
alias ll='ls -l'
alias la='ls -a'
alias l='ls -la'

alias rm='rm -i'

