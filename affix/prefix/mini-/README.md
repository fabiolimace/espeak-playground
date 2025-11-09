Prefix mini-
====================

## Generate list

Command used to generate the list of words with transcription:

```bash
grep -Ehi '^mini..' /usr/share/dict/*(brazilian|portuguese) | sort | uniq | awk '{ "espeak-ng -v pt-br --ipa -q " $1 | getline ipa; print $1, ipa }' > ~/mini.a.txt
```
```
miniatura mˌiniʲatˈuɾɐ
miniaturá mˌiniʲˌatuɾˈa
miniaturada mˌiniʲˌatuɾˈadɐ
miniaturadas mˌiniʲˌatuɾˈadɐs
miniaturado mˌiniʲˌatuɾˈadʊ
miniaturados mˌiniʲˌatuɾˈadʊs
miniaturai mˌiniʲˌatuɾˈaɪ
miniaturais mˌiniʲˌatuɾˈaɪs
miniatural mˌiniʲˌatuɾˈaʊ
miniaturam mˌiniʲatˈuɾɐ̃ʊ̃
```

