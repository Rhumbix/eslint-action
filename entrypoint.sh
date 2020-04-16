#!/bin/sh

# Exit if any subcommand fails
set -e 

# Install dependencies
yarn --non-interactive --silent --ignore-scripts --production=false

# Run ESLint on files that were modified (but not deleted) by this PR
ESLINT="./node_modules/.bin/eslint"
CHANGED_FILES=$(git diff --name-only --diff-filter=ACM ${HEAD_REF}..${BASE_REF} | grep -E "\\.[jt]sx?$")

echo "## Running ESLint"
if [[ "$CHANGED_FILES" != "" ]]; then

    for FILE in $CHANGED_FILES; do
        "$ESLINT" "$FILE"
    done
fi
