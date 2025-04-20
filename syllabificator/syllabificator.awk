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
# This script puts <ss> and <rr> in the same syllable, for simplicity of the transcriber rules.
#
# If you need separate <ss> and <rr> in different syllables, use the flag `-v ORTHOGRAPHICALLY_CORRECT=1`.
#
# If you are looking for a syllabificator for another other language, this script will probably fail miserably.
#
# Although this script splits a few words wrongly, such as "continuidade" and "intuição," its success rate far outweighs its failures.
#

BEGIN {
	
	C = "[bcdfghjklmnpqrstvwxyzç]"   # consonants
	D = "rr|ss|ch|nh|lh|qu|gu|qü|gü" # digraphs
	E = "[bcdfgkptv][rl]"            # clusters
	F = "[bgjkptswz][h]"             # ph, sh, th, wh...
	
	O = "[" "aeiou" "àáâã" "èéê" "ìí" "òóôõ" "ùúü" "wy" "]"
	G = "[" "iu" "yw" "]"
	N = "[" "ãõ" "]"
	H = "[" "eo" "]"
	
	# The onset can be a single consonant (C), or a common pair of letters known
	# as digraph (D), or a cluster formed of a consonant followed by the letters
	# `r` or `l` (E), or cluster of a consonant followed by the letter `h` (F).
	
	ONSET = "(" C "|" D "|" E "|" F ")"
	
	# The nucleous may be a single vowel (O), or a vowel followed
	# by a glide (OG), or a nasal voewel followed by a glide (NH).
	
	NUCLEUS = "(" O "|" O G "|" N H ")"
	
	# In Portuguese, only /L/, /N/, /S/, /R/ arquiphonemes can be in coda position,
	# but here we allow for any combination of consonants in the end of a syllable.
	
	CODA = "(" C "+" ")"
	
	RHYME = NUCLEUS CODA "?"
	
	SYLLABLE = ONSET "?" RHYME
	
}

{
	for (i = 1; i <= NF; i++) {

		wrd = $i;
		buf = "";
		err = "";

		wrd = tolower(wrd);
		
		while (wrd) {

			if (wrd ~ "^" ONSET O G SYLLABLE) {
			
				# This `if` joins a vowel with its neighbour semivowel,
				# forming a diththong, and off course it's not perfect.

				match(wrd, "^" ONSET O G);
				
			} else if (wrd ~ "^" ONSET O G "[^s]" && wrd ~ "^[^gq]") {
			
				# This `if` tries create hiatus in the right place,
				# but it often fails due to reasons related to word
				# semantics and morphology, for example "dei.da.de"
				# has a semantic radical that forces the diphthong.
				# In contrast, "con.ti.nu.i.da.de" must have hiatus
				# due to it's morphology: con.ti.nu.ar plus i.da.de.

				match(wrd, "^" ONSET O G "[^s]");
				pair = substr(wrd, RSTART, RLENGTH);
				
				match(pair, G "[^s]" "$");
				second = substr(pair, RSTART, RLENGTH);
				first = substr(pair, 1, RSTART - 1);

				match(wrd, "^" first);

			} else if (wrd ~ "^" SYLLABLE ONSET NUCLEUS) {

				# This `if` block sets a line between coda and onset
				# in words with complex coda, like "pers.pec.ti.va".
				# It's impossible to figure out where the conda ends
				# without looking ahead at the next sillable's onset.

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

		if (ORTHOGRAPHICALLY_CORRECT) {
			gsub(/\.rr/, "r.r", buf);
			gsub(/\.ss/, "s.s", buf);
		}
	
		if (err) { print "ERROR: " $i > "/dev/stderr"; }
		else { print buf };
	}
}



