#### ---- fast-syntax-highlighting ------------------------
[ -f $ZSH/plugins/f-sy-h/F-Sy-H.plugin.zsh ] && source $ZSH/plugins/f-sy-h/F-Sy-H.plugin.zsh

#### ---- zsh-autosuggestions ------------------------
[ -f $ZSH/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source $ZSH/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# This speeds up pasting w/ autosuggest
# https://github.com/zsh-users/zsh-autosuggestions/issues/238
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

#autosuggestion highlighting
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=60'

### ---- Load fzf completions and keybindings -----------------------------------
[ -f $ZSH/plugins/fzf-zsh-plugin/fzf-zsh-plugin.plugin.zsh ] && source $ZSH/plugins/fzf-zsh-plugin/fzf-zsh-plugin.plugin.zsh
