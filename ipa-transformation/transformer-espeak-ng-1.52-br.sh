#!/bin/bash

#
# Transform the phonetic transcription from eSpeak NG 1.53
# into the phonetic transcription used in eSpeak NG 1.52.
#
# To be used with the voice pt-BR.
#
# Usage:
#
#     espeak-ng -q -v pt-br --ipa "Isto é um teste." | ./transformer-espeak-ng-1.52-br.sh
#

sed -E -f <(cat <<-EOL

s/ɐ̃[nŋ]/ɐ̃ŋ/g;  # FIXME: granizo ɡrˌænˈizʊ
s/ẽ[nŋ]/eɪŋ/g;
s/ĩ[nŋ]/iŋ/g;
s/õ[nŋ]/oŋ/g;
s/ũ[nŋ]/ũŋ/g;

s/ɐ̃m/ɐ̃m/g;
s/ẽm/eɪm/g;
s/ĩm/im/g;
s/õm/om/g;
#s/ũm/ũm/g;

s/aʊ([ ]|$)/aw\1/g;
s/iʊ([ ]|$)/iw\1/g;
s/oʊ/ow/g;
s/ɔʊ/ow/g;
s/uʊ/uw/g;

s/ʎ/lj/g;  # ilha
s/õɪ̃/õj/g; # leões
s/ɐ̃j/ɐ̃y/g; # mães

s/ɐ([ ]|$)/æ\1/g;
s/ɪ([ ]|$)/y\1/g;

s/ɪ([ ][ˈˌ]?[aɐæəɑeɛiɪɨoɔuʊ])/j\1/g;
s/ʊ([ ][ˈˌ]?[aɐæəɑeɛiɪɨoɔuʊ])/w\1/g;

s/([ˈˌ]?[aɐæəɑeɛiɪɨoɔuʊ])ɾ\>/\1ɹ/g
s/([^aɐæəɑeɛiɪɨoɔuʊ])ɾ([ˈˌ]?[aɐæəɑeɛiɪɨoɔuʊ])/\1R\2/g # FIXME
s/([ˈˌ]?[aɐæəɑeɛiɪɨoɔuʊ])ɾ([^aɐæəɑeɛiɪɨoɔuʊ])/\1R\2/g # FIXME

EOL
)

