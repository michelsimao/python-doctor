#!/usr/bin/env bash

#
# ============================================================
# Python Doctor
# Logger Module
# ============================================================
#

[[ -n "${LOGGER_LOADED:-}" ]] && return
readonly LOGGER_LOADED=1

_write_log() {

    local level="$1"
    shift

    printf "%s [%-5s] %s\n" \
        "$(date '+%F %T')" \
        "$level" \
        "$*" >> "$LOG_FILE"

}

_print_message() {

    local color="$1"
    local level="$2"
    shift 2

    color_echo "$color" "[$(printf '%-5s' "$level")] $*"

}

log_debug() {

    _write_log "DEBUG" "$*"

}

log_info() {

    _print_message "$INFO" "INFO" "$*"
    _write_log "INFO" "$*"

}

log_success() {

    _print_message "$SUCCESS" "OK" "$*"
    _write_log "OK" "$*"

}

log_warn() {

    _print_message "$WARNING" "WARN" "$*"
    _write_log "WARN" "$*"

}

log_error() {

    _print_message "$ERROR" "ERROR" "$*"
    _write_log "ERROR" "$*"

}