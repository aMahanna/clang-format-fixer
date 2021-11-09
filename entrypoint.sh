#!/bin/bash
SOURCES=()

function log() {
    echo -e "[ gh-action ] :: $1"
}

function split_csv() {
    IFS=','
    csv_data="$1"
    local -n global_list_array="$2"
    for i in $csv_data; do
        if [ -f "$i" ]; then
            global_list_array+=("$i")
        fi
    done
    unset IFS
}

cd "$GITHUB_WORKSPACE" || exit 2
log "Action started"
log "Sources to check: $INPUT_SOURCES\n"
split_csv "$INPUT_SOURCES" SOURCES

for file in "${SOURCES[@]}"; do
    clang-format -style=file -i "${file}"
done

echo "### Getting branch"
BRANCH=${GITHUB_REF#*refs/heads/}

echo "## Configuring git author..."
git config --global user.email "anthony.mahanna@gmail.com"
git config --global user.name "aMahanna"

echo "## Commiting files..."
git commit -a -m "apply clang-format" || true

echo "## Pushing to $BRANCH"
git push -u origin $BRANCH
