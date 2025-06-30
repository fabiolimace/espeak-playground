#!/usr/bin/gawk -f

#
# This script detects the format of each word of a text.
# 
# It produces an TSV file with the following fields:
# 
#  1. TOKEN: the token, i.e. a "word".
#  2. FORMAT: the token's format..
#
# Use `-v CUSTOM_FORMATS=KEY1:REGEX1;KEY2:REGEX2;` to push a list of custom formats.
#
# A custom format has a key and a regex separated by a colon. A list of custom formats has its itens separated by semicolons.
#
# Usage:
#
#     gawk -f word-formats.awk input.txt > output.txt
#     gawk -f word-spacer.awk input.txt | gawk -f word-formats.awk > output.txt
#
# This script only works with GNU's Awk (gawk).
#

function format(token,    f) {
	for(f in FORMAT_ARRAY) {
		if (token ~ FORMAT_ARRAY[f]) return f;
	}
	return "NA";
}

function push_formats(FORMATS,   n, f, format, formats, format_key, format_val) {

	if (!FORMATS) return;

	split(FORMATS, formats, /;/);
	
	for (f in formats) {
		format = formats[f];
		if (format ~ /[[:alnum:]]+:.+/) {
			n = index(format, "=");
			format_key = substr(format, 1, n - 1);
			format_val = substr(format, n + 1);
			FORMAT_ARRAY[format_key] = format_val;
		}
	}
}

function load_formats() {

	push_formats(CUSTOM_FORMATS);
	
	# Lower case: "word"
	push_formats("L=^[[:lower:]]+$");
	# Upper case: "WORD"
	push_formats("U=^[[:upper:]]+$");
	# Start case: "Word"
	push_formats("S=^[[:upper:]][[:lower:]]+$");
	
	# Number
	push_formats("N=^[-]?[[:digit:]]+$");
	# Percent
	push_formats("P=^[-]?[[:digit:]]+%$");
	# Fraction
	push_formats("F=^[-]?[[:digit:]]+[/][[:digit:]]+$");
	
	# Lower case with hyphen: "compound-word", "compound-WORD", "compound-Word" and "compound-WoRd"
	push_formats("LH=^[[:lower:]]+(-([[:lower:]]+|[[:upper:]]+|[[:upper:]][[:lower:]]+))+$");
	# Upper case with hyphen: "COMPOUND-WORD", "COMPOUND-word", "COMPOUND-Word" and "COMPOUND-WoRd"
	push_formats("UH=^[[:upper:]]+(-([[:lower:]]+|[[:upper:]]+|[[:upper:]][[:lower:]]+))+$");
	# Start case with hyphen: "Compound-Word", "Compound-word", "Compound-WORD" and "Compound-WoRd"
	push_formats("SH=^[[:upper:]][[:lower:]]+(-([[:lower:]]+|[[:upper:]]+|[[:upper:]][[:lower:]]+))+$");
	
	# Camel case: "compoundWord" "CompoundWord"
	push_formats("C=^[[:upper:]]?[[:lower:]]+([[:upper:]][[:lower:]]+)+$");
	
	# Number with decimal dot (USA)
	push_formats("ND=^[-]?[[:digit:]]+[.][[:digit:]]+$");
	# Number with decimal comma (Other countries)
	push_formats("NC=^[-]?[[:digit:]]+[,][[:digit:]]+$");
	# Number with decimal dot and thousands comma (USA)
	push_formats("NDC=^[-]?([[:digit:]]{1,3})?([,][[:digit:]]{3})+[.][[:digit:]]+$");
	# Number with decimal comma and thousands dot (Other countries)
	push_formats("NCD=^[-]?([[:digit:]]{1,3})?([.][[:digit:]]{3})+[,][[:digit:]]+$");
	
	# Percent with dot
	push_formats("PD=^[-]?[[:digit:]]+[.][[:digit:]]+%$");
	# Percent with comma
	push_formats("PC=^[-]?[[:digit:]]+[,][[:digit:]]+%$");

	# Time
	push_formats("T=^[[:digit:]]{1,2}[:][[:digit:]]{2}$");
	# Time with H
	push_formats("TH=^[[:digit:]]{1,2}[hH]([[:digit:]]{2})?$");

	# Date
	push_formats("D=^(([[:digit:]]{1,2}[-]){2}|([[:digit:]]{1,2}[/]){2}|([[:digit:]]{1,2}[.]){2})([[:digit:]]{2}|[[:digit:]]{4})$");
	
	# Date backwards
	push_formats("DB=^([[:digit:]]{2}|[[:digit:]]{4})(([-][[:digit:]]{1,2}){2}|([/][[:digit:]]{1,2}){2}|([.][[:digit:]]{1,2}){2})$");
	
	# Date and time ISO
	push_formats("DI=^[[:digit:]]{4}([-][[:digit:]]{2}){2}([T][[:digit:]]{2}[:][[:digit:]]{2}([:][[:digit:]]{2}([.][[:digit:]]+))(Z|[+-][[:digit:]]{2}))$");
	
	# E-mail
	push_formats("E=^[[:alnum:]-]+(\\.[[:alnum:]-]+)*@[[:alnum:]-]+(\\.[[:alnum:]-]+)*$");
	
	# URL
	push_formats("R=^(http[s]?|ftp)://[[:alnum:]-]+(\\.[[:alnum:]-]+)*(\\/[[:alnum:]-]+)*(\\/[[:alnum:]%?#&=~,.+-]+)?$");
	
	# Hashtag
	push_formats("H=^#[[:alnum:]]+$");
	
	# At tag, aka user tag or mention
	push_formats("A=^@[[:alnum:]]+$");
}

BEGIN {
	load_formats();
}

{
    for (i = 1; i <= NF; i++) {
		tokens[$i];
    }
}

END {
    print "TOKEN\tFORMAT";
    for (token in tokens) {
        printf "%s\t%s\n", token, format(token);
    }
}

