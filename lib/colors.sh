#!/usr/bin/env bash

# ============================================================
# Colors
# ============================================================

RESET="\033[0m"

BOLD="\033[1m"

BLACK="\033[30m"
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
MAGENTA="\033[35m"
CYAN="\033[36m"
WHITE="\033[37m"

GRAY="\033[90m"

SUCCESS="${GREEN}"
WARNING="${YELLOW}"
ERROR="${RED}"
INFO="${CYAN}"

color_echo() {
    local color="$1"
    shift

    printf "%b%s%b\n" "$color" "$*" "$RESET"
}