#!/bin/bash

#
# Compiles eSpeak phonemes, lists, rules and mbrola.
#
# Usage:
#    espeak-compile.sh LANG [MBROLA]
#    espeak-compile.sh pt-pt pt1   # mb-pt1
#    espeak-compile.sh pt-pt ptbr  # mb-br[123]
#    espeak-compile.sh pt-br ptbr4 # mb-br4
#
# If no argument is provided, all portuguese voices are compiled.
#

ESPEAK_HOME=$HOME/git/espeak-br

function espeak_compile {

	local LANG=${1-pt-br}
	local MBROLA=${2-ptbr4}

	echo "---------------------------------------------"
	echo "Compile the phoneme data"
	echo "---------------------------------------------"
	sudo espeak-ng --compile-phoneme=$ESPEAK_HOME/phsource
	echo

	echo
	echo "---------------------------------------------"
	echo "Compile pronunciation rules and dictionary"
	echo "---------------------------------------------"
	bash -c "cd $ESPEAK_HOME/dictsource; sudo espeak-ng --compile-debug=$LANG;"
	echo

	if [ -n "${MBROLA}" ]; then
		echo "---------------------------------------------"
		echo "Compile an MBROLA voice"
		echo "---------------------------------------------"
		bash -c "cd $ESPEAK_HOME/phsource/mbrola; sudo espeak-ng --compile-mbrola=$MBROLA"
		echo
	fi;

}

if [ -n "${1}" ]; then
	espeak_compile "${1}" "${2}";
else
	espeak_compile "pt-pt" "pt1"
	espeak_compile "pt-br" "ptbr"
	espeak_compile "pt-br" "ptbr4"
fi;


