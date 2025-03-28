### ---- ZSH HOME ---------------------------------------------------------
export ZSH=$HOME/.zsh

### ---- Zoxide ---------------------------------------------------------
eval "$(zoxide init zsh)"

### ---- autocompletions --------------------------------------------------
autoload -Uz compinit && compinit

### ---- Completion options and styling -----------------------------------
zstyle ':completion:*' menu select # selectable menu
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]-_}={[:upper:][:lower:]_-}' 'r:|=*' 'l:|=* r:|=*'  # case insensitive completion
zstyle ':completion:*' special-dirs true # Complete . and .. special directories
zstyle ':completion:*' list-colors '' # colorize completion lists
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01' # colorize kill list
export WORDCHARS=${WORDCHARS//[\/]} # remove / from wordchars so that / is a seperator when deleting complete words

### ---- Source other configs ---------------------------------------------
[[ -f $ZSH/config/history.zsh ]] && source $ZSH/config/history.zsh
[[ -f $ZSH/config/aliases.zsh ]] && source $ZSH/config/aliases.zsh
[[ -f $ZSH/config/auto_activate_venv.zsh ]] && source $ZSH/config/auto_activate_venv.zsh

### ---- Source plugins ---------------------------------------------------
[[ -f $ZSH/plugins/plugins.zsh ]] && source $ZSH/plugins/plugins.zsh

### ---- gpg agent config with pinentry-mac -------------------------------
export GPG_TTY=$(tty)

### ---- Load Starship ----------------------------------------------------
eval "$(starship init zsh)"

### ---- Load UV ----------------------------------------------------------
. "$HOME/.local/bin/env"

### ---- FNM - Node Version Manager----------------------------------------
FNM_PATH="$HOME/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$HOME/.local/share/fnm:$PATH"
  # eval "`fnm env`"
  eval "`fnm env --use-on-cd --shell zsh`"
fi
