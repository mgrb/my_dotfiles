alias ls="eza --icons --group-directories-first -l"
alias ll="eza --icons --group-directories-first -la"

alias cp='cp -iv'                           # Preferred 'cp' implementation
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
cd() { builtin cd "$@"; ll; }               # Always list directory contents upon 'cd'
alias edit='subl'                           # edit: Opens any file in sublime editor
mcd () { mkdir -p "$1" && cd "$1"; }        # mcd: Makes new Dir and jumps inside
alias tree='eza --tree -l --icons --level=${1:-2}' # comando tree utilizando o eza com ícones


alias git-config-ufpe="echo 'Set git configurations for gitlab.UFPE.br' && \
git config user.name 'Marlos Ribeiro' && \
git config user.email 'marlos@ufpe.br' && \
git config commit.gpgsign true && \
git config user.signingkey <get-key>"


alias git-config-github="echo 'Set git configurations for GitHub.com' && \
git config user.name 'Marlos Ribeiro' && \
git config user.email '550561+mgrb@users.noreply.github.com' && \
git config commit.gpgsign true && \
git config user.signingkey <get-key>"


alias git-config-global="echo 'Set git configurations for GLOBAL' && \
git config --global user.name 'Marlos Ribeiro' && \
git config --global commit.gpgsign true && \
git config --global init.defaultBranch main && \
git config --global color.ui auto && \
git config --global core.editor 'subl' && \
git config --global pull.ff only"
