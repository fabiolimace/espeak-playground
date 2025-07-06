#!/usr/bin/awk -f

# 
# Sort file, except its header.
#
# Use `-v SORT_ARGS=` to pass arguments to `sort`.
#
# Usage:
#
#     awk -f sort-except-header.awk input.txt > output.txt
#     awk -v SORT_ARGS="-n" -f sort-except-header.awk input.txt > output.txt
#
# Reference: https://unix.stackexchange.com/questions/11856/
#

NR == 1; NR > 1 {print $0 | "sort " SORT_ARGS}

