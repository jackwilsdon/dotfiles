#!/bin/bash

applycolors() {
    echo -en "\e]P0272822"
    echo -en "\e]P1BC315B"
    echo -en "\e]P274AA04"
    echo -en "\e]P3B6B649"
    echo -en "\e]P401549E"
    echo -en "\e]P589569C"
    echo -en "\e]P61A83A6"
    echo -en "\e]P7CACACA"

    echo -en "\e]P87C7C7C"
    echo -en "\e]P9F3044B"
    echo -en "\e]PA8DD006"
    echo -en "\e]PBCCCC81"
    echo -en "\e]PC0383F5"
    echo -en "\e]PDA87DB8"
    echo -en "\e]PE0383F5"
    echo -en "\e]PFFFFFFF"
}

[[ $(tty) =~ ^\/dev\/tty[0-9]+$ ]] && applycolors
