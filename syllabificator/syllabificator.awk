#!/usr/bin/gawk -f

#
# Script for separation of words into syllables for Portuguese language.
#
# Usage:
#     # produces: in.cons.ti.tu.cio.na.lis.si.ma.men.te
#     echo inconstitucionalissimamente | awk -f separate-syllables-for-portuguese.awk
#
#     # split all words from a Linux dictionary
#     awk -f separate-syllables-for-portuguese.awk /usr/share/dict/brazilian
#
# This script can has a low level of error or imprecision.
#
# FIXME: tra.ir; ca.ir; tri.un.fo; cons.tru.ir; obs.tru.í
# FIXME: tran.sla.ção
#

BEGIN {

	C = "[" "bcdfghjklmnpqrstvwxz" "ç" "]" # all consonants
	G = "(" "[" "gq" "]" "[" "uüw" "]" "|" "gn" "|" "mn" "|" "ps" "|" "pn" ")" # special consonants, such as <gu>, <qu> and <ps>

	U = "[" "ãõ" "]" # common nasal vowels in diphthongs
	V = "[" "aeiou" "àáâã" "èéê" "ìí" "òóôõ" "ùúü" "y" "]" # all vowels, including nasals

	X = "[" "iu" "yw" "]" # glides that apear in coda position
	Y = "[hlr]" # consonants in consonant clusters such as <ch>, <kl> and <br>
	Z = "[lmnrsxz]" # consonants allowed to apper in coda position

	PATTERN_BASIC =   "(" C "?" Y "?" "|" G ")" "?" V;
	PATTERN_OPEN =    "(" C "?" Y "?" "|" G ")" "?" U "?" V X "?";
	PATTERN_CLOSED =  "(" C "?" Y "?" "|" G ")" "?" U "?" V X "?" "(" Z "|" C ")" "?" ;
	PATTERN_GENERAL = "(" C "?" Y "?" "|" G ")" "?" U "?" V X "?" "(" Z "|" C ")" "?" "(" Z "|" C ")" "?";

	# Note: here we also consider a syllable with a glide as "open", although glides are actually non-syllabic vowels.
	# Another observation: we treat <gu> and <qu> as special consonants in contexts where <u> is silent. 
	# Likewise, unusual consonant clusters such as <ps> and <gn> are also considered special consonants, for algorithmic simplicity.
}

{
	for (i = 1; i <= NF; i++) {

		wrd = $i;
		buf = "";
		err = "";

		wrd = tolower(wrd);

		while (wrd) {
				if (wrd ~ "^" PATTERN_OPEN PATTERN_BASIC) {
					# fix for "reinstalar", "rium" and "ruins"
					if (wrd ~ "^" PATTERN_BASIC "(im|ins)") {
						match(wrd, "^" PATTERN_BASIC);
					} else if (wrd ~ "^" PATTERN_OPEN Z C || wrd ~ "^" PATTERN_OPEN Z "$") {
						match(wrd, "^" PATTERN_CLOSED);
					} else {
						match(wrd, "^" PATTERN_OPEN);
					}
				} else if (wrd ~ "^" PATTERN_CLOSED PATTERN_BASIC) {
					match(wrd, "^" PATTERN_CLOSED);
				} else {
					match(wrd, "^" PATTERN_GENERAL);
				}

				if (RLENGTH < 0) { err = $i; break; };

				if (buf) { buf = buf "."; }
				buf = buf substr(wrd, RSTART, RLENGTH);
				wrd = substr(wrd, RSTART + RLENGTH);
		}

		# fix consonant clusters
		gsub(/l\.h/, ".lh", buf);
		gsub(/n\.h/, ".nh", buf);
		gsub(/\.rr/, "r.r", buf);
		gsub(/\.ss/, "s.s", buf);

		if (err) { print "ERROR: " $i > "/dev/stderr"; }
		else { print buf };
	}
}


