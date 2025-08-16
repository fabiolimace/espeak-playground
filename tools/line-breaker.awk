#!/usr/bin/awk

#
# Breaks lines greater than a certain number of characters.
#
# It is useful for software that has a limit of characters per line, for example, `espeak-ng` v1.51.
#
# In `espeak-ng` when the limit is trespassed, the phrase pronunciation is interrupted, sometimes in the middle of a word.
#
# This script tries to break the line in the most convenient place for `espeak-ng`, which is in the end of a phrase.
#
# Usage:
#
#     awk -f line-breaker.awk input.txt
#
# Use the parameter MAX_LENGTH to set the maximum number of characters per line. The default is 1000, the same as in espeak-ng.
#
# Repository: https://github.com/fabiolimace/awk-tools/
#

BEGIN {
	MAX = (MAX_LENGTH ? MAX_LENGTH : 1000);
}

function break_line(MAX,    LINE) {

	LINE=$0;
	
	gsub(/^[ ]+/, "", LINE);
	gsub(/[ ]+$/, "", LINE);

	while (length(LINE) > MAX)  {
	
		match(substr(LINE, 0, MAX), /^.*[.!?]/);
		if (!RSTART) match(substr(LINE, 0, MAX), /^.*[,;:]/);
		if (!RSTART) match(substr(LINE, 0, MAX), /^.*[ ]/);
		if (!RSTART) break;
		
		print substr(LINE, RSTART, RLENGTH);
		LINE = substr(LINE, RLENGTH + 1);
		gsub(/^[ ]+/, "", LINE);
	}
	
	print LINE;
}

{
	break_line(MAX);
}

