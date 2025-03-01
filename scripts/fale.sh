#!/bin/bash

function fale-espeak {
	espeak-ng -v "$2" "$1" 
}

function fale-mbrola {
	espeak-ng -v "$2" -s 120 "$1"
}

function transcreva-kirsh {
	espeak-ng -q -v "$2" -x "$1"
}

function transcreva-ipa {
	espeak-ng -q -v "$2" --ipa "$1"
}

fale-espeak "$1" "pt-br"
fale-mbrola "$1" "mb-br4"

fale-espeak "$1" "pt"
fale-mbrola "$1" "mb-pt1"

echo -e "pt-br:\t$(transcreva-ipa "$1" "pt-br")\t$(transcreva-kirsh "$1" "pt-br")"
echo -e "pt:\t$(transcreva-ipa "$1" "pt")\t$(transcreva-kirsh "$1" "pt")"

