#!/usr/bin/env bash

[[ -n "${RESULT_CREATE_LOADED:-}" ]] && return
readonly RESULT_CREATE_LOADED=1

result_create() {

    declare -gA RESULT=()

    RESULT[id]=""
    RESULT[title]=""

    RESULT[status]="INFO"
    RESULT[risk]="INFO"

    RESULT[summary]=""
    RESULT[details]=""
    RESULT[recommendation]=""

}