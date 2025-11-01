Dicionário Porto Grande
============================

Define a dictionary to be used:

```bash
DICTIONARY="PRIVATE/Grande Dicionário da Língua Portuguesa da Porto Editora - Porto Editora.txt"
```

List dictionaries entries that contain indication of the rised vowel [ó]:


```bash
grep -E "^[^ ]+ \[[^[:punct:]]*ˈo[^[:punct:]]*\]" "${DICTIONARY}" | head
```
```
aônio [ɐˈonju] adj.
arquiprior [ɐrkipriˈor] s.m. grão-mestre dos Templários
arte-maior [artɨmɐjˈor] s.f. LITERATURA designação dada ao verso castelhano e português de onze sílabas
baba-ovo [babɐˈovu] s.2g. coloquial, pejorativo adulador; bajulador
boiona [bojˈonɐ] s.f. [CABO VERDE] boi muito grande
briófita [briˈofitɐ] ■ s.f. BOTÂNICA espécime das briófitas
briônia [briˈonjɐ] s.f. BOTÂNICA planta herbácea da família das Cucurbitáceas, trepadeira, de folhas grandes e flores dioicas, cujos tubérculos apresentam propriedades medicinais
brioso [briˈozu] adj.
cabeça-oca [kɐbesɐˈokɐ] s.2g. popular pessoa fútil; pessoa que não tem ideias próprias
cá-cá-ô-ô [kakaˈoo] interj. [SÃO TOMÉ E PRÍNCIPE] exprime espanto ou surpresa; como é possível!; que espanto!; o quê!
```

Listing the words that should be pronunced by espeak-ng with an [ˈɔ] (open "o"):

```bash
grep -E "^[^ ]+ \[[^[:punct:]]*ˈɔ[^[:punct:]]*\]" "${DICTIONARY}" | awk '{ gsub("[[:punct:]]", "", $1); $1=tolower($1); "espeak-ng -v pt-br --ipa -q " $1 | getline phonemes; print $1, $2, $3, "[" phonemes "]" }' | grep -F 'ˈo'
```
```
bardanamaior [bɐrdɐnɐmɐjˈɔr] s.f. [bˌaɾdɐnˌɐmaɪˈoɾ]
eoo [εˈɔu] adj. [ˌeˈoʊ]
homem [ˈɔm] s.m. [ˈomeɪŋ]
homo [ˈɔmɔ] s.m. [ˈomʊ]
homo [ˈɔmɔ] elemento [ˈomʊ]
margaridamaior [mɐrgɐridɐmɐjˈɔr] s.f. [mˌaɾɡaɾˌidɐmaɪˈoɾ]
ogro [ˈɔgru] s.m. [ˈoɡɾʊ]
oh [ˈɔ] interj. [ˈo]
ohm [ˈɔm] s.m. [ˈom]
ola2 [ˈɔlɐ] s.f. [ˈɔlɐ dˈoɪs]
olga [ˈɔłgɐ] s.f. [ˈowɡɐ]
opa [ˈɔpɐ] s.f. [ˈopɐ]
orça2 [ˈɔrsɐ] s.f. [ˈɔɾsɐ dˈoɪs]
orco [ˈɔrku] s.m. [ˈoɾkʊ]
orto [ˈɔrtu] s.m. [ˈoɾtʊ]
osga [ˈɔʒgɐ] s.f. [ˈozɡɐ]
ricohomem [ʀikuˈɔm] s.m. [xˌikoˈomeɪŋ]
roselhamaior [ʀuzɐʎɐmɐjˈɔr] s.f. [xˌozeʎˌɐmaɪˈoɾ]
salepeiramaior [sɐlɨpɐjrɐmɐjˈɔr] s.f. [sˌalepˌeɪɾɐmaɪˈoɾ]
semihomem [sɨmiˈɔm] s.m. [sˌemiˈomeɪŋ]
```

Listing the words that should be pronunced by espeak-ng with an [ˈo] (closed "o"):

```bash
grep -E "^[^ ]+ \[[^[:punct:]]*ˈo[^[:punct:]]*\]" "${DICTIONARY}" | awk '{ gsub("[[:punct:]]", "", $1); $1=tolower($1); "espeak-ng -v pt-br --ipa -q " $1 | getline phonemes; print $1, $2, $3, "[" phonemes "]" }' | grep -F 'ˈɔ'
```
```
briófita [briˈofitɐ] ■ [bɾˌiˈɔfitɐ]
cabeçaoca [kɐbesɐˈokɐ] s.2g. [kˌabesaˈɔkɐ]
caoco [kɐˈoku] s.m. [kˌaˈɔkʊ]
gaiolo [gajˈolu] ■ [ɡˌaɪˈɔlʊ]
hódi [ˈodi] ■ [ˈɔdʒi]
ligaosso [ligɐˈosu] s.m. [lˌiɡaˈɔsʊ]
olha [ˈoʎɐ] s.f. [ˈɔʎɐ]
olho [ˈoʎu] s.m. [ˈɔʎʊ]
picaosso [pikɐˈosu] s.m. [pˌikaˈɔsʊ]
priora [priˈorɐ] s.f. [pɾˌiˈɔɾɐ]
```

Listing the words that should be pronunced by espeak-ng with an [ˈε] (open "e"):

```bash
grep -E "^[^ ]+ \[[^[:punct:]]*ˈε[^[:punct:]]*\]" "${DICTIONARY}" | awk '{ gsub("[[:punct:]]", "", $1); $1=tolower($1); "espeak-ng -v pt-br --ipa -q " $1 | getline phonemes; print $1, $2, $3, "[" phonemes "]" }' | grep -F 'ˈe'
```
```
butadieno [butɐdiˈεnu] s.m. [bˌutadʒiˈenʊ]
ecstasy [ˈεkstɐzi] s.m. [ˈekstazi]
eh [ˈε] interj. [ˈe]
ena [ˈεnɐ] interj. [ˈenɐ]
erg1 [ˈεrg] s.m. [ˈeɾɡ ˈũm]
erg2 [ˈεrg] s.m. [ˈeɾɡ dˈoɪs]
ergo [ˈεrgu] s.m. [ˈeɾɡʊ]
eta1 [ˈεtɐ] s.m. [ˈetɐ ˈũm]
eta2 [ˈεtɐ] ■ [ˈetɐ dˈoɪs]
euê [ˈεwe] interj. [eʊˈe]
ex [ˈεks] s.2g. [ˈes]
heie [ˈεj] interj. [ˈeɪɪ]
hena [ˈεnɐ] s.f. [ˈenɐ]
herma [ˈεrmɐ] s.f. [ˈeɾmɐ]
hetera [ˈεtɨrɐ] ■ [ˌetˈeɾɐ]
m [ˈεm] s.m. [ˈemɪ]
n [ˈεn] s.m. [ˈenɪ]
quilohertz [kilɔˈεrtz] s.m.2n. [kˌiloˈeɾts]
```

Listing the words that should be pronunced by espeak-ng with an [ˈe] (closed "e"):

```bash
grep -E "^[^ ]+ \[[^[:punct:]]*ˈe[^[:punct:]]*\]" "${DICTIONARY}" | awk '{ gsub("[[:punct:]]", "", $1); $1=tolower($1); "espeak-ng -v pt-br --ipa -q " $1 | getline phonemes; print $1, $2, $3, "[" phonemes "]" }' | grep -F 'ˈɛ'
```
```
cambraieta [kbrajˈetɐ] s.f. [kˌɐ̃mbɾaɪˈɛtɐ]
gipaeto [ʒipɐˈetu] s.m. [ʒˌipaˈɛtʊ]
hela [ˈelɐ] interj. [ˈɛlɐ]
isoieta [izɔjˈetɐ] s.f. [ˌizoɪˈɛtɐ]
saieta [sajˈetɐ] s.f. [sˌaɪˈɛtɐ]
```


