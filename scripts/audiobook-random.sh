
EBOOK_FOLDER=${1}
BASEDIR=`dirname "${0}"`

function random {
	local LIST="${1}"
	echo "${LIST}" | awk '{ srand(systime()); i = int((rand() * NF) + 1); print $i }';
}

function audiobook_random {
	local ESPEAK_VOICES="${1}"
	find "${EBOOK_FOLDER}" -type f -name "*.txt" | sort | while read -r EBOOK; do
		"${BASEDIR}"/audiobook.sh "${EBOOK}" `random "${ESPEAK_VOICES}"`;
	done 2>&1 | tee -a "${EBOOK_FOLDER}"/audiobook-random.log
}

audiobook_random 'pt-pt pt-br mb-pt1 mb-br1 mb-br2 mb-br3 mb-br4';
