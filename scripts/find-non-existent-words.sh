#!/bin/bash

#
# Finds all words in a text file that doesn't exist in a dictionary.
#
# It provides simple statistics and word format for each non-existent word found.
#
# Usage
#
#     find-non-existent-words.sh FILE.txt                                 # use default dictonary
#     find-non-existent-words.sh FILE.txt /usr/share/dict/portuguese      # use another dictionary
#     find-non-existent-words.sh FILE.txt | awk '$4 == "S"'               # find only names
#     find-non-existent-words.sh FILE.txt | awk '$4 == "L" || $4 == "S"'  # find only words
#

TEXT_FILE=${1}
DICT_FILE=${2:-/usr/share/dict/brazilian}

SCRIPTDIR=$(dirname "$0");

[ ! -f "${TEXT_FILE}" ] && exit 1;

cat "${TEXT_FILE}" \
	| awk -f "${SCRIPTDIR}/../tools/word-spacer.awk"  \
	| awk -f "${SCRIPTDIR}/../tools/word-counter-with-formats.awk" \
	| awk -v "DICT_FILE=${DICT_FILE}" 'BEGIN { while (getline < DICT_FILE) { DICT[tolower($1)]=1; } } { if (!(tolower($1) in DICT)) { print $0 } } '


