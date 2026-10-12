#!/bin/bash

#
# Transform the phonetic transcription from eSpeak NG into the
# phonetic transcription used in the Grande Dicionário da Língua
# Portuguesa, published by Porto Editora.
#
# Note: the first stress mark keeps next to the vowel.
#

sed -E -f <(cat <<-EOL

s/([ɐ̃ẽĩɪ̃õũʊ̃])[nŋm]([^aɐəɑeɛiɪɨoɔuʊ])/\1\2/g;

s/([ɐ̃ẽĩɪ̃õũʊ̃])ɪ̃/\1j̃/g;
s/([ɐ̃ẽĩɪ̃õũʊ̃])ʊ̃/\1w̃/g;

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

s/ʊ/u/g;
s/x/ʀ/g;
s/ʁ/ʀ/g;
s/ɾ/r/g;

s/ɫ/ł/g; # different bytes
s/ʃ/∫/g; # different bytes
s/ɛ/ε/g; # different bytes
s/ɡ/g/g; # different bytes

s/ˌ//g;  # remove 2nd accent

EOL
)

