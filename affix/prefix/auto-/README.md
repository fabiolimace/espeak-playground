Prefix auto-
====================

## Generate list

Command used to generate the list of words with transcription:

```bash
grep -Ehi '^auto..' /usr/share/dict/*(brazilian|portuguese) | sort | uniq | awk '{ "espeak-ng -v pt-br --ipa -q " $1 | getline ipa; print $1, ipa }' > ~/auto.a.txt
```
```
autoajuda ˌaʊtoaʒˈudɐ
autoaprendizagem ˌaʊtoˌapɾeɪndʒizˈaʒeɪm
autoavaliação ˌaʊtoˌavalˌiʲasˈɐ̃ʊ̃
autoavaliações ˌaʊtoˌavalˌiʲasˈõɪ̃s
autoavaliar ˌaʊtoˌavaliʲˈaɾ
autobiografia ˌaʊtobˌiʲoɡɾafˈiʲɐ
autobiografias ˌaʊtobˌiʲoɡɾafˈiʲɐs
autobiográfica ˌaʊtobˌiʲoɡɾˈafikɐ
autobiográficas ˌaʊtobˌiʲoɡɾˈafikɐs
autobiográfico ˌaʊtobˌiʲoɡɾˈafikʊ
```

