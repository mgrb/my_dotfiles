alias ls="eza --icons --group-directories-first -l"
alias ll="eza --icons --group-directories-first -la"

alias cp='cp -iv'                           # Preferred 'cp' implementation
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
cd() { builtin cd "$@"; ll; }               # Always list directory contents upon 'cd'
alias edit='subl'                           # edit:         Opens any file in sublime editor
mcd () { mkdir -p "$1" && cd "$1"; }        # mcd:          Makes new Dir and jumps inside
