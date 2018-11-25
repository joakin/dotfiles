[[ -s ~/.bashrc ]] && source ~/.bashrc



# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export PATH="$HOME/.cargo/bin:$PATH"

# opam configuration
test -r /Users/jhernandez/.opam/opam-init/init.sh && . /Users/jhernandez/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
