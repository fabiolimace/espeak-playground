#!/bin/bash

#
# A scritp that says a list of words, until you answer good or not for each one of them.
#
# The answers are logged into a file called `espeak-ng-say-list.log`.
#
# Usage:
#
#     espeak-ng-say-list.sh LIST [VOICE]
#
#     y or Y: the word has a good pronunciation
#     n or N: the word has a bad pronunciation
#     ENTER: speak the word again
#     CTRL+C: stop program
#
# The default voice is `pt-br`
# 

list=$1
voice=${2-pt-br}
output=espeak-ng-say-list.log

[ -f "${list}" ] || exit 1;

for word in $(cat "${list}"); do
    while true;
	do
		echo --------------------------------
		espeak-ng -v $voice "$word" -X;
		espeak-ng -q -v $voice "$word" --ipa;
		echo
		read -n 1 -p "Is it good? [y/n]: " option
		
		case $option in
		  [yY] )
			echo -e "$word\t$(espeak-ng -q -v $voice "$word" -x)\t$(espeak-ng -q -v $voice "$word" --ipa)\tGOOD" >> $output;
			echo; break
			;;
		  [nN] )
			echo -e "$word\t$(espeak-ng -q -v $voice "$word" -x)\t$(espeak-ng -q -v $voice "$word" --ipa)\tBAD" >> $output;
			echo; break
			;;
		  *)
		  	continue;
			;;
		esac
	done;
done

echo --------------------------------
echo "cat \"$output\"";
cat "$output";
