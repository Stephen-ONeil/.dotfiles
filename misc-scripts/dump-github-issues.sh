#! /bin/bash
set -e

open_issue_numbers=`gh issue list --state open | awk '{print $1}'`;

file_name="$(basename `git rev-parse --show-toplevel`)-issues.csv"

rm -rf $file_name

echo "author,title,body,comments" >> $file_name;

while IFS= read -r issue_number; do
  gh issue view $issue_number --json author,title,body,comments | jq -r '[.author.login,.title,.body,(.comments | map(.author.login + ": " +.body) | @csv)] | @csv' >> $file_name;
done <<< "$open_issue_numbers"
