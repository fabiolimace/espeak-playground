
EBOOK_FOLDER=${1}
BASEDIR=`dirname "${0}"`

function audiobook_folder {
	local ESPEAK_VOICE=${1}
	find "${EBOOK_FOLDER}" -type f -name "*.txt" | sort -h \
	| while read -r EBOOK; do "${BASEDIR}"/audiobook.sh "${EBOOK}" "${ESPEAK_VOICE}"; done 2>&1 \
	| tee -a "${EBOOK_FOLDER}"/audiobook-folder.log
}

audiobook_folder pt-br;
audiobook_folder mb-br1;
audiobook_folder mb-br2;
audiobook_folder mb-br3;
audiobook_folder mb-br4;

audiobook_folder pt-pt;
audiobook_folder mb-pt1;

