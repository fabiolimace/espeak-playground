#!/usr/bin/mawk -f

# 
# Generates a phonetic transcription of a text.
# 
# Usage
#
# 	# output: a.vi.'a~ʊ 'bɔ.lə 'ka.zə
#	echo "a.vi.ão bo.la ca.sa" | awk -f transcribe.awk
#

BEGIN {

	DOT=".";
	EMPTY="";
	TAB="\t";
	SPACE=" ";
	PERCENT="%";
	UNDERLINE="_";
	APOSTROPHE="'";
	
	RULES_F1[0] = null;
	RULES_F2[0] = null;
	RULES_F3[0] = null;
	RULES_F4[0] = null;
	RULES_INDEX[0] = null;
	RULES_STRESS[0] = null;
	RULES_BOUNDARY[0] = null;
	
	STRESS_LEFT = 1
	STRESS_RIGHT = -1;
	
	BOUNDARY_LEFT_1 = 1
	BOUNDARY_LEFT_2 = 2
	BOUNDARY_RIGHT_1 = -1;
	BOUNDARY_RIGHT_2 = -2;

	ALPHABET_IPA[0] = null; # 1: IPA
	ALPHABET_KIR[0] = null; # 2: Kirshembaum
	ALPHABET_SAM[0] = null; # 3: X-SAMPA
	
	SYLLABLE_PENULTIMATE=-2;
	SYLLABLE_ULTIMATE=-1;
	
	if (!ALPHABET) ALPHABET = 1 # IPA
	if (!RULES_FILE) RULES_FILE = "./transcriber-rules.tsv";
	if (!STRESSED_SYLLABLE) STRESSED_SYLLABLE = SYLLABLE_PENULTIMATE;
	
	load_alphabets();
	
	read_rules_file(RULES_FILE);
}

function load_alphabets(    i, s, k) {

	# the `sam` (X-SAMPA) string must be escaped so it is treated as fixed text in the 1st parameter of `gsub()`
	sam = "h\\\\  r\\\\ L  J  a~ e~ i~ o~ u~ a @ b d e E f g gw h i I j Z k kw l m n o O p 4 R s S t u U v w x G z";
	kir = "h<?>   r.    l^ n^ a~ e~ i~ o~ u~ a @ b d e E f g gw h i I j Z k kw l m n o O p * R s S t u U v w x Q z";
	ipa = "ɦ      ɹ     ʎ  ɲ  ã  ẽ  ı͂  õ  u͂  a ə b d e ɛ f g gw h i ɪ j ʒ k kw l m n o ɔ p ɾ ř s ʃ t u ʊ v w x ɣ z";

	split(sam, ALPHABET_SAM);
	split(kir, ALPHABET_KIR);
	split(ipa, ALPHABET_IPA);
}

function read_rules_file(file,    n, r, F) {

	if (system("test -f " file) != 0) error("file not found: '" file "'.");
	
	while(getline rule < file) {
		r++; # the line number is the rule key
		
		# remove all commented content
		sub(/[ \t]*(\/\/.*)?$/, EMPTY, rule);

		# separate rule fields
		n = split(rule, F, TAB);
		
		# ignore if not four
		if (n != 4) continue;
		
		# put rule fields
		RULES_F1[r]=F[1];
		RULES_F2[r]=F[2];
		RULES_F3[r]=F[3];
		RULES_F4[r]=F[4];
		translate_f4(r);

		# find stress side
		RULES_STRESS[r] = 0;
		if (F[1] ~ PERCENT) RULES_STRESS[r] = STRESS_LEFT;
		if (F[3] ~ PERCENT) RULES_STRESS[r] = STRESS_RIGHT;
		
		# find boundary side
		RULES_BOUNDARY[r] = 0;
		if (F[1] ~ "^" UNDERLINE "$") RULES_BOUNDARY[r] = BOUNDARY_LEFT_1;
		if (F[1] ~ "^" UNDERLINE ".+$") RULES_BOUNDARY[r] = BOUNDARY_LEFT_2;
		if (F[3] ~ "^" UNDERLINE "$") RULES_BOUNDARY[r] = BOUNDARY_RIGHT_1;
		if (F[3] ~ "^.+" UNDERLINE "$") RULES_BOUNDARY[r] = BOUNDARY_RIGHT_2;
		
		gsub("[" PERCENT UNDERLINE "]", EMPTY, RULES_F1[r]);
		gsub("[" PERCENT UNDERLINE "]", EMPTY, RULES_F3[r]);
		
		# put the rule line number in tab-split list
		RULES_INDEX[F[2]] = RULES_INDEX[F[2]] TAB r;
	}
}

function translate_f4(rule,    i) {
	if (ALPHABET == 3) return;
	for (i in ALPHABET_SAM) {
		if (ALPHABET == 1) gsub(ALPHABET_SAM[i], ALPHABET_IPA[i], RULES_F4[rule]);
		if (ALPHABET == 2) gsub(ALPHABET_SAM[i], ALPHABET_KIR[i], RULES_F4[rule]);
	}
}

function error(msg) {
	print "ERROR: " msg > "/dev/stderr";
	# exit 1;
}

function stress_side(syllable_position, stress_position) {
	if (stress_position && stress_position < syllable_position) return  STRESS_LEFT;
	if (stress_position && syllable_position < stress_position) return STRESS_RIGHT;
	return 0;
}

function boundary_side(syllable_position, word_syllables) {
	if (syllable_position == 1) return BOUNDARY_LEFT_1;
	if (syllable_position + 0 == word_syllables) return BOUNDARY_RIGHT_1;
	if (word_syllables > 2) {
		if (syllable_position == 2) return BOUNDARY_LEFT_2;
		if (syllable_position + 1 == word_syllables) return BOUNDARY_RIGHT_2;
	}
	return 0;
}


# TODO: se `^` e `$` não forem incluídos, colocá-los em F1, F2 e F3.
# TEST VECTOR: a.ba.da á.ba.da a.ba.dá a.dão á.dão a.dam á.dam a.dan á.dan
function test_match(pre, syl, pos, rule, stress, boundary) {

	f1 = RULES_F1[rule];
	f2 = RULES_F2[rule];
	f3 = RULES_F3[rule];
	f4 = RULES_F4[rule];
	fs = RULES_STRESS[rule];
	fb = RULES_BOUNDARY[rule];
	
	if (fs && fs != stress) return null;
	if (fb && fb != boundary) return null;
	
	if ((pre ~ f1) && (syl ~ f2) && (pos ~ f3)) return f4;

	return null;
}

function find_match(pre, syl, pos, stress, boundary,   i, n, rule, numbers, matched) {

	if (!(syl in RULES_INDEX)) {
		return null;
	}
	
	n = split(RULES_INDEX[syl], numbers);
	for (i = n; i > 0; i--) {
		rule = numbers[i];
		matched = test_match(pre, syl, pos, rule, stress, boundary);
		if (matched) return matched;
	}
	
	return null;
}

function transcribe_word(word,    i, s, b, x, n, syl, pre, pos, found, array, stress, result, syllables) {

	stress = 0;
	
	n = split(word, syllables, DOT);
	
	for (i = 1; i <= n; i++) {
	
		syl = syllables[i];
		if (i == 1) pre = EMPTY; else pre = syllables[i-1];
		if (i == n) pos = EMPTY; else pos = syllables[i+1];
		
		s = stress_side(i, stress);
		b = boundary_side(i, n);

		found = find_match(pre, syl, pos, s, b);
		
		if (found ~ APOSTROPHE) {
			if (!stress) stress = i; else continue;
		}
		
		array[i] = found;
	}
	
	# check all syllables
	for (i = 1; i <= n; i++) {
		if (!array[i]) {
			error("Match not found for syllable " i " in '" word "'.");
			return null;
		}
	}
	
	if (!stress) {
		# set the default stress
		if (STRESSED_SYLLABLE < 0) {
			x  = n + 1 + STRESSED_SYLLABLE;
			if (array[x] !~ APOSTROPHE) array[x] = APOSTROPHE array[x];
		} else {
			x  = STRESSED_SYLLABLE;
			if (array[x] !~ APOSTROPHE) array[x] = APOSTROPHE array[x];
		}
	}
	
	# join all syllables
	for (i = 1; i <= n; i++) {
		if (result) result = result DOT;
		result = result array[i];
	}
	
	return result;
}

{
	buffer = EMPTY;
	for (i = 1; i <= NF; i++) {
		if (buffer) buffer = buffer SPACE;
		buffer = buffer transcribe_word($i);
	}
	
	print buffer;
}

END {

}

