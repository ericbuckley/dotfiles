#!/usr/bin/env bash


# TODO:
# - test if homebrew is installed before setting PATHs in .zshrc

set -e

dotfilesDir=$(pwd)

function linkDotfile {
    # $1: parent directory
    # $2: dotfile to link
    dest="${HOME}/${2}"
    dateStr=$(date +%Y-%m-%d-%H%M)

    if [ -f "${dest}" ]; then
        read -p "Replace ${dest}? [Y/n]: "  replace
        if [ $replace = "Y" ]; then
            echo "Replacing symlink: ${dest}"
            rm ${dest} && ln -s ${1}/${2} ${dest}
        fi
    else
        echo "Creating new symlink: ${dest}"
	mkdir -p $(dirname ${dest})
        ln -s ${1}/${2} ${dest}
    fi
}

for FILE in `find . -type f -name 'init.script'`
do
    "${PWD}/${FILE}"
done

for GROUP in *; do
    if [ -d "${GROUP}" ]; then
        for FILE in `find ${GROUP} ! -name 'init.script' -type f -exec realpath --relative-to ${GROUP} {} \;`
        do
            linkDotfile "${PWD}/${GROUP}" "${FILE}"
        done
    fi
done
