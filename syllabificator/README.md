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
cat /usr/share/dict/brazilian | awk -f syllabificator.awk  2> /dev/null | awk '{ for (i = 1; i <= NF; i++) { n = split($i, sy, "."); for (j = 1; j &lt; n; j++) list[sy[j] "." sy[j+1]]++ } } END { for (s in list) { print list[s] "\t" s } }' | sort -nr | head -n 10;
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

Comparisons with dictionaries
----------------------------------

For the comparisons, I had to temporally change the `syllabificator.awk` script to print out the input word along with the separated syllables.

### Comparison with Silveira Bueno's:

```bash
awk '{ print $1, $2 }' ~/Backup/dict-collection/extracted-entries/Dicionário\ Global\ Escolar\ Silveira\ Bueno\ da\ Língua\ Portuguesa\ -\ Silveira\ Bueno.tsv | sort > ~/silveira-bueno.txt
```

```bash
awk '{ print $1 }' ~/Backup/dict-collection/extracted-entries/Dicionário\ Global\ Escolar\ Silveira\ Bueno\ da\ Língua\ Portuguesa\ -\ Silveira\ Bueno.tsv | gawk -v ORTHOGRAPHICALLY_CORRECT=1 -f syllabificator/syllabificator.awk | sort > ~/silveira-bueno.syllabificator.txt 
```

```bash
wc -l silveira-bueno.txt silveira-bueno.syllabificator.txt 
  32641 silveira-bueno.txt
  32544 silveira-bueno.syllabificator.txt
  65185 total
```

```
comm -12 silveira-bueno.txt silveira-bueno.syllabificator.txt  | wc -l
32210
```

```
echo "32210 / 32641" | bc -l
.98679574767929904108
```

The conclusion is that the script agrees with Ciranda Cultural's in 98% of 32,641 entries.

### Comparison with Ciranda Cultural's:

```
$ awk '{ print $1, $2 }' ~/Backup/dict-collection/extracted-entries/Minidicionário\ Escolar\ Língua\ Portuguesa\ -\ Ciranda\ Cultural.tsv | sort > ~/ciranda-cultural.txt
```

```
awk '{ print $1 }' ~/Backup/dict-collection/extracted-entries/Minidicionário\ Escolar\ Língua\ Portuguesa\ -\ Ciranda\ Cultural.tsv | gawk -f ~/git/espeak-playground/syllabificator/syllabificator.awk | sort > ~/minidicionario.syllabificator.txt 
```

```
wc -l ciranda-cultural.txt ciranda-cultural.syllabificator.txt 
 12022 ciranda-cultural.txt
 11977 ciranda-cultural.syllabificator.txt
 23999 total
```

```
comm -12 ciranda-cultural.txt ciranda-cultural.syllabificator.txt | wc -l
10658
```

```
echo "10658 / 12022" | bc -l
.88654134087506238562
```

The conclusion is that the script agrees with Ciranda Cultural's in 88% of 12,022 entries. Ciranda Cultural's has a preference for crescent diphthongs (see the comparison between both dictionaries at the end of this document).

### Comparison of Silveira Bueno's against Ciranda Cultural's:

```
awk '{ print $1 }' silveira-bueno.txt | sort > silveira-bueno.field1.txt
awk '{ print $1 }' ciranda-cultural.txt | sort > ciranda-cultural.field1.txt
```
```
wc -l silveira-bueno.field1.txt ciranda-cultural.field1.txt
 32641 silveira-bueno.field1.txt
 12022 ciranda-cultural.field1.txt
 44663 total
```
```
comm -12 silveira-bueno.field1.txt ciranda-cultural.field1.txt | sort > silveira-bueno-ciranda-cultural.txt
```
```
wc -l silveira-bueno-ciranda-cultural.txt
10930 silveira-bueno-ciranda-cultural.txt
```
```
join silveira-bueno-ciranda-cultural.txt <(sort -k1,1 silveira-bueno.txt) | sort -k 1,2 > silveira-bueno.join.txt
join silveira-bueno-ciranda-cultural.txt <(sort -k1,1 ciranda-cultural.txt) | sort -k 1,2 > ciranda-cultural.join.txt
```
```
comm -12 silveira-bueno.join.txt ciranda-cultural.join.txt  | wc -l
10304
```
```
echo "10304 / 10930" | bc -l
.94272644098810612991
```

The conclusion is that the two dictionaries disagree in 6% of their 10,930 common entries. Very interesting.

#### Who wins?

As we can see in the comparison below, Ciranda Cultural's has a clear preference for crescent diphthongs. That's the difference. Both are correct.

```
comm -3 <(awk '{print $2}' silveira-bueno.join.txt | sort) <(awk '{print $2}' ciranda-cultural.join.txt | sort) > silveira-bueno-ciranda-cultural.who-wins.txt
```
```
head -n 100 silveira-bueno-ciranda-cultural.who-wins.txt
a.be.ce.dá.ri.o
	a.be.ce.dá.rio
	a.bo.li.ci.o.nis.mo
a.bo.li.cio.nis.mo
a.bun.dân.ci.a
	a.bun.dân.cia
a.ces.só.ri.o
	a.ces.só.rio
a.ci.o.ná.ri.o
	a.cio.ná.rio
a.de.rên.ci.a
	a.de.rên.cia
ad.ja.cên.ci.a
	ad.ja.cên.cia
ad.ju.tó.ri.o
	ad.ju.tó.rio
a.do.les.cên.ci.a
	a.do.les.cên.cia
a.dul.té.ri.o
	a.dul.té.rio
ad.ven.tí.ci.o
	ad.ven.tí.cio
ad.vér.bi.o
	ad.vér.bio
ad.ver.sá.ri.o
	ad.ver.sá.rio
ad.ver.tên.ci.a
	ad.ver.tên.cia
a.é.re.o
	a.é.reo
	a.e.ro.náu.ti.co
ae.ro.náu.ti.co
a.e.ro.vi.á.ri.o
	a.e.ro.vi.á.rio
a.flu.ên.ci.a
	a.flu.ên.cia
a.gên.ci.a
	a.gên.cia
á.gi.o
	á.gio
	a.gi.o.ta.gem
a.gio.ta.gem
a.go.ni.a.do
	a.go.nia.do
a.gro.in.dús.tri.a
	a.gro.in.dús.tria
a.gro.pe.cu.á.ri.a
	a.gro.pe.cu.á.ria
á.gui.a
	á.guia
a.ju.i.zar
	a.jui.zar
a.ju.tó.ri.o
	a.ju.tó.rio
a.le.a.tó.ri.o
	a.le.a.tó.rio
a.li.men.tí.ci.o
	a.li.men.tí.cio
al.ter.nân.ci.a
	al.ter.nân.cia
al.vé.o.lo
	al.véo.lo
am.bu.lân.ci.a
	am.bu.lân.cia
am.bu.la.tó.ri.o
	am.bu.la.tó.rio
a.me.rín.di.o
	a.me.rín.dio
am.né.si.a
	am.né.sia
a.mô.ni.a
	a.mô.nia
an.fí.bi.o
	an.fí.bio
an.gús.ti.a
	an.gús.tia
a.ni.ver.sá.ri.o
	a.ni.ver.sá.rio
an.ti.mô.ni.o
	an.ti.mô.nio
a.nu.ên.ci.a
	a.nu.ên.cia
a.nu.i.da.de
	a.nui.da.de
a.pa.rên.ci.a
	a.pa.rên.cia
a.quá.ri.o
	a.quá.rio
a.rau.cá.ri.a
	a.rau.cá.ria
ar.dó.si.a
	ar.dó.sia
á.re.a
	á.rea
ar.má.ri.o
	ar.má.rio
ar.mis.tí.ci.o
	ar.mis.tí.cio
as.sé.di.o
	as.sé.dio
```

