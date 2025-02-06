auto_activate_venv() {
    if [ -d ".venv" ]; then
        if [ -n "$VIRTUAL_ENV" ]; then
            deactivate
        fi
        source .venv/bin/activate

        echo "\n------------------------------------"
        echo -e " 🐍 :: Python \e[1m.venv\e[0m activated."
        echo "------------------------------------\n"
    fi
}

chpwd() {
    auto_activate_venv
}

auto_activate_venv  # Para ativar quando abrir o terminal no diretório
