#!/bin/bash

dirname=$(dirname "$0")

first='true'
for script in battery wifi date; do
  [[ "$first" == 'true' ]] || echo "<span class='status-seperator'>|</span>"
  "$dirname/${script}.sh"
  first='false'
done
