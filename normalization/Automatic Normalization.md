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

Example script to turn 1 000,00 into 1.000,00: [awk/normalize-1000.awk].

### Intervals

* 1-10 -> 1--10
* 2025-2026 -> 2025--2026

### Ordinals

* 1.ª -> 1ª
* 1.º -> 1º

Sed command to normalize ordinals:

```bash
# normalize 1°, 1o, 1.°, 1.º, 1.o to 1º
echo "1°" | sed -E 's/([0-9]+)[oa°]/\1º/' | sed -E 's/([0-9]+)\.[oaºª°]/\1º/'
```

#### Ordinals as superscripts

* 1^a^ -> 1ª
* 1^o^ -> 1º

#### Ordinals as lowercases

* 1a -> 1ª
* 1o -> 1º

#### Ordinals as degrees

* 1° -> 1º

#### Ordinals as ring above

* 1U+02DA -> 1º


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

Abbreviations
----------------------------------

### Superscripts as ordinals

* Sr.ª -> Sr.^a^
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

#### Degrees as ordinals

* ºC -> °C
* ºF -> °F

### sub-topic


Law
----------------------------------

### Artigo

* Art. 1º  -> Artigo 1º.
* Art. 1o  -> Artigo 1º.
* Art. 10. -> Artigo 10.

### Parágrafo

* § 1º  -> Parágrafo 1º.
* § 1o  -> Parágrafo 1º.
* § 10. -> Parágrafo 10.

### incisos

* I - -> 1.

### alínea

* a) -> a.

#### Degrees as ordinals

* ºC -> °C
* ºF -> °F

### sub-topic


References
----------------------------------

* [Indicador ordinal](https://pt.wikipedia.org/wiki/Indicador_ordinal)
* [Ordinal indicator](https://en.wikipedia.org/wiki/Ordinal_indicator)
* [Estrutura do decreto] https://www.planalto.gov.br/ccivil_03/dicas/estrutur.htm

