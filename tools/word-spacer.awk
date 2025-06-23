#!/usr/bin/gawk -f

#
# This script inserts spaces between words and punctuation.
# 
# Example:
#
#  *  Input:  This is... a '(very)' ('especial') example!
#  *  Output: This is ... a ' ( very ) ' ( ' especial ' ) example !
#
# The output is useful for tokenization.
#
# Usage:
#
#     gawk -f word-spacer.awk input.txt > output.txt
#
# This script only works with GNU's Awk (gawk).
#

function sub_wrapper(regex, str, i) {
	match($i, regex);
	if (length($i) > RLENGTH) {
		sub(regex, str, $i);
	}
}

function puncts() {
	for (i = 1; i <= NF; i++) {
		sub_wrapper(@/^[.…,:;!?¿]+/, "& ", i);
		sub_wrapper(@/[.…,:;!?¿]+$/, " &", i);
	} $0=$0
}

function quotes() {
	for (i = 1; i <= NF; i++) {
		sub_wrapper(@/^[\042\047‘’“”‚„«»‹›—―]+/, "& ", i);
		sub_wrapper(@/[\042\047‘’“”‚„«»‹›—―]+$/, " &", i);
	} $0=$0
}

function braces() {
	for (i = 1; i <= NF; i++) {
		sub_wrapper(@/^[][{}()<>]+/, "& ", i);
		sub_wrapper(@/[][{}()<>]+$/, " &", i);
	} $0=$0
}

function push_away() {
	puncts();
	quotes();
	braces();
}

{
	# 2x is OK
	push_away();
	push_away();
	print;
}

