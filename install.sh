#!/bin/bash

# Definir a pasta home do usuario
USER_HOME="$HOME"

# INSTALAÇÕES ESSENCIAIS -------------------------------------------------------
# - GIT
# - ZSH
# - EZA
# - SDKMAN
# - FNM
# - UV
# - Starship
# - Nala
# - Docker Engine
# - PIPX
# - Sublime Text

# Instalar Git
if ! command -v git &> /dev/null; then
    echo "Instalando Git..."
    sudo apt update && sudo apt install -y git
    echo "Git instalado."
else
    echo "Git já está instalado."
fi

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

# Instalar SDKMAN
if [ ! -d "$USER_HOME/.sdkman" ]; then
    echo "Instalando SDKMAN..."
    curl -s "https://get.sdkman.io" | bash
    echo "SDKMAN instalado."
else
    echo "SDKMAN já está instalado."
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

# Instalar Nala
if ! command -v nala &> /dev/null; then
    echo "Instalando Nala..."
    sudo apt install nala
    echo "Nala instalado e configurado."
else
    echo "Nala já está instalado."
fi

# Instalar Docker
if ! command -v docker &> /dev/null; then
    echo "Instalando Docker Engine..."
    echo "uninstall all conflicting packages with Docker Engine"
    for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done
    
    # Add Docker's official GPG key:
    echo "Set up Docker's apt repository"
    sudo apt-get update
    sudo apt-get install ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources:
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    
    echo "Install the Docker packages"
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    
    echo "Linux post-installation for Docker Engine"
    if ! getent group docker > /dev/null; then
        echo "Criando grupo docker..."
        sudo groupadd docker
    fi
    sudo usermod -aG docker $USER
    newgrp docker    
else
    echo "Docker já está instalado."
fi

# Instalar PIPX
if ! command -v pipx &> /dev/null; then
    echo "Instalando PIPX..."
    sudo apt update
    sudo apt install pipx
    pipx ensurepath
    sudo pipx ensurepath --global # optional to allow pipx actions with --global argument
else
    echo "PIPX já está instalado."
fi

# Instalar Sublime Text 
if ! command -v subl &> /dev/null; then
    wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg > /dev/null
    echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
    sudo apt-get update
    sudo apt-get install sublime-text
else
    echo "Sublime Text já está instalado."
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

# DOWNLOAD E INSTALAÇÃO DE FONTES -------------------------------------------------------
FONTS_DIR="/usr/local/share/fonts"
if [ ! -d "$FONTS_DIR" ]; then
    echo "Criando diretório de fontes em $FONTS_DIR..."
    sudo mkdir -p "$FONTS_DIR"
else
    echo "Diretório de fontes já existe em $FONTS_DIR."
fi

FONT_URLS=(
    "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/FiraCode.zip"
    "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.zip"
    "https://github.com/kencrocken/FiraCodeiScript/archive/refs/heads/master.zip"
    "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Meslo.zip"
)

for url in "${FONT_URLS[@]}"; do
    filename=$(basename "$url")
    temp_zip="/tmp/$filename"
    
    echo "Baixando $url..."
    curl -L "$url" -o "$temp_zip"
    
    if [[ "$filename" == *.zip ]]; then
        echo "Descompactando $filename em $FONTS_DIR..."
        sudo unzip -o "$temp_zip" -d "$FONTS_DIR"
        rm "$temp_zip"
    fi
done

# Atualizar cache de fontes
fc-cache -f -v

echo "==============================="
echo "Configuração finalizada."
echo "==============================="
