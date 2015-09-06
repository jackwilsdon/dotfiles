#!/bin/bash

install() {
    local SCRIPT_PATH="$(readlink -e "${BASH_SOURCE[0]}")"
    local SCRIPT_NAME="$(basename "${SCRIPT_PATH}")"
    local DIRECTORY_PATH="$(dirname "${SCRIPT_PATH}")"

    source "${DIRECTORY_PATH}/dotfiles.sh"

    local FILE_NAME
    for FILE_NAME in "${DOTFILES[@]}"; do
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

    unset DOTFILES
}

install
