#!/bin/bash

unignore() {
    local SCRIPT_PATH="$(readlink -e "${BASH_SOURCE[0]}")"
    local SCRIPT_NAME="$(basename "${SCRIPT_PATH}")"
    local DIRECTORY_PATH="$(dirname "${SCRIPT_PATH}")"

    source "${DIRECTORY_PATH}/dotfiles.sh"

    git update-index --no-assume-unchanged ${DOTFILES[*]}

    unset DOTFILES
}

unignore
