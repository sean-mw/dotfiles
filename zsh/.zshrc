# PATH (~/.local/bin holds claude and mise)
export PATH="$HOME/.local/bin:$PATH"
export EDITOR='nvim'

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=$HISTSIZE
setopt sharehistory hist_ignore_all_dups hist_ignore_space

# Completion
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Keybindings
bindkey -v
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# Prompt
PROMPT='%F{blue}%~%f %# '

# Machine-specific, untracked
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
