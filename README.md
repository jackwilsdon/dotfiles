# dotfiles
My dotfiles.

## Installing
You can install these dotfiles using `install.sh`.

The script will make symbolic links from the current directory to `$HOME`.

## Making changes
If you are making changes to the files but want git to ignore them, you can use the following command;

    git update-index --assume-unchanged <file>

And you can use the following command to un-ignore files:

    git update-index --no-assume-unchanged <file>

You can also use the provided `ignore.sh` to ignore changes to all dotfiles in this repository and `unignore.sh` to un-ignore changes.
