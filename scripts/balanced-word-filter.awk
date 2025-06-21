#!/usr/bin/gawk -f

#
# Filters a list of words trying to reduce repeated bigrams (pairs of letters).
#
# The input is a list of words. The output is a list with less bigram repetition.
#
# Usage:
#     gawk -f ../scripts/balanced-word-filter.awk input.txt | sort > output.txt
#     gawk -v N=1000 -f ../scripts/balanced-word-filter.awk input.txt | sort > output.txt
#

BEGIN {
	
	MAX = N ? N : 2^32-1;

	PAIRS_SUM=0;
	split(null, PAIRS);
	split(null, WORDS);
}

$1 ~ /[[:alpha:].-]+/ {

	word = $1;
	
	if (word in WORDS) next;
	if (length(word) < 2) next;
	
	n = split(tolower(word), LETTERS, //);
	
	for (i = 1; i < n; i++) {
		pair = LETTERS[i] LETTERS[i + 1];
		if (++PAIRS[pair] > (++PAIRS_SUM / length(PAIRS)) * log(PAIRS[pair])) { next; }
	}
	
	WORDS[word];
}

END {
	for (i in WORDS) {
		print i;
		if (++x >= MAX) break;
	}
}

