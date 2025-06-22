#!/usr/bin/gawk -f

#
# This script counts words, calculating absolute frequency, and relative frequency.
# 
# It produces an TSV file with the following fields:
# 
#  1. TOKEN: the token, i.e. a "word".
#  2. COUNT: the token's absolute frequency, i.e. the number of occurrences of a token.
#  3. RATIO: the token's relative frequency, i.e. the number of occurrences of a token divided by the total number of tokens.
#
# Usage:
#
#     gawk -f word-counter.awk input.txt > output.txt
#     gawk -f word-spacer.awk input.txt | gawk -f word-counter.awk - > output.txt
#
# This script only works with GNU's Awk (gawk).
#

function insert(token) {
    total++;
    counters[token]++;
}

{
    for (i = 1; i <= NF; i++) {
		insert($i);
    }
    insert("\\n");
}

END {

    print "TOKEN\tCOUNT\tRATIO";
    
    for (token in counters) {
        count = counters[token];
        ratio = counters[token] / total;
        printf "%s\t%d\t%.9f\n", token, count, ratio;
    }
}

