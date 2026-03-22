
EBOOK_FOLDER=${1}

cd "${EBOOK_FOLDER}";

function audiobook_folder {
	local ESPEAK_VOICE=${1}
	find . -type f -name "*.txt" | sort | while read -r EBOOK; do ~/git/espeak-playground/tools/audiobook.sh "${EBOOK}" "${ESPEAK_VOICE}"; done 2>&1 | tee -a audiobook-folder.log
}

audiobook_folder pt-br;
audiobook_folder mb-br1;
audiobook_folder mb-br2;
audiobook_folder mb-br3;
audiobook_folder mb-br4;

audiobook_folder pt-pt;
audiobook_folder mb-pt1;

