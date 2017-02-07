#!/usr/bin/env bash

trap 'clean-up' INT TERM EXIT

LOGFILE="$(umask 077 && mktemp -t dotfiles.XXXXXXXXXX)"

function error {
	echo "$1"; exit 1
}

function clean-up {
	trap - INT EXIT

	echo
	if [[ -s "${LOGFILE}" ]]; then
		echo "Installation of contents not completely successful..."
		echo -n "Hit enter to display details of encountered errors: "; read
		less "${LOGFILE}"
	else
		echo "Cleaning up and exiting installer..."
	fi

	rm -f "${LOGFILE}"

	exit 0
}

function install-file {
	test ! -z ${1:-} || return

	local _srcfile="$1"
	local _dstfile="${HOME}/${1/dot/}"
	local _copycmd="cp -af"

	if [[ ! -r "${_srcfile}" ]]; then
		echo "Couldn't read source file ${_srcfile}, skipping..." 2>> "${LOGFILE}"
		return
	fi

	if [[ -d "${_srcfile}" ]]; then
		copydot="${_copycmd} ${_srcfile}/* ${_dstfile}/"; _type="directory"
	elif [[ -f "${_srcfile}" ]]; then
		copydot="${_copycmd} ${_srcfile} ${_dstfile}"; _type="file"
	else
		echo "Unknown file type for ${_srcfile}, skipping..." 2>> "${LOGFILE}"
		return
	fi

	echo -n "Install ${_srcfile} to ${_dstfile}? [y/n]: "; read ans

	case ${ans} in
	y|Y)
		test -d "${_srcfile}" && mkdir -p "${_dstfile}"
		${copydot} 2>> ${LOGFILE}

		[[ $? -eq 0 ]] && _retcode="ok" || _retcode="err"
		echo "--> installation of ${_type} to ${_dstfile}: ${_retcode}"
		;;
	esac
}

for i in dot.*; do install-file "${i}"; done
