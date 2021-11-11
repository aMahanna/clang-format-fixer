#!/bin/bash

set -e

function log() {
    echo -e "[ gh-action ] :: $1"
}

cd "$GITHUB_WORKSPACE" || exit 2

if [ -z "$INPUT_SOURCES" ]
then
    log "\$INPUT_SOURCES is empty. Skipping Action..."
else
    log "Action started"
    log "Sources to check: $INPUT_SOURCES\n"
    clang-format -style=file -i $INPUT_SOURCES

    log "### Getting branch"
    BRANCH=${GITHUB_REF#*refs/heads/}

    log "## Configuring git author..."
    git config --global user.email "fixer@clang-format.com"
    git config --global user.name "clang-format-fixer"

    log "## Commiting files..."
    git commit -a -m "apply: clang-format" || true

    log "## Pushing to $BRANCH"
    git push -u origin $BRANCH
fi