#!/bin/bash

# 
# List all misspelled words in a text file using Aspell.
# 

TEXT=${1}
DICT_1=${2-pt_BR}
DICT_2=${3-en}

[ -z "`which aspell`" ] && echo "Please install 'aspell'." >&2 && exit 1;

function aspell_list {
	local DICT=${1}
	cat - | aspell -a -d "${DICT}" | grep "^&" | cut -d' ' -f2 | sort | uniq;
}

cat "${TEXT}" | aspell_list "${DICT_1}" | aspell_list "${DICT_2}";

