#!/bin/bash

unignore() {
    local SCRIPT_PATH="$(readlink -e "${BASH_SOURCE[0]}")"
    local SCRIPT_NAME="$(basename "${SCRIPT_PATH}")"
    local DIRECTORY_PATH="$(dirname "${SCRIPT_PATH}")"

    source "${DIRECTORY_PATH}/dotfiles.sh"

    git update-index --no-assume-unchanged ${DOTFILES[*]}

    local PLURAL="dotfile"

    [ ${#DOTFILES[*]} -eq 1 ] || PLURAL="${PLURAL}s"

    echo "Un-ignored ${#DOTFILES[*]} ${PLURAL}"

    unset DOTFILES
}

unignore
