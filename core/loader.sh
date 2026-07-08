#!/usr/bin/env bash

#
# ============================================================
# Python Doctor
# Loader Module
# ============================================================
#

[[ -n "${LOADER_LOADED:-}" ]] && return
readonly LOADER_LOADED=1

load_module() {

    local module="$1"

    if [[ ! -f "$module" ]]; then
        printf "Fatal: module not found: %s\n" "$module"
        exit 1
    fi

    # shellcheck source=/dev/null
    source "$module"

}

load_core_modules() {

    load_module "$CORE_DIR/logger.sh"
    load_module "$CORE_DIR/bootstrap.sh"
    load_module "$CORE_DIR/registry.sh"
    load_module "$CORE_DIR/dispatcher.sh"
    load_module "$CORE_DIR/cli.sh"

}