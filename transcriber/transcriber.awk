#!/usr/bin/mawk -f

# 
# Generates a phonetic transcription of a text.
# 
# Usage
#
# 	# output: ə.vɪ.'ə~ʊ~ 'bɔ.lə 'kə.za
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
	
	POS_TONIC = 1
	PRE_TONIC = 2;

	ALPHABET_IPA[0] = null; # 1: IPA
	ALPHABET_KIR[0] = null; # 2: Kirshembaum
	ALPHABET_SAM[0] = null; # 3: X-SAMPA

	if (!ALPHABET) ALPHABET = 1 # IPA
	if (!STRESSED_SYLLABLE) STRESSED_SYLLABLE = -2; # Penultimate
	if (!RULES_FILE) RULES_FILE = "./transcriber-rules.tsv";
	
	load_alphabets();
	
	read_rules_file(RULES_FILE);
}

function load_alphabets(    i, s, k) {

	i = "ɦ          ɹ           ʎ   ɲ  ã  ẽ  ı͂  õ  u͂  a ə b d e ɛ f g gw h i ɪ  j ʒ k kw l m n o ɔ p ɾ ř s ʃ  t u ʊ v w x ɣ z";
	k = "h<?>  r.    l^ n^ a~ e~ i~ o~ u~ a @ b d e E f g gw h i I j Z k kw l m n o O p * R s S t u U v w x Q z";
	s = "h\\\\ r\\\\ L  J  a~ e~ i~ o~ u~ a @ b d e E f g gw h i I j Z k kw l m n o O p 4 R s S t u U v w x G z";
	
	split(i, ALPHABET_IPA);
	split(k, ALPHABET_KIR);
	split(s, ALPHABET_SAM);
}

function read_rules_file(file,    n, r, F) {

	if (system("test -f " file) != 0) error("file not found: '" file "'.");
	
	while(getline rule < file) {
		r++; # the line number is the rule key
			
		# remove commented content
		sub(/\/\/.*$/, EMPTY, rule);

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
		
		# put the rule line number in tab-split list
		RULES_INDEX[F[2]] = RULES_INDEX[F[2]] TAB r;
	}
}

function translate_f4(rule,    i, before) {
	before = RULES_F4[rule];
	if (ALPHABET == 3) return;
	for (i in ALPHABET_SAM) {
		if (ALPHABET == 1) gsub(ALPHABET_SAM[i], ALPHABET_IPA[i], RULES_F4[rule]);
		if (ALPHABET == 2) gsub(ALPHABET_SAM[i], ALPHABET_KIR[i], RULES_F4[rule]);
	}
	# for debug
	# if (before != RULES_F4[rule]) print "\n" before "\t" RULES_F4[rule];
}

function error(msg) {
	print "ERROR: " msg > "/dev/stderr";
	exit 1;
}

function test_match(pre, syl, pos, rule, stress) {
	
	if (stress == POS_TONIC && RULES_F1[rule] ~ PERCENT) pre = PERCENT;
	if (stress == PRE_TONIC && RULES_F3[rule] ~ PERCENT) pos = PERCENT;
	
	if (RULES_F1[rule] && pre !~ RULES_F1[rule]) return null;
	if (RULES_F2[rule] && syl !~ RULES_F2[rule]) return null;
	if (RULES_F3[rule] && pos !~ RULES_F3[rule]) return null;

	return RULES_F4[rule];
}

function find_match(pre, syl, pos, stress,    i, n, rule, numbers, matched) {

	if (!(syl in RULES_INDEX)) {
		return null;
	}
	
	n = split(RULES_INDEX[syl], numbers, TAB);
	for (i = n; i > 0; i--) {
		rule = numbers[i];
		matched = test_match(pre, syl, pos, rule, stress);
		if (matched) return matched;
	}
	
	return null;
}

function transcribe_word(word,    i, x, n, syl, pre, pos, found, array, stress, result, syllables) {

	n = split(word, syllables, DOT);
	
	# 1nd pass (forwards):
	# for post-tonic syllables
	for (i = 1; i <= n; i++) {
	
		syl = syllables[i];
		if (i == 1) pre = UNDERLINE; else pre = syllables[i-1];
		if (i == n) pos = UNDERLINE; else pos = syllables[i+1];

		found = find_match(pre, syl, pos, stress);
		
		if (found ~ APOSTROPHE) stress = POS_TONIC;
		
		array[i] = found;
	}
	
	# 2nd pass (backwards):
	# for pre-tonic syllables
	for (i = n; i >= 1; i--) {
	
		if (array[i]) { continue };
	
		syl = syllables[i];
		if (i == 1) pre = UNDERLINE; else pre = syllables[i-1];
		if (i == n) pos = UNDERLINE; else pos = syllables[i+1];

		found = find_match(pre, syl, pos, stress);
		
		if (found ~ APOSTROPHE) stress = PRE_TONIC;
		
		array[i] = found;
	}
	
	if (!stress) {
		if (STRESSED_SYLLABLE < 0) {
			x  = n + 1 + STRESSED_SYLLABLE;
			array[x] = APOSTROPHE array[x];
		} else {
			x  = STRESSED_SYLLABLE;
			array[x] = APOSTROPHE array[x];
		}
	}
	
	for (i = 1; i <= n; i++) {
		if (!array[i]) {
			error("Match not found for '" syl "' in '" word "'.");
			return null;
		}
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

