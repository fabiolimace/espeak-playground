#!/bin/bash

#
# Convert a ebook into an audiobook.
#
# Input format: TXT
# Output format: MP3
#
# USAGE
#
#     audiobook.sh FILE [VOICE]
#     audiobook.sh 'title - author.txt'
#     audiobook.sh 'title - author.txt' mb-br1
#     audiobook.sh 'title - author.txt' pt-br+Annie
#
# If the filename has the format "TITLE - AUTHOR.txt", the output file will have separate tags for title and author.
#
# You can choose any voice supported by espeak-ng. However, if you choose an mbrola voice, be sure you have installed 'mbrola' along with 'espeak-ng'.
#
# The default espeak-ng voice is "pt-br" (Brazilian Portuguese).
#
# Dependencies: espeak-ng, lame (or ffmpeg), and id3v2 (or id3tool).
#

DEFAULT_VOICE="fr";

RED='\033[0;31m';
NOCOLOR='\033[0m';

function error {
	printf "\n${RED}${1}${NOCOLOR}\n" >&2 && exit 1;
}

function mp3tag {
	local FILE_NAM=${1};
	local FILE_MP3=${2};

	if [[ "${FILE_NAM}" =~ ^[^-]+-[^-]+$ ]]; then
		FILE_TIT=`echo ${FILE_NAM%%-*}`
		FILE_AUT=`echo ${FILE_NAM##*-}`
	else
		FILE_TIT=${FILE_NAM}
		FILE_AUT=""
	fi;

	[ -n "`which id3v2`" ] && id3v2 -t "${FILE_TIT}" -a "${FILE_AUT}" "${FILE_MP3}" && return;
	[ -n "`which id3tool`" ] && id3tool -t "${FILE_TIT}" -r "${FILE_AUT}" "${FILE_MP3}" && return;
}


function audiobook {

	local FILE_TXT=${1}
	local VOICE=${2}

        local BASENAME="`basename "${FILE_TXT}"`"
        local FILE_NAM="${BASENAME%.*}"
	local FILE_SUF=${VOICE}_$(date -I)_${EPOCHSECONDS}
	local FILE_WAV=$(echo "${FILE_NAM}")."${FILE_SUF}".wav
	local FILE_MP3=$(echo "${FILE_NAM}")."${FILE_SUF}".mp3

	echo -e "\nConverting '${BASENAME}'";

	[ -n "`which lame`" ] && ( \
		espeak-ng --stdout -v "${VOICE}"  -f "${FILE_TXT}" | \
		lame -b 32 - "${FILE_MP3}" ) && \
		mp3tag "${FILE_NAM}" "${FILE_MP3}" && exit;

	[ -n "`which ffmpeg`" ] && ( \
		espeak-ng -v "${VOICE}" -f "${FILE_TXT}" -w "${FILE_WAV}" && \
		ffmpeg -i "${FILE_WAV}" "${FILE_MP3}" && rm "${FILE_WAV}" ) && \
		mp3tag "${FILE_NAM}" "${FILE_MP3}" && exit;
}

[ -z "`which espeak-ng`" ] && error "Please install 'espeak-ng'.";
[ -z "`which lame`" ] && [ -z "`which ffmpeg`" ] && error "Please install 'lame' or 'ffmpeg'.";
[ -z "`which id3v2`" ] && [ -z "`which id3tool`" ] && error "Please install 'id3v2' or 'id3tool'.";

[ -f "${1}" ] && time audiobook "${1}" "${2-$DEFAULT_VOICE}";


