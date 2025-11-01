Suffix -ista
====================

## Generate list

Command used to generate the list of words with transcription:

```bash
grep -Ehi '..ista$' /usr/share/dict/*(brazilian|portuguese) | sort | uniq | awk '{ "espeak-ng -v pt-br --ipa -q " $1 | getline ipa; print $1, ipa }' > ~/ista.a.txt
```
```
abolicionista ˌabolˌisjonˈistɐ
absentista ˌabseɪntʃˈistɐ
absolutista ˌabsolutʃˈistɐ
abstencionista ˌabsteɪnsjonˈistɐ
abstracionista ˌabstɾasjonˈistɐ
academista ˌakademˈistɐ
acionista ˌasjonˈistɐ
acordeonista ˌakoɾdˌeonˈistɐ
aderecista ˌadeɾesˈistɐ
administrativista ˌadminˌistɾatʃivˈistɐ
```

## Issues after the creation of "-ista"

Words in `pt_list` such as "pet" can cause wrong pronunciation, for example, "petismo" is pronunced as [[pEt'ismU]]. To avoid this behaviour, use `$only` so that "pet" can never be used with a suffix.
