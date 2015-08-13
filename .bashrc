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
        "$HOME/.rvm/bin"
        "$HOME/bin"
    )

    for name in "${PATH_NAMES[@]}"; do
        if [ -d "${name}" ]; then
            PATH="${PATH}:${name}"
        fi
    done
}

__source_files() {
    local FILE_NAMES=(
        "$HOME/.rvm/scripts/rvm"
    )

    for name in "${FILE_NAMES[@]}"; do
        if [ -f "${name}" ]; then
            source "${name}"
        fi
    done
}

__get_prompt_command() {
    local CYAN="\[\e[0;36m\]"
    local GRAY="\[\e[1;30m\]"
    local RESET="\[\e[0;0m\]"

    local TITLE="\[\033]0;\w\007"
    local PREFIX="${TITLE}\n${CYAN}> ${GRAY}\u@\h${RESET} \W"
    local SUFFIX=" ${CYAN}\$${RESET} "

    if type -t __git_ps1 | grep '^function$' > /dev/null 2>&1; then
        echo -n "__git_ps1 \"${PREFIX}\" \"${SUFFIX}\""
    else
        echo -n "PS1=\"${PREFIX}${SUFFIX}\""
    fi
}

__setup_path
__source_files

PROMPT_COMMAND=$(__get_prompt_command)

alias "ls"="ls --color=auto"
alias "l"="ls -lh"
alias "la"="ls -lah"

export rvmsudo_secure_path=1
