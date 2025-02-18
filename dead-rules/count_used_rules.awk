#!/usr/bin/gawk -f

# Counts how many times each espeak-ng rule is used.
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

/^$/ {
	n = asorti(lines, indexes);
	rule = lines[indexes[n]];
	rules[rule]++;
	for (i in lines) delete lines[i];
}

$1 ~ /[0-9]+/ {
	number = $1
	sub(number, "");
	# format the number to 4 digits
	number = sprintf("%4d", number);
	# remove the square quotes: `[kir]`
	$NF = substr($NF, 2, length($NF) - 2);
	lines[number] = $0;
}

END {
	for (i in rules) print rules[i], i;
}

