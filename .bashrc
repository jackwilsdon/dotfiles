export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1

__setup_path() {
    if [ -z "${__OLD_PATH}" ]; then
        __OLD_PATH=$PATH
    else
        PATH=$__OLD_PATH
    fi

    local PATH_NAMES=(
        "$HOME/Development/Programs/Android/SDK/tools"
        "$HOME/Development/Programs/Android/SDK/platform-tools"
        "$HOME/Development/Programs/Android/adb-sync"
        "$HOME/.rvm/bin"
        "$HOME/bin"
        "/usr/local/heroku/bin"
    )

    for name in "${PATH_NAMES[@]}"; do
        if [ -d "${name}" ]; then
            PATH="${PATH}:${name}"
        fi
    done
}

__source_files() {
    local FILE_NAMES=(
        "/etc/profile.d/bash_completion.sh"
        "$HOME/.rvm/scripts/rvm"
        "$HOME/.git-prompt.sh"
    )

    for name in "${FILE_NAMES[@]}"; do
        if [ -f "${name}" ]; then
            source "${name}"
        fi
    done
}

__prompt_command() {
    local CYAN="\[\e[0;36m\]"
    local GRAY="\[\e[1;30m\]"
    local GREEN="\[\e[0;32m\]"
    local RESET="\[\e[0;0m\]"

    local TITLE="\[\033]0;\w\007"
    local PREFIX="${TITLE}\n${CYAN}> ${GRAY}\u@\h${RESET} \W"
    local SUFFIX=" ${CYAN}\$${RESET} "

    if [ -n "${VIRTUAL_ENV-}" ]; then
        PREFIX="${PREFIX} (${GREEN}venv${RESET})"
    fi

    if type -t __git_ps1 | grep '^function$' > /dev/null 2>&1; then
        __git_ps1 "${PREFIX}" "${SUFFIX}"
    else
        export PS1="${PREFIX}${SUFFIX}"
    fi
}

__setup_path
__source_files

PROMPT_COMMAND=__prompt_command

alias "ls"="ls --color=auto"
alias "l"="ls -lh"
alias "la"="ls -lah"

export rvmsudo_secure_path=1

export EDITOR="vim"
export VISUAL="${EDITOR}"
