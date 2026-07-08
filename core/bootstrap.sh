bootstrap() {

    mkdir -p \
        "$LOG_DIR" \
        "$REPORT_DIR" \
        "$TMP_DIR" \
        "$STATE_DIR"

    LOG_FILE="$LOG_DIR/$LOG_FILENAME"
    REPORT_FILE="$REPORT_DIR/$REPORT_FILENAME"

    touch "$LOG_FILE"
}