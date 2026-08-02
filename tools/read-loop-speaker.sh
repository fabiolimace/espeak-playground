#!/bin/bash

#
# Read and speak from standard input line by line.
#
# It also prints each line with its respective number and phonetic representation.
#
# These parameters can be used to paginate the reading:
# 1. SIZE: the number of lines to be read, i.e. the page size;
# 2. PAGE: the page number.
#
# Usage:
#
#     cat list-of-words.txt | ./read-loop-speaker.sh      # read all words
#     cat list-of-words.txt | ./read-loop-speaker.sh 10 2 # read the second page of 10 words each (from 11th to 20th line)
#     cat list-of-words.txt | ./read-loop-speaker.sh 50 3 # read the third page of 50 words each (from 101th to 150th line)
#


SIZE=${1:-2147483647} # 2^31-1 (safe limit)
PAGE=${2:-1}

MAX=$(expr $PAGE \* $SIZE)
i=$(expr $MAX \- $SIZE)

awk '/[^ \t]/' | head -n $MAX | tail -n $SIZE | \
while read line; do i=$(expr $i \+ 1); echo; echo $i; echo $line; espeak-ng --ipa -v pt-br $line; done;

