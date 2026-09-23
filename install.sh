#!/bin/bash

# Install dotfiles: run initialization scripts in dependency order, then
# symlink managed files into $HOME while excluding .dotfilesignore entries.
#
# Usage: ./install.sh

set -euo pipefail

cd "$(dirname "$0")"

DOTFILES_IGNORE="${PWD}/.dotfilesignore"

is_ignored() {
	local repo_file="${1#./}"
	local pattern

	[ -f "${DOTFILES_IGNORE}" ] || return 1

	while IFS= read -r pattern || [ -n "${pattern}" ]; do
		case "${pattern}" in
			''|\#*)
				continue
				;;
		esac

		if [[ "${repo_file}" == "${pattern}" ]]; then
			return 0
		fi
	done < "${DOTFILES_IGNORE}"

	return 1
}

function linkDotfile {
	# $1: parent directory
	# $2: dotfile to link
	DEST="${HOME}/${2}"

	if [ -f "${DEST}" ]; then
		if [ -L "${DEST}" ] && [ "$(readlink -- "${DEST}")" = "${1}/${2}" ]; then
			# existing file is link and it already matches
			return
		fi
		# The callers below use find | while, so stdin is a pipe even when the
		# installer was launched from a terminal. Read the prompt from the TTY.
		REPLACE="n"
		if [ -t 1 ] && [ -r /dev/tty ]; then
			read -r -p "Replace ${DEST}? [Y/n]: " REPLACE </dev/tty || REPLACE="n"
		else
			echo "Skipping ${DEST} (not a TTY)"
		fi
		
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

runInitScript() {
	FILE="$1"
	echo "INITIALIZING: ${PWD}/${FILE}..."
	"${PWD}/${FILE}"
}

# Execute dependency-sensitive init scripts first. The remaining scripts are
# independent and run afterward in a stable, sorted order.
for FILE in homebrew/init.script mise/init.script; do
	if [ -f "${FILE}" ]; then
		runInitScript "${FILE}"
	fi
done

find . -type f -name "init.script" -print | sort | while read -r FILE; do
	case "${FILE#./}" in
		homebrew/init.script|mise/init.script)
			continue
			;;
	esac
	runInitScript "${FILE#./}"
done

# create all symlinks
for GROUP in *; do
	if [ -d "${GROUP}" ]; then
		find "${GROUP}" ! -name 'init.script' -type f | while read -r FILE; do
			# Installer inputs and other repository-only files are listed here
			# instead of being linked into the home directory.
			if is_ignored "${FILE}"; then
				continue
			fi

			RELPATH=$(realpath --relative-to="${GROUP}" "${FILE}")
			linkDotfile "${PWD}/${GROUP}" "${RELPATH}"
		done
	fi
done
