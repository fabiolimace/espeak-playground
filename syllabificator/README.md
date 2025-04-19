Syllabificator
==================================

Description
----------------------------------

The `syllabificator.awk` script an Awk script that separates words into syllables for Portuguese language.

Usage:

    # produces: in.cons.ti.tu.ci.o.nal.men.te
    echo inconstitucionalmente | awk -f syllabificator.awk
    
    # split all words from a Linux dictionary
    awk -f syllabificator.awk /usr/share/dict/brazilian

This script can has a very low level of error or imprecision.

Demonstrations
----------------------------------

Separate into syllables the words from Linux dictionary:

```bash
cat /usr/share/dict/brazilian | awk -f syllabificator.awk 2> /dev/null | shuf | head -n 10;
```
```
di.li.gen.ci.ais
co.te.ja.ri.a
re.di.gis.ses
sub.ver.te.rí.eis
su.ge.rin.do
ma.la.ba.ris.tas
a.cer.ca.vam
ca.ças.sem
a.cre.di.tá
in.te.greis
```

Separate into syllables the words from Linux dictionary and print the result into an output file:

```bash
cat /usr/share/dict/brazilian | awk -f syllabificator.awk 2> /dev/null > syllabificator.output.txt
```

Separate into syllables the words from Linux dictionary and then count the frequencies of every syllable:

```bash
cat /usr/share/dict/brazilian | awk -f syllabificator.awk  2> /dev/null \
    | awk '{ for (i = 1; i <= NF; i++) { split($i, sy, "."); for (s in sy) list[sy[s]]++ } } END { for (s in list) { print list[s] "\t" s } }' \
    | sort -nr | head -n 10;
```
```
56768	a
32835	mos
32430	re
23255	ra
23155	ri
21063	mo
20624	ta
19823	de
17444	ti
16872	ca
```

Separate into syllables the words from Linux dictionary and then count the frequencies of every pair of syllables (bigrams):

```bash
cat /usr/share/dict/brazilian | awk -f syllabificator.awk  2> /dev/null | awk '{ for (i = 1; i <= NF; i++) { n = split($i, sy, "."); for (j = 1; j < n; j++) list[sy[j] "." sy[j+1]]++ } } END { for (s in list) { print list[s] "\t" s } }' | sort -nr | head -n 10;
```
```
5237	a.mos
5080	ri.a
4559	ri.as
4526	re.mo
4329	ra.mos
4283	re.mos
4141	se.mos
4066	ri.am
4056	rí.a
4053	rí.eis
```

