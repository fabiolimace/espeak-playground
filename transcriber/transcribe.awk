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
	
	rules[0] = null;
	lines[0] = null;
	
	POS_TONIC = 1
	PRE_TONIC = 2;

	if (!ALPHABET) ALPHABET = 1 # 1: IPA, 2: Kirshembaum, 3: X-SAMPA
	if (!STRESSED_SYLLABLE) STRESSED_SYLLABLE = -2; # Penultimate
	if (!RULES_FILE) RULES_FILE = "./transcribe-rules.tsv";
	
	IPA="a ə  ɐ   b d e ɛ f g gw h ɦ     i ɪ j ʒ k kw  l ʎ  m n ɲ  o ɔ p ɾ ř ɹ     s ʃ t u ʊ v w x ɣ z";
	SAM="a @ 6   b d e E f g gw h h\\\\ i I j Z k kw l L  m n J  o O p 4 R r\\\\ s S t u U v w x G z";
	KIR="a @ &\" b d e E f g gw h h<?>  i I j Z k kw l l^ m n n^ o O p * R r.    s S t u U v w x Q z";
	
	load_rules(RULES_FILE);
}

function load_rules(file,    n, r) {
	while(getline rule < file) {
		sub(/\/\/.*$/, EMPTY, rule);
		rules[++r] = rule;
		
		R[0] = null;
		n = split(rule, R, TAB);
		if (n == 4) lines[R[2]] = lines[R[2]] TAB r;
	}
}

function translate_alphabet(buffer,    i, j, trans, fields) {

	split(SAM, sam);
	split(KIR, kir);
	split(IPA, ipa);
	
	if (ALPHABET == 3) return buffer;
	
	for (i in sam) {
		if (ALPHABET == 1) gsub(sam[i], ipa[i], buffer);
		if (ALPHABET == 2) gsub(sam[i], kir[i], buffer);
	}
	
	return buffer;
}

function error(msg) {
	print "ERROR: " msg > "/dev/stderr";
	exit 1;
}

function test_match(pre, syl, pos, rule, stress,   fields) {

	split(rule, fields, TAB);
	
	if (stress == POS_TONIC && fields[1] ~ PERCENT) pre = PERCENT;
	if (stress == PRE_TONIC && fields[3] ~ PERCENT) pos = PERCENT;
	
	if (fields[1] && pre !~ fields[1]) return null;
	if (fields[2] && syl !~ fields[2]) return null;
	if (fields[3] && pos !~ fields[3]) return null;

	return fields[4];
}

function find_match(pre, syl, pos, stress,    i, n, rule, numbers, matched) {

	if (!(syl in lines)) {
		return null;
	}
	
	n = split(lines[syl], numbers, TAB);
	for (i = n; i > 0; i--) {
		matched = test_match(pre, syl, pos, rules[numbers[i]], stress);
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
		
		print syl;

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
	
	print translate_alphabet(buffer);
}

END {
#	for (i in rules) # print i "\t" rules[i];
#	for (i in lines) # print i "\t" lines[i];
}

