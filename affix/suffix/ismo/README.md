Suffix -ismo
====================

## Generate list

Command used to generate the list of words with transcription:

```bash
grep -Ehi '..ismo$' /usr/share/dict/*(brazilian|portuguese) | sort | uniq | awk '{ "espeak-ng -v pt-br --ipa -q " $1 | getline ipa; print $1, ipa }' > ~/ismo.a.txt
```
```
abismo ˌabˈizmʊ
abolicionismo ˌabolˌisjonˈizmʊ
absentismo ˌabseɪntʃˈizmʊ
absolutismo ˌabsolutʃˈizmʊ
abstencionismo ˌabsteɪnsjonˈizmʊ
abstracionismo ˌabstɾasjonˈizmʊ
abstratismo ˌabstɾatʃˈizmʊ
absurdismo ˌabsuɾdʒˈizmʊ
academicismo ˌakadˌemisˈizmʊ
academismo ˌakademˈizmʊ
```

## Issues after the creation of "-ismo"

Words in `pt_list` such as "bud" can cause wrong pronunciation, for example, budismo is pronunced as [[b&dismu]]. To avoid this behaviour, use `$only` so that "bud" can never be used with a suffix.

The word "Bach" have two pronunciation: [[bax]] alone and [[bak]] with a suffix. To separate both uses, the first is marked with `$only` and the second with `$stem`.

