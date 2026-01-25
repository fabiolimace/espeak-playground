#!/bin/bash

FILE="${1}"

TOOLS_DIR=~/git/espeak-playground/tools

${TOOLS_DIR}/aspell-list.sh \
	<(cat "${FILE}" | awk -f ${TOOLS_DIR}/word-spacer.awk \
	| sed -E 's/[[:space:]]+/ /;' | grep -E '^.{200,}$') \
	| awk '$2 ~ /[[:upper:]]/'

