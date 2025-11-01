Suffix -iano
====================

## Generate list

Command used to generate the list of words with transcription:

```bash
grep -Ehi '....iano$' /usr/share/dict/*(brazilian|portuguese) | sort | uniq | awk '{ "espeak-ng -v pt-br --ipa -q " $1 | getline ipa; print $1, ipa }'
```
```
abeliano ˌabeliˈɐ̃nʊ
açoriano ˌasoɾiˈɐ̃nʊ
agostiniano ˌaɡostʃˌiniˈɐ̃nʊ
alsaciano ˌaʊsasiˈɐ̃nʊ
ambrosiano ˌɐ̃mbɾoziˈɐ̃nʊ
antoniano ˌɐ̃ntoniˈɐ̃nʊ
apalaciano ˌapalˌasiˈɐ̃nʊ
arcadiano ˌaɾkadʒiˈɐ̃nʊ
artesiano ˌaɾteziˈɐ̃nʊ
asturiano ˌastuɾiˈɐ̃nʊ
```

## Issues after the creation of "-iano"

Words in `pt_list` marked with `$1..$7` have two stresses. E.g. "Martin" is marked with $1 in `pt_list`, so "martiniano" is pronunced as \[mˈaɾtʃˌɪniˈɐ̃nʊ\], i.e. with stresses in the 1st and the 4th syllables. To avoid this, don't use flags; use a full phoneme translation of the word.

Words such as "Voltaire" and "Shakespeare" aren't found in `pt_list` to form "voltairiano" and "shakespeariano". Adding `e` to `S4` to form `S4e` doesn't work. So we have to add the steams "voltair" and "shakespear", both without the final "e".


