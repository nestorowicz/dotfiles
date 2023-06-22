## ZSH HOME
export ZSH=$HOME/.zsh

### ---- history config -------------------------------------
export HISTFILE=$ZSH/.zsh_history

# How many commands zsh will load to memory.
export HISTSIZE=10000

# How many commands history will save on file.
export SAVEHIST=10000

# History won't save duplicates.
setopt HIST_IGNORE_ALL_DUPS

# History won't show duplicates on search.
setopt HIST_FIND_NO_DUPS

### ---- ALIASES --------------------------------------------

alias vi="nvim"

### ---- PLUGINS & THEMES -----------------------------------

### --- Others

source $ZSH/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# PROMPT Customization
autoload colors && colors
parse_branch() {
	branch=$(git rev-parse --abbrev-ref HEAD) 2>/dev/null
	[ -z $branch ] || echo " ($branch)"
}
setopt PROMPT_SUBST
P="%F{240}%2~%f" # Show path relative to home, 2 last dirs only
P="${P}%F{240}$(parse_branch)%f" # Show git branch if defined
P="${P} %F{220}%(!.#.>)%f " # Show %/#, color gold (220)
PROMPT="$P"
RPROMPT="%(?.. [%F{red}%?%f])" # Show last command status if non-zero, color red

# Haskell
[ -f "/home/mnestor/.ghcup/env" ] && source "/home/mnestor/.ghcup/env" # ghcup-env

