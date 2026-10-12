#!/bin/bash

#
# Transform the phonetic transcription from eSpeak NG into the
# phonetic transcription used in the Grande Dicionário da Língua
# Portuguesa, published by Porto Editora.
#

sed -E -f <(cat <<-EOL

# TODO: properly normalize nasals
s/ã/ã/g;
s/ẽ/ẽ/g;
s/ĩ/ĩ/g;
s/õ/õ/g;
s/ũ/ũ/g;

s/ãɪ̃/ãj̃/g;
s/ɐ̃ɪ̃/ɐ̃j̃/g;
s/ẽɪ̃/ẽj̃/g;
s/ĩɪ̃/ĩj̃/g;
s/ɪ̃ɪ̃/ɪ̃j̃/g;
s/õɪ̃/õj̃/g;
s/ũɪ̃/ũj̃/g;
s/ʊ̃ɪ̃/ʊ̃j̃/g;
	
s/ãʊ̃/ãw̃/g;
s/ɐ̃ʊ̃/ɐ̃w̃/g;
s/ẽʊ̃/ẽw̃/g;
s/ĩʊ̃/ĩw̃/g;
s/ɪ̃ʊ̃/ɪ̃w̃/g;
s/õʊ̃/õw̃/g;
s/ũʊ̃/ũw̃/g;
s/ʊ̃ʊ̃/ʊ̃w̃/g;

s/aɪ/aj/g;
s/ɐɪ/ɐj/g;
s/əɪ/əj/g;
s/ɑɪ/ɑj/g;
s/eɪ/ej/g;
s/ɛɪ/ɛj/g;
s/iɪ/ij/g;
s/ɪɪ/ɪj/g;
s/ɨɪ/ɨj/g;
s/oɪ/oj/g;
s/ɔɪ/ɔj/g;
s/uɪ/uj/g;
s/ʊɪ/ʊj/g;

s/aʊ/aw/g;
s/ɐʊ/ɐw/g;
s/əʊ/əw/g;
s/ɑʊ/ɑw/g;
s/eʊ/ew/g;
s/ɛʊ/ɛw/g;
s/iʊ/iw/g;
s/ɪʊ/ɪw/g;
s/ɨʊ/ɨw/g;
s/oʊ/ow/g;
s/ɔʊ/ɔw/g;
s/uʊ/uw/g;
s/ʊʊ/ʊw/g;

s/([^aɐəɑeɛiɪɨoɔuʊˈˌɾlɫw][ɾlɫw]?)([ˈˌ])([aɐəɑeɛiɪɨoɔuʊ])/\2\1\3/g;

s/(ã|ɐ̃|ẽ|ĩ|ɪ̃|õ|ũ|ũ)[nŋm]([^aɐəɑeɛiɪɨoɔuʊ])/\1\2/g;

s/ʊ/u/g;
s/x/ʀ/g;
s/ʁ/ʀ/g;
s/ɾ/r/g;

s/ɫ/ł/g; # different bytes
s/ʃ/∫/g; # different bytes
s/ɛ/ε/g; # different bytes
s/ɡ/g/g; # different bytes

#s/ˌ//g; # remove 2nd accent

EOL
)

