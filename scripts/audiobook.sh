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
# If the filename has the format "TITLE - AUTHOR.txt", the output file will have ID3 tags for title and author, otherwise it will have only a title.
#
# You can choose any voice supported by espeak-ng. However, if you choose an mbrola voice, be sure you have installed 'mbrola' along with 'espeak-ng'.
#
# The default espeak-ng voice is "pt-br" (Brazilian Portuguese).
#
# Dependencies: espeak-ng, ffmpeg, and id3v2 (or id3tool).
#

DEFAULT_VOICE="pt-br";

RED='\033[0;31m';
NOCOLOR='\033[0m';

function error {
	printf "\n${RED}${1}${NOCOLOR}\n" >&2 && exit 1;
}

function mp3tag {

	local FILE_MP3=${1};
	local TITLE_DASH_AUTHOR=${2};

	if [[ "${TITLE_DASH_AUTHOR}" =~ ^[^-]+-[^-]+$ ]]; then
		TITLE=`echo ${TITLE_DASH_AUTHOR%%-*}`
		AUTHOR=`echo ${TITLE_DASH_AUTHOR##*-}`
	else
		TITLE=${TITLE_DASH_AUTHOR}
		AUTHOR=""
	fi;
	
	[ -n "`which id3v2`" ] && id3v2 -t "${TITLE}" -a "${AUTHOR}" "${FILE_MP3}" && return;
	[ -n "`which id3tool`" ] && id3tool -t "${TITLE}" -r "${AUTHOR}" "${FILE_MP3}" && return;
}

function audiobook {

	local FILE_TXT=${1}
	local VOICE=${2}

	local MINUTES=$(expr 1 \* 60);
	
	local TEMP_FOLD=$(mktemp -d)
        local BASE_NAME=$(basename "${FILE_TXT}")
        local BASE_FOLD=$(dirname "${FILE_TXT}")
        local FILE_NAME=${BASE_NAME%.txt}-${VOICE}-$(date +%s)
        
	local FILE_WAV=${TEMP_FOLD}/${FILE_NAME}.wav
	local FILE_MP3=${TEMP_FOLD}/${FILE_NAME}.mp3
	local LIST_MP3=${TEMP_FOLD}/${FILE_NAME}.list

	echo -e "\nProcessing '${FILE_TXT}'";
	
	# generate audio in parts of $MINUTES.
	# eSpeak NG generates WAV files of up to 13 hours and 31 minutes at 22050 Hz.
	espeak-ng -v "${VOICE}" --split="${MINUTES}" -f "${FILE_TXT}" -w "${FILE_WAV}";

	find "${TEMP_FOLD}" -name "${FILE_NAME}_[0-9][0-9].wav" | sort | \
	while read -r i; do
		# convert each WAV partial file into MP3 audio
		# NOTE: `-nostdin` avoids ffmpeg reading standard input
		ffmpeg -nostdin -i "${i}" "${i%.wav}.mp3" &> /dev/null \
		&& echo "file '${i%.wav}.mp3'" >> "${LIST_MP3}";
	done;
	
	# combine all partial MP3 files into a single MP3 audio file
	ffmpeg -f concat -safe 0 -i "${LIST_MP3}" -c copy "${FILE_MP3}" -nostdin &> /dev/null;

	mp3tag "${FILE_MP3}" "${BASE_NAME%.txt}";

	mv "${FILE_MP3}" "${BASE_FOLD}/" && rm -f ${TEMP_FOLD}/* && rmdir ${TEMP_FOLD};
}

[ -z "`which espeak-ng`" ] && error "Please install 'espeak-ng'.";
[ -z "`which ffmpeg`" ] && error "Please install 'ffmpeg'.";
[ -z "`which id3v2`" ] && [ -z "`which id3tool`" ] && error "Please install 'id3v2' or 'id3tool'.";

[ -f "${1}" ] && time audiobook "${1}" "${2-$DEFAULT_VOICE}";


