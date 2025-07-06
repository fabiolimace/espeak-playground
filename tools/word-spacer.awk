#!/usr/bin/gawk -f

#
# This script inserts spaces between words and punctuation.
# 
# Example:
#
#  *  Input:  This is... a '(very)' ('special') example!
#  *  Output: This is ... a ' ( very ) ' ( ' special ' ) example !
#
# The output is useful for tokenization.
#
# Usage:
#
#     gawk -f word-spacer.awk input.txt > output.txt
#
# This script only works with GNU's Awk (gawk).
#

function separate_punctuation() {
	for (i = 1; i <= NF; i++) {
		sub(/^[.…,:;!¡?¿]+/, "& ", $i);
		sub(/[.…,:;!¡?¿]+$/, " &", $i);
	}
}

function separate_quotation() {
	for (i = 1; i <= NF; i++) {
		sub(/^[\042\047‘’“”‚„«»‹›—―]+/, "& ", $i);
		sub(/[\042\047‘’“”‚„«»‹›—―]+$/, " &", $i);
	}
}

function separate_parenthesis() {
	for (i = 1; i <= NF; i++) {
		sub(/^[][{}()<>]+/, "& ", $i);
		sub(/[][{}()<>]+$/, " &", $i);
	}
}

function separate() {
	separate_punctuation();
	separate_quotation();
	separate_parenthesis();
}

function begin_line() {
	gsub(/[[:space:]]+/, " "); # SP TAB NBSP
	gsub(/[[{(<][[:alnum:]]+[]})>]/, " & "); # (1) [a] {1} <a>
	gsub(/[][{}()<>\042\047‘’“”‚„«»‹›—―.…,:;!¡?¿]{2,}/, " & "); # ?! ...
}

function end_line() {
	gsub(/[ ]{2,}/, " "); # squeeze spaces after `separate()`
}

{
	begin_line();
	
	# 2x is OK
	separate();
	separate();
	
	end_line();
	
	print;
}

