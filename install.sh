#!/bin/bash

# Definir a pasta home do usuario
USER_HOME="$HOME"

# INSTALAÇÕES ESSENCIAIS -------------------------------------------------------
# - ZSH
# - EZA
# - FNM
# - UV
# - Starship

# Instalar ZSH e definir como shell padrão
if ! command -v zsh &> /dev/null; then
    echo "Instalando ZSH..."
    sudo apt update && sudo apt install -y zsh
    chsh -s $(which zsh)
    echo "ZSH instalado e definido como padrão."
else
    echo "ZSH já está instalado."
fi

# Instalar EZA
if ! command -v eza &> /dev/null; then
    echo "Instalando EZA..."
    sudo apt install -y eza
    echo "EZA instalado."
else
    echo "EZA já está instalado."
fi

# Instalar FNM
if ! command -v fnm &> /dev/null; then
    echo "Instalando FNM..."
    curl -fsSL https://fnm.vercel.app/install | bash
    echo "FNM instalado."
else
    echo "FNM já está instalado."
fi

# Instalar UV
if ! command -v uv &> /dev/null; then
    echo "Instalando UV..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
    echo "UV instalado."
else
    echo "UV já está instalado."
fi

# Instalar Starship
if ! command -v starship &> /dev/null; then
    echo "Instalando Starship..."
    curl -sS https://starship.rs/install.sh | sh
    # echo 'eval "$(starship init zsh)"' >> ~/.zshrc
    echo "Starship instalado e configurado."
else
    echo "Starship já está instalado."
fi

# CONFIGURAÇÕES -------------------------------------------------------

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
  "https://github.com/z-shell/F-Sy-H.git $USER_HOME/.zsh/plugins/f-sy-h"
  "https://github.com/unixorn/fzf-zsh-plugin.git $USER_HOME/.zsh/plugins/fzf-zsh-plugin"
  "https://github.com/zsh-users/zsh-autosuggestions.git $USER_HOME/.zsh/plugins/zsh-autosuggestions"
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
