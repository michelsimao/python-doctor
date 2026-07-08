#!/usr/bin/env bash

#
# ============================================================
# Python Doctor
# Loader Module
# ============================================================
#

[[ -n "${LOADER_LOADED:-}" ]] && return
readonly LOADER_LOADED=1

#
# Carrega um módulo
#

load_module() {

    local module="$1"

    if [[ ! -f "$module" ]]; then
        printf "\n"
        printf "Fatal error\n\n"
        printf "Unable to load module:\n"
        printf "  %s\n\n" "$module"
        printf "The Python Doctor installation appears to be incomplete.\n"
        exit 1
    fi

    # shellcheck source=/dev/null
    source "$module"
}

#
# Core
#

load_core_modules() {

    load_module "$CORE_DIR/logger.sh"
    load_module "$CORE_DIR/bootstrap.sh"
    load_module "$CORE_DIR/registry.sh"
    load_module "$CORE_DIR/dispatcher.sh"
    load_module "$CORE_DIR/cli.sh"

}

#
# Result
#

load_result_modules() {

    load_module "$CORE_DIR/result/create.sh"

}

#
# Libraries
#

load_library_modules() {

    load_module "$LIB_DIR/filesystem.sh"
    load_module "$LIB_DIR/strings.sh"
    load_module "$LIB_DIR/table.sh"

}

#
# Renderers
#

load_renderer_modules() {

    if [[ -d "$RENDERERS_DIR" ]]; then

        [[ -f "$RENDERERS_DIR/terminal.sh" ]] && load_module "$RENDERERS_DIR/terminal.sh"
        [[ -f "$RENDERERS_DIR/markdown.sh" ]] && load_module "$RENDERERS_DIR/markdown.sh"
        [[ -f "$RENDERERS_DIR/html.sh" ]] && load_module "$RENDERERS_DIR/html.sh"

    fi

}

#
# Inicialização completa
#

load_all_modules() {

    load_core_modules
    load_result_modules
    load_library_modules
    load_renderer_modules

}