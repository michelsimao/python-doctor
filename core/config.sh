#!/usr/bin/env bash

#
# ============================================================
# Python Doctor
# Configuration Module
# ============================================================
#

# Evita carregamento múltiplo
[[ -n "${CONFIG_LOADED:-}" ]] && return
readonly CONFIG_LOADED=1

#
# Caminhos do projeto
#

readonly PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

readonly BIN_DIR="$PROJECT_ROOT/bin"
readonly CORE_DIR="$PROJECT_ROOT/core"
readonly LIB_DIR="$PROJECT_ROOT/lib"
readonly COMMANDS_DIR="$PROJECT_ROOT/commands"
readonly CHECKS_DIR="$PROJECT_ROOT/checks"

readonly ASSETS_DIR="$PROJECT_ROOT/assets"
readonly DOCS_DIR="$PROJECT_ROOT/docs"

readonly LOG_DIR="$PROJECT_ROOT/logs"
readonly REPORT_DIR="$PROJECT_ROOT/reports"
readonly TMP_DIR="$PROJECT_ROOT/tmp"
readonly STATE_DIR="$PROJECT_ROOT/state"

readonly DATE_FORMAT="%F %T"

#
# Versão
#

readonly VERSION_FILE="$PROJECT_ROOT/VERSION"

if [[ -f "$VERSION_FILE" ]]; then
    readonly APP_VERSION="$(<"$VERSION_FILE")"
else
    readonly APP_VERSION="development"
fi

#
# Timestamp único da execução
#

readonly RUN_TIMESTAMP="$(date +%Y%m%d-%H%M%S)"

#
# Nomes dos arquivos gerados
#

readonly LOG_FILENAME="python-doctor-${RUN_TIMESTAMP}.log"
readonly REPORT_FILENAME="report-${RUN_TIMESTAMP}.md"
