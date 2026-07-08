#!/usr/bin/env bash

LOG_DIR=""
REPORT_DIR=""
LOG_FILE=""

init() {

    LOG_DIR="$BASE_DIR/logs"
    REPORT_DIR="$BASE_DIR/reports"

    mkdir -p "$LOG_DIR"
    mkdir -p "$REPORT_DIR"

    LOG_FILE="$LOG_DIR/python-doctor-$(date +%Y%m%d-%H%M%S).log"

    touch "$LOG_FILE"
}

log() {

    echo "[$(date '+%F %T')] $*" >> "$LOG_FILE"

}

title() {

    echo
    printf '=%.0s' {1..70}
    echo
    echo "$1"
    printf '=%.0s' {1..70}
    echo

}

info() {

    color_echo "$INFO" "[INFO] $*"
    log "[INFO] $*"

}

success() {

    color_echo "$SUCCESS" "[ OK ] $*"
    log "[ OK ] $*"

}

warning() {

    color_echo "$WARNING" "[WARN] $*"
    log "[WARN] $*"

}

error() {

    color_echo "$ERROR" "[FAIL] $*"
    log "[FAIL] $*"

}