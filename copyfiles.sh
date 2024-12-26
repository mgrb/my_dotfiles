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

mv starship.toml .config/