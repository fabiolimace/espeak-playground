#!/usr/bin/gwk -f

#
# Lists all phonemes defined from phsource files.
#
# Usage:
#
#     cat phsource/*(phonemes|ph_consonants|ph_english|ph_english_us) | awk -f list-phonemes.awk | sort | uniq
#
# Reference: https://github.com/espeak-ng/espeak-ng/issues/2236
#

function print_ipa() {
	if (IPA) {
		print IPA, "\t", FEATURES;
	}
	IPA = "";
	FEATURES = "";
}

{
	gsub(/[\t ]+/, " ");
	gsub(/[\t ]*\/\/.*/, "");
}

/[\t ]*phoneme[\t ]/ {
	print_ipa();
	match($0, /^[\t ]*phoneme[\t ]+/);
	IPA = substr($0, RLENGTH + 1);
	next;
}

/^[\t ]*([\t ][a-z]{3})+[\t ]*$/ {
	match($0, /[a-z]{3}([\t ][a-z]{3})+/);
	FEATURES = substr($0, RSTART, RLENGTH);
	next;
}

/^[\t ]*(vwl)+[\t ]+.*$/ {
	match($0, /[\t ]+/);
	FEATURES = substr($0, RLENGTH + 1);
	next;
}

/[\t ]*ipa[\t ]/ {
	match($0, /^[\t ]*ipa[\t ]+/);
	IPA = substr($0, RLENGTH + 1);
	print_ipa();
}

END {
	print_ipa()
}

