#!/usr/bin/env bash

echo_red () {
    local red
    local reset
    red=$(tput setaf 1)
    reset=$(tput sgr0)
    echo -e "${red}" "$@" "${reset}"
}
