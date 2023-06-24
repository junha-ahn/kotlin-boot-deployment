#!/bin/sh

echo "prepare-commit-msg hook script is running"

commit_template_file=$(git config commit.template)

if [ -z "$commit_template_file" ]; then
  echo "Commit template is not configured. Please set the commit.template configuration."
  exit 1
fi

commit_msg_file="$1"
commit_msg_type="$2"
commit_msg="$3"

if [ "$commit_msg_type" = "-m" ]; then
  echo "$commit_msg" > "$commit_msg_file"
fi

commit_msg=$(cat "$commit_msg_file")

commit_msg_regex="^(feat|fix|refactor|style|docs|test|chore):.{1,50}(\n.{1,72})?$"

# skip merge commits
# if echo "$commit_msg" | grep -qi "merge"; then
#   exit 0
# fi

if ! echo "$commit_msg" | grep -Eq "$commit_msg_regex"; then
  echo "Invalid commit message format."
  echo
  cat "$commit_template_file"
  echo
  exit 1
fi