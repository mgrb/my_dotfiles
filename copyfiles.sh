#!/bin/bash

# Arquivos e pastas a serem copiados
FILES_TO_COPY=("$HOME/.zshrc" "$HOME/.zsh" "$HOME/.config/starship.toml")

# Diretório de destino (o diretório corrente)
DEST_DIR=$(pwd)

# Loop para copiar cada item da lista
for FILE in "${FILES_TO_COPY[@]}"; do
    if [ -e "$FILE" ]; then
        cp -rf "$FILE" "$DEST_DIR"
        echo "Cópia de $(basename "$FILE") concluída com sucesso."
    else
        echo "Aviso: $FILE não encontrado."
    fi
done

# Deleta todas as subpastas em .zsh/plugins
PLUGIN_DIR="$DEST_DIR/.zsh/plugins"

if [ -d "$PLUGIN_DIR" ]; then
    find "$PLUGIN_DIR" -mindepth 1 -type d -exec rm -rf {} +
    echo "Todas as subpastas em $PLUGIN_DIR foram deletadas."
else
    echo "Aviso: O diretório $PLUGIN_DIR não foi encontrado."
fi

# Deletar histórico
echo "Arquivo de histórico deletado."
rm $DEST_DIR/.zsh/.zsh_history

# Movendo starship config
echo "Movendo starship config."
mv starship.toml .config/