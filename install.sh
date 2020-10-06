#!/bin/sh

set -e

dotfilesDir=$(pwd)

function linkDotfile {
    # $1: parent directory
    # $2: dotfile to link
    dest="${HOME}/${2}"
    dateStr=$(date +%Y-%m-%d-%H%M)

    if [ -f "${dest}" ]; then
        # Existing file
        echo "File already exists: ${dest}"
    else
        echo "Creating new symlink: ${dest}"
	mkdir -p $(dirname ${dest})
        ln -s ${1}/${2} ${dest}
    fi
}

for GROUP in *; do
    if [ -d "${GROUP}" ]; then
        for FILE in `find ${GROUP} -type f -exec realpath --relative-to ${GROUP} {} \;`
        do
            linkDotfile "${PWD}/${GROUP}" "${FILE}"
        done
    fi
done
