#!/bin/bash
SOURCES=()

function log() {
    echo -e "[ gh-action ] :: $1"
}

cd "$GITHUB_WORKSPACE" || exit 2
log "Action started"
log "Sources to check: $INPUT_SOURCES\n"
clang-format -style=file -i $INPUT_SOURCES

echo "### Getting branch"
BRANCH=${GITHUB_REF#*refs/heads/}

echo "## Configuring git author..."
git config --global user.email "fixer@clang-format.com"
git config --global user.name "clang-format-fixer"

echo "## Commiting files..."
git commit -a -m "apply clang-format" || true

echo "## Pushing to $BRANCH"
git push -u origin $BRANCH