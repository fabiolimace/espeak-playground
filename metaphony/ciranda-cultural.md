Dicionário Ciranda Cultural
============================

Define a dictionary to be used:

```bash
DICTIONARY="PRIVATE/Minidicionário Escolar Língua Portuguesa - Ciranda Cultural.txt"
```

List dictionaries entries that contain indication of the rised vowel [ó]:

```bash
grep -E "^[^ ]+ \(ó\)" "${DICTIONARY}" | head
```
```
COR (ó) s.m. Usado na expressão de cor: de memória ♦ Já sei de cor o Hino Nacional.
COR.TE (ó) s.m. 1) Ato ou efeito de cortar(-se). 2) Golpe, incisão ou talho com instrumento cortante.
COR.VO (ô) s.m. Ornit. Pássaro da família dos Corvídeos, do Hemisfério Norte, reputado por sua inteligência e traquinices. Pl.: corvos (ó).
LO.BO (ó) s.m. Anat. Parte mais ou menos arredondada e saliente de um órgão.
O.VER.DO.SE (ó) s.f. Dose muito elevada de tóxicos consumida por alguém.
PO.LO (ó) s.m. 1) Geom. Extremidades do eixo da esfera. 2) Geogr. Extremidades do eixo imaginário da Terra e, as regiões polares que circundam essas extremidades. 3) Extremidades de qualquer eixo ou linha. 4) Extremidades opostas de um corpo ou órgão oval. / s.m. (ô) 5) Falcão ou gavião de menos de um ano.
QUÓ.RUM (ó) lat. s.m. Número mínimo, indispensável, de pessoas presentes a uma assembleia, para dar início ao funcionamento legal ou votação.
TRO.ÇO (ó) s.m. 1) gír. Qualquer objeto; coisa, que não se sabe o nome ou não se quer revelar. 2) Algo imprestável; bagulho. 3) Mal-estar súbito e não definido; imprevisto.
```

Listing the words that should be pronunced by espeak-ng with an [ˈɔ] (open "o"):

```bash
grep -E "^[^ ]+ \(ó\)" "${DICTIONARY}" | awk '{ gsub("[[:punct:]]", "", $1); $1=tolower($1); "espeak-ng -v pt-br --ipa -q " $1 | getline phonemes; print $1, $2, $3, "[" phonemes "]" }' | grep -F 'ˈo'
```
```
cor (ó) s.m. [kˈoɾ]
lobo (ó) s.m. [lˈobʊ]
```

Listing the words that should be pronunced by espeak-ng with an [ˈo] (closed "o"):

```bash
grep -E "^[^ ]+ \(ô\)" "${DICTIONARY}" | awk '{ gsub("[[:punct:]]", "", $1); $1=tolower($1); "espeak-ng -v pt-br --ipa -q " $1 | getline phonemes; print $1, $2, $3, "[" phonemes "]" }' | grep -F 'ˈɔ'
```
```
acocho (ô) s.m. [ˌakˈɔʃʊ]
arroto (ô) s.m. [ˌaxˈɔtʊ]
choco (ô) adj. [ʃˈɔkʊ]
choro (ô) s.m. [ʃˈɔɾʊ]
controle (ô) s.m. [kˌõntɾˈɔlɪ]
corte (ô) s.f. [kˈɔɾtʃɪ]
crosta (ô) s.f. [kɾˈɔstɐ]
desafogo (ô) s.m. [dˌezafˈɔɡʊ]
despojo (ô) s.m. [dˌespˈɔʒʊ]
destroço (ô) s.m. [dˌestɾˈɔsʊ]
endosso (ô) s.m. [ˌeɪndˈɔsʊ]
forma (ô) s.f. [fˈɔɾmɐ]
loto (ô) s.m. [lˈɔtʊ]
namoro (ô) s.m. [nˌɐmˈɔɾʊ]
olho (ô) s.m. [ˈɔʎʊ]
piloto (ô) s.m. [pˌilˈɔtʊ]
reboco (ô) s.m. [xˌebˈɔkʊ]
rebojo (ô) s.m. [xˌebˈɔʒʊ]
revolto (ô) adj. [xˌevˈɔltʊ]
rodo (ô) s.m. [xˈɔdʊ]
rolo (ô) s.m. [xˈɔlʊ]
roto (ô) adj. [xˈɔtʊ]
sopro (ô) s.m. [sˈɔpɾʊ]
toco (ô) s.m. [tˈɔkʊ]
toldo (ô) s.m. [tˈɔldʊ]
topo (ô) s.m. [tˈɔpʊ]
torpe (ô) adj. [tˈɔɾpɪ]
torre (ô) s.f. [tˈɔxɪ]
troco (ô) s.m. [tɾˈɔkʊ]
troço (ô) s.m. [tɾˈɔsʊ]
virtuose (ô) s.2gên. [vˌiɾtwˈɔzɪ]
```

Listing the words that should be pronunced by espeak-ng with an [ˈɛ] (open "e"):

```bash
grep -E "^[^ ]+ \(é\)" "${DICTIONARY}" | awk '{ gsub("[[:punct:]]", "", $1); $1=tolower($1); "espeak-ng -v pt-br --ipa -q " $1 | getline phonemes; print $1, $2, $3, "[" phonemes "]" }' | grep -F 'ˈe'
```
```
e (é) s.m. [ˈe]
sede (é) s.f. [sˈedʒɪ]
```

Listing the words that should be pronunced by espeak-ng with an [ˈe] (closed "e"):

```bash
grep -E "^[^ ]+ \(ê\)" "${DICTIONARY}" | awk '{ gsub("[[:punct:]]", "", $1); $1=tolower($1); "espeak-ng -v pt-br --ipa -q " $1 | getline phonemes; print $1, $2, $3, "[" phonemes "]" }' | grep -F 'ˈɛ'
```
```
acerto (ê) s.m. [ˌasˈɛɾtʊ]
agulheta (ê) s.f. [ˌaɡuʎˈɛtɐ]
apelo (ê) s.m. [ˌapˈɛlʊ]
aperto (ê) s.m. [ˌapˈɛɾtʊ]
asserto (ê) s.m. [ˌasˈɛɾtʊ]
desassossego (ê) s.m. [dˌezasosˈɛɡʊ]
desinteresse (ê) s.m. [dˌezĩnteɾˈɛsɪ]
desprezo (ê) s.m. [dˌespɾˈɛzʊ]
esmero (ê) s.m. [ˌezmˈɛɾʊ]
espeto (ê) s.m. [ˌespˈɛtʊ]
fecho (ê) s.m. [fˈɛʃʊ]
felpa (ê) s.f. [fˈɛʊpɐ]
feltro (ê) s.m. [fˈɛʊtɾʊ]
flerte (ê) s.m. [flˈɛɾtʃɪ]
grumete (ê) s.m. [ɡɾˌumˈɛtʃɪ]
nego (ê) s.m. [nˈɛɡʊ]
ofego (ê) s.m. [ˌofˈɛɡʊ]
rastelo (ê) s.m. [xˌastˈɛlʊ]
regelo (ê) s.m. [xˌeʒˈɛlʊ]
seca (ê) s.f. [sˈɛkɐ]
sossego (ê) s.m. [sˌosˈɛɡʊ]
tempero (ê) s.m. [tˌeɪmpˈɛɾʊ]
verga (ê) s.f. [vˈɛɾɡɐ]
```

