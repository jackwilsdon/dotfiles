DOTFILES=()

load_dotfiles() {
    local SCRIPT_PATH="$(readlink -e "${BASH_SOURCE[0]}")"
    local DIRECTORY_PATH="$(dirname "${SCRIPT_PATH}")"

    while read line; do
      [ -z "${line}" ] && continue

      DOTFILES+=(${line})
    done < "${DIRECTORY_PATH}/dotfiles.txt"
}

load_dotfiles
