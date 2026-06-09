Automatic Normalization
==================================

Punctuation
----------------------------------

For other kinds of normalization to work, it may be necessary to insert spaces to separate words from punctuation.

Example script to separate words from punctuation: [awk/normalize-punct.awk].

Numbers
----------------------------------

### Thousands

* 1.000 -> 1000
* 1 000 -> 1000
* 1.000,00 -> 1000,00
* 1 000,00 -> 1000,00

		echo '1 000,00' | sed -E 's/\b([0-9]{1,3})[ ]([0-9]{3}),([0-9]+)\b/\1.\2,\3/g'
		echo '1 000 000,00' | sed -E 's/\b([0-9]{1,3})[ ]([0-9]{3})[ ]([0-9]{3}),([0-9]+)\b/\1.\2.\3,\4/g'
		echo '1 000 000 000,00' | sed -E 's/\b([0-9]{1,3})[ ]([0-9]{3})[ ]([0-9]{3})[ ]([0-9]{3}),([0-9]+)\b/\1.\2.\3.\4,\5/g'

Example script to turn 1 000,00 into 1.000,00: [awk/normalize-1000.awk].

### Intervals

* 1-10 -> 1--10
* 2025-2026 -> 2025--2026

### Ordinals

* 1.ª -> 1ª

		sed -E 's/\b([0-9]+)[.]ª\b/\1ª/g' ebook.txt

* 1.º -> 1º

		sed -E 's/\b([0-9]+)[.]º\b/\1º/g' ebook.txt

#### Ordinals as lowercases

* 1a -> 1ª

		sed -E 's/\b([0-9]+)a\b/\1ª/g' ebook.txt

* 1o -> 1º

		sed -E 's/\b([0-9]+)o\b/\1º/g' ebook.txt

#### Ordinals in HTML

* 1&ordf;

		echo '12&ordf;' | sed -E 's|\b([0-9]+)[.]?&ordf;|\1ª|g'
* 1&ordm;

		echo '12&ordf;' | sed -E 's|\b([0-9]+)[.]?&ordm;|\1º|g'

#### Ordinals as superscripts in HTML

* 1<sup>a</sup>

		echo '1<sup>a</sup>' | sed -E 's|\b([0-9]+)[.]?<sup[^>]*>a</sup>|\1ª|g'

* 1<sup>o</sup>

		echo '1<sup>o</sup>' | sed -E 's|\b([0-9]+)[.]?<sup[^>]*>o</sup>|\1º|g'


#### Ordinals as degrees

* 1°  -> 1º
* 1.° -> 1º

		sed -E 's/\b([0-9]+)[.]?°\b/\1º/g' ebook.txt

#### Ordinals as ring above

* 1U+02DA -> 1º


#### Roman numbers in lowercase

Século xxi -> Século XXI

		awk '{ for (i=1; i<NF; i++) { if ($i ~ /^[[:punct:]]*[Ss]éculos?$/ && $(i+1) ~ /^[ivxlcm]+[[:punct:]]*$/ ) { $(i+1) = toupper($(i+1)) } }; print; }' ebook.txt

(xxi) -> (XXI)

		awk '{ for (i=1; i<NF; i++) { if ($i ~ /^\([ivxlcm]+\)$/ ) { $i = toupper($i) } }; print; }' ebook.txt


Dates
----------------------------------

### Date

* 01/01/1970 -> 1ª de janeiro de 1970
* 01-01-1970 -> 1ª de janeiro de 1970
* 01.01.1970 -> 1ª de janeiro de 1970

Example script to normalize date: [awk/normalize-date.awk].

### Time

* 23:59 -> 23 horas e 59 minutos
* 23h59 -> 23 horas e 59 minutos

Example script to normalize time: [awk/normalize-time.awk].

### Years ranges

* 1939-1945 -> 1939–1945 (using en-dash for ranges instead of simple dash)

		echo '1939-1945' | sed 's/\b([0-9]{4})-([0-9]{4})\b/\1–\2/g'

Abbreviations
----------------------------------

### Superscripts as ordinals

* Sr.ª  -> Sr.^a^
* Eng.º -> Eng.^o^

### Acronims

* ACC: upp /^[aeiou][^aeiou][^aeiou]$/
* CCA: fbi /^[^aeiou][^aeiou][aeiou]$/
* ACCC: adsl /^[aeiou][^aeiou][^aeiou][^aeiou]$/
* CCCA: hdmi /^[^aeiou][^aeiou][^aeiou][aeiou]$/
* CCAC: gzip /^[^aeiou][^aeiou][aeiou][^aeiou]$/

### Constant prefixed

* CWord: csharp /^[^aeiou][^aeiou].*$/
* CCWord: dbmanager /^[^aeiou][^aeiou][^aeiou].*$/

Degrees
----------------------------------

### Temperature

* 1°C -> 1 °C
* 1°F -> 1 °F

		sed -E 's/\b([0-9]+)[ ]?°(C|F)\b/\1 °\2/g' ebook.txt

#### Degrees as ordinals

* 1 ºC -> 1 °C
* 1 ºF -> 1 °F

		sed -E 's/\b([0-9]+)[ ]?º(C|F)\b/\1 °\2/g' ebook.txt


Law
----------------------------------

### Artigo

* Art. 1º  -> Artigo 1º.
* Art. 1o  -> Artigo 1º.
* Art. 1.º -> Artigo 1º.

		echo 'Art. 1.º' | sed -E 's/\b(A|a)rt[.] ([0-9]+)[.]?[oº]\b/\1rtigo \2º/g' ebook.txt


### Parágrafo

* § 1º  -> Parágrafo 1º.
* § 1o  -> Parágrafo 1º.
* § 1.º -> Parágrafo 1º.
* §$ 1º ao 5º -> Parágrafos 1º ao 5º.

		echo '§ 1.º' | sed -E 's/§ ([0-9]+)[.]?[oº]/Parágrafo \1º/g'  ebook.txt
		echo '§§ 1.º ao 5º' | sed -E 's/§§ ([0-9]+)[.]?[oº]/Parágrafos \1º/g'  ebook.txt


### incisos

* I - -> 1.

### alínea

* a) -> a.

		echo 'a) ' | sed -E 's/^([a-z])[)]/\1. /'  ebook.txt


#### Ordinals as degrees

* ºC -> °C
* ºF -> °F

### sub-topic

Other fixes
----------------------------------

Remove numbers between brackets:

```
sed -E 's/\[[0-9]+\]//g' ebook.txt
```

```
sed -E 's/\b([[:alpha:]]+)([.,:;!?])[0-9]+\b/\1\2/g' ebook.txt
```

References
----------------------------------

* [Indicador ordinal](https://pt.wikipedia.org/wiki/Indicador_ordinal)
* [Ordinal indicator](https://en.wikipedia.org/wiki/Ordinal_indicator)
* [Estrutura do decreto] https://www.planalto.gov.br/ccivil_03/dicas/estrutur.htm

