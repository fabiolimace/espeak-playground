#!/bin/awk

#
# Lists noun phrases containing prepositive adjectives in this format: DETERMINANT + ADJECTIVE + NOUN. For example:
#
#	um bom motivo
#	uma suave brisa
#	o famoso professor
#
# The variable PART_OF_SPEECH_DICT contains the path for a dictionary that lists words with their respective part of speech, in the following format:
#
#	amor	s.m.
#       lindo	adj.
#	mero	adj.
#	mulher	s.f.
#
# Usage
#
#	PART_OF_SPEECH_DICT=../dict-extraction/PRIVATE/Dicionário Porto Editora da Língua Portuguesa - Porto Editora.tsv
# 	cat /path/to/text-file.txt | awk -f ../tools/word-spacer.awk | awk -v "PART_OF_SPEECH_DICT=$PART_OF_SPEECH_DICT" -f prepositive-adjectives.awk
#


BEGIN {

	DET["a"]="art.";
	DET["as"]="art.";
	DET["o"]="art.";
	DET["os"]="art.";
	DET["um"]="art.";
	DET["uns"]="art.";
	DET["uma"]="art.";
	DET["umas"]="art.";
	DET["da"]="contr.";
	DET["das"]="contr.";
	DET["do"]="contr.";
	DET["dos"]="contr.";
	DET["na"]="contr.";
	DET["nas"]="contr.";
	DET["no"]="contr.";
	DET["nos"]="contr.";
	
	while (getline < PART_OF_SPEECH_DICT) {
		word = tolower($1);
		if ($2 ~ /s\.[mf]\./) {
			SUB[word]=$2;
		}
		if ($2 ~ /adj\./) {
			ADJ[word]=$2;
		}
		if ($2 ~ /(art\.|pron\.|contr\.)/) {
			if (!($1 in DET)) DET[word]=$2;
		}
	}
}

function sng(word) {
	if (word ~ /[aoe]s$/) return substr(word, 1, length(word) - 1);
	return word;
}

function fem(word) {
	if (word ~ /[o]$/) return substr(word, 1, length(word) - 1) "a";
	return word;
}

function mas(word) {
	if (word ~ /[a]$/) return substr(word, 1, length(word) - 1) "o";
	return word;
}

{
	for (i = 1; i <= NF-2; i++) {
		if (!($i in DET)) continue;
		if (($(i+1) in ADJ) && ($(i+2) in SUB)) { print $i, $(i+1), $(i+2); }
		else if ((sng($(i+1)) in ADJ) && (sng($(i+2)) in SUB)) { print $i, $(i+1), $(i+2); }
		else if ((fem($(i+1)) in ADJ) && (fem($(i+2)) in SUB)) { print $i, $(i+1), $(i+2); }
		else if ((mas($(i+1)) in ADJ) && (mas($(i+2)) in SUB)) { print $i, $(i+1), $(i+2); }
		else if ((fem(sng($(i+1))) in ADJ) && (fem(sng($(i+2))) in SUB)) { print $i, $(i+1), $(i+2); }
		else if ((mas(sng($(i+1))) in ADJ) && (mas(sng($(i+2))) in SUB)) { print $i, $(i+1), $(i+2); }
	}
}

