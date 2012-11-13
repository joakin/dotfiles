
platform='unknown'
is_win=false
if [[ "$OSTYPE" == 'msys' ]]; then
    is_win=true
fi

if [[ $is_win ]]; then
    alias vim='gvim'
    alias vi='gvim'
fi

