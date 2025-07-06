#!/usr/bin/gawk -f

#
# This script detects the format of each word of a text.
# 
# It produces an TSV file with the following fields:
# 
#  1. TOKEN: the token, i.e. a "word".
#  2. FORMAT: the token's format..
#
# Use `-v CUSTOM_FORMATS="KEY1=REGEX1;KEY2=REGEX2";` to push a list of custom formats.
#
# A custom format has a key and a regex separated by a colon. A list of custom formats has its itens separated by semicolons.
#
# Usage:
#
#     gawk -f word-formats.awk input.txt > output.txt
#     gawk -f word-spacer.awk input.txt | gawk -f word-formats.awk > output.txt
#
# The table rows are sorted using this command via pipe: `sort -t'	' -k1,1`.
#
# This script only works with GNU's Awk (gawk).
#

function format(token,    i, key) {
	for (i = 0; i < order; i++) {
		key = FORMAT_ORDER[i];
		if (token ~ FORMAT_ARRAY[key]) return key;
	}
	return "NA";
}

function push_formats(FORMATS,   n, f, format, formats, format_key, format_val) {

	if (!FORMATS) return;

	split(FORMATS, formats, /;/);
	
	for (f in formats) {
		format = formats[f];
		if (format ~ /[[:alnum:]]+=.+/) {
			n = index(format, "=");
			format_key = substr(format, 1, n - 1);
			format_val = substr(format, n + 1);
			FORMAT_ORDER[order++] = format_key;
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
	
	# Punctuation: . , !? ...
	push_formats("P=^[[:punct:]]+$");
	
	# Number: -1 -1.2 -1,3
	push_formats("N=^[+-]?[[:digit:]]+([.,][[:digit:]]+)?$");
	# Number with percent: -1% -1.2% -1,3%
	push_formats("NP=^[+-]?[[:digit:]]+([.,][[:digit:]]+)?%$");
	
	# Lower case with hyphen: "compound-word", "compound-WORD", "compound-Word" and "compound-WoRd"
	push_formats("LH=^[[:lower:]]+(-([[:lower:]]+|[[:upper:]]+|[[:upper:]][[:lower:]]+))+$");
	# Upper case with hyphen: "COMPOUND-WORD", "COMPOUND-word", "COMPOUND-Word" and "COMPOUND-WoRd"
	push_formats("UH=^[[:upper:]]+(-([[:lower:]]+|[[:upper:]]+|[[:upper:]][[:lower:]]+))+$");
	# Start case with hyphen: "Compound-Word", "Compound-word", "Compound-WORD" and "Compound-WoRd"
	push_formats("SH=^[[:upper:]][[:lower:]]+(-([[:lower:]]+|[[:upper:]]+|[[:upper:]][[:lower:]]+))+$");
	
	# Camel case: "compoundWord" "CompoundWord"
	push_formats("C=^[[:upper:]]?[[:lower:]]+([[:upper:]][[:lower:]]+)+$");

	# Number with thousands comma (USA): -1,000.00
	push_formats("NTC=^[+-]?([[:digit:]]{1,3})?([,][[:digit:]]{3})+[.][[:digit:]]+$");
	# Number with thousands dot (Other countries): -1.000,00
	push_formats("NTD=^[+-]?([[:digit:]]{1,3})?([.][[:digit:]]{3})+[,][[:digit:]]+$");
	
	# Time: 1:59 23:59
	push_formats("T=^[[:digit:]]{1,2}[:][[:digit:]]{2}$");
	# Time with H: 1h 1h59 23h59
	push_formats("TH=^[[:digit:]]{1,2}[hH]([[:digit:]]{2})?$");
	
	# Date: ?1/?1/1970 ?1-?1-1970 ?1.?1.1970
	push_formats("D=^(([[:digit:]]{1,2}[/]){2}|([[:digit:]]{1,2}[-]){2}|([[:digit:]]{1,2}[.]){2})([[:digit:]]{4})$");
	# Date backwards: 1970/01/01 1970-01-01 1970.01.01
	push_formats("DB=^([[:digit:]]{4})(([/][[:digit:]]{2}){2}|([-][[:digit:]]{2}){2}|([.][[:digit:]]{2}){2})$");
	
	# E-mail
	push_formats("WE=^[[:alnum:]-]+([.][[:alnum:]-]+)*@[[:alnum:]-]+([.][[:alnum:]-]+)*$");
	
	# URL
	push_formats("WU=^http[s]?://[[:alnum:]-]+([.][[:alnum:]-]+)*([/][[:alnum:]_$%?#&:=~,.+-]*)*$");
	
	# Sub-domain name with WWW
	push_formats("WW=^www([.][[:alnum:]-]+)+([.][[:alpha:]]{2,3})$");
	
	# Domain or sub-domain name with the original 7 TLDs created in 1998: .com .org .net etc
	push_formats("WD=^([[:alnum:]-]+[.])+(com|org|net|int|edu|gov|mil)([.][[:alpha:]]{2})?$");
	
	# Hashtag
	push_formats("WH=^#[[:alnum:]]+$");
	
	# At tag, aka user tag or mention
	push_formats("WA=^@[[:alnum:]]+$");
}

BEGIN {
	load_formats();
}

{
    for (i = 1; i <= NF; i++) {
		tokens[$i];
    }
    tokens["\\n"];
}

END {
	OFS="\t"
    print "TOKEN", "FORMAT";
    for (token in tokens) {
        print token, format(token) | "sort -t'	' -k1,1";
    }
}

