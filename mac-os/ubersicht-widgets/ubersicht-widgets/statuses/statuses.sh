#!/bin/bash

DIRNAME=$(dirname "$0")

FIRST='true'
for SCRIPT in battery wifi date; do
    [[ "$FIRST" == 'true' ]] || echo "<span class='status-seperator'>|</span>"
    "$DIRNAME/${SCRIPT}.sh"
    FIRST='false'
done
