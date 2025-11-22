#!/bin/bash

# 
# List all misspelled words in a text file using Aspell.
# 
# Usage
#
#     aspell-list file.txt
#     aspell-list file.txt pt_BR pt_PT
#     aspell-list file.txt pt_BR pt_PT en_US
#
# Install dicts:
#
#     apt install aspell-pt-br aspell-pt-pt aspell-en aspell-uk aspell-fr aspell-it aspell-es aspell-de
#

TEXT=${1}
DICT_1=${2-pt_BR}
DICT_2=${3-$DICT_1}
DICT_3=${4-$DICT_2}

[ -z "`which aspell`" ] && echo "Please install 'aspell'." >&2 && exit 1;

cat "${TEXT}" \
	| aspell --master "${DICT_1}" list \
	| aspell --master "${DICT_2}" list \
	| aspell --master "${DICT_3}" list \
	| sort | uniq -c | sort -n;


