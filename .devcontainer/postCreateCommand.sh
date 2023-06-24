#!/bin/bash

echo "postCreateCommand hook script is running"

git config --local commit.template commit-template.txt
cp scripts/prepare-commit-msg.sh .git/hooks/prepare-commit-msg
chmod +x .git/hooks/prepare-commit-msg