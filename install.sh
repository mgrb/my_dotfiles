#!/bin/bash

# Definir a pasta home do usuario
USER_HOME="$HOME"

# 1. Copiar o arquivo .zshrc para a home
cp .zshrc "$USER_HOME/.zshrc"
echo ".zshrc copiado para $USER_HOME"

# 2. Copiar o arquivo .config para a home
cp -r .config "$USER_HOME"
echo "Pasta .config copiada para $USER_HOME"

# 3. Copiar a pasta .zsh para a home
cp -r .zsh "$USER_HOME"
echo "Pasta .zsh copiada para $USER_HOME"

# 4. Criar a estrutura de plugins
mkdir -p "$USER_HOME/.zsh/plugins"

# 5. Clonar ou atualizar os repositórios
repos=(
  "https://github.com/z-shell/F-Sy-H.git ~/.zsh/plugins/f-sy-h"
  "https://github.com/unixorn/fzf-zsh-plugin.git ~/.zsh/plugins/fzf-zsh-plugin"
  "https://github.com/zsh-users/zsh-autosuggestions.git ~/.zsh/plugins/zsh-autosuggestions"
)

for repo in "${repos[@]}"; do
  url=$(echo $repo | awk '{print $1}')
  dest=$(echo $repo | awk '{print $2}')

  if [ -d "$dest" ]; then
    echo "Atualizando $dest..."
    git -C "$dest" pull
  else
    echo "Clonando $url em $dest..."
    git clone "$url" "$dest"
  fi
done

echo "Configuração finalizada."
