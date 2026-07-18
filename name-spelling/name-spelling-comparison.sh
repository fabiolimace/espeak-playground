#!/bin/bash

NAME1=$1
VOICE=${2:-pt-br}

DIR=$(dirname "$0")

PRON1=$(espeak-ng --ipa -q -v $VOICE $NAME1)

"$DIR"/name-spelling-modifier.sh $NAME1 | while read NAME2; do
	PRON2=$(espeak-ng --ipa -q -v $VOICE $NAME2)
	PRON3=$(espeak-ng --ipa -q -v $VOICE $NAME2 | sed -E 's/([^ˈ])i$/\1ɪ/')
	[ "$PRON1" == "$PRON2" ] && EQUAL=EQ || EQUAL=NE
	[ "$EQUAL" == "NE" ] && [ "$PRON1" == "$PRON3" ] && EQUAL=OK
	echo -e "$NAME1\t$NAME2\t$PRON1\t$PRON2\t$EQUAL"
done;


