#!/bin/bash

install() {
    local SCRIPT_PATH="$(readlink -e "${BASH_SOURCE[0]}")"
    local SCRIPT_NAME="$(basename "${SCRIPT_PATH}")"
    local DIRECTORY_PATH="$(dirname "${SCRIPT_PATH}")"

    local FILE_NAMES=(
        .bash_profile
        .bashrc
        .config/subtle/subtle.rb
        .gitconfig
        .tmux.conf
        .vimrc
    )

    shopt -s nullglob

    local FILE_NAME
    for FILE_NAME in "${FILE_NAMES[@]}"; do
        local FILE_DIRECTORY="${DIRECTORY_PATH}/${FILE_NAME}"
        local DESTINATION="${HOME}/${FILE_NAME}"

        if [ ! -f "${FILE_DIRECTORY}" ]; then
            echo "File not found at ${FILE_DIRECTORY}"
            continue;
        fi

        if [ -f "${DESTINATION}" ]; then
            echo "File already exists at ${DESTINATION}"
        else
            mkdir -p "$(dirname "${DESTINATION}")"

            ln -s "${FILE_DIRECTORY}" "${DESTINATION}"
            echo "Installing ${FILE_NAME} to ${DESTINATION}"
        fi
    done

    shopt -u nullglob
}

install
