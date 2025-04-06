#!/usr/bin/gawk -f

# Counts how many times each espeak-ng rule is used.
#
# First, you must compile with debug option, so that line numbers are printed with the rules.
#
#     sudo espeak-ng --compile-debug=pt-br
#
# Usage:
#
#     cat list_of_words.txt | espeak-ng -q -v pt-br -X | gawk -f ./count_used_rules.awk > list_of_used_rules.count.txt
#
#     cat list_of_words.txt | espeak-ng -q -v pt-br -X | gawk -f ./count_used_rules.awk \
#         | tr -s "\t" " " | awk '{ $1 = ""; print $0; }' | sed -E "s/(\?[!]?[0-9])[ ]+//" \
#         | sed -E "s/^[ ]+//;s/[ ]+$//" | sort > list_of_used_rules.txt
#

BEGIN {
}

/^Translate/ {
    sub(/Translate/,"")
    word=$0;
    next;
}

/^$/ && rule {
    rule = "";
    # sort the candidates by score
    n = asorti(candidates, scores);
    # the winner has highest score
    winner = candidates[scores[n]];
    rules[winner]++;
	for (i in candidates) delete candidates[i];
    if (!examples[winner]) {
        examples[winner] = word;
    };
}

$1 ~ /[0-9]+/ {
	
	sub(/:/,"",$2);
	
	# format the score value to 6 digits
	score = sprintf("%6d", $1); $1 = "";
	# format the line number to 6 digits and remove ":"
	line = sprintf("%6d", $2); $2 = "";
	
	# squash spaces and tabs
	gsub(/[ \t]+/," ", $0);
	# trim the spaces
	sub(/^[ ]/,"", $0);
	sub(/[ ]$/,"", $0);
	
	rule = line "\t" $0;
	candidates[score] = rule;
}

END {
	for (i in rules) print rules[i] "\t" i "\t" examples[i];
}

