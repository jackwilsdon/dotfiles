#!/bin/bash

install() {
    local SCRIPT_PATH="$(readlink -e "${BASH_SOURCE[0]}")"
    local SCRIPT_NAME="$(basename "${SCRIPT_PATH}")"
    local DIRECTORY_PATH="$(dirname "${SCRIPT_PATH}")"

    local FILE_NAMES=(
        .applycolors.sh
        .bash_profile
        .bashrc
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
            ln -s "${FILE_DIRECTORY}" "${DESTINATION}"
            echo "Installing ${FILE_NAME} to ${DESTINATION}"
        fi
    done

    shopt -u nullglob
}

install
