# XDG Base Directory Specification
export XDG_CONFIG_HOME="$HOME/.config"

export PATH="$HOME/bin:$PATH"

# Editor
export EDITOR="nvim"

# Add deno completions to search path
if [[ ":$FPATH:" != *":$HOME/.zsh/completions:"* ]]; then export FPATH="$HOME/.zsh/completions:$FPATH"; fi
export PATH="/opt/homebrew/bin:$PATH"
source <(fzf --zsh)
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Key bindings
bindkey "^P" history-beginning-search-backward
bindkey "^N" history-beginning-search-forward

# Set up completion
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Enable completion
autoload -Uz compinit && compinit

# Set up prompt
eval "$(starship init zsh)"

# History
SAVEHIST=100000
HISTSIZE=100000
setopt hist_ignore_dups
setopt hist_expire_dups_first

# Vim and Neovim aliases
WHICHVIM=$(which vim)
alias oldvim="${WHICHVIM}"
alias vim='nvim'
alias v='nvim'
alias v.='nvim .'
alias vi='nvim'
alias n='nvim'

# ls aliases
alias ls='ls -G'
alias ll='ls -l'
alias la='ls -a'
alias l='ls -lha'

# Uncomment if you want the safe rm alias
# alias rm='rm -i'

# Miscellaneous aliases
alias serve_this='python -m SimpleHTTPServer'
alias c='clear'
alias g='git'
alias collapse="sed -e 's/  */ /g'"
alias cuts="cut -d' '"
alias rlwrap2="rlwrap -r -m \"\" -q '\\\"' -b \"(){}[],^%3@\\\";:'\""
alias t='tree -L 1'
alias renamephotos='jhead -autorot -n%Y%m%d-%H%M%S-%f '
alias today='date +%Y-%m-%d'
alias node-repl='NODE_NO_READLINE=1 rlwrap -p green node'
alias fuck='figlet -t -f broadway fuck '


# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
[[ ! -r "$HOME/.opam/opam-init/init.zsh" ]] || source "$HOME/.opam/opam-init/init.zsh" > /dev/null 2> /dev/null
# END opam configuration

# Created by `pipx` on 2024-09-17 14:57:16
export PATH="$PATH:$HOME/.local/bin"

# Deno
[ -f ~/.deno/env ] && source ~/.deno/env

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
# Odin
export PATH="$PATH:$HOME/dev/forks/Odin"
export PATH="$PATH:$HOME/dev/forks/ols"
