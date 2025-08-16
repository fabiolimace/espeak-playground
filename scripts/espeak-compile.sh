#!/bin/bash

#
# Compiles eSpeak phonemes, lists, rules and mbrola.
#
# Usage:
#    espeak-compile.sh pt-pt pt1   # mb-pt1
#    espeak-compile.sh pt-pt ptbr  # mb-br[123]
#    espeak-compile.sh pt-br ptbr4 # mb-br4 (default)
#

VOICE=${1-pt-br}
MBROLA=${2-ptbr4}

ESPEAK_HOME=$HOME/git/espeak-br

echo "---------------------------------------------"
echo "Compile the phoneme data"
echo "---------------------------------------------"
sudo espeak-ng --compile-phoneme=$ESPEAK_HOME/phsource
echo

echo
echo "---------------------------------------------"
echo "Compile pronunciation rules and dictionary"
echo "---------------------------------------------"
bash -c "cd $ESPEAK_HOME/dictsource; sudo espeak-ng --compile-debug=$VOICE;"
echo

echo "---------------------------------------------"
echo "Compile an MBROLA voice"
echo "---------------------------------------------"
bash -c "cd $ESPEAK_HOME/phsource/mbrola; sudo espeak-ng --compile-mbrola=$MBROLA"
echo
