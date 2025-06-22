#!/usr/bin/gawk -f

#
# This script inserts spaces between words and punctuation.
# 
# Example:
#	Input: this is a "example".
#   Output: this is a " example " .
#
# The output is more useful for tokenization.
#
# Usage:
#
#     gawk -f word-spacer.awk input.txt > output.txt
#
# This script only works with GNU's Awk (gawk). Other implementations, such as mawk and busybox, don't work well with multibyte characters (Unicode).
#
# Interesting text about tokenization:
# https://www.ixopay.com/blog/what-is-nlp-natural-language-processing-tokenization
#

{
	for (i = 1; i <= NF; i++) {
		if (length($i) > 1) {
			sub(/^[.…,:;!?¿]/, "& ", $i);
			sub(/[.…,:;!?¿]$/, " &", $i);
		}
	} $0=$0
	
	for (i = 1; i <= NF; i++) {
		if (length($i) > 1) {
			sub(/^[]{}()<>\042\047‘’“”«»‹›—–]/, "& ", $i);
			sub(/[]{}()<>\042\047‘’“”«»‹›—–]$/, " &", $i);
		}
	} $0=$0
	
	print;
}

