#!/bin/bash

# TODO:
# - test if homebrew is installed before setting PATHs in .zshrc

set -euo pipefail

cd "$(dirname "$0")"

function linkDotfile {
	# $1: parent directory
	# $2: dotfile to link
	DEST="${HOME}/${2}"

	if [ -f "${DEST}" ]; then
		if [ -L "${DEST}" ] && [ "$(readlink -- "${DEST}")" = "${1}/${2}" ]; then
			# existing file is link and it already matches
			return
		fi
		read -r -p "Replace ${DEST}? [Y/n]: " REPLACE
		if [ "$REPLACE" = "Y" ]; then
			echo "Replacing symlink: ${DEST}"
			ln -f -s "${1}/${2}" "${DEST}"
		fi
	else
		echo "Creating new symlink: ${DEST}"
		mkdir -p "$(dirname "${DEST}")"
		ln -f -s "${1}/${2}" "${DEST}"
	fi
}

# execute all init.script files
find . -type f -name "init.script" | while read -r FILE; do
	echo "INITIALIZING: ${PWD}/${FILE}..."
	"${PWD}/${FILE}"
done

# create all symlinks
for GROUP in *; do
	if [ -d "${GROUP}" ]; then
		find "${GROUP}" ! -name 'init.script' -type f | while read -r FILE; do
			RELPATH=$(realpath --relative-to="${GROUP}" "${FILE}")
			linkDotfile "${PWD}/${GROUP}" "${RELPATH}"
		done
	fi
done
