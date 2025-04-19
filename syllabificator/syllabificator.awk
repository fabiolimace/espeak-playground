#!/usr/bin/gawk -f

#
# Script that separates words into syllables for Portuguese language.
#
# Usage:
#     # produces: in.cons.ti.tu.ci.o.nal.men.te
#     echo inconstitucionalmente | awk -f syllabificator.awk
#
#     # split all words from a Linux dictionary
#     awk -f syllabificator.awk /usr/share/dict/brazilian
#

BEGIN {
	
	C = "[bcdfghjklmnpqrstvwxyzç]"   # consonants
	D = "gu|qu|gü|qü|ch|lh|nh|rr|ss" # digraphs
	E = "[bcdfgkptv][rl]"            # clusters
	F = "[bgjkptswz][h]"             # ph, sh, th, wh...
	
	O = "[" "aeiou" "àáâã" "èéê" "ìí" "óôõ" "úü" "wy" "]"
	G = "[" "iu" "yw" "]"
	N = "[" "ãõ" "]"
	H = "[" "eo" "]"
	
	ONSET = "(" C "|" D "|" E "|" F ")"
	
	NUCLEUS = "(" O "|" O G "|" N H ")"
	
	CODA = "(" C "+" ")"
	
	RIMA = NUCLEUS CODA "?"
	
	SYLLABLE = ONSET "?" RIMA
	
}

{
	for (i = 1; i <= NF; i++) {

		wrd = $i;
		buf = "";
		err = "";

		wrd = tolower(wrd);
		
		while (wrd) {

			if (wrd ~ "^" ONSET O G SYLLABLE) {

				match(wrd, "^" ONSET O G);
				
			} else if (wrd ~ "^" ONSET O G "[^s]" && wrd ~ "^[^gq]") {

				match(wrd, "^" ONSET O G "[^s]");
				pair = substr(wrd, RSTART, RLENGTH);
				
				match(pair, G "[^s]" "$");
				second = substr(pair, RSTART, RLENGTH);
				first = substr(pair, 1, RSTART - 1);

				match(wrd, "^" first);

			} else if (wrd ~ "^" SYLLABLE ONSET NUCLEUS) {

				match(wrd, "^" SYLLABLE ONSET NUCLEUS);
				pair = substr(wrd, RSTART, RLENGTH);
				
				match(pair, ONSET NUCLEUS "$");
				second = substr(pair, RSTART, RLENGTH);
				first = substr(pair, 1, RSTART - 1);

				match(wrd, "^" first);
				
			} else {
				match(wrd, "^" SYLLABLE);
			}

							
			if (RLENGTH < 0) { err = $i; break; };

			if (buf) { buf = buf "."; }
			buf = buf substr(wrd, RSTART, RLENGTH);
			wrd = substr(wrd, RSTART + RLENGTH);
		}

		# fix consonant clusters
		gsub(/\.rr/, "r.r", buf);
		gsub(/\.ss/, "s.s", buf);
	
		if (err) { print "ERROR: " $i > "/dev/stderr"; }
		else { print buf };
	}
}



