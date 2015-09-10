alias ls="ls -G"
export FIGNORE="${FIGNORE}:DS_Store"

if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi
