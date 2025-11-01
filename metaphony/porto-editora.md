Dicionário Porto Editora
============================

Define a dictionary to be used:

```bash
DICTIONARY="PRIVATE/Dicionário Porto Editora da Língua Portuguesa - Porto Editora.txt"
```

List dictionaries entries that contain indication of the rised vowel [ó]:

```bash
grep -E "^[^ ]+ \[ó\]" "${DICTIONARY}" | head
```
```
bola1 [ó] s.f.
cor1 [ó] s.m. ♦ de cor: de memória
corte1 [ó] s.m.
forma1 [ó] s.f.
lobo1 [ó] s.m. parte arredondada e saliente de um órgão
molho1 [ó] s.m. conjunto de coisas agrupadas ♦ pop. tudo ao molho (e fé em Deus):
moto1 [ó] s.f. forma reduzida de motocicleta ♦ moto quatro: veículo de quatro ou mais rodas, próprio para terrenos acidentados
o1 [ó] s.m. décima quinta letra do alfabeto português
soco1 [ó] s.m. calçado com base de madeira • SIN. tamanco
```

Listing the words that should be pronunced by espeak-ng with an [ˈɔ] (open "o"):

```bash
grep -E "^[^ ]+ \[ó\]" "${DICTIONARY}" | awk '{ gsub("[[:punct:]]", "", $1); $1=tolower($1); "espeak-ng -v pt-br --ipa -q " $1 | getline phonemes; print $1, $2, $3, "[" phonemes "]" }' | grep -F 'ˈo'
```
```
cor1 [ó] s.m. [kˈoɾ ˈũm]
lobo1 [ó] s.m. [lˈobw ˈũm]
soco1 [ó] s.m. [sˈokw ˈũm]
```oberto

Listing the words that should be pronunced by espeak-ng with an [ˈo] (closed "o"):

```bash
grep -E "^[^ ]+ \[ô\]" "${DICTIONARY}" | awk '{ gsub("[[:punct:]]", "", $1); $1=tolower($1); "espeak-ng -v pt-br --ipa -q " $1 | getline phonemes; print $1, $2, $3, "[" phonemes "]" }' | grep -F 'ˈɔ'
```
```
bola2 [ô] s.f. [bˈɔlɐ dˈoɪs]
corte2 [ô] ■ [kˈɔɾtʃɪ dˈoɪs]
forma2 [ô] s.f. [fˈɔɾmɐ dˈoɪs]
molho2 [ô] s.m. [mˈɔʎʊ dˈoɪs]
moto2 [ô] s.m. [mˈɔtʊ dˈoɪs]
```

Listing the words that should be pronunced by espeak-ng with an [ˈɛ] (open "e"):

```bash
grep -E "^[^ ]+ \[é\]" "${DICTIONARY}" | awk '{ gsub("[[:punct:]]", "", $1); $1=tolower($1); "espeak-ng -v pt-br --ipa -q " $1 | getline phonemes; print $1, $2, $3, "[" phonemes "]" }' | grep -F 'ˈe'
```
```
besta1 [é] s.f. [bˈestɐ ˈũm]
colher1 [é] s.f. [koʎˈeɾ ˈũm]
sede1 [é] s.f. [sˈedʒɪ ˈũm]
termos [é] s.m./f.2n. [tˈeɾmʊs]
teta1 [é] s.m. [tˈetɐ ˈũm]
```

Listing the words that should be pronunced by espeak-ng with an [ˈe] (closed "e"):

```bash
grep -E "^[^ ]+ \[ê\]" "${DICTIONARY}" | awk '{ gsub("[[:punct:]]", "", $1); $1=tolower($1); "espeak-ng -v pt-br --ipa -q " $1 | getline phonemes; print $1, $2, $3, "[" phonemes "]" }' | grep -F 'ˈɛ'
```
```
coberto2 [ê] s.m. [kˌobˈɛɾtʊ dˈoɪs]
pega2 [ê] s.f. [pˈɛɡɐ dˈoɪs]
sede2 [ê] s.f. [pˈɛɡɐ dˈoɪs]
```


