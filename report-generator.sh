#!/bin/bash

set -euo pipefail

: ${TESTS_DIR:=/allure/tests}
: ${REPORTS_DIR:=/allure/reports}
: ${ALLURE:=/opt/allure/bin/allure}
: ${SLEEP_BEFORE_RUN_ALLURE:=0}

inotifywait -m -q -e create -e moved_to --format '%f' "$TESTS_DIR" | while read test_results_dir
do
    echo "New test results found: $test_results_dir"
    sleep "$SLEEP_BEFORE_RUN_ALLURE"
    if [ -e "$REPORTS_DIR/latest/history" ] && [ ! -e "$TESTS_DIR/$test_results_dir/history" ]; then
	ln -s "$REPORTS_DIR/latest/history" "$TESTS_DIR/$test_results_dir/history"
    fi
    $ALLURE generate "$TESTS_DIR/$test_results_dir" -o "$REPORTS_DIR/$test_results_dir"
    rm -f "$REPORTS_DIR/latest"
    ln -s "$test_results_dir" "$REPORTS_DIR/latest"
done
