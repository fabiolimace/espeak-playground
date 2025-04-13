#!/usr/bin/mawk -f

# 
# Generates a phonetic transcription of a text.
# 
# Usage
#
# 	# output: &.vI.'&~U~ 'bO.l& 'k&.za
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

	if (!STRESSED_SYLLABLE) STRESSED_SYLLABLE = -2; # penultimate
	if (!RULES_FILE) RULES_FILE = "./transcribe-rules.tsv";
	
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
	
	print buffer;
}

END {

#       # translation lists
#	SAM="L  J  OI"; # X-SAMPA
#	KIR="l^ n^ OI"; # Kirshenbaum
#	IPA="ʎ    ɲ    ɔɪ̯"; # IPA
	
#	for (i in rules) # print i "\t" rules[i];
#	for (i in lines) # print i "\t" lines[i];
}

