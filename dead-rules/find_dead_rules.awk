#!/usr/bin/gawk -f

# Finds the rules that are not used (dead rules) by espeak-ng.
#
# Usage:
#
#     gawk -f ./find_dead_rules.awk -v ALL_RULES_FILE="rules/list_of_all_rules.txt" rules/list_of_used_rules.txt
#

BEGIN {
    minimum = 1;
    if (MINIMUM) minimum = MINIMUM;
}

{
    line = $2;
    count = $1;
    used[line] = count;
}

END {
    while(getline rule < ALL_RULES_FILE) {
        split(rule, arr);
        line = arr[1];
        
        if (used[line] >= minimum) continue;
        else print rule;
    }
}
