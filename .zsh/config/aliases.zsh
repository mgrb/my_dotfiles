alias ls="eza --icons --group-directories-first -l"
alias ll="eza --icons --group-directories-first -la"

alias cp='cp -iv'                           # Preferred 'cp' implementation
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
cd() { builtin cd "$@"; ll; }               # Always list directory contents upon 'cd'
alias edit='subl'                           # edit:         Opens any file in sublime editor
mcd () { mkdir -p "$1" && cd "$1"; }        # mcd:          Makes new Dir and jumps inside

alias git-config-ufpe="echo 'Set git configurations for gitlab.UFPE.br' && \
git config user.name 'Marlos Ribeiro' && \
git config user.email 'marlos@ufpe.br' && \
git config commit.gpgsign true && \
git config user.signingkey 4DB485592170FAA9"


alias git-config-github="echo 'Set git configurations for GitHub.com' && \
git config user.name 'Marlos Ribeiro' && \
git config user.email '550561+mgrb@users.noreply.github.com' && \
git config commit.gpgsign true && \
git config user.signingkey 98AE061D821B7748"